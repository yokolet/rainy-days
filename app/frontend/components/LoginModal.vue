<script setup lang="ts">
const props = defineProps<{ isOpen: boolean }>()
defineEmits(['close'])
</script>

<template>
  <Teleport defer to="#app">
    <Transition>
    <section id="loginModal" v-show="props.isOpen">
      <div
          @click="$emit('close')"
          class="absolute bg-stone-500 dark:bg-stone-700 opacity-70 inset-0 z-0"
      ></div>
      <div
          class="absolute inset-0 top-0 flex items-center justify-center h-80 max-w-sm md:max-w-lg
          p-3 mx-auto my-auto rounded-xl shadow-lg bg-[#eff5f3] opacity-90 dark:bg-[#2e3231]"
      >
        <div>
          <div class="text-center p-3 flex-auto justify-center leading-6">
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
            <h2 class="text-2xl font-bold py-4 text-stone-800 dark:text-stone-200">Log in with</h2>
          </div>
          <div class="flex flex-col p-3 mt-2 text-center space-y-4 md:space-x-4 md:block">
            <button class="social-button">
              <span><font-awesome-icon :icon="['fab', 'google']" /> Google</span>
            </button>
            <button class="social-button">
              <span><font-awesome-icon :icon="['fab', 'github']" /> GitHub</span>
            </button>
            <button class="social-button">
              <span><font-awesome-icon :icon="['fab', 'gitlab']" /> GitLab</span>
            </button>
          </div>
        </div>
      </div>
    </section>
      </Transition>
  </Teleport>

</template>

<style scoped>
.social-button {
  @apply mb-2 md:mb-0 bg-white dark:bg-stone-900 px-5 py-2 text-base shadow-sm font-medium tracking-wider
  border dark:border-stone-700 text-stone-600 dark:text-stone-100 rounded-md hover:shadow-lg
  hover:bg-stone-100 hover:dark:bg-stone-700 hover:scale-105
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
