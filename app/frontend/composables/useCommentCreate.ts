import { useMutation, useQuery } from "@vue/apollo-composable"
import { POST_QUERY, COMMENT_MUTATION } from "../graphql/queries"
import { computed, ref } from "vue"
import { escapeHtml } from "./useEscapeHtml"

export const useCommentCreate = (postId: string, replyId: string | null) => {
  const { result } = useQuery(POST_QUERY, () => ({ postId }))
  const post = computed(() => result.value?.post ?? undefined)

  const body = ref<string>("")

  const {
    mutate: commentCreate,
    loading: commentCreateLoading,
    error: commentCreateError,
    onDone,
    onError,
  } = useMutation(COMMENT_MUTATION, () => ({
    variables: {
      body: escapeHtml(body.value),
      pid: postId,
      rid: replyId,
    },
    update: (cache, { data: { commentCreate } }) => {
      let data = cache.readQuery({
        query: POST_QUERY,
        variables: { id: postId },
      })
      data = {
        ...data,
        post: {
          ...data.post,
          comments: [...data.post.comments, commentCreate],
        },
      }
      cache.writeQuery({ query: POST_QUERY, variables: { id: postId }, data })
    },
  }))

  onDone(() => {
    body.value = ""
  })

  onError((error) => {
    console.log(error)
  })

  return {
    body,
    commentCreate,
    commentCreateLoading,
    commentCreateError,
  }
}
