local use = require("packer").use

return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    -- Tree Sitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    -- TJ created lodash of neovim
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")

    -- Colors
    use("gruvbox-community/gruvbox")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/nvim-cmp")
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')
    use("onsails/lspkind-nvim")

    -- Undotree
    use("mbbill/undotree")

    -- Comments
    use{
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    --- Literally just for EOL symbol ->
    use("tjdevries/cyclist.vim")

    --- Definitions and shit for lua dev
    use("folke/neodev.nvim")
    use("nanotee/luv-vimdocs")
    use("milisims/nvim-luaref")

    -- Status Bar
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Git
    use('tpope/vim-fugitive')

    -- use "~/code/plugins/neotes.nvim/"

end)
