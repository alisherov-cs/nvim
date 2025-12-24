-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
	{ "ellisonleao/gruvbox.nvim", config = function ()
		vim.cmd.colorscheme("gruvbox")
	end },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			require("nvim-treesitter.config").setup({
				ensure_installed = { "html", "css", "lua", "typescript", "tsx", "javascript" },
				highlight = { enable = true },
				autotag = { enable = true }
			})
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						"dist",
						".git",
						"build",
						"assets",
						"public"
					},
				},
			})

			local map = vim.keymap.set
			map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
			map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
			map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
			map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
		end,
	},
	{
		"mg979/vim-visual-multi",
	},
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"tailwindcss"
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- Lua LSP
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			vim.lsp.config("tailwindcss", {
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"tsx",
				},

				init_options = {
					userLanguages = {
						typescript = "javascript",
						typescriptreact = "javascript",
					},
				},

				settings = {
					tailwindCSS = {
						classAttributes = { "class", "className", "clsx", "cva" },
						experimental = {
							classRegex = {
								"clsx%(([^)]*)%)",
								"cva%(([^)]*)%)",
							},
						},
					},
				},
			})

			-- TypeScript LSP
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				filetypes = {
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"javascript",
					"javascriptreact",
				},
				on_attach = function(client)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

					-- Go to declaration
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})

					-- Go to implementation
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})

					-- Find references
					vim.keymap.set("n", "gr", vim.lsp.buf.references, {})

					-- Hover documentation
					vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

					-- Signature help
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {})

					-- Diagnostics
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})

					-- Show error under cursor
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})

					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			})

			-- Enable servers
			vim.lsp.enable({
				"lua_ls",
				"ts_ls",
				'autotag'
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				mapping = {
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = {
					{ name = "nvim_lsp" },
				},
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			enable_close = true, -- Auto close tags
			enable_rename = true, -- Auto rename pairs of tags
			enable_close_on_slash = true -- Auto close on trailing </
		},
		per_filetype = {
			["javascriptreact"] = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true
			},
			["typescriptreact"] = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true
			}
		},
		config = function()
			require("nvim-ts-autotag").setup()
		end
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end
	},
	{
		"prettier/vim-prettier",
		run = "yarn install",
	},
	{
		"alvan/vim-closetag"
	},
	{
		"lewis6991/gitsigns.nvim"
	}
})

