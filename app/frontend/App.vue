<template>
  <div class="devices">
    <Device v-for="device in devices" :device="device" @click="ask(device)"/>
  </div>
  <PWABadge />
  <TemplatePromise v-slot="{ resolve, args, isResolving }">
    <div class="fixed inset-0 bg-black/10 flex items-center z-30">
      <dialog open class="border-gray/10 shadow rounded ma">
        <div>{{ args[0].name }} ({{ args[0].name }}) asked to send file</div>
        <div class="flex gap-2 justify-end">
          <button class="w-35" @click="resolve('cancel')">
            Cancel
          </button>
          <button class="w-35" :disabled="isResolving" @click="resolve(asyncFn())">
            {{ isResolving ? 'Confirming...' : 'OK' }}
          </button>
        </div>
      </dialog>
    </div>
  </TemplatePromise>
</template>

<script setup>
import { createTemplatePromise } from '@vueuse/core'
import Device from '~/components/Device.vue'
import PWABadge from '~/components/PWABadge.vue'
import { onMounted, ref } from "vue"
import { CABLE_NEARBY_CHANNEL } from "./config/constants.js"
import cable from "./config/cable"
import { getFingerprint } from "@thumbmarkjs/thumbmarkjs"

const TemplatePromise = createTemplatePromise()

const asyncFn = () => {
  return new Promise(resolve => setTimeout(resolve, 1000))
}

const open = async data => {
  const result = await TemplatePromise.start(data)
}

const online = ref(false)
const devices = ref([])
const iam = ref({})

const ask = device => cable.use(CABLE_NEARBY_CHANNEL).ask(device)

onMounted(async () => {
  window.fingerprint = await getFingerprint()
  await cable.init({ device: window.fingerprint })

  cable.subscribe(CABLE_NEARBY_CHANNEL, {
    connected() {
      online.value = true
    },

    disconnected() {
      online.value = false
    },

    rejected() {
      console.log("rejected")
    },

    received({ event, data }) {
      console.info(`Received ${event} with data ${JSON.stringify(data)}`)

      switch (event) {
        case "users_list":
          devices.value = data
          iam.value = data.find(el => el.fingerprint === window.fingerprint)
          break
        case "ask":
          open(data)
      }
    },

    ask({ fingerprint, ...device }) {
      console.log(device)
      this.perform("ask", { fingerprint })
    }
  })
})
</script>

<style scoped>
.devices {
  display: flex;
}
</style>
