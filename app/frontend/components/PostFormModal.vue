<script setup lang="ts">
import { usePostCreate } from "../composables/usePostCreate"

const props = defineProps<{ isOpen: boolean }>()
const emit = defineEmits(["close"])

const { title, content, postCreate, postCreateLoading, postCreateError } =
  usePostCreate()

const handleCreate = () => {
  postCreate()
  emit("close")
}

const handleCancel = () => {
  title.value = ""
  content.value = ""
  emit("close")
}
</script>

<template>
  <Teleport defer to="#app">
    <Transition>
      <section id="postFormModal" v-show="props.isOpen">
        <div
          @click="$emit('close')"
          class="absolute inset-0 z-0 bg-stone-500 opacity-70 dark:bg-stone-700"
        ></div>
        <div
          class="absolute inset-0 top-0 mx-auto my-auto flex h-fit w-4/5
            items-start justify-center rounded-xl bg-[#eff5f3] p-3 opacity-90
            shadow-lg dark:bg-[#2e3231]"
        >
          <div class="w-full font-roboto-mono tracking-tight">
            <div
              class="w-full flex-auto justify-center p-3 text-center leading-6"
            >
              <!-- Close Button -->
              <div
                class="group absolute right-4 top-3 flex h-10 w-10 items-center
                  justify-center rounded-full bg-gray-200 transition
                  duration-150 hover:-translate-y-0.5 hover:cursor-pointer
                  dark:bg-stone-800 md:top-4"
                @click="$emit('close')"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-6 w-6 text-black group-hover:text-gray-600
                    dark:text-white dark:group-hover:text-gray-400"
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
            <div
              class="flex h-full w-full flex-col items-center justify-center
                space-y-6 text-stone-800 dark:text-stone-200"
            >
              <h2 class="py-4 text-2xl font-bold">New Post</h2>
              <label for="#title-input" class="block w-11/12">
                <span class="font-semibold">Title</span>
                <span class="text-sm text-gray-600 dark:text-gray-400"
                  >1-50 characters</span
                >
                <input
                  id="title-input"
                  type="text"
                  class="form-style"
                  v-model="title"
                />
              </label>
              <label for="#content-input" class="block w-11/12">
                <span class="font-semibold">Content</span>
                <span class="text-sm text-gray-600 dark:text-gray-400"
                  >1-1000 characters</span
                >
                <textarea
                  id="content-input"
                  minlength="1"
                  maxlength="1000"
                  rows="5"
                  class="form-style"
                  v-model="content"
                ></textarea>
              </label>
              <div
                class="mx-auto flex w-full flex-row items-center justify-around
                  space-x-10"
              >
                <button
                  type="submit"
                  class="button-style cancel-button"
                  @click="handleCancel"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  class="button-style create-button"
                  @click="handleCreate"
                >
                  Create
                </button>
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
  @apply mt-1 block w-full rounded-md border-gray-300 bg-white shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:border-stone-600 dark:bg-[#393f3d] dark:focus:border-violet-950 dark:focus:ring-violet-600 dark:focus:ring-opacity-30;
}

.button-style {
  @apply block w-auto rounded-md border-2 border-white px-4 py-2 transition duration-150 hover:-translate-y-0.5 dark:border-stone-400;
}

.cancel-button {
  @apply bg-[#edcfd9] hover:bg-[#e2b1c1] active:bg-[#dda6b9] dark:bg-[#933557] hover:dark:bg-[#a13a5f] active:dark:bg-[#b8426d];
}

.create-button {
  @apply bg-[#bbe7d7] hover:bg-[#a8e1cc] active:bg-[#9dddc5] dark:bg-[#2f8365] hover:dark:bg-[#399d79] active:dark:bg-[#44bb91];
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
