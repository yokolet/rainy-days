import { useQuery } from "@vue/apollo-composable"
import { POSTS_QUERY } from "../graphql/queries"
import { computed } from "vue"

export const usePosts = () => {
  const { result, loading, error } = useQuery(POSTS_QUERY)

  const posts = computed(() => result.value?.posts ?? [])

  return {
    posts,
    loading,
    error,
  }
}
