import { IComment } from "../components/Comment.vue"

interface ITree {
  idToIndex: { [key: string]: number }
  comment: IComment
  children: ITree[]
}

export const buildCommentTree = (comments: IComment[]) => {
  // const rootIdToIndex: { [key: string]: number } = comments
  //   .filter((comment) => comment.replyId === null)
  //   .reduce((acc, comment, index) => ({...acc, [comment.id]: index}), {})
  // const tree: ITree[] = []
  // const idToIndex: { [key: string]: number } = {}
  // comments.forEach((comment, index) => {
  //   if (comment.replyId === null) {
  //     idToIndex[comment.id] = index
  //     tree.push({idToIndex, comment, children: []})
  //   } else {
  //
  //   }
  // })

  const idToIndex: { [key: string]: number } =
    comments.reduce((acc, comment, index) => ({...acc, [comment.id]: index}), {})
  const graph = Array.from({length: comments.length}).map(() => [])
  comments.forEach((comment) => {
    if (comment.replyId !== null) {
      graph[idToIndex[comment.replyId]].push(comment)
    }
  })

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
