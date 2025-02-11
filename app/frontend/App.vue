<script setup lang="ts">
import { RouterView } from 'vue-router'
import Navbar from './components/Navbar.vue';
import Footer from './components/Footer.vue';
</script>

<template>
  <div id="app" class="min-h-screen w-full bg-[#eff5f3] dark:bg-[#484e4c]">
    <Navbar />
    <RouterView />
    <Footer />
  </div>
</template>

<style scoped>
</style>
