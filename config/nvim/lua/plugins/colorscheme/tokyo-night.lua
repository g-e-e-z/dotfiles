-- NOTE: 2026 Colorscheme

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
	init = function()
    ---colorscheme tokyonight
    ---colorscheme tokyonight-night
    ---colorscheme tokyonight-storm
    ---colorscheme tokyonight-day
    ---colorscheme tokyonight-moon
		vim.cmd.colorscheme "tokyonight"
		-- vim.cmd.hi("Comment gui=none")
  end
}
