-- plugins.lua
return {
  -- Lazy can manage itself
  { 'folke/lazy.nvim', lazy = false },

  { 'catppuccin/nvim', name = 'catppuccin' },
  {
      "vhyrro/luarocks.nvim",
      priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
      config = true,
  },

  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/playground' },
  -- { 'theprimeagen/harpoon' },
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { 'eandrju/cellular-automaton.nvim' },

  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup() -- This calls Mason's own setup function
    end,
  },

  -- install without yarn or npm
  -- {
  --   'iamcco/markdown-preview.nvim',
  --   build = 'cd app && npm install',
  --   setup = function() vim.g.mkdp_filetypes = { 'markdown' } end,
  --   ft = { 'markdown' }
  -- },

  {
      'stevearc/oil.nvim',
      config = function()
          require('oil').setup(
          {
              default_file_explorer = true,
              delete_to_trash = true,
              win_options = {
                  wrap = true,
              },
              view_options = {
                  show_hidden = true, -- Show dotfiles and dotdirs

              },
          }
          )
      end
  },

  { 'https://github.com/apple/pkl-neovim.git' },

  {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 
          'nvim-lua/plenary.nvim',
          'nvim-lua/popup.nvim',
          'xiyaowong/telescope-emoji.nvim',
          'danielvolchek/tailiscope.nvim',
          'jonarrien/telescope-cmdline.nvim',
      }
  },

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
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' }
    }
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        -- automatic_installation = true, -- Optional
      })
    end,
  }
}
