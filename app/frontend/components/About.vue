<script setup lang="ts">
import { marked } from 'marked'
import aboutContent from '../assets/about.md?raw'
import { computed } from 'vue';

const about = computed(() => marked.parse(aboutContent))
</script>

<template>
  <section id="about-app">
    <div class="text-sm bg-white dark:bg-zinc-700 text-teal-950 dark:text-teal-50 font-roboto-mono m-4 p-4 rounded-md">
      <div v-html="about"></div>
    </div>
  </section>
</template>

<style scoped>
#about-app :deep(h2) {
  @apply text-gray-800 dark:text-gray-200 font-bold text-base;
}

#about-app :deep(ul) {
  @apply list-disc ml-4;
}
</style>
