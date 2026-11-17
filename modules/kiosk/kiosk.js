// Full-screen WebKit view with no browser UI. Usage: kiosk <url>

import GLib from "gi://GLib";
import Gtk from "gi://Gtk?version=4.0";
import WebKit from "gi://WebKit?version=6.0";

const url = ARGV[0];
const app = new Gtk.Application({ application_id: "lab.home.Kiosk" });

app.connect("activate", () => {
  // WebKit reports this to pages as prefers-color-scheme: dark.
  Gtk.Settings.get_default().gtk_application_prefer_dark_theme = true;

  const web = new WebKit.WebView();
  // Swipes would otherwise navigate back and forward.
  web.get_settings().enable_back_forward_navigation_gestures = false;
  // The page renders in a separate process. Reload if it dies.
  web.connect("web-process-terminated", () => {
    GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 5, () => {
      web.load_uri(url);
      return GLib.SOURCE_REMOVE;
    });
  });
  web.load_uri(url);

  const win = new Gtk.ApplicationWindow({ application: app, child: web });
  win.fullscreen();
  win.present();
});

app.run([]);
