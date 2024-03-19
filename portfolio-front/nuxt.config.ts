export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: ['@pinia/nuxt', '@nuxtjs/i18n'],
  i18n: {
    seo: true,
    strategy: 'prefix_and_default',
    langDir: 'locales/',
    lazy: true,
    baseUrl: process.env.NUXT_BASE_URL,
    defaultLocale: 'en',
    locales: [
      {
        name: 'English',
        code: 'en',
        iso: 'en',
        file: 'en/index.ts'
      },
      {
        name: 'Français',
        code: 'fr',
        iso: 'fr',
        file: 'fr/index.ts'
      }
    ],
    detectBrowserLanguage: {
      useCookie: true,
      cookieKey: 'i18n_redirected',
      redirectOn: 'root'
    }
  },
  css: [
    'assets/styles/index.scss'
  ]
})
