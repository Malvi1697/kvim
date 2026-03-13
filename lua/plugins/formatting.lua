return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	opts = {
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return
			end
			return { timeout_ms = 1500, lsp_format = 'fallback' }
		end,
		formatters_by_ft = {
			lua = { 'stylua' },
			go = { 'goimports', 'gofumpt' },
			python = { 'ruff_format' },
			javascript = { 'prettierd', 'prettier', stop_after_first = true },
			typescript = { 'prettierd', 'prettier', stop_after_first = true },
			vue = { 'prettierd', 'prettier', stop_after_first = true },
			html = { 'prettierd', 'prettier', stop_after_first = true },
			css = { 'prettierd', 'prettier', stop_after_first = true },
			json = { 'prettierd', 'prettier', stop_after_first = true },
		},
	},
}
