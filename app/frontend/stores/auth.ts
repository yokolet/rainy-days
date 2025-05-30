import { defineStore } from "pinia"
import { ref } from "vue"
import axios from "axios"
import * as cookie from 'cookie'

export const useAuthStore = defineStore("auth", () => {
  const isAuthenticated = ref<boolean>(false)
  const username = ref<string | null>(null)
  const provider = ref<string | null>(null)
  const imageUrl = ref<string | null>(null)

  const csrfToken = () => {
    const meta = document.querySelector("meta[name=csrf-token]")
    const token = meta && meta.getAttribute("content")
    return token ?? false
  }

  const getAuthFullPath = async (provider: string) => {
    const url = `${window.location.protocol}//${window.location.host}/sign_in/${provider}`
    const response = await axios.get(url)
    if (response.status !== 200) {
      throw new Error(`Unable to get auth provider: ${provider}`)
    }
    console.log(response.data)
    const params = new URLSearchParams(response.data?.params).toString()
    return `${response.data.endpoint}?${params}`
  }

  const updateUserData = () => {
    const local_cookies = cookie.parse(document.cookie)
    if (local_cookies && "rainy-days" in local_cookies) {
      const cookieValues = local_cookies['rainy-days']
      const cookieObject = JSON.parse(cookieValues)
      username.value = cookieObject.username
      provider.value = cookieObject.provider
      imageUrl.value = cookieObject.image
      isAuthenticated.value = !!(username.value && provider.value)
    }
  }

  const logout = async () => {
    const url = `${window.location.protocol}//${window.location.host}/sign_out`
    const response = await axios.delete(url, {
      headers: { "X-CSRF-Token": csrfToken() },
    })
    if (response.status !== 204) {
      throw new Error("Unable to logout")
    }
    username.value = null
    provider.value = null
    imageUrl.value = null
    isAuthenticated.value = false
    const cookieHeader = "rainy-days="
    if (document.cookie.startsWith(cookieHeader)) {
      document.cookie =
        "rainy-days=; Expires=Thu, 01 Jan 1970 00:00:01 GMT; path=/;"
    }
  }

  return {
    isAuthenticated,
    username,
    provider,
    imageUrl,
    getAuthFullPath,
    updateUserData,
    logout,
  }
})
