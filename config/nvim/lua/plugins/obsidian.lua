local SECOND_BRAIN = os.getenv("SECOND_BRAIN") or "$HOME/second_brain"
return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "second_brain",
				path = SECOND_BRAIN,
				overrides = {
					notes_subdir = "inbox",
				},
			},
		},
		-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
		completion = {
			-- Enables completion using nvim_cmp
			nvim_cmp = true,
			-- Enables completion using blink.cmp
			blink = false,
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},
		mappings = {
			["gd"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
		},
		note_id_func = function(title)
			return string.gsub(title, " ", "_")
		end,
		new_notes_location = "notes_subdir",
		disable_frontmatter = true,
		templates = {
			folder = SECOND_BRAIN .. "/templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {
				selection = function()
					-- Get the start and end positions of the visual selection
					local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
					local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))

					-- Get selected text
					local lines = vim.fn.getline(start_line, end_line)

					-- Ensure lines is always a table
					if type(lines) == "string" then
						lines = { lines }
					end

					if #lines == 0 then
						return ""
					end

					-- Trim the first and last lines based on column selection
					lines[1] = lines[1]:sub(start_col)
					lines[#lines] = lines[#lines]:sub(1, end_col)

					-- Join the lines into a single string
					return table.concat(lines, "\n")
				end,
			},
		},
		attachments = {
			img_folder = "images",
		},
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			vim.fn.jobstart({ "open", url }) -- Mac OS
			-- vim.fn.jobstart({"xdg-open", url})  -- linux
			-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
			-- vim.ui.open(url) -- need Neovim 0.10.0+
		end,
	},
	config = function(_, opts)
		local obsidian = require("obsidian")

		obsidian.setup(opts)

		vim.keymap.set("n", "<leader>oo", obsidian.util.toggle_checkbox, { desc = "Obsidian | Toggle Checkbox" })
		-- vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Obsidian | Open in Obsidian App" })
		vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Obsidian | Show Obsidian Backlinks" })
		vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Obsidian | Show Obsidian Links" })
		vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Obsidian | Search Obsidian" })
		vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Obsidian | Quick Switch" })
		vim.keymap.set("n", "<leader>op", "<cmd>ObsidianPasteImg<CR>", { desc = "Obsidian | Paste Image" })
		vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<CR>:bd<CR>", { desc = "Obsidian | Delete File", silent = true })

		local function format_title(line_num)
			local title = vim.fn.getline(line_num)

			title = title:sub(3)
			title = title:gsub("_", " ")
			title = title:gsub("(%w+)", function(word)
				return word:sub(1, 1):upper() .. word:sub(2):lower()
			end)

			-- Set the modified title back to the line
			vim.fn.setline(line_num, "# " .. title)
		end

		vim.keymap.set("n", "<leader>on", function()
			-- Get the current date
			-- local current_date = os.date("%Y-%m-%d")

			-- Prompt user for the filename
			local user_input = vim.fn.input("Enter filename: ")

			-- If user provides an input, prepend the date and create the file
			if user_input and user_input ~= "" then
				-- local formatted_filename = current_date .. "_" .. user_input
				local formatted_filename = user_input
				vim.cmd("ObsidianNew " .. formatted_filename)

				-- Delete all text
				vim.cmd("silent! %d")

				-- Apply Template
				vim.cmd("ObsidianTemplate note")

				-- Format Title
				format_title(11)

				-- Remove search highlight
				vim.cmd("noh")
			else
				print("Filename not provided, note creation cancelled.")
			end
		end, { desc = "Obsidian | Create New Note" })

		-- Inserts template and formats first title by removing date and file name chars
		vim.keymap.set("n", "<leader>ot", function()
			vim.cmd("ObsidianTemplate note")
			-- Format Title
			format_title(9)
			vim.cmd("noh")
		end, { desc = "Obsidian | Insert Template" })

		-- Find Notes Files
		local notes_dir = { os.getenv("SECOND_BRAIN") }
		vim.keymap.set("n", "<leader>of", function()
			require("telescope.builtin").find_files({
				prompt_title = "Notes Files",
				search_dirs = notes_dir,
				no_ignore = true,
				-- search_file = "%.md"
			})
		end, { desc = "Obsidian | Find Notes Files", silent = true })

		-- Grep Notes Files
		vim.keymap.set("n", "<leader>og", function()
			require("telescope.builtin").live_grep({
				prompt_title = "Notes Files",
				search_dirs = notes_dir,
			})
		end, { desc = "Obsidian | Grep Notes Files", silent = true })
	end,
}
