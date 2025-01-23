import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'

export default defineConfig({
  base: "",
  plugins: [
    RubyPlugin(),
    vue(),
    vueDevTools(),
  ],
})
