--------------------------
-- Global Settings
--------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.cmdheight = 0
opt.number = true
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 10
opt.background = "dark"
opt.tabstop = 2
opt.shiftwidth = 2

---------------------------
--- Keymaps
---------------------------
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

---------------------------
--- LSP and Diagnostics
---------------------------
vim.lsp.enable({ "lua_ls", "ts_ls" })
local severity = vim.diagnostic.severity
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
})
----------------------------
--- Autocommands
----------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

----------------------------
--- Lazy.nvim setup
----------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	{ ---Autopair brackets, braces etc
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{ ---Autocomplete
		"saghen/blink.cmp",
		version = "1.*",
		opts = {},
	},

	{ --- Autoformart
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					css = { "biome" },
					scss = { "biome" },
					json = { "biome" },
					jsonc = { "biome" },
					javascript = { "biome", "biome-organize-imports" },
					typescript = { "biome", "biome-organize-imports" },
					javascriptreact = { "biome", "biome-organize-imports" },
					typescriptreact = { "biome", "biome-organize-imports" },
				},
				formatters = {
					biome = {
						command = "biome",
						args = { "format", "--stdin-file-path", "$FILENAME", "--line-width", "120" },
						stdin = true,
					},
				},
				format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
			})
		end,
	},

	{ --- Simple Useful Plugins
		"echasnovski/mini.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local statusline = require("mini.statusline")
			statusline.setup({})
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},

	{ --- Language Parser
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ensure_installed = { "bash", "javascript", "typescript", "lua", "python", "json" }
			require("nvim-treesitter").install(ensure_installed)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = ensure_installed,
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},

	{ --- LSP Installer
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	{ --- Fuzzy Search
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.1",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))
			end, { desc = "Fuzzily search in current buffer" })
		end,
	},

	{ --- Git
		"lewis6991/gitsigns.nvim",
	},

	{ import = "plugins" },
})
