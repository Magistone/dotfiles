return {
	'mason-org/mason-lspconfig.nvim',
	opts = {
		ensure_installed = { 'lua_ls', 'rust_analyzer', 'html', 'eslint', 'clangd', 'gopls', 'pyright', 'htmx' },
	},
	dependencies = {
		'neovim/nvim-lspconfig',
		{
			'mason-org/mason.nvim',
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				},
				automatic_installation = true,
			}
		}
	}
}
