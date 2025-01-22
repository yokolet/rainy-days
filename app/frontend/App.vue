<script setup lang="ts">
import { RouterView } from 'vue-router'
import Navbar from './components/Navbar.vue';
import Footer from './components/Footer.vue';
</script>

<template>
  <div class="h-screen w-full">
    <Navbar />
    <RouterView />
    <Footer />
  </div>
</template>

<style scoped>
</style>
