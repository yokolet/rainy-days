<script setup lang="ts">
const props = defineProps<{ image: string }>()
</script>

<template>
  <section id="hero"
      class="relative h-[100px] md:h-[200px] lg:h-[250px] w-full bg-cover bg-[50%] bg-no-repeat"
      :class="props.image">
    <div
        class="absolute bottom-0 left-0 right-0 top-0 h-full w-full overflow-hidden bg-stone-500/50 bg-fixed">
      <div class="flex h-full items-center justify-center">
        <div class="px-6 text-center text-white md:px-12">
          <h1 class="mb-6 text-2xl md:text-4xl lg:text-5xl font-roboto-mono font-bold">Blogging in Rainy Days</h1>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>

</style>
