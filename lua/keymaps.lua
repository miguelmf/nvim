-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- vim.keymap.set('n', '<leader>s', function()
--   require('mini.jump2d').start(require('mini.jump2d').builtin_opts.word_start)
-- end, { desc = 'Jump to start of words' })

vim.keymap.set('n', '<C-s>', function()
  require('mini.jump2d').start(require('mini.jump2d').builtin_opts.word_start)
end, { desc = 'Jump to start of words' })

-- vim.keymap.set('n', '<CR>', function()
--   require('mini.jump2d').start(require('mini.jump2d').builtin_opts.word_start)
-- end, { desc = 'Jump to start of words' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et

-- nvim-surround
vim.keymap.set('x', '(', 'S)', { remap = true })
vim.keymap.set('x', ')', 'S)', { remap = true })
vim.keymap.set('x', '[', 'S]', { remap = true })
vim.keymap.set('x', ']', 'S]', { remap = true })
vim.keymap.set('x', '{', 'S}', { remap = true })
vim.keymap.set('x', '}', 'S}', { remap = true })
vim.keymap.set('x', '"', 'S"', { remap = true })

-- Paste over word without yanking
vim.keymap.set('n', '<leader>p', [["_diw"+P]], { desc = 'Paste over word without yanking' })

-- to-do comments
vim.keymap.set('n', '<leader>tx', ':TodoTelescope<CR>', { desc = 'To-do comments' })

-- LSP
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'LSP Signature Help (insert mode)' })

-- Fyler
vim.keymap.set('n', '\\', '<cmd>Fyler kind=float<cr>', { desc = 'Fyler' })

-- Mini-diff
vim.keymap.set('n', '<leader>go', function()
  require('mini.diff').toggle_overlay(0)
end, { desc = 'Toggle mini.diff overlay' })

-- CodeDiff
vim.keymap.set('n', '<leader>gd', '<cmd>CodeDiff<cr>', { desc = '(git)CodeDiff' })

-- Pane switching with numbers
-- for i = 1, 4 do
--   vim.keymap.set('n', '<leader' .. i .. '>', function()
--     vim.api.nvim_command(i .. 'wincmd w')
--   end, { desc = 'Go to window ' .. i })
-- end

-- Jump to window 1-9 with <leader>1 ... <leader>9
for i = 1, 4 do
  vim.keymap.set('n', '<leader>' .. i, i .. '<C-w>w', { desc = 'Go to window ' .. i })
end

-- goto-preview https://github.com/rmagatti/goto-preview
vim.keymap.set('n', 'gp', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, desc = 'preview definition (goto-preview)' })
-- vim.keymap.set('n', '<Esc>', "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true, desc = 'close all win goto-preview' })

vim.keymap.set('n', '<Esc>', function()
  require('goto-preview').close_all_win()
  vim.cmd 'nohlsearch'
end, { noremap = true, silent = true, desc = 'Close goto-preview windows + nohlsearch' })

-- incremental selection treesitter/lsp
vim.keymap.set('n', '<C-Right>', function()
  vim.cmd 'normal! v'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('an', true, false, true), 'x', false)
end, { desc = 'Increment selection' })
vim.keymap.set('x', '<C-Right>', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('an', true, false, true), 'x', false)
end, { desc = 'Increment selection' })
vim.keymap.set('x', '<C-Left>', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('in', true, false, true), 'x', false)
end, { desc = 'Decrement selection' })

-----
--vim.keymap.set({ 'n', 'x', 'o' }, 's', require('jump').start, {})

-- deltaview

-- vim.keymap.set('n', '<leader>gd', ':DeltaView<CR>', { desc = 'DeltaView' })
-- vim.keymap.set('n', '<leader>gf', ':DeltaMenu<CR>', { desc = 'DeltaMenu' })
