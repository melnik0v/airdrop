// const channels = import.meta.globEager('./**/*_channel.js')

import '~/styles/index.css'

import { createPinia } from 'pinia'
import { createApp } from 'vue'

const pinia = createPinia()

import App from '~/App.vue'

createApp(App)
  .use(pinia)
  .mount('#app')
