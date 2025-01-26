import { defineStore } from 'pinia';
import { ref } from 'vue';

export const useAuthStore = defineStore('auth', () => {
  const isAuthenticated = ref<boolean>(false);
  const authProvider = ref<string | null>(null);
  const username = ref<string | null>(null);

  const authenticate = () => {
    isAuthenticated.value = true;
    authProvider.value = "auth provider";
    username.value = "Whoami";
  }

  const logout = () => {
    isAuthenticated.value = false;
    authProvider.value = "";
    username.value = "";
  }

  return { isAuthenticated, authProvider, username, authenticate, logout };
})
