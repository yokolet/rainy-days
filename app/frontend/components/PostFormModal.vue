<script setup lang="ts">
import { usePostCreate } from '../composables/usePostCreate'

const props = defineProps<{ isOpen: boolean }>()
const emit = defineEmits(['close'])

const { title, content, postCreate, postCreateLoading, postCreateError,} = usePostCreate()

const handleCreate = () => {
  postCreate()
  emit('close')
}

const handleCancel = () => {
  title.value = ''
  content.value = ''
  emit('close')
}

</script>

<template>
  <Teleport defer to="#app">
    <Transition>
      <section id="postFormModal" v-show="props.isOpen">
        <div
            @click="$emit('close')"
            class="absolute bg-stone-500 dark:bg-stone-700 opacity-70 inset-0 z-0"
        ></div>
        <div
            class="absolute inset-0 top-0 flex items-start justify-center h-fit w-4/5
            p-3 mx-auto my-auto rounded-xl shadow-lg bg-[#eff5f3] opacity-90 dark:bg-[#2e3231]"
        >
          <div class="w-full font-roboto-mono tracking-tight">
            <div class="text-center p-3 flex-auto w-full justify-center leading-6">
              <!-- Close Button -->
              <div class="group absolute top-3 md:top-4 right-4 flex items-center justify-center w-10 h-10
              bg-gray-200 dark:bg-stone-800 rounded-full hover:cursor-pointer hover:-translate-y-0.5 transition duration-150"
                   @click="$emit('close')"
              >
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="w-6 h-6 text-black dark:text-white group-hover:text-gray-600 dark:group-hover:text-gray-400"
                    viewBox="0 0 24 24"
                    stroke-width="1.5"
                    stroke="currentColor"
                    fill="none"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                >
                  <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                  <line x1="18" y1="6" x2="6" y2="18" />
                  <line x1="6" y1="6" x2="18" y2="18" />
                </svg>
              </div>
            </div>
            <div class="w-full flex flex-col items-center justify-center h-full space-y-6 text-stone-800 dark:text-stone-200">
              <h2 class="text-2xl font-bold py-4">New Post</h2>
              <label for="#title-input" class="block w-11/12">
                <span class="font-semibold">Title</span> <span class="text-sm text-gray-600 dark:text-gray-400">1-50 characters</span>
                <input id="title-input" type="text" class="form-style" v-model="title" />
              </label>
              <label for="#content-input" class="block w-11/12">
                <span class="font-semibold">Content</span> <span class="text-sm text-gray-600 dark:text-gray-400">1-1000 characters</span>
                <textarea id="content-input" minlength="1" maxlength="1000" rows="5" class="form-style" v-model="content"></textarea>
              </label>
              <div class="flex flex-row items-center justify-around w-full space-x-10 mx-auto">
                <button type="submit" class="button-style cancel-button" @click="handleCancel">Cancel</button>
                <button type="submit" class="button-style create-button" @click="handleCreate">Create</button>
              </div>
            </div>
          </div>
        </div>
      </section>
    </Transition>
  </Teleport>
</template>

<style scoped>
.form-style {
  @apply mt-1 block w-full rounded-md border-gray-300 dark:border-stone-600 shadow-sm
    bg-white dark:bg-[#393f3d]
  focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50
  dark:focus:border-violet-950 dark:focus:ring-violet-600 dark:focus:ring-opacity-30
}

.button-style {
  @apply block px-4 py-2 w-auto rounded-md border-2 border-white dark:border-stone-400 hover:-translate-y-0.5 transition duration-150
}

.cancel-button {
  @apply bg-[#edcfd9] dark:bg-[#933557] hover:bg-[#e2b1c1] hover:dark:bg-[#a13a5f] active:bg-[#dda6b9] active:dark:bg-[#b8426d]
}

.create-button {
  @apply bg-[#bbe7d7] dark:bg-[#2f8365] hover:bg-[#a8e1cc] hover:dark:bg-[#399d79] active:bg-[#9dddc5] active:dark:bg-[#44bb91]
}

.v-enter-active,
.v-leave-active {
  transition: opacity 0.5s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
</style>
