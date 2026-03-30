local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local config = wezterm.config_builder()

local is_win = wezterm.target_triple:find("windows")
local unix_cmd = (os.getenv("SHELL") or "sh") .. " -l -c 'command -v nu' 2>/dev/null"
local handle = io.popen(is_win and "where nu 2>nul" or unix_cmd)
local nu_path = handle and handle:read("*l")
if handle then handle:close() end

if nu_path and nu_path ~= "" then
	config.default_prog = { nu_path:gsub("\r", ""), "-l" }
end

config.color_scheme = "Catppuccin Macchiato"
config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_padding = {
	left = 5,
	right = 0,
	top = 10,
	bottom = 0,
}

tabline.setup({
	options = {
		theme = "Catppuccin Macchiato",
	},
})

return config
