local wezterm = require 'wezterm'
local act = wezterm.action
local machines = require 'machines'
local config = wezterm.config_builder() -- if needed, add back if loop

-- ─────────────────────────────
-- 0. User Configuration (Edit these)
-- MAKE SURE YOU SET-UP YOUR ENV VARIABLES!!!!!!!
-- ─────────────────────────────
local cid = os.getenv('CLEMSON_ID') or 'kgilbe3'
local win_user = os.getenv('USERNAME') or 'User'
-- Path to your local font folder (relative or absolute)
local font_path = 'C:/Users/' .. win_user .. '/Programs/WezTerm/fonts'

-- ─────────────────────────────
-- 1. Network Detection & SSH Logic
-- ─────────────────────────────
local function is_on_campus()
    local success, stdout, _ = wezterm.run_child_process({ 'ipconfig' })
    return success and stdout:find("172.27.") ~= nil
end
local on_campus = is_on_campus()

-- Use the Windows username for the PATH, but CID for the logic
local ssh_config = string.format("C:/Users/%s/.ssh/config-%s", 
      win_user, (on_campus and "on-campus" or "off-campus"))

-- ─────────────────────────────
-- 2. Appearance & Dynamic Theme
-- ─────────────────────────────
local rp = require 'colors/rose-pine'
-- Pick your flavor: 'main', 'moon', or 'dawn'
local theme = rp.moon
local palette = theme.palette() -- gets the table of raw colors by hex codes

-- Apply the colors to the global config
config.colors = theme.colors()
config.window_frame = theme.window_frame()
-- Use palette variables instead of hardcoded hex to keep things dynamic. Can hardcode if you prefer, but I suggest doing it in the rose-pine.lua file
config.colors.selection_bg = palette.selection_bg
config.colors.selection_fg = palette.selection_fg
config.colors.split = palette.highlight_med

-- ─────────────────────────────
-- 3. Dynamic Tab Titles (Universal Fix)
-- ─────────────────────────────
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local title = tab.active_pane.title
    local id = tab.tab_index + 1

    -- If title is generic (ssh/powershell), look at the process arguments
    if title:find('ssh') or title:find('powershell') or title:find('cmd') then
        local process = tab.active_pane.get_foreground_process_info()
        if process and process.argv then
            for _, arg in ipairs(process.argv) do
                -- Pattern: Match any name followed by the clemson domain or common lab prefixes
                local match = arg:match("([^@]+)%.computing%.clemson%.edu") 
                           or arg:match("jump%-(%w+)")
                if match then
                    title = match:upper()
                    break
                end
            end
        end
    end

    -- Final cleanups for common shells
    local clean_titles = { 
        ['ssh.exe'] = 'Clemson', 
        ['powershell.exe'] = 'PowerShell', 
        ['cmd.exe'] = 'Command Prompt' 
    }
    title = clean_titles[title] or title

    return { { Text = string.format(" %d │ %s ", id, title) } }
end)

-- ─────────────────────────────
-- Clemson Status Bar
-- ─────────────────────────────
-- shows Clemson username & current date in the corner of the tab bar
wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime('%a %b %d %I:%M %p')
  local network_icon = on_campus and " 󰒍  (Direct)" or " 󰖟 (Access)"
    
    window:set_right_status(wezterm.format({
        { Background = { Color = palette.surface } },
        { Foreground = { Color = palette.gold } },
        { Text = '     ' }, 
        { Foreground = { Color = palette.text } },
        { Text = string.format("%s  | %s  |  %s  ", cid, network_icon, date) },
    }))
end)

-- where to look for font files, ABSOLUTE path
config.font_dirs = { 'C:/Users/missk/Programs/WezTerm/fonts' }

config.font = wezterm.font_with_fallback({
  { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
  'Consolas', -- Fallback if the above fails
})

config.font_size = 12.0
config.window_background_opacity = 1.0
config.scrollback_lines = 10000

-- Tab Bar Configuration (for SoC username and datetime)
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false -- Set to false so you can always see where you are
config.show_tab_index_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = true

-- Ensure this is set so the bar actually updates
config.status_update_interval = 1000
config.tab_max_width = 64

-- This function cleans up the title so it's not a giant messy path
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  local id = tab.tab_index + 1

  -- TODO: NEED TO UPDATE THIS SO IT'S NOT RELIANT ON MY CONFIGS BUT UNIVERSAL. DONE MANUALLY FOR NOW BUT IT'S CLUNKY
  -- If it's just 'ssh.exe', let's hunt for the Clemson name in the pane metadata
  if title == 'ssh.exe' or title == 'ssh' or title:find('powershell') then
    -- Check the foreground process arguments (this usually contains 'ssh babbage1')
    local process = tab.active_pane.get_foreground_process_info()
    if process and process.argv then
      for _, arg in ipairs(process.argv) do
        if arg:find('babbage') then title = arg:gsub('%.computing%.clemson%.edu', '')
        elseif arg:find('newton') then title = 'Newton'
        elseif arg:find('titan') then title = arg:gsub('%.computing%.clemson%.edu', '')
        elseif arg:find('ada') then title = arg:gsub('%.computing%.clemson%.edu', '')
        elseif arg:find('cerf') then title = arg:gsub('%.computing%.clemson%.edu', '')
        elseif arg:find('joey') then title = arg:gsub('%.computing%.clemson%.edu', '')
        elseif arg:find('cirrus') then title = arg:gsub('%.computing%.clemson%.edu', '')
        end
      end
    end
  end

  -- Fallbacks (often the remote prompt will update the title eventually)
  if title == 'ssh.exe' then
    title = 'Clemson'
  elseif title == 'powershell.exe' then
    title = 'PowerShell'
  elseif title == 'cmd.exe' then
    title = 'Command Prompt'
  end

  return {
    { Text = ' ' .. id .. ' │ ' .. title .. ' ' },
  }
end)

