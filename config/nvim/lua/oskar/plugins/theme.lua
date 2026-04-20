return {
"samharju/synthweave.nvim",
lazy = false,
priority = 1000,
config = function()
	vim.cmd.colorscheme("synthweave-transparent")
	local synthweave = require("synthweave")
	synthweave.setup({
		transparent = false,
		overrides = {
			-- example Identifier = { fg = "#f22f52" },
		},
		palette = {
			-- example bg0 = "#040404",
		},
	})
	synthweave.load()
end,
}
