-- NOTE: to make any of this work you need a language server.
-- If you don't know what that is, watch this 5 min video:
-- https://www.youtube.com/watch?v=LaS32vctfOY

-- Reserve a space in the gutter
vim.opt.signcolumn = 'no'

local lspconfig = require('lspconfig')

local cmp = require('cmp')
cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
	},
	snippet = {
		expand = function(args)
			-- You need Neovim v0.10 to use vim.snippet
			vim.snippet.expand(args.body)
		end,
	},
	cmp_select = { behavior = cmp.SelectBehavior.Select },
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
-- local lspconfig_defaults = lspconfig.util.default_config
-- lspconfig_defaults.capabilities = vim.tbl_deep_extend(
-- 	'force',
-- 	lspconfig_defaults.capabilities,
-- 	require('cmp_nvim_lsp').default_capabilities()
-- )
vim.lsp.config('*', {
	root_markers = { '.git', '.hg' },
	capabilities = capabilities,
	-- capabilities = {
	-- 	textDocument = {
	-- 	  semanticTokens = {
	-- 		multilineTokenSupport = true,
	-- 	  }
	-- 	}
	--   }
})

vim.lsp.config('rust_analyzer', {
	settings = {
		imports = {
			granularity = {
				group = "module",
			},
			prefix = "self",
		},
		cargo = {
			buildScripts = {
				enable = true,
			},
		},
		procMacro = {
			enable = true
		},
	},
})

vim.lsp.config('clangd', {
	on_init = function(client)
		client.offset_encoding = 'utf-16'
	end,
	on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end,
	cmd = { 'clangd', '--background-index', '--clang-tidy', '--query-driver=/usr/bin/g++' },
	settings = {
		init_options = {
			fallbackFlags = { '-std=c++20' },
		},
	},
})

vim.lsp.config('lua_ls', {
	on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end,
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath('config')
				and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					'/usr/bin/wireshark',
					-- Depending on the usage, you might want to add additional paths
					-- here.
					-- '${3rd}/luv/library'
					-- '${3rd}/busted/library'
				}
				-- Or pull in all of 'runtimepath'.
				-- NOTE: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
				-- library = {
				--   vim.api.nvim_get_runtime_file('', true),
				-- }
			}
		})
	end,
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					'vim',
					'require'
				},
			},

		}
	}
})

require("sonarlint").setup({
	-- vim.lsp.config("sonarlint", {
	server = {
		cmd = {
			"sonarlint-language-server",
			-- Ensure that sonarlint-language-server uses stdio channel
			"-stdio",
			"-analyzers",
			-- paths to the analyzers you need, using those for python and java in this example
			-- IMPORTANT: the downloaded files for whatever fucking reason don't have
			-- cfamily analyzer with them. Don't forget to download it, then it will work
			-- (required version is in extensions/package.json, search for 'cfamily')
			vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
			vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
		},
		settings = {
			sonarlint = {
				-- pathToCompileCommands = "insert path here"
			}
		}
	},
	filetypes = {
		-- Tested and working
		"cs",
		"dockerfile",
		"python",
		"cpp",
	},
})

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	vim.diagnostic.config({ jump = { float = true } }),
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', '<leader>vws', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
		vim.keymap.set('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
		vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.jump({count=1})<cr>', opts)
		vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.jump({count=-1})<cr>', opts)
		vim.keymap.set('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		vim.keymap.set('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		vim.keymap.set('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set('n', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	end,
})
