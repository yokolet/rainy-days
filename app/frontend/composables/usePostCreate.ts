import { useQuery, useMutation } from '@vue/apollo-composable'
import { POSTS_QUERY, POST_MUTATION } from '../graphql/queries'
import { computed, ref } from 'vue'
import { escapeHtml} from './useEscapeHtml'

export const usePostCreate = () => {
  const { result } = useQuery(POSTS_QUERY)
  const posts = computed(() => result.value?.posts ?? [])

  const title = ref<string>('')
  const content = ref<string>('')

  const { mutate: postCreate, loading: postCreateLoading, error: postCreateError, onDone, onError } = useMutation(
    POST_MUTATION,
    () => ({
      variables: {
        title: escapeHtml(title.value),
        content: escapeHtml(content.value),
      },
      update: (cache, { data: { postCreate }}) => {
        let data = cache.readQuery({ query: POSTS_QUERY })
        data = {
          ...data,
          posts: [
            ...data.posts,
            postCreate,
          ],
        }
        cache.writeQuery({ query: POSTS_QUERY, data });
      }
    })
  )

  onDone(() => {
    title.value = ''
    content.value = ''
  })

  onError(error => {
    console.log(error)
  })

  return {
    title,
    content,
    postCreate,
    postCreateLoading,
    postCreateError,
  }
}
