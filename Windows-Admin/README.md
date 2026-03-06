# 🚀 Clemson SoC WezTerm Setup Guide

This setup gives you a one-click connection to lab machines (Babbage, Newton, etc.) with automatic off-campus proxying and a custom **Rosé Pine** theme based on the officially supported WezTerm one but updated for 2026!

### 1. Install WezTerm & Fonts

* **Download WezTerm:** Download and run the Windows `.exe` installer from the [Official WezTerm Downloads page](https://wezterm.org/install/windows.html).
* **Install Fonts:** WezTerm needs a "Nerd Font" to display the icons in the status bar. And, for some stupid reason, does not include Nerd Fonts by default.
  1. Go to the JetBrainsMono Nerd Font download page.
  2. Find JetBrainsMono, click Download, and unzip the folder.
  3. Crucial: Open the folder, select the below `.ttf` files, **Right-click > "Install for all users."** Windows must have them at the system level for WezTerm to see them
     * NOTE: At present, the only `.ttf` files necessary are
        * `JetBrainsMonoNerdFont-Regular.ttf` (The heart of the terminal)
        * `JetBrainsMonoNerdFont-Bold.ttf` (For highlighted text/syntax)
        * `JetBrainsMonoNerdFont-Italic.ttf` (For comments in code)
        * `JetBrainsMonoNerdFont-BoldItalic.ttf` (Rare, but good for completeness)

### 2. Place the Configuration Files
Move the provided files into your user profile directory as follows:

* **Main Config:** `C:\Users\<YourUser>\.config\wezterm\wezterm.lua`
* **Theme File:** `C:\Users\<YourUser>\.config\wezterm\colors\rose-pine-wip.lua`

> Note: If the folders don't exist, create them exactly as named above.

### 3. Setup SSH for Off-Campus Access (The "Smart" Connection)
To make "Jump Hosting" through the Clemson gateway work automatically:

1. Go to `C:\Users\<YourUser>\.ssh\` (create it if missing).
2. Open or create a file named `config` (make sure there is **NO** `.txt` extension).
3. Paste the following (replacing `<YourID>` with your Clemson username):

```Plaintext
# Universal identity
Host *
    User YourID
    IdentityFile ~/.ssh/id_ed25519

# The Gateway
Host access
    HostName access.computing.clemson.edu

# The Lab Machines
Host babbage* newton titan*
    # Try to connect directly for 2 seconds
    ConnectTimeout 2
    # If direct fails, use access as a jump point
    ProxyJump access
```

### 4. Enable Passwordless Login (Optional but Recommended)
To avoid typing your password twice every time you connect:

1. Open PowerShell and run: `ssh-keygen -t ed25519` (Press Enter for all).
2. Copy your public key: `cat ~/.ssh/id_ed25519.pub`

Log into `access.computing.clemson.edu` and paste that string into a new line in `~/.ssh/authorized_keys.` I used vim, but nano would work as well

---

### ⌨️ Shortcuts to Know

* **Alt + L**: Opens the "Clemson Lab Quick-Connect" menu.
* **Ctrl + Shift + Enter**: Split screen vertically (clones your current SSH session).
* **Alt + Shift + Enter**: Split screen horizontally.
* **Alt + Arrow Keys**: Move your cursor between split panes.
* **Ctrl + D**: Closes the open pane

> Note: Those commands only work while directly on campus wifi at the moment. I'm going to trouble shoot it
