local wezterm = require("wezterm")

local config = {}

if wezterm.config_build then
	config = wezterm.config_builder()
end

-- UI config
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font_size = 14.0

config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

-- key bindings
config.leader = { key = "a", mods = "CMD", timeout_milliseconds = 2000 }

--tmux
config.keys = {
	{
		mods = "LEADER",
		key = "|",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action({ CloseCurrentPane = { confirm = true } }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action({ ActivatePaneDirection = "Left" }),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action({ ActivatePaneDirection = "Down" }),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action({ ActivatePaneDirection = "Up" }),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action({ ActivatePaneDirection = "Right" }),
	},
}

return config
