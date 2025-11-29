return {
	{
		{
			"kepano/flexoki-neovim",
			name = "flexoki",
			priority = 1000,
			lazy = false,
			config = function()
				vim.cmd("colorscheme flexoki-light")
			end,
		},
	},
}
