-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'Mofiqul/dracula.nvim',
    config = function()
      require('dracula').setup {
        colors = {
          bg = '#060808',
          fg = '#B9b9b2',
          selection = '#1c2525',
          comment = '#6272A4',
          red = '#FF5555',
          orange = '#FFB86C',
          yellow = '#CFC88D',
          green = '#7ACB88',
          purple = '#BD93F9',
          cyan = '#6fbaca',
          pink = '#FF79C6',

          bright_red = '#FF6E6E',
          bright_green = '#9ADF94',
          -- bright_yellow = '#F5F5A5',
          bright_yellow = '#DAD39A',
          bright_blue = '#CBB5FF',
          bright_magenta = '#F2A8D5',
          bright_cyan = '#A3D4D4',
          bright_white = '#DADADA',

          menu = '#21222C',
          visual = '#3E4452',
          gutter_fg = '#4B5263',
          nontext = '#3B4048',
          white = '#CCCCCC',
          black = '#191A21',
        },
        -- show the '~' characters after the end of buffers
        show_end_of_buffer = true, -- default false
        -- use transparent background
        -- transparent_bg = true, -- default false
        -- set custom lualine background color
        lualine_bg_color = '#44475a', -- default nil
        -- set italic comment
        italic_comment = true, -- default false
        -- overrides the default highlights with table see `:h synIDattr`
        overrides = {},
        -- You can use overrides as table like this
        -- overrides = {
        --   NonText = { fg = "white" }, -- set NonText fg to white
        --   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
        --   Nothing = {} -- clear highlight of Nothing
        -- },
        -- Or you can also use it like a function to get color from theme
        -- overrides = function (colors)
        --   return {
        --     NonText = { fg = colors.white }, -- set NonText fg to white of theme
        --   }
        -- end,
      }
      vim.cmd 'colorscheme dracula'
    end,
  },

  { 'shortcuts/no-neck-pain.nvim', opts = {
    autocmds = {
      enableOnTabEnter = true,
      enableOnVimEnter = true,
    },
  } },

  {
    'supermaven-inc/supermaven-nvim',
    event = 'VeryLazy',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          -- accept_suggestion = '<Tab>',
          accept_suggestion = '<Right>',
          clear_suggestion = '<C-]>',
          accept_word = '<C-j>',
        },
        ignore_filetypes = { cpp = true }, -- or { "cpp", }
        color = {
          suggestion_color = '#525252',
          cterm = 244,
        },
        log_level = 'info', -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
        condition = function()
          return false
        end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
      }
    end,
  },

  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },

  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = { -- set to setup table
    },
  },

  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    opts = {},
  },

  {
    'echasnovski/mini.jump2d',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('mini.jump2d').setup {
        silent = true,
        view = {
          dim = true,
          n_steps_ahead = 2,
        },
      }
      vim.keymap.del('n', '<CR>')
      vim.keymap.del('v', '<CR>')

      vim.api.nvim_set_hl(0, 'MiniJump2dSpot', {
        fg = '#00e34f',
        bg = '#000000',
        bold = true,
      })

      vim.api.nvim_set_hl(0, 'MiniJump2dSpotAhead', {
        fg = '#c600ff',
        bg = '#000000',
        italic = true,
      })
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox_dark',
        },
      }
    end,
  },

  {
    'renerocksai/telekasten.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telekasten').setup {
        home = vim.fn.expand '~/priv/docs/synced_phone/notes/',
      }
      -- vim.keymap.set('n', '<leader>zg', '<cmd>Telekasten search_notes<CR>')
      vim.keymap.set('n', '<leader>n/', function()
        require('telekasten').search_notes { default_text = '' }
      end, { desc = 'Search/Grep in notes (Telekasten)' })
      vim.keymap.set('n', '<leader>nf', '<cmd>Telekasten find_notes<CR>')
    end,
  },

  {
    'kylechui/nvim-surround',
    version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    'luiscassih/AniMotion.nvim',
    event = 'VeryLazy',
    config = function()
      require('AniMotion').setup {
        clear_keys = {}, -- disable <Esc> key so it won't override my "remove search highlight" mapping
      }
    end,
  },

  -- {
  --   'stevearc/oil.nvim',
  --   ---@module 'oil'
  --   ---@type oil.SetupOpts
  --   opts = {},
  --   -- Optional dependencies
  --   -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  --   dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  --   -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  --   lazy = false,
  -- },

  {
    'MagicDuck/grug-far.nvim',
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require('grug-far').setup {
        -- options, see Configuration section below
        -- there are no required options atm
      }
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    'echasnovski/mini.bufremove',
    version = '*',
    event = 'VeryLazy',

    config = function()
      require('mini.bufremove').setup {}
      vim.keymap.set('n', '<C-q>', require('mini.bufremove').delete, { desc = 'Delete buffer' })
    end,
  },
}
