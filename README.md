# 🌌 Hyprland Dotfiles

My personal configuration files for a dynamic, aesthetic Hyprland setup.

# ❗ Warning ai made my quickshell config so I am still changing things up.



<p align="center">
  <img src="https://github.com/Mysz0/screenshots/blob/main/Screenshot_28-Nov_20-41-03_4358.png?raw=true" width="48%" />
  <img src="https://github.com/Mysz0/screenshots/blob/main/Screenshot_28-Nov_20-42-13_31089.png?raw=true" width="48%" /> 
  <img src="https://github.com/Mysz0/screenshots/blob/main/Screenshot_28-Nov_20-43-14_25219.png?raw=true" width="48%" />
  <img src="https://github.com/Mysz0/screenshots/blob/main/Screenshot_28-Nov_20-44-07_29483.png?raw=true" width="48%" />
</p>

## 🖼️ Features

* **Window Manager:** [Hyprland](https://hyprland.org/) (Dwindle layout)
* **Theming Engine:** [Matugen](https://github.com/InioX/matugen) - Generates color schemes from your wallpaper automatically.
* **Bar & Widgets:** [Quickshell](https://github.com/outfoxxed/quickshell)
* **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/)
* **Launcher:** [Rofi](https://github.com/lbonn/rofi) (with custom styles)
* **File Manager:** [Yazi](https://github.com/sxyazi/yazi) (Terminal) & Dolphin (GUI)
* **Editor:** [Neovim](https://neovim.io/) (LazyVim distribution)
* **Lock Screen:** Hyprlock
* **Idle Daemon:** Hypridle
* **Wallpaper Daemon:** swww

## 📦 Dependencies

To use this configuration fully, you will need the following packages installed on your system (names may vary by distribution):

* `hyprland`
* `kitty`
* `rofi-wayland`
* `swww`
* `matugen-bin` (or build from source)
* `hypridle`
* `hyprlock`
* `wlogout`
* `btop`
* `yazi`
* `neovim`
* `zen-browser` (or change `$browser` in variables)
* `dolphin`
* `grim`, `slurp`, `swappy` (for screenshots)
* `wl-clipboard`
* `playerctl`
* `quickshell` (You may need to build this from source)

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
| **Rofi Style Switcher** | `Mod` + `Alt` + `Space` |

## 🎨 Theming

This setup uses **Matugen** to generate a color palette from the current wallpaper set by `swww`.
When you change the wallpaper (via the keybinds above), Matugen automatically updates colors for:
* Hyprland borders
* Kitty
* Rofi
* Hyprlock
* Wlogout

## 📂 Installation

1.  Clone this repository:
    ```bash
    git clone https://github.com/Mysz0/dotfiles
    ```
2.  Run the install script (backs up old configs):
    ```bash
    cd dotfiles
    chmod +x install.sh
    ./install.sh
    ```
# I used code from dotfiles like: [Matuprland](https://github.com/Abhra00/Matuprland) and [Elifouts](https://github.com/elifouts/Dotfiles)
