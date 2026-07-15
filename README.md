# This is a **b**are **m**inimal bar

![Screenshot](/docs/bar_closed.png)
---
![Screenshot with popups opened](/docs/bar_opened.png)

A simple, dependency-light and easy to customize bar based on [Quickshell](https://quickshell.org/).

The goal of this project is to just provide a really minimal bar for [Hyprland](https://hypr.land/).

## Why use this
- Minimal: no install scripts, just 3 external dependencies
- Non-invasive: doesn't change anything in your config
- Customizable: modify QML components as you wish

## Dependencies
- Hyprland (duh)
- Quickshell
- Nerd Font Icons (you can also use others)
- playerctl
- Matugen (optional)

## (really) Quick start
1. Clone the repo 

`git clone https://github.com/jukoby/bmbar.git`

2. Rename the folder or just use a symlink

`ln -s location/of/bmbar/ $XDG_CONFIG_HOME/quickshell`

3. (If you don't want to use Matugen for setting your primary color)

`cp $XDG_CONFIG_HOME/quickshell/theme/Theme.template $XDG_CONFIG_HOME/quickshell/theme/Theme.qml`

```qml
pragma Singleton
import Quickshell

Singleton {
    // replace with the color of your choice 
    property string primary: "{{ colors.on_surface.default.hex }}" // e.g "white"
}
```

## Features

- fully functional system tray
- audio menu to switch devices and  
- power menu (shutdown, reboot, sleep, logout)
- media menu working with playerctl for better reliability
- toggle buttons: hyprsunset (night light), sleep inhibitor
- color picker
- notification daeman showing incoming notifications
- updater for arch and pacman
- runs commands in installed terminal emulator automatically

## TODO
- fix small animation issues
- basic config file
- workspace overview
- maybe support other compositors (e.g. niri)
- easier setup without Matugen
- updater for other distros (fedora, debian)

## Contributing
- Prefer small, focused PRs.
- Follow existing coding style in QML files.

## Supported Terminal Emulators for auto detection
- alacritty, konsole, xterm, ghostty, gnome-terminal, kitty, foot
