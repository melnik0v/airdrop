import * as ActionCable from "@rails/actioncable"
import { CABLE_URL, CABLE_NEARBY_CHANNEL } from "./constants"

export default {
  consumer: null,
  subscriptions: {},

  async init(params) {
    const query = new URLSearchParams(params).toString()
    this.consumer = ActionCable.createConsumer(`${CABLE_URL}?${query}`)
  },

  subscribe(channel, options) {
    const subs = this.consumer.subscriptions.create(channel, options)
    this.subscriptions[channel] = subs
    return subs
  },

  use(channel) {
    return this.subscriptions[channel]
  }
}
