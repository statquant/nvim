local config = function ()

  -- Set up the keybinding

  local opts = {
    -- Options passed to R
    R_args = {"--quiet", "--no-save"},
    -- open terminal in another tmux pane
    external_term = "tmux split-window -v ",
    -- Use radian for terminal
    -- R_app = "radian",
    -- config_tmux = false,
    -- Only user mappings
    user_maps_only = true,
    hook = {
      on_filetype = function ()
        if vim.o.syntax ~= "rbrowser" then
          -- Start/Stop
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>rf", "<Plug>RStart", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>rq", "<Plug>RClose", {})
          -- Default sending
          vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Plug>RDSendLine", {})
          vim.api.nvim_buf_set_keymap(0, "v", "<Space>", "<Plug>RSendSelection", {})
          -- More movements
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader><CR>", "<Plug>RDSendLine", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader><CR>", "<Esc><Leader><CR>i", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader><up>", "<Plug>RSendAboveLines", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader><up>", "<Esc><Leader><up>i", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader><left>", "<Plug>RNLeftPart", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader><left>", "<Esc><Leader><left>i", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader><right>", "<Plug>RNRightPart", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader><right>", "<Esc><Leader><right>i", {})
          -- Advanced
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>hp", "<Plug>RHelp", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>hp", "<Esc><Leader>hpi", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>ou", "<Plug>RInsertLineOutput", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>ou", "<Esc><Leader>oui", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>pr", "<Plug>RObjectPr", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>pr", "<Esc><Leader>pri", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>ag", "<Plug>RShowArgs", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>ag", "<Esc><Leader>agi", {})
          -- That should work with the current buffer path
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>dg", "<Cmd>lua require('r.run').action('debugonce')<CR>", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>dg", "<Esc><Leader>dgi", {})
        end
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
        vim.api.nvim_buf_set_keymap(0, "n", "<Leader>dc", "<Cmd>lua require('r.send').cmd(string.format('devtools::document(\"%s\")', find_package_root()))<CR>", {})
        vim.api.nvim_buf_set_keymap(0, "n", "<Leader>dc", "<Esc><Leader>dci", {})
        vim.api.nvim_buf_set_keymap(0, "n", "<Leader>la", "<Cmd>lua require('r.send').cmd(string.format('pkgload::load_all(\"%s\")', find_package_root()))<CR>", {})
        vim.api.nvim_buf_set_keymap(0, "n", "<Leader>la", "<Esc><Leader>lai", {})
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
      "RFormatSubsetting", --Replace all the `$` subsetting operators with `[[` in the current buffer.
      "RFormatNumbers", -- Add an 'L' suffix after numbers to explicitly indicate them as integers.
      "RSeparatePathHere", --Split the path of the file under the cursor and open it using the here() prefix function
      "RSeparatePathPaste",
      "RSetwd", --Send to R setwd(<directory of current document>)
      "RShowRout", --R CMD BATCH the current document and show the output in a new tab
      "RSendMotion",
      "ROBCloseLists",
      "ROBOpenLists"
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
