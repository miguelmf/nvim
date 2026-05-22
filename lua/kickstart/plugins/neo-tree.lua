-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  -- version = '*',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  -- keys = {
  --   { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  -- },
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    window = {
      position = 'left',
      width = 25,
    },

    -- filesystem = {
    --   window = {
    --     mappings = {
    --       ['\\'] = 'close_window',
    --     },
    --   },
    -- },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    -- vim.api.nvim_create_autocmd('VimEnter', {
    --   callback = function()
    --     if vim.fn.argc() == 0 then
    --       require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd() }
    --     end
    --   end,
    -- })

    -- Open Neo-tree on startup if no file argument is given
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        if vim.fn.argc() == 0 then
          -- Open Neo-tree in the current directory
          require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd() }

          -- Move cursor back to the main window (the empty buffer)
          local wins = vim.api.nvim_tabpage_list_wins(0)
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
            if ft ~= 'neo-tree' then
              vim.api.nvim_set_current_win(win)
              break
            end
          end
        end
      end,
    })
  end,
}
