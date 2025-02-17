import { IComment } from "../components/Comment.vue"

interface ITree {
  idToIndex: { [key: string]: number }
  comment: IComment
  children: ITree[]
}

export const buildCommentTree = (comments: IComment[]) => {
  const commentMap = comments.reduce((acc, comment) => ({...acc, [comment.id]: []}), {})
  comments.forEach((comment) => {
    if (comment.replyId !== null) {
      commentMap[comment.replyId].push(comment)
    }
  })
  return commentMap
}

export const getCommentGroup = (comments: IComment[], replyId: string | null) =>
  comments.filter((comment) => comment.replyId === replyId)
