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


    -- Colors
    use("gruvbox-community/gruvbox")

end)
