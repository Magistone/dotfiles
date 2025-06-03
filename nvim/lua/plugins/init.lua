return {
	'wbthomason/packer.nvim',
	{
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  	},
  	{
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  	},
	{'nvim-treesitter/nvim-treesitter', branch = master, lazy = false, build = ':TSUpdate'},
	{
	  "ThePrimeagen/harpoon",
	  branch = "harpoon2",
	  requires = { {"nvim-lua/plenary.nvim"} }
  	},
	'mbbill/undotree',
  	'tpope/vim-fugitive',
  	'VonHeikemen/lsp-zero.nvim', branch = 'v4.x',
  	'neovim/nvim-lspconfig',
  	'williamboman/mason.nvim',
  	'williamboman/mason-lspconfig.nvim',
  	'hrsh7th/nvim-cmp',
  	'hrsh7th/cmp-nvim-lsp',
	'laytan/cloak.nvim',
}
