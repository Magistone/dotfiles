return {
	{
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  dependencies = {'nvim-lua/plenary.nvim'}
  	},
  	{
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  	},
	{'nvim-treesitter/nvim-treesitter', branch = 'master', lazy = false, build = ':TSUpdate'},
	{
	  "ThePrimeagen/harpoon",
	  branch = "harpoon2",
	  dependencies = { "nvim-lua/plenary.nvim" }
  	},
	'mbbill/undotree',
  	'tpope/vim-fugitive',
  	'hrsh7th/nvim-cmp',
  	'hrsh7th/cmp-nvim-lsp',
	'laytan/cloak.nvim',
	'sharkdp/fd',
	'lewis6991/gitsigns.nvim',
	'https://gitlab.com/schrieveslaach/sonarlint.nvim',
}
