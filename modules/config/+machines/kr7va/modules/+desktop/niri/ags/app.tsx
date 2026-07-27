import app from "ags/gtk4/app";
import { Astal, Gdk, Gtk } from "ags/gtk4";
import { createPoll } from "ags/time";
import { execAsync } from "ags/process";
import { createState } from "ags";
import Battery from "gi://AstalBattery";
import Network from "gi://AstalNetwork";
import css from "./style.css";

const battery = Battery.get_default();
const network = Network.get_default();
const [panelVisible, setPanelVisible] = createState(true);

const run = (command: string) =>
  execAsync(["bash", "-lc", command]).catch((error) => {
    console.error(error);
  });

const requestToggle = (name: string) => run(`kr7va-shell toggle ${name}`);

const toggle = (name: string) => {
  const win = app.get_window(name);
  if (win) {
    win.visible = !win.visible;
  }
};

const request = (argv: string[], response: (value: string) => void) => {
  const [command, target] = argv;

  if (command === "close" && target) {
    const win = app.get_window(target);
    if (win) {
      win.visible = false;
    }
    response(`closed ${target}`);
    return;
  }

  if (command === "toggle" && target) {
    toggle(target);
    response(`toggled ${target}`);
    return;
  }

  if (command === "panel-toggle") {
    setPanelVisible((visible) => !visible);
    response("toggled panel");
    return;
  }

  if (command === "wallpaper") {
    run("kr7va-shell wallpaper");
    response("wallpaper applied");
    return;
  }

  if (command === "volume-up") {
    run("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+");
    response("volume up");
    return;
  }

  if (command === "volume-down") {
    run("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-");
    response("volume down");
    return;
  }

  if (command === "volume-mute") {
    run("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle");
    response("volume mute");
    return;
  }

  if (command === "brightness-up") {
    run("brightnessctl set 5%+");
    response("brightness up");
    return;
  }

  if (command === "brightness-down") {
    run("brightnessctl set 5%-");
    response("brightness down");
    return;
  }

  response("unknown request");
};

const pill = (label: string, command: string, extraClass = "") => (
  <button class={`pill ${extraClass}`} onClicked={() => run(command)}>
    <label label={label} />
  </button>
);

const togglePill = (label: string, windowName: string, extraClass = "") => (
  <button class={`pill ${extraClass}`} onClicked={() => toggle(windowName)}>
    <label label={label} />
  </button>
);

function Bar() {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;
  const clock = createPoll("", 1000, "date '+%H:%M'");
  const wifiLabel = createPoll("󰤭 offline", 5000, () => {
    const ssid = network.wifi?.ssid;
    return ssid ? `󰤨 ${ssid}` : "󰤭 offline";
  });
  const batteryLabel = createPoll("󰁿 --%", 30000, () => {
    const value = Math.round(battery.percentage * 100);
    return value >= 95 ? `󰁹 ${value}%` : `󰁿 ${value}%`;
  });

  return (
    <window
      name="Bar"
      application={app}
      visible
      anchor={TOP | LEFT | RIGHT}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      layer={Astal.Layer.TOP}
      class="bar-window"
    >
      <box class="bar-stage" orientation={1}>
        <revealer
          class="bar-revealer"
          revealChild={panelVisible}
          transitionDuration={180}
          transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        >
          <centerbox class="bar">
            <box $type="start" spacing={8} />
            <box $type="center">
              <button
                class="clock-button"
                onClicked={() => requestToggle("Calendar")}
              >
                <label class="clock" label={clock} />
              </button>
            </box>
            <box $type="end" spacing={8}>
              <label class="bar-status wifi-status" label={wifiLabel} />
              <label class="bar-status battery-status" label={batteryLabel} />
            </box>
          </centerbox>
        </revealer>
      </box>
    </window>
  );
}

function Popup({
  name,
  title,
  children,
}: {
  name: string;
  title: string;
  children: any;
}) {
  const { TOP, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      name={name}
      application={app}
      visible={false}
      anchor={TOP | RIGHT}
      keymode={Astal.Keymode.ON_DEMAND}
      layer={Astal.Layer.TOP}
      class="popup-window"
    >
      <Gtk.EventControllerKey
        onKeyPressed={(_, keyval: number) => {
          if (keyval === Gdk.KEY_Escape) {
            const win = app.get_window(name);
            if (win) {
              win.visible = false;
            }
          }
        }}
      />
      <box class="popup" orientation={1} spacing={14}>
        <label class="popup-title" label={title} />
        {children}
      </box>
    </window>
  );
}

function Launcher() {
  return (
    <Popup name="Launcher" title="Applications">
      <box orientation={1} spacing={10}>
        {pill("󰍉  Fuzzel", "fuzzel")}
        {pill("  Terminal", "alacritty")}
        {pill("󰈹  Firefox", "firefox")}
      </box>
    </Popup>
  );
}

function Calendar() {
  const fullDate = createPoll("", 60000, "date '+%A, %d %B %Y'");
  const calendar = createPoll("", 60000, "cal -m");

  return (
    <Popup name="Calendar" title="Today">
      <box orientation={1} spacing={12}>
        <label class="status-row" label={fullDate} />
        <label class="calendar" label={calendar} />
      </box>
    </Popup>
  );
}

function Session() {
  return (
    <Popup name="Session" title="Session">
      <box orientation={1} spacing={10}>
        {pill("󰌾  Lock", "kr7va-lock", "accent")}
        {pill("󰒲  Suspend", "systemctl suspend")}
        {pill("󰗽  Logout", "niri msg action quit")}
        {pill("󰜉  Reboot", "systemctl reboot", "danger")}
        {pill("󰐥  Power Off", "systemctl poweroff", "danger")}
      </box>
    </Popup>
  );
}

function SimplePopup({
  name,
  title,
  text,
}: {
  name: string;
  title: string;
  text: string;
}) {
  return (
    <Popup name={name} title={title}>
      <label class="status-row" label={text} />
    </Popup>
  );
}

app.start({
  instanceName: "kr7va-shell",
  css,
  requestHandler: request,
  main() {
    Bar();
    Launcher();
    Calendar();
    Session();
  },
});
