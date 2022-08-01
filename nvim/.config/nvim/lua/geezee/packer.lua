return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    -- Tree
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    --
    -- Colors
    use("gruvbox-community/gruvbox")
end)
