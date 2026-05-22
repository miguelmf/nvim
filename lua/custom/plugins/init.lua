-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'shortcuts/no-neck-pain.nvim',
    opts = {
      autocmds = {
        enableOnTabEnter = true,
        enableOnVimEnter = true,
      },
      -- buffers = {
      --   right = {
      --     enabled = true,
      --     -- width = 150,
      --   },
      --   left = {
      --     enabled = false,
      --   },
      -- },
      -- width = 115,
      --@type table
      -- integrations = {
      --   NeoTree = {
      --     -- The position of the tree.
      --     --@type "left"|"right"
      --     position = 'left',
      --     -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
      --     reopen = true,
      --   },
      -- },
    },
  },

  {
    'supermaven-inc/supermaven-nvim',
    event = 'VeryLazy',
    -- enabled = false,
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<C-l>',
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
    -- opts = {
    -- lsp = {
    --   -- override = {
    --   --   ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
    --   --   ['vim.lsp.util.stylize_markdown'] = true,
    --   -- },
    --   signature = {
    --     enabled = false,
    --   },
    -- presets = {
    --   lsp_doc_border = false, -- add a border to hover docs and signature help
    -- },
    -- },
    -- opts = {},
    config = function()
      require('noice').setup {
        lsp = {
          signature = {
            enabled = false,
          },
          presets = {
            lsp_doc_border = true, -- add a border to hover docs and signature help
          },
        },
      }
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    -- Fixes annoying notify background warning.
    vim.api.nvim_set_hl(0, 'NotifyBackground', { bg = '#000000' }),
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
    'ellisonleao/gruvbox.nvim',
    config = function()
      require('gruvbox').setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = 'hard', -- can be "hard", "soft" or empty string
        -- overrides = {},
        dim_inactive = false,
        transparent_mode = false,
        palette_overrides = {},
        overrides = {
          Normal = { bg = '#060808' },
          GruvboxFg1 = { fg = '#d5c4a1' },
          -- Comment = { fg = '#FF1111' },
        },
      }
      vim.cmd 'colorscheme gruvbox'
    end,
  },

  {
    'renerocksai/telekasten.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telekasten').setup {
        home = vim.fn.expand '~/priv/docs/synced_phone/notes/',
        -- picker = 'snacks',
      }
      -- vim.keymap.set('n', '<leader>zg', '<cmd>Telekasten search_notes<CR>')
      vim.keymap.set('n', '<leader>n/', function()
        require('telekasten').search_notes { default_text = '' }
      end, { desc = 'Search/Grep in notes (Telekasten)' })
      vim.keymap.set('n', '<leader>nf', '<cmd>Telekasten find_notes<CR>')
      vim.keymap.set('n', '<leader>nn', '<cmd>Telekasten new_note<CR>')
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
      -- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
    end,
  },

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

  {
    'ethanholz/nvim-lastplace',
    config = function()
      require('nvim-lastplace').setup {
        lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
        lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
      }
    end,
  },
  -- {
  --   'augmentcode/augment.vim',
  --   enabled = false,
  --   init = function()
  --     -- Disable default <Tab> mapping
  --     vim.g.augment_disable_tab_mapping = true
  --   end,
  --   config = function()
  --     -- Map <C-l> to accept suggestions
  --     vim.keymap.set('i', '<C-l>', '<cmd>call augment#Accept()<CR>', { noremap = true, silent = true })
  --   end,
  -- },

  -- {
  --   'barrett-ruth/live-server.nvim',
  --   build = 'pnpm add -g live-server',
  --   cmd = { 'LiveServerStart', 'LiveServerStop' },
  --   config = true,
  -- },

  {
    'windwp/nvim-ts-autotag',
  },
  {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    opts = {
      views = {
        finder = {
          mappings = {
            ['q'] = 'CloseView',
            ['<Esc>'] = 'CloseView',
            ['<CR>'] = 'Select',
            ['<C-t>'] = 'SelectTab',
            ['|'] = 'SelectVSplit',
            ['-'] = 'SelectSplit',
            ['^'] = 'GotoParent',
            ['='] = 'GotoCwd',
            ['.'] = 'GotoNode',
          },

          win = {
            border = 'single',
            kinds = {
              float = {
                height = '50%',
                width = '50%',
                top = '10%',
                left = '25%',
              },
            },
          },
        },
      },
    },
  },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  {
    'karb94/neoscroll.nvim',
    enabled = false,
    opts = {},
  },

  {
    'esmuellert/codediff.nvim',
    -- enabled = false,
    cmd = 'CodeDiff',
    opts = {
      -- Highlight configuration
      highlights = {
        -- Line-level: accepts highlight group names or hex colors (e.g., "#2ea043")
        -- line_insert = 'DiffAdd', -- Line-level insertions
        line_insert = '#006b00', -- Line-level insertions
        line_delete = 'DiffDelete', -- Line-level deletions

        -- Character-level: accepts highlight group names or hex colors
        -- If specified, these override char_brightness calculation
        char_insert = nil, -- Character-level insertions (nil = auto-derive)
        char_delete = nil, -- Character-level deletions (nil = auto-derive)

        -- Brightness multiplier (only used when char_insert/char_delete are nil)
        -- nil = auto-detect based on background (1.4 for dark, 0.92 for light)
        char_brightness = nil, -- Auto-adjust based on your colorscheme

        -- Conflict sign highlights (for merge conflict views)
        -- Accepts highlight group names or hex colors (e.g., "#f0883e")
        -- nil = use default fallback chain
        conflict_sign = nil, -- Unresolved: DiagnosticSignWarn -> #f0883e
        conflict_sign_resolved = nil, -- Resolved: Comment -> #6e7681
        conflict_sign_accepted = nil, -- Accepted: GitSignsAdd -> DiagnosticSignOk -> #3fb950
        conflict_sign_rejected = nil, -- Rejected: GitSignsDelete -> DiagnosticSignError -> #f85149
      },

      -- Diff view behavior
      diff = {
        -- layout = 'side-by-side', -- Diff layout: "side-by-side" (two panes) or "inline" (single pane with virtual lines)
        layout = 'inline', -- Diff layout: "side-by-side" (two panes) or "inline" (single pane with virtual lines)
        disable_inlay_hints = true, -- Disable inlay hints in diff windows for cleaner view
        max_computation_time_ms = 5000, -- Maximum time for diff computation (VSCode default)
        ignore_trim_whitespace = false, -- Ignore leading/trailing whitespace changes (like diffopt+=iwhite)
        hide_merge_artifacts = false, -- Hide merge tool temp files (*.orig, *.BACKUP.*, *.BASE.*, *.LOCAL.*, *.REMOTE.*)
        original_position = 'left', -- Position of original (old) content: "left" or "right"
        conflict_ours_position = 'right', -- Position of ours (:2) in conflict view: "left" or "right"
        conflict_result_position = 'bottom', -- "bottom" (default): result below diff panes or "center": result between diff panes (three columns)
        conflict_result_height = 30, -- Height of result pane in bottom layout (% of total height)
        conflict_result_width_ratio = { 1, 1, 1 }, -- Width ratio for center layout panes {left, center, right} (e.g., {1, 2, 1} for wider result)
        cycle_next_hunk = true, -- Wrap around when navigating hunks (]c/[c): false to stop at first/last
        cycle_next_file = true, -- Wrap around when navigating files (]f/[f): false to stop at first/last
        jump_to_first_change = true, -- Auto-scroll to first change when opening a diff: false to stay at same line
        highlight_priority = 100, -- Priority for line-level diff highlights (increase to override LSP highlights)
        compute_moves = false, -- Detect moved code blocks (opt-in, matches VSCode experimental.showMoves)
      },

      -- Explorer panel configuration
      explorer = {
        hidden = true,
        position = 'left', -- "left" or "bottom"
        width = 25, -- Width when position is "left" (columns)
        height = 15, -- Height when position is "bottom" (lines)
        indent_markers = true, -- Show indent markers in tree view (│, ├, └)
        initial_focus = 'explorer', -- Initial focus: "explorer", "original", or "modified"
        icons = {
          folder_closed = '', -- Nerd Font folder icon (customize as needed)
          folder_open = '', -- Nerd Font folder-open icon
        },
        view_mode = 'list', -- "list" or "tree"
        flatten_dirs = true, -- Flatten single-child directory chains in tree view
        file_filter = {
          ignore = { '.git/**', '.jj/**' }, -- Glob patterns to hide (e.g., {"*.lock", "dist/*"})
        },
        focus_on_select = false, -- Jump to modified pane after selecting a file (default: stay in explorer)
        visible_groups = { -- Which groups to show (can be toggled at runtime)
          staged = true,
          unstaged = true,
          conflicts = true,
        },
      },

      -- History panel configuration (for :CodeDiff history)
      history = {
        position = 'bottom', -- "left" or "bottom" (default: bottom)
        width = 40, -- Width when position is "left" (columns)
        height = 15, -- Height when position is "bottom" (lines)
        initial_focus = 'history', -- Initial focus: "history", "original", or "modified"
        view_mode = 'list', -- "list" or "tree" for files under commits
      },

      -- Keymaps in diff view
      keymaps = {
        view = {
          quit = 'q', -- Close diff tab
          toggle_explorer = '<leader>b', -- Toggle explorer visibility (explorer mode only)
          focus_explorer = '<leader>e', -- Focus explorer panel (explorer mode only)
          next_hunk = ']c', -- Jump to next change
          prev_hunk = '[c', -- Jump to previous change
          next_file = ']f', -- Next file in explorer/history mode
          prev_file = '[f', -- Previous file in explorer/history mode
          diff_get = 'do', -- Get change from other buffer (like vimdiff)
          diff_put = 'dp', -- Put change to other buffer (like vimdiff)
          open_in_prev_tab = 'gf', -- Open current buffer in previous tab (or create one before)
          close_on_open_in_prev_tab = false, -- Close codediff tab after gf opens file in previous tab
          toggle_stage = '-', -- Stage/unstage current file (works in explorer and diff buffers)
          stage_hunk = '<leader>hs', -- Stage hunk under cursor to git index
          unstage_hunk = '<leader>hu', -- Unstage hunk under cursor from git index
          discard_hunk = '<leader>hr', -- Discard hunk under cursor (working tree only)
          hunk_textobject = 'ih', -- Textobject for hunk (vih to select, yih to yank, etc.)
          show_help = 'g?', -- Show floating window with available keymaps
          align_move = 'gm', -- Temporarily align moved code blocks across panes
          toggle_layout = 't', -- Toggle between side-by-side and inline layout
        },
        explorer = {
          select = '<CR>', -- Open diff for selected file
          hover = 'K', -- Show file diff preview
          refresh = 'R', -- Refresh git status
          toggle_view_mode = 'i', -- Toggle between 'list' and 'tree' views
          stage_all = 'S', -- Stage all files
          unstage_all = 'U', -- Unstage all files
          restore = 'X', -- Discard changes (restore file)
          toggle_changes = 'gu', -- Toggle Changes (unstaged) group visibility
          toggle_staged = 'gs', -- Toggle Staged Changes group visibility
          -- Fold keymaps (Vim-style)
          fold_open = 'zo', -- Open fold (expand current node)
          fold_open_recursive = 'zO', -- Open fold recursively (expand all descendants)
          fold_close = 'zc', -- Close fold (collapse current node)
          fold_close_recursive = 'zC', -- Close fold recursively (collapse all descendants)
          fold_toggle = 'za', -- Toggle fold (expand/collapse current node)
          fold_toggle_recursive = 'zA', -- Toggle fold recursively
          fold_open_all = 'zR', -- Open all folds in tree
          fold_close_all = 'zM', -- Close all folds in tree
        },
        history = {
          select = '<CR>', -- Select commit/file or toggle expand
          toggle_view_mode = 'i', -- Toggle between 'list' and 'tree' views
          refresh = 'R', -- Refresh history (re-fetch commits)
          -- Fold keymaps (Vim-style, apply to directory nodes only)
          fold_open = 'zo', -- Open fold (expand current node)
          fold_open_recursive = 'zO', -- Open fold recursively (expand all descendants)
          fold_close = 'zc', -- Close fold (collapse current node)
          fold_close_recursive = 'zC', -- Close fold recursively (collapse all descendants)
          fold_toggle = 'za', -- Toggle fold (expand/collapse current node)
          fold_toggle_recursive = 'zA', -- Toggle fold recursively
          fold_open_all = 'zR', -- Open all folds in tree
          fold_close_all = 'zM', -- Close all folds in tree
        },
        conflict = {
          accept_incoming = '<leader>ct', -- Accept incoming (theirs/left) change
          accept_current = '<leader>co', -- Accept current (ours/right) change
          accept_both = '<leader>cb', -- Accept both changes (incoming first)
          discard = '<leader>cx', -- Discard both, keep base
          -- Accept all (whole file) - uppercase versions
          accept_all_incoming = '<leader>cT', -- Accept ALL incoming changes
          accept_all_current = '<leader>cO', -- Accept ALL current changes
          accept_all_both = '<leader>cB', -- Accept ALL both changes
          discard_all = '<leader>cX', -- Discard ALL, reset to base
          next_conflict = ']x', -- Jump to next conflict
          prev_conflict = '[x', -- Jump to previous conflict
          diffget_incoming = '2do', -- Get hunk from incoming (left/theirs) buffer
          diffget_current = '3do', -- Get hunk from current (right/ours) buffer
        },
      },
    },
  },

  {
    'rmagatti/goto-preview', -- https://github.com/rmagatti/goto-preview
    dependencies = { 'rmagatti/logger.nvim' },
    event = 'BufEnter',
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    opts = {
      width = 80, -- Width of the floating window
      height = 15, -- Height of the floating window
      border = { '↖', '─', '┐', '│', '┘', '─', '└', '│' }, -- Border characters of the floating window
      default_mappings = false, -- Bind default mappings
      debug = false, -- Print debug information
      opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
      resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
      post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
      post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
      references = { -- Configure the telescope UI for slowing the references cycling window.
        provider = 'telescope', -- telescope|fzf_lua|snacks|mini_pick|default
        telescope = require('telescope.themes').get_dropdown { hide_preview = false },
      },
      -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
      focus_on_open = true, -- Focus the floating window when opening it.
      dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
      force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
      bufhidden = 'wipe', -- the bufhidden option to set on the floating window. See :h bufhidden
      stack_floating_preview_windows = true, -- Whether to nest floating windows
      same_file_float_preview = true, -- Whether to open a new floating window for a reference within the current file
      preview_window_title = { enable = true, position = 'left' }, -- Whether to set the preview window title as the filename
      zindex = 1, -- Starting zindex for the stack of floating windows
      vim_ui_input = true, -- Whether to override vim.ui.input with a goto-preview floating window
    },
  },

  {
    'nvim-mini/mini.map',
    version = false, -- use 'false' for main / '*" for stable
    event = 'VeryLazy',
    config = function()
      require('mini.map').setup {
        -- YOUR CONFIG HERE (all are optional)
        window = {
          side = 'right', -- "left" or "right"
          width = 5, -- columns
          focusable = false,
        },
        show_integration_count = false,
      }

      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('MiniMapAutoOpen', { clear = true }),
        callback = function()
          if vim.bo.buftype == '' and vim.bo.filetype ~= '' then
            require('mini.map').open()
          end
        end,
      })
    end,
  },

  -- {
  --   'kokusenz/deltaview.nvim',
  --   -- dependencies = { 'kokusenz/delta.lua' },
  --   event = 'VeryLazy',
  --   config = function()
  --     require('deltaview').setup {
  --       fzf_picker = 'telescope',
  --       keyconfig = {
  --         dm_toggle_keybind = '<leader>gf',
  --         dv_toggle_keybind = '<leader>gd',
  --       },
  --     }
  --   end,
  -- },
  --
  -- {
  --   'kokusenz/delta.lua', -- deltaview depends on this
  --   config = function()
  --     require('delta').setup {
  --       highlight_groups = {
  --         dark = {
  --           DeltaDiffAddedLine = { bg = '#006b00', default = false },
  --         },
  --       },
  --     }
  --   end,
  -- },

  {
    'hiphish/rainbow-delimiters.nvim',
  },
}
