# 🚀 Clemson SoC WezTerm Setup Guide for Windows

This setup gives you a one-click connection to lab machines (Babbage, Newton, etc.) with automatic off-campus proxying and a custom **Rosé Pine** theme based on the officially supported WezTerm one but updated for 2026!

## 1. Install WezTerm & Fonts

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

## 2. Set your Environment Variables
In order for the below scripts to work with *anyone*, two enviornment variables had to be set:

* `CLEMSON_ID`: This should be **your** Clemson Username. You know, that thing that you use to sign into iRoar, the short little string at the start of your `@clemson.edu` email, what you use to `ssh` into the SoC machines. It's been at least 6 months since you were assigned one upon accepting your enrollment offer. CPSC 1070 literally teaches this on *Week 2*. Figure it out! I believe in you!

Now, since you are on Windows, there are two ways to do this: the "Quick Way" (Command Line) and the "Visual Way" (GUI). Setting it at the ***User level*** ensures it stays saved even after you restart your laptop:

### Option 1. The PowerShell Way (Fastest)
Open a PowerShell window (not an SSH session, just a local one) and run this single line. Replace `yourClemsonUserhere` with your actual Clemson username (e.g., `kgilbe3`):
> `[System.Environment]::SetEnvironmentVariable('CLEMSON_ID', 'yourClemsonUserhere', 'User')`


**Important:** You must restart WezTerm completely after running this command so it can "see" the new variable!

### Option 2: The Windows GUI Way (Visual)**
If you prefer clicking through menus:

1. Press the Windows Key (or open the search bar. Whatever floats your boat) and type `env`.
2. Select "Edit environment variables for your account" (should be the second option. Not the "best match").
3. Under the top box (User variables), click **New...**.
4. You should get a pop-up (New User Variable). Enter the following values:
    * Variable name: CLEMSON_ID
    * Variable value: Your Clemson Username
5. Click OK on all windows.

### How to verify it worked
After you restart WezTerm, you can verify that the terminal sees your ID by typing this in a local prompt:

> ```echo $env:CLEMSON_ID```

If it prints your Clemson ID, your `wezterm.lua` script will now automatically pull that name into the `ssh` commands.

## 3. Place the Configuration Files
Move the provided files into your user profile directory as follows:

* **Main Config:** `C:\Users\<YourUser>\.config\wezterm\wezterm.lua`
* **SoC Addresses:** `C:\Users\<YourUser>\.config\wezterm\machines.lua`
* **Theme File:** `C:\Users\<YourUser>\.config\wezterm\colors\rose-pine-wip.lua`

> Note: If the folders don't exist, create them exactly as named above.

## 4. Setup SSH for Off-Campus Access (The "Smart" Connection)
To make "Jump Hosting" through the Clemson gateway work automatically:

