# 🌌 Hyprland Dotfiles

My personal configuration files for a dynamic, aesthetic Hyprland setup.

<p align="center">
  <img src="https://github.com/Mysz0/screenshots/blob/main/dotfiles/Screenshot_11-Jan_14-28-08_30953.png?raw=true" width="48%" />
  <img src="https://github.com/Mysz0/screenshots/blob/main/dotfiles/Screenshot_11-Jan_15-39-34_10847.png?raw=true" width="48%" /> 
  <img src="https://github.com/Mysz0/screenshots/blob/main/dotfiles/Screenshot_11-Jan_15-40-15_31385.png?raw=true" width="48%" />
  <img src="https://github.com/Mysz0/screenshots/blob/main/dotfiles/Screenshot_11-Jan_15-42-14_28273.png?raw=true" width="48%" />
</p>

## 🖼️ Features

* **Window Manager:** [Hyprland](https://hyprland.org/) (Dwindle layout)
* **Theming Engine:** [Matugen](https://github.com/InioX/matugen) - Generates color schemes from your wallpaper automatically.
* **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/)
* **Launcher:** [Rofi](https://github.com/lbonn/rofi) (with custom styles)
* **File Manager:** [Yazi](https://github.com/sxyazi/yazi) (Terminal) & Dolphin (GUI)
* **Editor:** [Neovim](https://neovim.io/) (LazyVim distribution)
* **Bar:** Waybar
* **Notification daemon:** Swaync
* **Lock Screen:** Hyprlock
* **Idle Daemon:** Hypridle
* **Wallpaper Daemon:** swww

## 📦 Dependencies

To use this configuration fully, you will need the following packages installed on your system (names may vary by distribution):

* `hyprland`
* `kitty`
* `rofi-wayland`
* `swww`
* `matugen-git`
* `hypridle`
* `hyprlock`
* `hyprpick`
* `wlogout`
* `zsh`
* `btop`
* `cava`
* `fastfetch`
* `yazi`
* `neovim`
* `zen-browser` (or change `$browser` in variables)
* `dolphin`
* `grim`, `slurp`, `swappy` (for screenshots)
* `wl-clipboard`
* `playerctl`
* `waybar`
* `swaync`

## ⌨️ Keybindings

**Mod Key:** `SUPER` (Windows Key)

| Action | Keybinding |
| :--- | :--- |
| **Terminal** | `Mod` + `T` |
| **App Launcher** | `Alt` + `Space` |
| **Browser (Zen)** | `Mod` + `A` |
| **File Manager (Dolphin)** | `Mod` + `E` |
| **File Manager (Yazi)** | `Mod` + `Shift` + `E` |
| **System Monitor (btop)** | `Ctrl` + `Shift` + `Esc` |
| **Close Window** | `Mod` + `Q` |
| **Fullscreen** | `Mod` + `Shift` + `F` |
| **Float Window** | `Mod` + `F` |
| **Logout Menu** | `Mod` + `Esc` |
| **Lock Screen** | `Mod` + `L` |

### Utility

| Action | Keybinding |
| :--- | :--- |
| **Screenshot (Full)** | `Mod` + `Shift` + `U` |
| **Screenshot (Area)** | `Mod` + `U` |
| **Screenshot (Edit)** | `Mod` + `Ctrl` + `U` |
| **Clipboard History** | `Mod` + `V` |
| **Emoji Picker** | `Mod` + `.` |
| **Change Wallpaper** | `Mod` + `,` |
| **Random Wallpaper** | `Mod` + `Shift` + `,` |

## 🎨 Theming

This setup uses **Matugen** to generate a color palette from the current wallpaper set by `swww`.
When you change the wallpaper (via the keybinds above), Matugen automatically updates colors for:
* Hyprland borders
* Kitty
* Rofi
* Hyprlock
* Wlogout
* Gtk

## 📂 Installation

1.  Clone this repository:
    ```bash
    git clone https://github.com/Mysz0/dotfiles
    ```
# I used code from dotfiles like: [Matuprland](https://github.com/Abhra00/Matuprland) and [Elifouts](https://github.com/elifouts/Dotfiles)
