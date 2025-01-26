<script setup lang="ts">
interface IComment {
  id: number;
  userId: string;
  postId: number;
  body: string;
  date: string;
}

interface IPost {
  id: number;
  userId: string;
  title: string;
  content: string;
  date: string;
  comments: IComment[];
}

const dummyData: IPost[] = [
  {
    id: 0,
    userId: 'belva@fahey.test',
    title: 'Recalled to Life',
    content: 'Harum dolor impedit. Quo iste officia. Et ab nulla.',
    date: '2024-07-19',
    comments: [
      {id: 0, userId: 'belva@fahey.test', postId: 0, body: 'Quaerat accusantium eum dicta.', date: '2024-08-01'}
    ]
  },
  {
    id: 1,
    userId: 'petra@okeefe-lubowitz.example',
    title: 'Down to a Sunless Sea',
    content: 'Vero architecto quia. Et tenetur exercitationem. Dolor laborum corrupti.',
    date: '2024-06-01',
    comments: [
      {id: 1, userId: 'Yun Hintz Grady', postId: 1, body: 'Dolorum veniam qui laborum.', date: '2024-06-01'},
      {id: 2, userId: 'Yun Hintz Grady', postId: 1, body: 'Ipsam quisquam voluptatem iure.', date: '2024-11-11'},
    ]
  },
  {
    id: 2,
    userId: 'Yun Hintz Grady',
    title: 'The Daffodil Sky',
    content: 'Architecto atque quia. Voluptates ullam aut. Repudiandae delectus explicabo.',
    date: '2023-12-31',
    comments: [
      {id: 3, userId: 'petra@okeefe-lubowitz.example', postId: 1, body: 'Dolorum veniam qui laborum.', date: '2023-12-31'},
      {id: 4, userId: 'belva@fahey.test', postId: 1, body: 'Ipsam quisquam voluptatem iure.', date: '2024-01-01'},
      {id: 5, userId: 'Yun Hintz Grady', postId: 1, body: 'Debitis hic consequatur voluptatem.', date: '2024-12-31'},
      {id: 6, userId: 'petra@okeefe-lubowitz.example', postId: 1, body: 'Qui est omnis laudantium.', date: '2025-01-01'},
      {id: 7, userId: 'Yun Hintz Grady', postId: 1, body: 'Non qui beatae iusto.', date: '2025-01-15'},
    ]
  }
]

const props = defineProps<{ id: number }>()

const post = dummyData[props.id]
</script>

<template>
  <section id="post-detail">
    <div class="w-11/12 mx-auto mt-4 items-center justify-center shadow-lg rounded-md font-roboto-mono
    p-2 md:p-4 text-sm md:text-base dark:text-white">
      <div class="flex flex-col space-y-4">
        <div class="font-bold text-lg">{{post.title}}</div>
        <div class="flex flex-row items-center justify-between">
          <div class="tracking-tight text-xs text-stone-700 dark:text-zinc-200">{{post.userId}}</div>
          <div class="tracking-tight text-xs text-stone-500 dark:text-zinc-400">{{post.date}}</div>
        </div>
        <div>{{post.content}}</div>
        <div class="cursor-pointer hover:text-cyan-600 dark:hover:text-cyan-400"><font-awesome-icon :icon="['far', 'comment']" /> Comment</div>
        <div class="text-sm font-bold">Comments ({{post.comments.length}})</div>
        <div v-for="comment in post.comments">
          <div class="border-l-[1px] border-stone-500 dark:border-zinc-300 rounded-md p-2">
            <div class="flex flex-row justify-between">
              <div class="tracking-tight text-xs text-stone-700 dark:text-zinc-200">{{comment.userId}}</div>
              <div class="tracking-tight text-xs text-stone-500 dark:text-zinc-400">{{comment.date}}</div>
            </div>
            <div class="my-2 text-sm">{{comment.body}}</div>
            <div class="cursor-pointer hover:text-cyan-600 dark:hover:text-cyan-400 text-xs"><font-awesome-icon :icon="['far', 'comment']" /> Comment</div>
          </div>

        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>

</style>
