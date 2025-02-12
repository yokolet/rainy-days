import { useMutation } from '@vue/apollo-composable'
import { POST_QUERY, COMMENT_MUTATION } from '../graphql/queries'
import { ref } from 'vue';

export const useCommentCreate = (body: string, postId: number, replyId: number) => {
  const variables = ref({
    body,
    postId,
    replyId,
  })
  const { mutate: commentCreate, loading: commentCreateLoading, onDone, onError } = useMutation(
    COMMENT_MUTATION,
    () => ({
      variables,
      update: (cache, { data: { postCreate }}) => {
        let data = cache.readQuery({ query: POST_QUERY, variables: { id: postId } })
        data = {
          comments: [
            {
              __typename: "Comments",
              id: commentCreate.comment.id,
              identifier: commentCreate.comment.user.email,
              body: commentCreate.comment.body,
              updatedAt: commentCreate.comment.updatedAt,
            },
            ...data.comments,
          ],
        }
        cache.writeQuery({ query: POST_QUERY, variables: { id: postId }, data });
      }
    })
  );
  return {
    commentCreate,
    commentCreateLoading,
    onDone,
    onError,
  }
}
