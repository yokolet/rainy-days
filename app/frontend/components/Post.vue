<script setup lang="ts">
import { usePost } from '../composables/usePost'
import { formatDate, longerName } from '../composables/useFormat'
import Comment from '../components/Comment.vue'
import CommentFormModal from '../components/CommentFormModal.vue'
import { ref } from 'vue'
import { buildCommentTree, getCommentGroup } from '../composables/useCommentTree'

const props = defineProps<{ id: string | string[] }>()

const id = typeof props.id === 'string' ? props.id : props.id[0]
const { post, loading, error } = usePost(id)

const isCommentFormOpen = ref<boolean>(false)

</script>

<template>
  <section id="post-detail">
    <div class="w-11/12 mx-auto mt-4 items-center justify-center shadow-lg rounded-md font-roboto-mono
    p-2 md:p-4 text-sm md:text-base dark:text-white bg-[#f6f9f8] dark:bg-[#3b3d3d]">
      <div v-if="loading">Loading...</div>
      <div v-else-if="error">Error {{ error.message }}</div>
      <div v-else-if="post">
        <div class="flex flex-col space-y-4">
          <div class="font-bold text-lg">{{post.title}}</div>
          <div class="flex flex-row items-center justify-between">
            <div class="tracking-tight text-xs text-stone-700 dark:text-zinc-200">{{ longerName(post.user.email) }}</div>
            <div class="tracking-tight text-xs text-stone-500 dark:text-zinc-400">{{ formatDate(post.updatedAt) }}</div>
          </div>
          <div>{{post.content}}</div>
          <div
              id="comment-form"
              class="cursor-pointer hover:text-cyan-600 dark:hover:text-cyan-500"
              @click="isCommentFormOpen=true"
          >
            <font-awesome-icon :icon="['far', 'comment']" /> Comment
          </div>
          <CommentFormModal
              :is-open="isCommentFormOpen"
              :post-id="id"
              :reply-id="null"
              @close="isCommentFormOpen = false"
          />
          <div id="comments-for-post" class="text-sm font-bold">Comments ({{post.comments.length}})</div>
          <div v-for="comment in getCommentGroup(post.comments, null)" :key="comment.id">
            <Comment :post-id="id" :comment="comment" :commentTree="buildCommentTree(post.comments)" />
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>

</style>
