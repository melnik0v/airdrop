<template>
  <div class="devices">
    <Device v-for="device in devices" :device="device"/>
  </div>
  <PWABadge />
</template>

<script setup>
import Device from '~/components/Device.vue'
import PWABadge from '~/components/PWABadge.vue'
import { onMounted, ref } from "vue";
import { createConsumer } from "./config/consumer.js"

const online = ref(false)
const devices = ref([])
const consumer = ref(null)

onMounted(async () => {
  consumer.value = await createConsumer(
    data => online.value = data,
    data => devices.value = data
  )
})
</script>

<style scoped>
.devices {
  display: flex;
}
</style>
