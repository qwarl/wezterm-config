local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local config = wezterm.config_builder()
local launch_menu = {}
local keys = {}

config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("CaskaydiaMono NFM")

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe" }
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "pwsh.exe" },
	})

	-- config for neovim completion
	table.insert(keys, {
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action.SendKey({
			key = "Enter",
			mods = "SHIFT",
		}),
	})
	table.insert(keys, {
		key = "Space",
		mods = "CTRL",
		action = wezterm.action.SendKey({
			key = "Space",
			mods = "CTRL",
		}),
	})
end
config.launch_menu = launch_menu

config.enable_tab_bar = false

-- set new keybinds
table.insert(keys, {
	key = "w",
	mods = "CTRL|ALT",
	action = wezterm.action.CloseCurrentPane({ confirm = false }),
})
table.insert(keys, {
	key = "`",
	mods = "CTRL|ALT",
	action = wezterm.action.ShowLauncher,
})
config.keys = keys

-- setup smart splits (move and resize like neovim config)
smart_splits.apply_to_config(config, {
	direction_keys = {
		move = { "h", "j", "k", "l" },
		resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
	},
	modifiers = {
		move = "CTRL",
		resize = "CTRL",
	},
})
return config
