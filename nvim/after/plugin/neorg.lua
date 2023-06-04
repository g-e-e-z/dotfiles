require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {  -- Adds pretty icons to your documents
            config = {
                folds = false
            }
        },
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/notes",
                },
                default_workspace = "notes"
            },
        },
        ["core.keybinds"] = {
            config = {
                neorg_leader = ","
            }
        },
        ["core.presenter"] = {
          config = {
            zen_mode = "zen-mode",
          },
        },
    }
}
