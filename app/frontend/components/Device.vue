<script setup>
defineProps({
  device: Object
})

const fp = window.fingerprint
</script>

<template>
  <div class="device">
    <img src="../assets/vue.svg" />
    <span>{{ device.name }}</span>
    <span v-if="device.fingerprint === fp">self</span>
  </div>
</template>

<style scoped>
.device {
  display: flex;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
  justify-content: center;
    align-items: center;
    flex-direction: column;
}
img {
  height: 3em;
  width: 3em;
}
.device:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}
.device.vue:hover {
  filter: drop-shadow(0 0 2em #42b883aa);
}
</style>
