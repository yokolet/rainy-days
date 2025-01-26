<script setup lang="ts">

</script>

<template>
  <section id="about-app">
    <div class="text-sm bg-white dark:bg-zinc-700 text-zinc-900 dark:text-teal-100 font-roboto-mono m-4 p-4 rounded-md">
      <dl class="flex flex-col space-y-4">
        <dt>This is a sample Ruby on Rails application with Vue.js on the frontend.</dt>
        <dt>
          <span class="font-semibold">Usage</span>
          <ul class="font-light">
            <li><font-awesome-icon :icon="['fas', 'mug-hot']" /> Everybody can see posts and comments</li>
            <li><font-awesome-icon :icon="['fas', 'mug-hot']" /> When a user logs in, the user can write a post and comment</li>
          </ul>
        </dt>
        <dt>
          <span class="font-semibold">Technologies and Versions</span>
          <ul class="font-light">
            <li><font-awesome-icon :icon="['fas', 'screwdriver-wrench']" /> Ruby on Rails: 8.0.1</li>
            <li><font-awesome-icon :icon="['fas', 'screwdriver-wrench']" /> Vue.js: 3.5.13</li>
          </ul>
        </dt>
      </dl>
    </div>
  </section>
</template>

<style scoped>

</style>
