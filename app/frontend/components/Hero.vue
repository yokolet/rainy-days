<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{ image: string }>()

const bgImage = computed(() => (`bg-[url(/assets/${props.image})]`))
</script>

<template>
  <div
      class="relative h-[100px] md:h-[200px] lg:h-[250px] w-full bg-cover bg-[50%] bg-no-repeat"
      :class="bgImage">
    <div
        class="absolute bottom-0 left-0 right-0 top-0 h-full w-full overflow-hidden bg-stone-500/50 bg-fixed">
      <div class="flex h-full items-center justify-center">
        <div class="px-6 text-center text-white md:px-12">
          <h1 class="mb-6 text-2xl md:text-5xl font-bold">Blogging in Rainy Days</h1>
        </div>
      </div>
    </div>
  </div>

</template>

<style scoped>

</style>