1. Go to `C:\Users\YourWindowsUser\.ssh\` (create it if missing. But it is a hidden folder, so just check first).
2. Take the files [`config-on-campus`](../config-on-campus) and [`config-off-campus`](../config-off-campus) in this repo and place them in that folder.
3. Open `machines.lua` and add `enabled = true` to your preferred machines. Remove that snippet from the defaults already set-up if you don't want them.

## 5. Enable Passwordless Login (Optional but Recommended)
To avoid typing your password twice every time you connect (whether on **or** off campus):

1. Open PowerShell and run: `ssh-keygen -t ed25519` (Press Enter for all).
2. Copy your public key: `cat ~/.ssh/id_ed25519.pub`
3. Log into `access.computing.clemson.edu` and paste that string into a new line in `~/.ssh/authorized_keys.` I used vim, but nano would work as well.
4. Anytime you access a machine that you haven't previously accessed (via WezTerm or any other Terminal Shell), you will get a prompt that looks like this:
<img width="576" height="445" alt="Connect-Off-Campus" src="https://github.com/user-attachments/assets/81f4be4d-8ae1-49be-a883-c777bec70510" />

This is **normal**. It means you're accessing directly via the IP address. You will see a similar screen when accessing a machine on campus for the first time. It's setting adding to the necessary files located in `~/.ssh/` on your computer *and* `~/.ssh/authorized_keys` on the SoC machine(s). Please see the Common Errors section for trouble shooting!

* *NOTE: Off-campus access was tested on a iPhone Hotspot, which works perfectly! At last test, regular off campus works perfectly! And, it also works via Cisco VPN, it will just register you as using Access instead of Direct connect at the minute! No clue why it's not registering as being on a school IP, but will figure it out!*

---

## ⌨️ Shortcuts to Know

* **Alt + L**: Opens the "Clemson Lab Quick-Connect" menu.
* **Ctrl + Shift + Enter**: Split screen vertically (clones your current SSH session).
* **Alt + Shift + Enter**: Split screen horizontally.
* **Alt + Arrow Keys**: Move your cursor between split panes.
* **Ctrl + D**: Closes the open pane

---

## ⚠️ Common Errors

### 1. Prompts for Fingerprint Oddly
If you are connecting off campus via Access, the new tab will look like this after using the launcher: `ssh <YourClemsonID>@b130.127.XX.XX`. This means the machine is located in the `machines.lua` file. This is fine, this is great! This is how it should look when connecting to a machine via Access for the first time with the custom launcher!

### 2. "Remote Host Identification Has Changed"
If you see a scary box of @@@ signs, the server was likely updated and is no longer in the current `machines.lua` file. 
Run this in PowerShell to fix it:
`ssh-keygen -R <hostname>.computing.clemson.edu`

### 3. Prompt Closes Immediately
If the window vanishes, you likely haven't "trusted" the server yet. 
Connect manually once: `ssh <YourClemsonID>@babbage1.computing.clemson.edu` and type **yes**.

### 4. Password requested twice
Ensure you have followed the **Passwordless Login** steps in the main README to add your SSH key to the Clemson `authorized_keys` file.

### 5. Password requested once
If any machine is asking for a password, it means your **Public Key** isn't authorized on the Clemson servers yet. 

So, even though you have an SSH key on your laptop, the Clemson lab machines don't know it belongs to you until you "handshake" with them.

#### Why it's happening
SSH uses a "lock and key" system. Your laptop has the **Private Key**, but you need to put the Public Key (`id_ed25519.pub`) into a specific file on your Clemson home directory so the servers can recognize you automatically.

#### The One-Time Fix
If you're already logged into any specific machine, run these steps right now in that window:

**1. On your local laptop (PowerShell):**

> `cat ~/.ssh/id_ed25519.pub | clip`

*(This copies your public key to your clipboard).*

**2. Back in the Lab Machine window (Clemson):**

```powershell
mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "PASTE_YOUR_KEY_HERE" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

*(Replace `PASTE_YOUR_KEY_HERE` with what you just copied. Make sure the quotes are around it!)*

### 6. Windows User Not Appearing
Usually, if you're the admin on a machine, *Windows sets the Environment Variable `USERNAME` automatically for every account. If you type `echo $env:USERNAME` in PowerShell right now, it should already return your local user. If not, here's how to do it manually! It's exactly the same as setting up the env variable for `CLEMSON_ID`! So, I kinda just copy and pasted...
* `USERNAME`: This should be the User for your computer, which is almost definitly different from your Clemson Username. It's that thing you see at the top of the folder path in File Explorer or when you open PowerShell or on the left of a terminal. Looks like this `C:\Users\YourWindowsUser\...` in File Explorer, like this `PS C:\Users\YourWindowsUser>` in PowerShell, and like this `C:\Users\YourWindowsUser>` in Command Prompt. You want what's at `<YourWindowsUser>`.

Now, since you are on Windows, there are two ways to do this: the "Quick Way" (Command Line) and the "Visual Way" (GUI). Setting it at the ***User level*** ensures it stays saved even after you restart your laptop:

#### Option 1. The PowerShell Way (Fastest)
Open a PowerShell window (not an SSH session, just a local one) and run this single line. Replace `yourWindowsUserhere` with your actual Windows username (e.g., `missk`):
> `[System.Environment]::SetEnvironmentVariable('USERNAME', 'yourWindowsUserhere', 'User')`

#### Option 2: The Windows GUI Way (Visual)**
If you prefer clicking through menus:

1. Press the Windows Key (or open the search bar. Whatever floats your boat) and type `env`.
2. Select "Edit environment variables for your account" (should be the second option. Not the "best match").
3. Under the top box (User variables), click **New...**.
4. You should get a pop-up (New User Variable). Enter the following values:
- Variable name: USERNAME
- Variable value: Your Windows Username
5. Click OK on all windows.

### How to verify it worked
After you restart WezTerm, you can verify that the terminal sees your ID by typing this in a local prompt:

> ```echo $env:USERNAME```

