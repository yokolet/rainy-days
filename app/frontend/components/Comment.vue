<script setup lang="ts">
import { formatDate, longerName } from '../composables/useFormat'
import { ref } from 'vue'
import CommentFormModal from '../components/CommentFormModal.vue'

interface IComment {
  id: string
  body: string
  email: string
  updatedAt: string
}

const props = defineProps<{postId: string, comment: IComment}>()
const isCommentFormOpen = ref<boolean>(false)
</script>

<template>
  <div class="border-l-[1px] border-stone-500 dark:border-zinc-300 rounded-md p-2">
    <div class="flex flex-row justify-between">
      <div class="tracking-tight text-xs text-stone-700 dark:text-zinc-200">{{ longerName(props.comment.email) }}</div>
      <div class="tracking-tight text-xs text-stone-500 dark:text-zinc-400">{{ formatDate(props.comment.updatedAt) }}</div>
    </div>
    <div class="my-2 text-sm">{{props.comment.body}}</div>
    <div
        class="cursor-pointer hover:text-cyan-600 dark:hover:text-cyan-400 text-xs"
        @click="isCommentFormOpen=true"
    >
      <font-awesome-icon :icon="['far', 'comment']" /> Reply
    </div>
    <CommentFormModal
        :is-open="isCommentFormOpen"
        :post-id="props.postId"
        :reply-id="props.comment.id"
        @close="isCommentFormOpen = false"
    />
  </div>
</template>

<style scoped>

</style>
