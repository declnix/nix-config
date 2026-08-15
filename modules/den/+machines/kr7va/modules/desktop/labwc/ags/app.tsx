import { createBinding, createComputed } from "ags";
import app from "ags/gtk4/app";
import { Astal, Gtk } from "ags/gtk4";
import Battery from "gi://AstalBattery";

const battery = Battery.get_default();

function BatteryPercentage() {
  const percentage = createBinding(battery, "percentage");
  const label = createComputed(() => `${Math.round(percentage() * 100)}%`);

  return <label class="battery" label={label} />;
}

app.start({
  css: `
    window {
      all: unset;
      background: #15191f;
      color: #edf2f7;
      font: 600 13px "Inter", "Noto Sans", sans-serif;
    }

    box.panel {
      min-height: 28px;
      padding: 0 12px;
    }

    label.battery {
      padding: 0 8px;
    }
  `,

  main() {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

    return (
      <window
        visible
        anchor={TOP | LEFT | RIGHT}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
      >
        <box class="panel" halign={Gtk.Align.END} valign={Gtk.Align.CENTER}>
          <BatteryPercentage />
        </box>
      </window>
    );
  },
});
