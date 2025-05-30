<script setup lang="ts">
import { formatDate, longerName } from "../composables/useFormat"
import { ref } from "vue"
import CommentFormModal from "../components/CommentFormModal.vue"
import { useAuthStore } from "../stores/auth"
import { storeToRefs } from "pinia"

export interface IComment {
  id: string
  body: string
  username: string
  updatedAt: string
  postId: string
  replyId: string | null
}

const store = useAuthStore()
const { isAuthenticated } = storeToRefs(store)
const props = defineProps<{
  postId: string
  comment: IComment
  commentTree: { [key: string]: IComment[] }
}>()
const isCommentFormOpen = ref<boolean>(false)

const curComments = props.commentTree[props.comment.id]
</script>

<template>
  <div
    class="mt-2 rounded-sm border-l-[1px] border-stone-500 pl-2
      dark:border-zinc-300 lg:pl-4"
  >
    <div class="flex flex-row justify-between">
      <div class="text-xs tracking-tight text-stone-700 dark:text-zinc-200">
        {{ longerName(props.comment.username) }}
      </div>
      <div class="text-xs tracking-tight text-stone-500 dark:text-zinc-400">
        {{ formatDate(props.comment.updatedAt) }}
      </div>
    </div>
    <div class="my-2 text-sm tracking-tighter lg:tracking-normal">
      {{ props.comment.body }}
    </div>
    <div
      class="cursor-pointer text-xs hover:text-cyan-600
        dark:hover:text-cyan-400"
      v-show="isAuthenticated"
      @click="isCommentFormOpen = true"
    >
      <font-awesome-icon :icon="['far', 'comment']" /> Reply
    </div>
    <CommentFormModal
      :is-open="isCommentFormOpen"
      :post-id="props.postId"
      :reply-id="props.comment.id"
      @close="isCommentFormOpen = false"
    />
    <div v-for="comment in curComments" :key="comment.id">
      <Comment
        :post-id="props.postId"
        :comment="comment"
        :commentTree="props.commentTree"
      />
    </div>
  </div>
</template>

<style scoped></style>
