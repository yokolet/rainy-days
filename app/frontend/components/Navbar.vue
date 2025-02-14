<script setup lang="ts">
import { RouterLink, useRoute } from 'vue-router'
import User from './User.vue'
import { useAuthStore } from '../stores/auth'
import { storeToRefs } from 'pinia'
import { useDark, useToggle } from '@vueuse/core'
import LoginModal from './LoginModal.vue'
import PostFormModal from './PostFormModal.vue'
import { ref } from 'vue'

const isDark = useDark();
const toggleDark = useToggle(isDark)

const store = useAuthStore();
const {isAuthenticated} = storeToRefs(store)

const isOpen = ref<boolean>(false)
const isPostOpen = ref<boolean>(false)
</script>

<template>
  <header id="navbar">
    <div class="w-full mx-auto p-4 font-roboto-mono font-bold bg-[#dfebe7] dark:bg-[#393f3d] text-[#2f2226] dark:text-[#f4f3f4]">
      <nav class="flex items-center justify-between">
        <div class="flex flex-row items-center justify-start space-x-4 text-base md:text-lg lg:text-xl">
          <RouterLink to="/" active-class="underline">Home</RouterLink>
          <RouterLink to="/about" active-class="underline">About</RouterLink>
        </div>
        <div class="flex flex-row items-center justify-end space-x-4">
          <div id="post-form" class="" @click="isPostOpen=true"><font-awesome-icon :icon="['fas', 'pen-to-square']" /></div>
          <PostFormModal :is-open="isPostOpen" @close="isPostOpen = false" />
          <User v-show="isAuthenticated" />
          <div id="logout" class="auth-button" v-if="isAuthenticated" @click="store.logout()">Logout</div>
<!--          <div id="login" class="auth-button" v-else @click="store.authenticate()">Login</div>-->
          <div id="login" class="auth-button" v-else @click="isOpen=true">Login</div>
          <LoginModal :is-open="isOpen" @close="isOpen = false" />
          <button
              id="theme-toggle"
              class="hover:bg-gray-100 dark:hover:bg-[#737977] focus:outline-none
            focus:ring-2 focus:ring-zinc-100 dark:focus:ring-zinc-600 rounded-lg text-sm p-2.5"
              @click="toggleDark()"
          >
            <!-- Dark SVG Icon -->
            <svg
                v-show="!isDark"
                id="theme-toggle-dark-icon"
                class="w-5 h-5"
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
            >
              <path
                  d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"
              ></path>
            </svg>
            <!-- Light SVG Icon -->
            <svg
                v-show="isDark"
                id="theme-toggle-light-icon"
                class="w-5 h-5"
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
            >
              <path
                  d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z"
                  fill-rule="evenodd"
                  clip-rule="evenodd"
              ></path>
            </svg>
          </button>
        </div>
      </nav>
    </div>
  </header>
</template>

<style scoped>
.auth-button {
  @apply cursor-pointer px-4 py-2 rounded-lg hover:bg-gray-100 dark:hover:bg-[#737977] focus:outline-none
  focus:ring-2 focus:ring-zinc-100 dark:focus:ring-zinc-600 text-base md:text-lg
}
</style>
