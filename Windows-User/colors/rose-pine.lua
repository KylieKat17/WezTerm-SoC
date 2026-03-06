-- Copyright (c) 2022 rose-pine
-- repository: https://github.com/neapsix/wezterm
-- license: MIT

local main = {}

local main_palette = {
    _nc = '#16141f',
    base = '#191724',
    surface = '#1f1d2e',
    overlay = '#26233a',
    muted = '#6e6a86',
    subtle = '#908caa',
    text = '#e0def4',
    love = '#eb6f92',
    gold = '#f6c177',
    rose = '#ebbcba',
    pine = '#31748f',
    foam = '#9ccfd8',
    iris = '#c4a7e7',
    leaf = '#95b1ac',
    highlight_high = '#524f67',
    highlight_med = '#403d52',
    highlight_low = '#21202e',
}

function main.palette() return main_palette end

local main_active_tab = {
    bg_color = main_palette.overlay,
    fg_color = main_palette.text,
}

local main_inactive_tab = {
    bg_color = main_palette.base,
    fg_color = main_palette.muted,
}

function main.colors()
    return {
        foreground = main_palette.text,
        background = main_palette.base,
        cursor_bg = main_palette.highlight_high,
        cursor_border = main_palette.highlight_high,
        cursor_fg = main_palette.text,
        selection_bg = '#2a283e',
        selection_fg = main_palette.text,

        ansi = {
            main_palette.overlay,
            main_palette.love,
            main_palette.leaf, -- Green
            main_palette.gold,
            main_palette.pine, -- Blue
            main_palette.iris,
            main_palette.foam, -- Cyan
            main_palette.text,
        },

        brights = {
            main_palette.muted,
            main_palette.love,
            main_palette.leaf,
            main_palette.gold,
            main_palette.pine,
            main_palette.iris,
            main_palette.foam,
            main_palette.text,
        },

        tab_bar = {
            background = main_palette.highlight_high,
            active_tab = main_active_tab,
            inactive_tab = main_inactive_tab,
            inactive_tab_hover = main_active_tab,
            new_tab = main_inactive_tab,
            new_tab_hover = main_active_tab,
            inactive_tab_edge = main_palette.muted,
        },
    }
end

function main.window_frame()
    return {
        active_titlebar_bg = main_palette._nc,
        inactive_titlebar_bg = main_palette._nc,
    }
end

local moon = {}

local moon_palette = {
    _nc = '#1f1d30',
    base = '#232136',
    surface = '#2a273f',
    overlay = '#393552',
    muted = '#6e6a86',
    subtle = '#908caa',
    text = '#e0def4',
    love = '#eb6f92',
    gold = '#f6c177',
    rose = '#ea9a97',
    pine = '#3e8fb0',
    foam = '#9ccfd8',
    iris = '#c4a7e7',
    leaf = '#95b1ac',
    highlight_high = '#56526e',
    highlight_med = '#44415a',
    highlight_low = '#2a283e',
}

function moon.palette() return moon_palette end

local moon_active_tab = {
    bg_color = moon_palette.overlay,
    fg_color = moon_palette.text,
}

local moon_inactive_tab = {
    bg_color = moon_palette.base,
    fg_color = moon_palette.muted,
}

function moon.colors()
    return {
        foreground = moon_palette.text,
        background = moon_palette.base,
        cursor_bg = moon_palette.highlight_high,
        cursor_border = moon_palette.highlight_high,
        cursor_fg = moon_palette.text,
        selection_bg = moon_palette.overlay,
        selection_fg = moon_palette.text,

        ansi = {
            moon_palette.overlay,
            moon_palette.love,
            moon_palette.leaf,
            moon_palette.gold,
            moon_palette.pine,
            moon_palette.iris,
            moon_palette.foam,
            moon_palette.text,
        },

        brights = {
            moon_palette.muted,
            moon_palette.love,
            moon_palette.leaf,
            moon_palette.gold,
            moon_palette.pine,
            moon_palette.iris,
            moon_palette.foam,
            moon_palette.text,
        },

        tab_bar = {
            background = moon_palette.base,
            active_tab = moon_active_tab,
            inactive_tab = moon_inactive_tab,
            inactive_tab_hover = moon_active_tab,
            new_tab = moon_inactive_tab,
            new_tab_hover = moon_active_tab,
            inactive_tab_edge = moon_palette.muted,
        },
    }
end

function moon.window_frame()
    return {
        active_titlebar_bg = moon_palette._nc,
        inactive_titlebar_bg = moon_palette._nc,
    }
end

local dawn = {}

local dawn_palette = {
    _nc = '#f8f0e7',
    base = '#faf4ed',
    surface = '#fffaf3',
    overlay = '#f2e9e1',
    muted = '#9893a5',
    subtle = '#797593',
    text = '#575279',
    love = '#b4637a',
    gold = '#ea9d34',
    rose = '#d7827e',
    pine = '#286983',
    foam = '#56949f',
    iris = '#907aa9',
    leaf = '#6d8f89',
    highlight_high = '#cecacd',
    highlight_med = '#dfdad9',
    highlight_low = '#f4ede8',
}

function dawn.palette() return dawn_palette end

local dawn_active_tab = {
    bg_color = dawn_palette.overlay,
    fg_color = dawn_palette.text,
}

local dawn_inactive_tab = {
    bg_color = dawn_palette.base,
    fg_color = dawn_palette.muted,
}

function dawn.colors()
    return {
        foreground = dawn_palette.text,
        background = dawn_palette.base,
        cursor_bg = dawn_palette.muted,
        cursor_border = dawn_palette.muted,
        cursor_fg = dawn_palette.text,
        selection_bg = dawn_palette.overlay,
        selection_fg = dawn_palette.text,

        ansi = {
            dawn_palette.overlay,
            dawn_palette.love,
            dawn_palette.leaf,
            dawn_palette.gold,
            dawn_palette.pine,
            dawn_palette.iris,
            dawn_palette.foam,
            dawn_palette.text,
        },

        brights = {
            dawn_palette.muted,
            dawn_palette.love,
            dawn_palette.leaf,
            dawn_palette.gold,
            dawn_palette.pine,
            dawn_palette.iris,
            dawn_palette.foam,
            dawn_palette.text,
        },

        tab_bar = {
            background = dawn_palette.base,
            active_tab = dawn_active_tab,
            inactive_tab = dawn_inactive_tab,
            inactive_tab_hover = dawn_active_tab,
            new_tab = dawn_inactive_tab,
            new_tab_hover = dawn_active_tab,
            inactive_tab_edge = dawn_palette.muted,
        },
    }
end

function dawn.window_frame()
    return {
        active_titlebar_bg = dawn_palette._nc,
        inactive_titlebar_bg = dawn_palette._nc,
    }
end

return {
    main = main,
    moon = moon,
    dawn = dawn,
}
