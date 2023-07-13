require("mason-lspconfig").setup({
	automatic_installation = false,
	ensure_installed = {
		"angularls",
		"bashls",
		"cssls",
		"emmet_ls",
		"html",
		"jsonls",
		"jdtls",
		"lua_ls",
		"tsserver",
		"vimls",
		"lemminx",
		"yamlls",
		"gopls",
		"rust_analyzer",
		"pyright",
		"ruff_lsp",
		"denols",
		"clangd",
		"marksman",
		"prosemd_lsp",
	},
})
