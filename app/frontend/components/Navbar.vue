<script setup lang="ts">
import User from '../components/User.vue';
import { RouterLink } from 'vue-router';
</script>

<template>
  <header>
    <div class="w-full">
      <nav>
        <RouterLink to="/">Home</RouterLink>
        <RouterLink to="/about">About</RouterLink>
        <div>Login</div>
        <User />
        <div>Logout</div>
      </nav>
    </div>
  </header>
</template>

<style scoped>

</style>
