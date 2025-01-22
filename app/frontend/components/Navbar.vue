<script setup lang="ts">
import { RouterLink } from 'vue-router';
import User from '../components/User.vue';
import { useAuthStore } from '../stores/auth';
import { storeToRefs } from 'pinia';

const store = useAuthStore();
const {isAuthenticated} = storeToRefs(store)

</script>

<template>
  <header>
    <div class="w-full p-4">
      <nav class="flex items-center justify-between">
        <div class="flex flex-row items-center justify-start space-x-4">
          <RouterLink to="/">Home</RouterLink>
          <RouterLink to="/about">About</RouterLink>
        </div>
        <div class="flex flex-row items-center justify-end space-x-4">
          <User v-show="isAuthenticated" />
          <div id="logout" class="button" v-if="isAuthenticated" @click="store.logout()">Logout</div>
          <div id="login" class="button" v-else @click="store.authenticate()">Login</div>
        </div>
      </nav>
    </div>
  </header>
</template>

<style scoped>
.button {
  @apply cursor-pointer px-4 py-2 border-2 rounded-lg
}
</style>
