---@module 'lazy'
---@type LazySpec
return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
    config = function()
      local parsers = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'javascript',
        'json',
        'python',
        'javascriptreact',
      }
      require('nvim-treesitter').install(parsers)
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          -- check if parser exists and load it
          if not vim.treesitter.language.add(language) then
            return
          end
          -- enables syntax highlighting and other treesitter features
          vim.treesitter.start(buf, language)

          -- enables treesitter based folds
          -- for more info on folds see `:help folds`
          -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo.foldmethod = 'expr'

          -- enables treesitter based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}

-- return {
--   { -- Highlight, edit, and navigate code
--     'nvim-treesitter/nvim-treesitter',
--     branch = 'main',
--     build = ':TSUpdate',
--     -- main = 'nvim-treesitter.configs', -- Sets main module to use for opts
--     -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
--     -- opts = {
--     config = function()
--       require('nvim-treesitter').setup {
--
--         ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
--         -- Autoinstall languages that are not installed
--         auto_install = true,
--         highlight = {
--           enable = true,
--           -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
--           --  If you are experiencing weird indenting issues, add the language to
--           --  the list of additional_vim_regex_highlighting and disabled languages for indent.
--           -- additional_vim_regex_highlighting = { 'ruby' },
--           additional_vim_regex_highlighting = false,
--         },
--         indent = { enable = true, disable = { 'ruby' } },
--
--         incremental_selection = {
--           enable = true,
--           keymaps = {
--             node_incremental = 'v',
--             node_decremental = 'V',
--           },
--         },
--       }
--       -- There are additional nvim-treesitter modules that you can use to interact
--       -- with nvim-treesitter. You should go explore a few and see what interests you:
--       --
--       --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--       --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--       --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--     end,
--   },
--

-- vim: ts=2 sts=2 sw=2 et
