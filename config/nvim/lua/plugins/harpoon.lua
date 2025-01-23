-- NOTE: Marks
return {
	"ThePrimeagen/harpoon",
	init = function()
		local harpoon = require("harpoon")

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
			vim.notify("   Marked file", vim.log.levels.INFO, { title = "Harpoon" })
		end, { desc = "Harpoon | Add Mark" })

		vim.keymap.set("n", "<leader>hi", function()
			harpoon.ui:toggle_quick_menu(require("harpoon"):list())
		end, { desc = "Harpoon | Index" })

		vim.keymap.set("n", "<leader>hh", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon | Select 1" })

		vim.keymap.set("n", "<leader>hj", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon | Select 2" })

		vim.keymap.set("n", "<leader>hk", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon | Select 3" })

		vim.keymap.set("n", "<leader>hl", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon | Select 4" })
	end,
	branch = "harpoon2",
	opts = {},
}
