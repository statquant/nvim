local keymap = vim.keymap

local config = function()
  local telescope = require('telescope')
  local work_dir = nil
  if vim.fn.expand("$USER") == "statquant" then 
    work_dir = {
      string.format("%s/Work/", vim.fn.expand("$HOME")),
    }
  else
    work_dir = {
      string.format("/sqpc/hpc/sp_auction_np/%s/public/", vim.fn.expand("$USER")),
      string.format("/sqpc/hpc/sp_auction_np/%s/private/", vim.fn.expand("$USER")),
      string.format("/sqpc/scratch/mid_freq/%s/private/", vim.fn.expand("$USER")),
      string.format("/sqpc/scratch/mid_freq/%s/public/", vim.fn.expand("$USER")),
    }
  end 
  local search_dirs = vim.list_extend({vim.fn.expand('%:p:h')}, work_dir)

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          -- Arrow keys are working fine
          -- ["<C-j>"] = "move_selection_next",
          -- ["<C-k>"] = "move_selection_previous"
        },
      },
    },
    pickers = {
      find_files = {
        search_dirs = search_dirs,
        theme = "dropdown",
        previewr = true,
        hidden = true
      },
      live_grep = {
        search_dirs = search_dirs,
        theme = "dropdown",
        previewer = true,
      },
      find_buffer = {
        search_dirs = search_dirs,
        theme = "dropdown",
        previewer = true,
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
    keymap.set('i', '<leader>f', "<Esc><leader>f"),
    keymap.set('n', '<leader>g', ":Telescope live_grep<CR>"),
    keymap.set('i', '<leader>g', "<Esc><leader>g"),
    keymap.set('n', '<leader>b', ":Telescope buffers<CR>"),
    keymap.set('i', '<leader>b', "<Esc><leader>b"),
    keymap.set('n', '<leader>k', ":Telescope keymaps<CR>"),
    keymap.set('i', '<leader>k', "<Esc><leader>k"),
  },
  enabled = true,
}
