return {
	"williamboman/mason-lspconfig.nvim",
	after = {"williamboman/mason.nvim", "neovim/nvim-lspconfig"},
	config = function()
	require("mason-lspconfig").setup({
	  ensure_installed = {
		"lua_ls",
		"ltex",
		"pylsp",
		"clangd",
		"cmake",
		"sqlls",
		"bashls",
		"zk",
		"quick_lint_js",
		"ts_ls",
		"gopls",
		"svelte"
	  },
	})
	end
}