-- Highlighting Configs
-- config.selection_word_boundary = " @-./_~" -- Makes double-clicking paths easier
config.skip_close_confirmation_for_processes_named = {
  'bash', 'sh', 'zsh', 'powershell', 'cmd', 'ssh',
}

-- ─────────────────────────────
-- Launch Menu & SSH
-- ─────────────────────────────
config.launch_menu = {}

-- Function to add a machine to the menu with smart routing
local function add_ssh_entry(name, ip)
    local label = name:gsub("^%l", string.upper)
    local cmd = {}
    local target_host = "" -- Default (On-campus)
    -- Status strings for clarity
    local connection_type = on_campus and "Direct" or "via Access"
    local icon = on_campus and "󰒍" or "󰖟"
    
    -- -F FLAG forces SSH to use custom config files
    -- Also explicitly add cid@ to ensure it doesn't use your Windows name
    if on_campus then
        -- Direct: Use the full public domain
        target_host = name .. ".computing.clemson.edu"
        cmd = { 'ssh', '-F', ssh_config, cid .. '@' .. target_host }
    else
        -- Off campus: use the jump- prefix, your off-campus config
        cmd = { 
            'ssh', '-F', ssh_config, 
            '-J', cid .. '@access.computing.clemson.edu', 
            cid .. '@' .. ip 
        }
    end

    table.insert(config.launch_menu, {
        --label = label .. (on_campus and " (Direct)" or " (via Access)"),
        label = string.format("%s (%s) %s", label, connection_type, icon),
        args = cmd
    })
end

-- ONLY add machines that have enabled = true
for _, m in ipairs(machines) do
  if m.enabled then
      add_ssh_entry(m.name, m.ip)
  end
end


-- ─────────────────────────────
-- Keybindings
-- ─────────────────────────────
-- NOTE: split panes only functions correctly on campus as of last test
config.keys = {
  -- Wezterm Launcher
  {
    key = 'l',
    mods = 'ALT',
    -- This flag ensures ONLY your launch_menu items appear
    action = act.ShowLauncherArgs { 
      flags = 'LAUNCH_MENU_ITEMS', 
      title = 'Clemson Lab Quick-Connect' 
    },
  },
  -- Clipboard things!
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'c', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
  -- Split vertical (Ctrl+Shift+Enter)
  {
    key = 'Return',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      local process = pane:get_foreground_process_info()
      if process and process.argv then
        -- This spawns a new pane with the EXACT same command (ssh babbage1, etc.)
        pane:split { args = process.argv }
      else
        pane:split {}
      end
    end),
  },
  -- Split horizontal (Alt+Shift+Enter)
  {
    key = 'Return',
    mods = 'ALT|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      local process = pane:get_foreground_process_info()
      if process and process.argv then
        pane:split { direction = 'Bottom', args = process.argv }
      else
        pane:split { direction = 'Bottom' }
      end
    end),
  },
  -- Move between panes using Alt + Arrow Keys
  { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
}

-- ─────────────────────────────
-- Startup Behavior
-- ─────────────────────────────
-- This spawns the window and immediately triggers the menu
wezterm.on('gui-startup', function(cmd)
  local _, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():perform_action(
    act.ShowLauncherArgs {
      -- Adding '|FUZZY' would make it like a searchable search bar
      flags = 'LAUNCH_MENU_ITEMS',
      title = 'Select Clemson Lab Machine',
    },
    pane
  )
end)

-- ─────────────────────────────
-- Default shell (Windows)
-- ─────────────────────────────
-- 'cmd.exe' is the "old reliable", but 'powershell.exe' is usually better 
-- for rendering Nerd Font symbols.
config.default_prog = { 'powershell.exe', '-NoLogo' }


-- ─────────────────────────────
-- Selection & Mouse Bindings
-- ─────────────────────────────
-- Disable the remote host from taking over the mouse for selections
config.selection_word_boundary = " \t\n{}[]()\"'`:;,"

config.mouse_bindings = {
  -- 1. Start selection (Works even when SSH tries to block it)
  {
    event = { Down = { button = 'Left', streak = 1 } },
    mods = 'NONE',
    action = act.SelectTextAtMouseCursor 'Cell',
  },
  -- 2. Expand selection while dragging
  {
    event = { Drag = { button = 'Left', streak = 1 } },
    mods = 'NONE',
    action = act.ExtendSelectionToMouseCursor 'Cell',
  },
  -- 3. Finish and Auto-Copy
  {
    event = { Up = { button = 'Left', streak = 1 } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },
  -- 4. Double click for words
  {
    event = { Up = { button = 'Left', streak = 2 } },
    mods = 'NONE',
    action = act.SelectTextAtMouseCursor 'Word',
  },
  -- 5. Right-Click to Paste (PuTTY style)
  {
    event = { Down = { button = 'Right', streak = 1 } },
    mods = 'NONE',
    action = act.PasteFrom 'Clipboard',
  },
}

return config