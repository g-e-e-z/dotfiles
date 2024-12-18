-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'sbdchd/neoformat'
    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        'ellisonleao/gruvbox.nvim',
        as = 'gruvbox',
        config = function()
            vim.cmd('colorscheme gruvbox')
        end
    }

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use 'nvim-treesitter/nvim-treesitter-context'

    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use("mbbill/undotree")

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'L3MON4D3/LuaSnip',
                -- follow latest release.
                tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!:).
                run = "make install_jsregexp"
            },
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use { "NvChad/nvim-colorizer.lua" }

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    use({
        "kdheepak/lazygit.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    use('lewis6991/gitsigns.nvim')
    use('windwp/nvim-ts-autotag')
    -- use {
    --     "windwp/nvim-autopairs",
    --     event = "InsertEnter",
    --     config = function()
    --         require("nvim-autopairs").setup {}
    --     end
    -- }
    use({
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end,
    })

    use("lukas-reineke/indent-blankline.nvim")
end)
