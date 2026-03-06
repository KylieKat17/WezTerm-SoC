# 🐯 Clemson SoC WezTerm Suite

A unified configuration suite for Clemson School of Computing students to sync their terminal environments across Windows and macOS, whether on personal machines (Admin) or restricted-access PCs (User).

## 🚀 Features
- **One-Click Connect:** `Alt + L` menu for Babbage, Newton, and Titan.
  - You ~can~ should adjust to your preferred machines. These are just mine!
- **Smart Routing:** Automatic "ProxyJump" via `access` when off-campus (Admin) or direct hardwired connection (User).
- **Rosé Pine WIP Theme:** Custom high-contrast palette with a "floating" status bar.
- **Adaptive UI:** Theme-aware status bar that changes based on your active flavor (Main/Moon/Dawn).
  - IMPORTANT: You will have to swap `YourID` for your Clemson username in the `wezterm.lua` file unless you want it to read as `YourID`!
- **Workflow Ready:** Pre-configured split-pane shortcuts and SSH key support.

---

## 🎨 Credits & Palette Sources

This configuration is a heavily modified variation of the official Rosé Pine ecosystem.

* **Base Logic:** Based on the [neapsix/wezterm](https://github.com/neapsix/wezterm) plugin. While this repo provided the initial WezTerm structure, it is no longer actively maintained.
* **Extended Palette:** Modern colors (including the `leaf` greens and `_nc` non-current window variants) are sourced from the actively maintained [rose-pine/neovim](https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/palette.lua) repository.
* **Customization:** Colors for selection, status bars, and the "light track" tab bar were custom-tuned for the Clemson SoC environment.

---

## 📂 Choose Your Setup

Select the folder that matches your current machine and permissions:

### 🪟 Windows
| Version | Machine Type | Permissions | Network |
| :--- | :--- | :--- | :--- |
| [**Windows-Admin**](./Windows-Admin) | **Personal Laptop** | Administrator | Off-Campus / Cisco VPN / Eduroam |
| [**Windows-User**](./Windows-User) | **Managed Office/Lab PC** | User-Level | Hardwired / Eduroam |

> **Note on Windows-User:** This version was specifically tested on a non-SoC Windows 10 workstation locatated at the Media Forensics Hub in Watt. It bypasses the need for administrative privileges by utilizing the User AppData directory. Basically, I wanted to log into a SoC machine and use NeoVim, but I couldn't install anything at the system level without an admin password.

### 🍎 macOS
| Version | Description |
| :--- | :--- |
| [**MacOS-Admin**](./MacOS-Admin) | **Personal Macbook.** Standard user-level install. |
| [**MacOS-User**](./MacOS-User) | **Restricted/Managed macOS devices.** |

> **Note:** Currently under construction

---

## 🛠️ Global Prerequisites

Before installing any version, ensure you have the required fonts installed at the system level:

1. **Terminal:**
   * [Download Windows WezTerm](https://wezfurlong.org/wezterm/install/windows.html)
   * [Download MacOS WezTerm](https://wezfurlong.org/wezterm/install/macos.html)
3. **Font:** [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads) 
   - *Note: On Managed Windows PCs, if "Install for all users" is blocked, simply double-click the font and select "Install" for the current user.* There are more detailed instructions in the respective set-up folders!

---

## 🤝 Contributing
If you find a better way to route SSH or a cleaner color for the tab bar, feel free to open a Pull Request!
