<script setup lang="ts">
import { useAuthStore } from '../stores/auth';
import { storeToRefs } from 'pinia';

const store = useAuthStore();
const { authProvider, username } = storeToRefs(store)
</script>

<template>
  <div class="flex flex-row p-0 space-x-4">
    <div>{{ authProvider}}</div>
    <div>{{ username }}</div>
  </div>
</template>

<style scoped>

</style>
