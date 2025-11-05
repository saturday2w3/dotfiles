local M = {}

-- Minimal alpha/nvim start page similar to DefectingCat/nvim
-- Uses alpha if available, otherwise it's a no-op

local function safe_require(name)
	local ok, mod = pcall(require, name)
	if not ok then
		return nil
	end
	return mod
end

function M.setup()
	local alpha = safe_require("alpha")
	local dashboard = alpha and safe_require("alpha.themes.dashboard")
	if not alpha or not dashboard then
		return
	end

	local header = {
		[[⣿⣿⣿⣿⣿⣿⣿⣿⡿⠻⠿⠿⠿⣋⣋⠩⠌⠿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
		[[⣿⣿⣿⣿⡿⠿⠿⢛⠃⣿⢹⡿⢠⡿⢛⣿⣶⣦⣌⣙⠃⢘⣛⠻⠿⢿⣿⣿⣿⣿]],
		[[⣿⣿⣿⠯⢰⡟⢿⣿⢸⠱⢌⢃⠯⠒⣸⣿⣿⣿⣿⣿⣿⣶⣮⣝⡛⠃⣿⣿⣿⣿]],
		[[⡟⢥⡲⣾⢸⢩⢜⡏⣸⣄⠄⣾⣧⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣬⡝⢿]],
		[[⣿⡜⢯⢬⡄⣇⠀⠅⣿⡏⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢁⣿]],
		[[⣿⣷⡘⣄⣄⢹⣿⢠⡟⣰⣿⣿⣿⣿⣿⣿⣿⡿⠟⣿⣿⣿⣿⣿⣿⣿⣿⠃⣾⣿]],
		[[⣿⣿⣷⠸⣿⢸⡿⠸⢡⣿⣿⣿⣿⠿⠛⠋⠁⠀⠀⢿⣿⣿⣿⣿⣿⣿⠇⣼⣿⣿]],
		[[⣿⣿⣿⣧⢹⡈⡇⢀⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⡏⣰⣿⣿⣿]],
		[[⣿⣿⣿⣿⣆⠃⠁⣾⣿⣿⣿⣿⣿⣦⣤⠄⡀⠀⠀⠀⣸⣿⣿⣿⡟⢰⣿⣿⣿⣿]],
		[[⣿⣿⣿⣿⣿⡆⣼⣿⣿⣿⣿⣿⣦⣍⡀⠀⢻⣶⣤⣶⣿⣿⣿⡿⠁⣿⣿⣿⣿⣿]],
		[[⣿⣿⣿⣿⡟⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣬⣿⣿⣿⣿⣿⠃⣦⠹⣿⣿⣿⣿]],
		[[⣿⣿⣿⣿⣑⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⠇⢀⢈⣥⣿⣿⣿⣿]],
		[[⣿⣿⣿⣿⣿⣐⠒⠤⠍⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⡿⣀⡈⠀⠛⣸⣿⣿⣿⣿⣿]],
		[[⣿⣿⣿⣿⣿⣿⣿⠸⠿⠟⠒⣒⡀⠉⠛⠿⢿⣿⣿⢁⡕⠰⢠⣿⣿⣿⣿⣿⣿⣿]],
		[[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣩⣥⣶⣿⣿⣿⣶⣬⣍⡛⣡⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	}

	dashboard.section.header.val = header

	local function button(sc, txt, keybind)
		return dashboard.button(sc, txt, keybind)
	end

	dashboard.section.buttons.val = {
		button("f", "  Find", ":Telescope find_files<CR>"),
		button("r", "  Recent", ":Telescope oldfiles<CR>"),
		button("c", "  Config", ":e $MYVIMRC<CR>"),
		button("p", "󰒲  Lazy", ":Lazy<CR>"),
		button("q", "  Quit", ":qa<CR>"),
	}

	local footer_text = {
		"",
		"",
	}

	-- Try to show plugin count and startup time if available
	local stats_ok, stats = pcall(function()
		return require("lazy").stats()
	end)

	if stats_ok and type(stats) == "table" then
		local ms = (stats.time or 0) / 1000
		table.insert(footer_text, string.format("live for us... arisu", "♤ ♡ ♧ ♢"))
	end

	dashboard.section.footer.val = footer_text

	dashboard.config.opts.noautocmd = true
	alpha.setup(dashboard.config)
	-- ensure alpha opens its dashboard when configured
	if alpha.start then
		pcall(alpha.start, true)
	end
end

return M
