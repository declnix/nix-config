import app from "ags/gtk3/app"
import { Astal } from "ags/gtk3"
import { createBinding } from "ags"
import { createPoll } from "ags/time"
import Network from "gi://AstalNetwork"
import Battery from "gi://AstalBattery"
import css from "./style.css"

const network = Network.get_default()
const battery = Battery.get_default()
const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

function NetworkWidget() {
  const wifi = createBinding(network, "wifi")
  return (
    <label label={wifi(w => w?.ssid ? `󰤨  ${w.ssid}` : "󰤭")} />
  )
}

function BatteryWidget() {
  const percent = createBinding(battery, "percentage")
  return (
    <label
      class={percent(p =>
        battery.charging ? "charging" : p <= 15 ? "critical" : p <= 30 ? "warning" : ""
      )}
      label={percent(p =>
        battery.charging
          ? `󰂄  ${p}%`
          : `${["󰁺","󰁻","󰁼","󰁽","󰁾","󰁿","󰂀","󰂁","󰂂","󰁹"][Math.floor(p / 10)]}  ${p}%`
      )}
    />
  )
}

function Clock() {
  const time = createPoll("", 60000, () => {
    const d = new Date()
    return `󰃰  ${d.toLocaleString("en-GB", {
      day: "2-digit", month: "short", hour: "2-digit", minute: "2-digit",
    })}`
  })
  return <label label={time} />
}

app.start({
  css,
  main() {
    return (
      <window
        name="bar"
        anchor={TOP | LEFT | RIGHT}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
      >
        <centerbox>
          <box hexpand />
          <box />
          <box class="modules-right">
            <NetworkWidget />
            <BatteryWidget />
            <Clock />
          </box>
        </centerbox>
      </window>
    )
  },
})