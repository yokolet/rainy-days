<script setup lang="ts">
import { useDateFormat } from '@vueuse/core'
import { usePosts } from '../composables/usePosts'

const { posts, loading, error } = usePosts()

const formatDate = (date: string) =>
    useDateFormat(new Date(date), 'YYYY-MM-DD')

const extractName = (name: string) =>
  name.split('@')[0].slice(0, 6)

</script>

<template>
  <section id="post-list">
    <div class="w-11/12 mx-auto mt-4 shadow-lg rounded-md font-roboto-mono
    text-sm md:text-base dark:text-white">
      <div v-if="loading">Loading...</div>
      <div v-else-if="error">Error {{ error.message }}</div>
      <div v-else-if="posts">
        <div class="flex flex-col space-y-0">
          <div v-for="post in posts" :key="post.id">
            <router-link :to="`/post/${post.id}`">
              <div class="grid grid-cols-1 md:grid-cols-12 md:gap-4 p-4 bg-white dark:bg-[#393f3d]
            border-b-2 border-[#dfebe7] dark:border-[#2e3231]
            hover:scale-95 md:hover:scale-100 md:hover:translate-x-1 hover:bg-gray-100 dark:hover:bg-[#484e4c]">
                <div class="md:col-span-1 text-xs lg:text-sm tracking-tight">{{ extractName(post.email) }}</div>
                <div class="py-2 md:py-0 md:col-span-3 font-bold tracking-tight">{{ post.title }}</div>
                <div class="md:col-span-5 md:text-sm lg:text-base md:tracking-tighter">{{ `${post.excerpt}...` }}</div>
                <div class="md:col-span-3 flex flex-row justify-between mt-2">
                  <div class="md:col-span-1 md:text-sm lg:text-base"><font-awesome-icon :icon="['far', 'comments']" /> {{ post.commentCount }}</div>
                  <div class="md:col-span-1 text-xs lg:text-sm tracking-tight">{{ formatDate(post.updatedAt) }}</div>
                  <div class="md:col-span-1 flex justify-end"><font-awesome-icon :icon="['fas', 'circle-chevron-right']" size="lg" /></div>
                </div>
              </div>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>

</style>
