<script setup lang="ts">
import { useAuthStore } from '../stores/auth';
import { storeToRefs } from 'pinia';

const store = useAuthStore();
const {  userId, provider, imageUrl } = storeToRefs(store)
</script>

<template>
  <div class="flex flex-row p-0 space-x-4">
    <div>{{ provider || ''}}</div>
    <div>{{ userId || ''}}</div>
  </div>
</template>

<style scoped>

</style>
