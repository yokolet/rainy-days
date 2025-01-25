<script setup lang="ts">
interface IPostEntry {
  id: number;
  title: string;
  excerpt: string;
  userId: string;
  numComments: number;
  date: string;
}

const tmpData: IPostEntry[] = [
  {
    id: 0,
    title: 'Recalled to Life',
    excerpt: 'Harum dolor impedit. Quo iste ...',
    userId: 'belva@fahey.test',
    numComments: 1,
    date: '2024-07-19'
  },
  {
    id: 1,
    title: 'Down to a Sunless Sea',
    excerpt: 'Vero architecto quia. Et tenet...',
    userId: 'petra@okeefe-lubowitz.example',
    numComments: 2,
    date: '2024-06-01'
  },
  {
    id: 2,
    title: 'The Daffodil Sky',
    excerpt: 'Architecto atque quia. Volupta...',
    userId: 'Yun Hintz Grady',
    numComments: 5,
    date: '2023-12-31'
  }
]
</script>

<template>
  <section id="post-list">
    <div class="w-11/12 mx-auto mt-4 items-center justify-center bg-white dark:bg-[#393f3d] shadow-lg rounded-md
    font-roboto-mono text-sm md:text-base dark:text-white">
      <div class="flex flex-col space-y-0">
        <div class="grid grid-cols-1 md:grid-cols-12 md:gap-4 p-4 border-b-2 border-[#dfebe7] dark:border-[#2e3231]"
             v-for="post in tmpData">
          <div class="md:col-span-2 text-xs lg:text-sm tracking-tight">{{ post.userId }}</div>
          <div class="md:col-span-3 font-bold">{{ post.title }}</div>
          <div class="md:col-span-4">{{ post.excerpt }}</div>
          <div class="md:col-span-1"><font-awesome-icon :icon="['far', 'comments']" /> {{ post.numComments }}</div>
          <div class="md:col-span-1 text-xs lg:text-sm tracking-tight">{{ post.date }}</div>
          <div class="md:col-span-1 flex justify-end"><font-awesome-icon :icon="['fas', 'circle-chevron-right']" size="lg" /></div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>

</style>
