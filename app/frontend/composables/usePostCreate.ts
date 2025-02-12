import { useMutation } from '@vue/apollo-composable'
import { POSTS_QUERY, POST_MUTATION } from '../graphql/queries'
import { ref } from 'vue'

export const usePostCreate = (title: string, content: string) => {
  const variables = ref({
    title,
    content,
  })
  const { mutate: postCreate, loading: postCreateLoading, onDone, onError } = useMutation(
    POST_MUTATION,
    () => ({
      variables,
      update: (cache, { data: { postCreate }}) => {
        let data = cache.readQuery({ query: POSTS_QUERY })
        data = {
          posts: [
            {
              __typename: "Posts",
              commentCount: 0,
              excerpt: postCreate.post.content.substring(0, 30),
              id: postCreate.post.id,
              email: postCreate.post.user.email,
              title: postCreate.post.title,
              updatedAt: postCreate.post.updatedAt,
            },
            ...data.posts,
          ],
        }
        cache.writeQuery({ query: POSTS_QUERY, data });
      }
    })
  );
  return {
    postCreate,
    postCreateLoading,
    onDone,
    onError,
  }
}
