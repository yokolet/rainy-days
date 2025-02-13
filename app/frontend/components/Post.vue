<script setup lang="ts">
import { usePost } from '../composables/usePost'
import { formatDate, longerName } from '../composables/useFormat'

const props = defineProps<{ id: string | string[] }>()

const id = typeof props.id === 'string' ? props.id : props.id[0]
const { post, loading, error } = usePost(id)

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
          <div class="cursor-pointer hover:text-cyan-600 dark:hover:text-cyan-400"><font-awesome-icon :icon="['far', 'comment']" /> Comment</div>
          <div class="text-sm font-bold">Comments ({{post.comments.length}})</div>
          <div v-for="comment in post.comments">
            <div class="border-l-[1px] border-stone-500 dark:border-zinc-300 rounded-md p-2">
              <div class="flex flex-row justify-between">
                <div class="tracking-tight text-xs text-stone-700 dark:text-zinc-200">{{ longerName(comment.email) }}</div>
                <div class="tracking-tight text-xs text-stone-500 dark:text-zinc-400">{{ formatDate(comment.updatedAt) }}</div>
              </div>
              <div class="my-2 text-sm">{{comment.body}}</div>
              <div class="cursor-pointer hover:text-cyan-600 dark:hover:text-cyan-400 text-xs"><font-awesome-icon :icon="['far', 'comment']" /> Reply</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>

</style>
