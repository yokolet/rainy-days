<script setup lang="ts">
import { marked } from "marked"
import aboutContent from "../assets/about.md?raw"
import { computed } from "vue"

const about = computed(() => marked.parse(aboutContent))
</script>

<template>
  <section id="about-app">
    <div
      class="m-4 rounded-md bg-white p-4 font-roboto-mono text-sm text-teal-950
        dark:bg-zinc-700 dark:text-teal-50"
    >
      <div v-html="about"></div>
    </div>
  </section>
</template>

<style scoped>
#about-app :deep(h2) {
  @apply text-base font-bold text-gray-800 dark:text-gray-200;
}

#about-app :deep(ul) {
  @apply ml-4 list-disc;
}
</style>
