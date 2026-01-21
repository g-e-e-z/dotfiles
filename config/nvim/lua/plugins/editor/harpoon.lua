-- NOTE: Marks
return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {},
	init = function()
		local harpoon = require("harpoon")

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
			vim.notify("   Marked file", vim.log.levels.INFO, { title = "Harpoon" })
		end, { desc = "Harpoon | Add Mark" })

		vim.keymap.set("n", "<leader>hi", function()
			harpoon.ui:toggle_quick_menu(require("harpoon"):list())
		end, { desc = "Harpoon | Index" })

		vim.keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon | Select 1" })

        vim.keymap.set("n", "<C-j>", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon | Select 2" })

		vim.keymap.set("n", "<C-k>", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon | Select 3" })

		vim.keymap.set("n", "<C-l>", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon | Select 4" })
	end,
}
