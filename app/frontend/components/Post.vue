<script setup lang="ts">
import { usePost } from "../composables/usePost"
import { formatDate, longerName } from "../composables/useFormat"
import Comment from "../components/Comment.vue"
import CommentFormModal from "../components/CommentFormModal.vue"
import { computed, ref } from "vue"
import {
  buildCommentTree,
  getCommentGroup,
} from "../composables/useCommentTree"
import { useAuthStore } from "../stores/auth"
import { storeToRefs } from "pinia"

const store = useAuthStore()
const { isAuthenticated } = storeToRefs(store)

const props = defineProps<{ id: string | string[] }>()

const id = typeof props.id === "string" ? props.id : props.id[0]
const { post, loading, error } = usePost(id)

const isCommentFormOpen = ref<boolean>(false)

const commentTree = computed(() =>
  post.value?.comments ? buildCommentTree(post.value?.comments) : {},
)
const commentGroup = computed(() =>
  post.value?.comments ? getCommentGroup(post.value?.comments, null) : [],
)
</script>

<template>
  <section id="post-detail">
    <div
      class="mx-auto mt-4 w-11/12 items-center justify-center rounded-md
        bg-[#f6f9f8] p-2 font-roboto-mono text-sm shadow-lg dark:bg-[#3b3d3d]
        dark:text-white md:p-4 md:text-base"
    >
      <div v-if="loading">Loading...</div>
      <div v-else-if="error">Error {{ error.message }}</div>
      <div v-else-if="post">
        <div class="flex flex-col space-y-4">
          <div class="text-lg font-bold">{{ post.title }}</div>
          <div class="flex flex-row items-center justify-between">
            <div
              class="text-xs tracking-tight text-stone-700 dark:text-zinc-200"
            >
              {{ longerName(post.user.username) }}
            </div>
            <div
              class="text-xs tracking-tight text-stone-500 dark:text-zinc-400"
            >
              {{ formatDate(post.updatedAt) }}
            </div>
          </div>
          <div>{{ post.content }}</div>
          <div
            id="comment-form"
            class="cursor-pointer hover:text-cyan-600 dark:hover:text-cyan-500"
            v-show="isAuthenticated"
            @click="isCommentFormOpen = true"
          >
            <font-awesome-icon :icon="['far', 'comment']" /> Comment
          </div>
          <CommentFormModal
            :is-open="isCommentFormOpen"
            :post-id="id"
            :reply-id="null"
            @close="isCommentFormOpen = false"
          />
          <div id="comments-for-post" class="text-sm font-bold">
            Comments ({{ post.comments.length }})
          </div>
          <div v-for="comment in commentGroup" :key="comment.id">
            <Comment
              :post-id="id"
              :comment="comment"
              :commentTree="commentTree"
            />
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped></style>
