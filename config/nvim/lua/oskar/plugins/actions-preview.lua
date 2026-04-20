return {
    'aznhe21/actions-preview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', "neovim/nvim-lspconfig",},
	after = {'nvim-telescope/telescope.nvim'},
    config = function()
      require('actions-preview').setup({
			backend = "telescope",
			theme = "dropdown",
			previewer = false,
      })
    end
}
