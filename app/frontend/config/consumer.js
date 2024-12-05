import * as ActionCable from "@rails/actioncable"
import { getFingerprint } from "@thumbmarkjs/thumbmarkjs"
import { CABLE_URL, CABLE_CHANNEL } from "./constants"

export const createConsumer = async (online_callback, data_callback) => {
  const fp = await getFingerprint()
  const consumer = ActionCable.createConsumer(`${CABLE_URL}?device=${fp}`)
  consumer.subscriptions.create(CABLE_CHANNEL, {
    connected() {
      online_callback(true)
    },

    disconnected() {
      online_callback(false)
    },

    rejected() {},

    received({ event, data }) {
      data_callback(data)
    }
  })

  return consumer
}
