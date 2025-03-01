<script setup lang="ts">
import { useAuthStore } from '../stores/auth';
import { storeToRefs } from 'pinia';

const store = useAuthStore();
const {  username, provider, imageUrl } = storeToRefs(store)
store.updateUserData()
</script>

<template>
  <div class="flex flex-row p-0 space-x-2 text-slate-500 dark:text-slate-400">
    <div v-if="provider === 'google'"><font-awesome-icon :icon="['fab', 'google']" /></div>
    <div v-else-if="provider === 'github'"><font-awesome-icon :icon="['fab', 'github']" /></div>
    <div v-else-if="provider === 'gitlab'"><font-awesome-icon :icon="['fab', 'gitlab']" /></div>
    <div v-else></div>
    <div
        class="flex items-center justify-center px-1 py-1 w-6 h-6
        bg-pink-800 dark:bg-pink-600 text-white rounded-full
        hover:scale-95 has-tooltip"
    >
      {{ username ? username[0].toUpperCase() : ''}}
      <span class="tooltip bg-slate-500 opacity-60 text-base">{{ username }}</span>
    </div>
  </div>
</template>

<style scoped>
.tooltip {
  @apply invisible absolute rounded-md shadow-lg p-1 left-1/2 -translate-x-1 translate-y-1/2 mx-auto;
}

.has-tooltip:hover .tooltip {
  @apply visible z-50
}
</style>
