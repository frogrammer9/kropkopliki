return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
	config = function ()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"c_sharp",
				"cpp",
				"asm",
				"bash",
				"cmake",
				"latex",
				"llvm",
				"make",
				"ninja",
				"python",
				"sql",
				"javascript",
				"typescript",
				"go",
				"svelte",
				"css",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
    end
}
