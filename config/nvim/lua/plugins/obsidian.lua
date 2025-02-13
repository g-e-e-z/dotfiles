return {
    "epwalsh/obsidian.nvim",
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
                name = "personal",
                path = "~/Notes",
                overrides = {
                    notes_subdir = "0-inbox",
                },
            },
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
        disable_frontmatter = true,
        templates = {
            folder = "templates",
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

                    if #lines == 0 then return "" end

                    -- Trim the first and last lines based on column selection
                    lines[1] = lines[1]:sub(start_col)
                    lines[#lines] = lines[#lines]:sub(1, end_col)

                    -- Join the lines into a single string
                    return table.concat(lines, "\n")
                end
            }

        },
        attachments = {
            img_folder = "images",
        },
    },
    config = function(_, opts)
        local obsidian = require("obsidian")

        obsidian.setup(opts)

        vim.keymap.set("n", "<leader><leader>", obsidian.util.toggle_checkbox, { desc = "Notes | Toggle Checkbox" })
        vim.keymap.set("n", "<leader>zo", "<cmd>ObsidianOpen<CR>", { desc = "Notes | Open in Obsidian App" })
        vim.keymap.set("n", "<leader>zb", "<cmd>ObsidianBacklinks<CR>", { desc = "Notes | Show Obsidian Backlinks" })
        vim.keymap.set("n", "<leader>zl", "<cmd>ObsidianLinks<CR>", { desc = "Notes | Show Obsidian Links" })
        vim.keymap.set("n", "<leader>zs", "<cmd>ObsidianSearch<CR>", { desc = "Notes | Search Obsidian" })
        vim.keymap.set("n", "<leader>zq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Notes | Quick Switch" })
        vim.keymap.set("n", "<leader>zp", "<cmd>ObsidianPasteImg<CR>", { desc = "Notes | Paste Image" })
        vim.keymap.set("n", "<leader>zdd", ":!rm '%:p'<CR>:bd<CR>", { desc = "Notes | Delete File", silent = true })

        local function format_title(line_num)
            local title = vim.fn.getline(line_num)

            title = title:sub(14)
            title = title:gsub("_", " ")
            title = title:gsub("(%w+)", function(word) return word:sub(1, 1):upper() .. word:sub(2):lower() end)

            -- Set the modified title back to the line
            vim.fn.setline(line_num, "# " .. title)
        end

        vim.keymap.set("n", "<leader>zn", function()
            -- Get the current date
            local current_date = os.date("%Y-%m-%d")

            -- Prompt user for the filename
            local user_input = vim.fn.input("Enter filename: ")

            -- If user provides an input, prepend the date and create the file
            if user_input and user_input ~= "" then
                local formatted_filename = current_date .. "_" .. user_input
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
        end, { desc = "Notes | Create New Note" })

        -- Inserts template and formats first title by removing date and file name chars
        vim.keymap.set("n", "<leader>zt", function()
            vim.cmd("ObsidianTemplate note")
            -- Format Title
            format_title(11)
            vim.cmd("noh")
        end, { desc = "Notes | Insert Template" })

        -- Find Notes Files
        local notes_dir = { os.getenv("SECOND_BRAIN") }
        vim.keymap.set("n", "<leader>zf", function()
            require("telescope.builtin").find_files {
                prompt_title = "Notes Files",
                search_dirs = notes_dir,
            }
        end, { desc = "Notes | Find Notes Files", silent = true })

        -- Grep Notes Files
        vim.keymap.set("n", "<leader>zg", function()
            require("telescope.builtin").live_grep {
                prompt_title = "Notes Files",
                search_dirs = notes_dir,
            }
        end, { desc = "Notes | Grep Notes Files", silent = true })
    end,
}
