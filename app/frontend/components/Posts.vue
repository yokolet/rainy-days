<script setup lang="ts">
import { usePosts } from "../composables/usePosts"
import { formatDate, shortName } from "../composables/useFormat"

const { posts, loading, error } = usePosts()
</script>

<template>
  <section id="post-list">
    <div
      class="mx-auto mt-4 w-11/12 rounded-md font-roboto-mono text-sm shadow-lg
        dark:text-white md:text-base"
    >
      <div v-if="loading">Loading...</div>
      <div v-else-if="error">Error {{ error.message }}</div>
      <div v-else-if="posts">
        <div class="flex flex-col space-y-0">
          <div v-for="post in posts" :key="post.id">
            <router-link :to="`/post/${post.id}`">
              <div
                class="grid grid-cols-1 border-b-2 border-[#dfebe7] bg-white p-4
                  hover:scale-95 hover:bg-gray-100 dark:border-[#2e3231]
                  dark:bg-[#393f3d] dark:hover:bg-[#484e4c] md:grid-cols-12
                  md:gap-4 md:hover:translate-x-1 md:hover:scale-100"
              >
                <div class="text-xs tracking-tight md:col-span-1 lg:text-sm">
                  {{ shortName(post.username) }}
                </div>
                <div
                  class="py-2 font-bold tracking-tight md:col-span-3 md:py-0"
                >
                  {{ post.title }}
                </div>
                <div
                  class="md:col-span-5 md:text-sm md:tracking-tighter
                    lg:text-base"
                >
                  {{ `${post.excerpt}...` }}
                </div>
                <div class="mt-2 flex flex-row justify-between md:col-span-3">
                  <div class="md:col-span-1 md:text-sm lg:text-base">
                    <font-awesome-icon :icon="['far', 'comments']" />
                    {{ post.commentCount }}
                  </div>
                  <div class="text-xs tracking-tight md:col-span-1 lg:text-sm">
                    {{ formatDate(post.updatedAt) }}
                  </div>
                  <div class="flex justify-end md:col-span-1">
                    <font-awesome-icon
                      :icon="['fas', 'circle-chevron-right']"
                      size="lg"
                    />
                  </div>
                </div>
              </div>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped></style>
