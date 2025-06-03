return {
    "mason-org/mason.nvim",
    opts = {
	ui = {
            icons = {
		package_installed = "✓",
		package_pending = "➜",
		package_uninstalled = "✗"
	    }
	},
	automatic_installation = true,
	ensure_installed = {"clangd"}
    }
}
