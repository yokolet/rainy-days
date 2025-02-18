import { defineStore } from 'pinia';
import { ref } from 'vue';
import axios from 'axios';

export const useAuthStore = defineStore('auth', () => {
  const isAuthenticated = ref<boolean>(false)
  const authProvider = ref<string | null>(null)
  const username = ref<string | null>(null)

  const getAuthFullPath = async (provider: string) => {
    const url = `${window.location.protocol}//${window.location.host}/sign_in/${provider}`
    const response = await axios.get(url)
    if (response.status !== 200) {
      throw new Error(`Unable to get auth provider: ${provider}`)
    }
    console.log(response.data)
    const params = new URLSearchParams(response.data?.params).toString()
    return `${response.data.authorization_url}?${params}`
  }

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

  return { isAuthenticated, authProvider, username, authenticate, getAuthFullPath, logout };
})
