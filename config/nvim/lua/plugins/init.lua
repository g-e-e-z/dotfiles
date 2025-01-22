return{
    'sbdchd/neoformat',
    'nvim-tree/nvim-web-devicons',
    {
        'ellisonleao/gruvbox.nvim',
        as = 'gruvbox',
        config = function()
            vim.cmd('colorscheme gruvbox')
        end
    },

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-treesitter/nvim-treesitter-context',

    -- use {
    --     'ThePrimeagen/harpoon',
    --     branch = 'harpoon2',
    --     dependencies = { { 'nvim-lua/plenary.nvim' } }
    -- }

    -- use('mbbill/undotree')

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
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
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    'NvChad/nvim-colorizer.lua',

    { 'iamcco/markdown-preview.nvim', build = 'cd app && npm install', setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }, },

    {
        'kdheepak/lazygit.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },

    'lewis6991/gitsigns.nvim',
    'windwp/nvim-ts-autotag',
    -- use {
    --     'windwp/nvim-autopairs',
    --     event = 'InsertEnter',
    --     config = function()
    --         require('nvim-autopairs').setup {}
    --     end
    -- }

    'lukas-reineke/indent-blankline.nvim'
    }
