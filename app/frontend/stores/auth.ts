import { defineStore } from 'pinia'
import { ref } from 'vue'
import axios from 'axios'

export const useAuthStore = defineStore('auth', () => {
  const isAuthenticated = ref<boolean>(false)
  const email = ref<string | null>(null)
  const userId = ref<string | null>(null)
  const provider = ref<string | null>(null)
  const imageUrl = ref<string | null>(null)

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

  const updateUserData = () => {
    const cookieHeader = 'rainy-days='
    if (document.cookie.startsWith(cookieHeader)) {
      const decodedCookie = decodeURIComponent(document.cookie)
      const cookieValues = JSON.parse(decodedCookie.slice(cookieHeader.length))
      email.value = cookieValues.email
      userId.value = cookieValues.uid
      provider.value = cookieValues.provider
      imageUrl.value = cookieValues.image_url
      isAuthenticated.value = true
    }
  }

  const logout = () => {
    email.value = null
    userId.value = null
    provider.value = null
    imageUrl.value = null
    isAuthenticated.value = false
    const cookieHeader = 'rainy-days='
    if (document.cookie.startsWith(cookieHeader)) {
      document.cookie = 'rainy-days=; Expires=Thu, 01 Jan 1970 00:00:01 GMT; path=/;'
    }
  }

  return { isAuthenticated, email, userId, provider, imageUrl, getAuthFullPath, updateUserData, logout };
})
