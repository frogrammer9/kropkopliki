return {
	"neovim/nvim-lspconfig",
	dependencies = {"hrsh7th/cmp-nvim-lsp"},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local nvim_lsp = require("cmp_nvim_lsp")

		local capabilities = nvim_lsp.default_capabilities()
		local on_attach = function(client, bufnr)
			local opts = {buffer = bufnr, remap = false}

			vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
			vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
			vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
			vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
			vim.keymap.set("n", "<leader>tr", function() vim.diagnostic.open_float() end, opts)
			vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
			vim.keymap.set('n', '<leader>ca', '<cmd>lua require("actions-preview").code_actions()<CR>', opts)
		end
		lspconfig.lua_ls.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.pylsp.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.clangd.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.cmake.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.sqlls.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.bashls.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.glslls.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.arduino_language_server.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.zk.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.ts_ls.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.ltex.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.gopls.setup({on_attach = on_attach, capabilities = capabilities})
		lspconfig.svelte.setup({on_attach = on_attach, capabilities = capabilities})
	end
}
