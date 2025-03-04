<script setup lang="ts">
import { useAuthStore } from "../stores/auth"

const props = defineProps<{ isOpen: boolean }>()
defineEmits(["close"])

const store = useAuthStore()

const handleGoogleLogin = async () => {
  const authFullPath = await store.getAuthFullPath("google")
  window.open(authFullPath, "_self")
}

const handleGitHubLogin = async () => {
  const authFullPath = await store.getAuthFullPath("github")
  window.open(authFullPath, "_self")
}

const handleGitLabLogin = async () => {
  const authFullPath = await store.getAuthFullPath("gitlab")
  window.open(authFullPath, "_self")
}
</script>

<template>
  <Teleport defer to="#app">
    <Transition>
      <section id="loginModal" v-show="props.isOpen">
        <div
          @click="$emit('close')"
          class="absolute inset-0 z-0 bg-stone-500 opacity-70 dark:bg-stone-700"
        ></div>
        <div
          class="absolute inset-0 top-0 mx-auto my-auto flex h-80 max-w-sm
            items-center justify-center rounded-xl bg-[#eff5f3] p-3 opacity-90
            shadow-lg dark:bg-[#2e3231] md:max-w-lg"
        >
          <div>
            <div class="flex-auto justify-center p-3 text-center leading-6">
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
              <h2
                class="py-4 text-2xl font-bold text-stone-800
                  dark:text-stone-200"
              >
                Log in with
              </h2>
            </div>
            <div
              class="mt-2 flex flex-col space-y-4 p-3 text-center md:block
                md:space-x-4"
            >
              <button class="social-button" @click="handleGoogleLogin">
                <span
                  ><font-awesome-icon :icon="['fab', 'google']" /> Google</span
                >
              </button>
              <button class="social-button" @click="handleGitHubLogin">
                <span
                  ><font-awesome-icon :icon="['fab', 'github']" /> GitHub</span
                >
              </button>
              <button class="social-button" @click="handleGitLabLogin">
                <span
                  ><font-awesome-icon :icon="['fab', 'gitlab']" /> GitLab</span
                >
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
  @apply mb-2 rounded-md border bg-white px-5 py-2 text-base font-medium tracking-wider text-stone-600 shadow-sm hover:scale-105 hover:bg-stone-100 hover:shadow-lg dark:border-stone-700 dark:bg-stone-900 dark:text-stone-100 hover:dark:bg-stone-700 md:mb-0;
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
