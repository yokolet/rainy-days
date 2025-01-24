/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./app/views/layouts/application.html.erb",
    "./app/frontend/**/*.{vue,js,ts,tsx}"
  ],
  darkMode: 'class',
  theme: {
    extend: {
      backgroundImage: {
        'pink-cherry-blossom': "url('/assets/pink-cherry-blossom-in-rain.jpeg')",
        'purple-hydrangea': "url('/assets/purple-hydrangea-in-rain.jpeg')"
      }
    },
  },
  plugins: [],
}

