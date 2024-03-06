-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'sbdchd/neoformat'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
          'ellisonleao/gruvbox.nvim',
          as = 'gruvbox',
          config = function()
        	  vim.cmd('colorscheme gruvbox')
          end
  }

  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
  use 'nvim-treesitter/nvim-treesitter-context'
  use("theprimeagen/harpoon")
  use("mbbill/undotree")

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }
  }

  use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
  use {"NvChad/nvim-colorizer.lua"}

  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  use("github/copilot.vim")

  use({
      "kdheepak/lazygit.nvim",
      requires = {
          "nvim-lua/plenary.nvim",
      },
  })

  use('lewis6991/gitsigns.nvim')

end)
