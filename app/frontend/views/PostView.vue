<script setup lang="ts">
import { useRoute } from 'vue-router';
import Post from '../components/Post.vue';
import Hero from '../components/Hero.vue';

const route = useRoute();
</script>

<template>
  <main id="post">
    <Hero image="bg-blue-lake-in-rain"/>
    <Post :id="route.params.id"/>
  </main>
</template>
