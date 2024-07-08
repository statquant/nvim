local keymap = vim.keymap

local config = function()
  local telescope = require('telescope')
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous"
        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewr = false,
        hidden = true
      },
      live_grep = {
        theme = "dropdown",
        previewer = false,
      },
      find_buffer = {
        theme = "dropdown",
        previewer = false,
      }
    },
  })
end

return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = config,
  keys = {
    keymap.set('n', '<leader>f', ":Telescope find_files<CR>"),
    keymap.set('n', '<leader>g', ":Telescope live_grep<CR>"),
    keymap.set('n', '<leader>b', ":Telescope buffers<CR>"),
    keymap.set('n', '<leader>k', ":Telescope keymaps<CR>"),
  },
  enabled = true,
}