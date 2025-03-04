<script setup lang="ts">
import { useAuthStore } from "../stores/auth"
import { storeToRefs } from "pinia"

const store = useAuthStore()
const { username, provider, imageUrl } = storeToRefs(store)
store.updateUserData()
</script>

<template>
  <div class="flex flex-row space-x-2 p-0 text-slate-500 dark:text-slate-400">
    <div v-if="provider === 'google'">
      <font-awesome-icon :icon="['fab', 'google']" />
    </div>
    <div v-else-if="provider === 'github'">
      <font-awesome-icon :icon="['fab', 'github']" />
    </div>
    <div v-else-if="provider === 'gitlab'">
      <font-awesome-icon :icon="['fab', 'gitlab']" />
    </div>
    <div v-else></div>
    <div
      class="has-tooltip flex h-6 w-6 items-center justify-center rounded-full
        bg-pink-800 px-1 py-1 text-white hover:scale-95 dark:bg-pink-600"
    >
      {{ username ? username[0].toUpperCase() : "" }}
      <span class="tooltip bg-slate-500 text-base opacity-60">{{
        username
      }}</span>
    </div>
  </div>
</template>

<style scoped>
.tooltip {
  @apply invisible absolute left-1/2 mx-auto -translate-x-1 translate-y-1/2 rounded-md p-1 shadow-lg;
}

.has-tooltip:hover .tooltip {
  @apply visible z-50;
}
</style>
