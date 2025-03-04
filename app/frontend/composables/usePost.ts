import { useQuery } from "@vue/apollo-composable"
import { POST_QUERY } from "../graphql/queries"
import { computed } from "vue"

export const usePost = (id: string) => {
  const { result, loading, error } = useQuery(POST_QUERY, () => ({ id }))

  const post = computed(() => result.value?.post ?? undefined)

  return {
    post,
    loading,
    error,
  }
}
