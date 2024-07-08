local config = function ()
  -- Create a table with the options to be passed to setup()
  -- Function to find the root directory of the R package
  function find_package_root()
    local dir = vim.fn.expand('%:p:h')
    while dir ~= '/' do
      if vim.fn.filereadable(dir .. '/DESCRIPTION') == 1 then
        return dir
      end
      dir = vim.fn.fnamemodify(dir, ':h')
    end
    return nil
  end

  -- Function to run devtools::load_all with the correct path
  function load_all()
    local package_root = find_package_root()
    if package_root then
      local cmd = string.format('devtools::load_all("%s")', package_root)
      vim.fn['SendCmdToR'](cmd)
    else
      print("DESCRIPTION file not found in any parent directory")
    end
  end
  vim.api.nvim_buf_set_keymap(0, "n", "<leader>la", ":lua load_all()<CR>", {})

  -- Set up the keybinding

  local opts = {
    -- Options passed to R
    R_args = {"--quiet", "--no-save"},
    -- open terminal in another tmux pane
    external_term = "tmux split-window -vf ",
    -- Use radian for terminal
    -- R_app = "radian",
    -- config_tmux = false,
    hook = {
      after_config = function ()
        -- This function will be called at the FileType event
        -- of files supported by R.nvim. This is an
        -- opportunity to create mappings local to buffers.
        if vim.o.syntax ~= "rbrowser" then
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader><CR>", "<Plug>RDSendLine<Esc>i", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader><CR>", "<Esc><Plug>RDSendLine<Esc>i", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Plug>RDSendLine", {})
          vim.api.nvim_buf_set_keymap(0, "v", "<Space>", "<Plug>RSendSelection", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>ro", "<Esc><Plug>RInsertLineOutput", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>ro", "<Esc><Plug>RInsertLineOutput<Esc>i", {})
          vim.api.nvim_buf_set_keymap(0, "v", "<LocalLeader>zl", "<Cmd>lua require('r.run').action('pkg_load::load_all(here::here())')<CR>", {})
          vim.api.nvim_buf_set_keymap(0, "v", "<LocalLeader>zd", "<Cmd>lua require('r.run').action('pkg_load::document(here::here())')<CR>", {})
        end
      end
    },
    min_editor_width = 72,
    -- Always split horizontally
    rconsole_width = 0,
    rconsole_height = 15,
    disable_cmds = {
      "RClearConsole",
      "RCustomStart",
      "RSPlot",
      "RSaveClose",
      "ROBToggle",
    },
  }
  -- Check if the environment variable "R_AUTO_START" exists.
  -- If using fish shell, you could put in your config.fish:
  -- alias r "R_AUTO_START=true nvim"
  if vim.env.R_AUTO_START == "true" then
    opts.auto_start = 1
    opts.objbr_auto_start = true
  end
  require("r").setup(opts)
end

return {
  "R-nvim/R.nvim",
  lazy = false,
  config = config,
  enabled = true,
}
