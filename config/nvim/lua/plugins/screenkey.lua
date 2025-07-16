-- NOTE: Show Screenkey
return {
	"NStefan002/screenkey.nvim",
	init = function()
		vim.keymap.set("n", "<leader>Ok", "<cmd>Screenkey<cr>", { desc = "Option | Toggle Screenkey", silent = true })
	end,
	cmd = "Screenkey",
	opts = {},
}
