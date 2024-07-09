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
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>z<CR>", "<Plug>RDSendLine", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>z<CR>", "<Esc><Leader>z<CR>i", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>z<up>", "<Plug>RSendAboveLines", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>z<up>", "<Esc><Leader>z<up>i", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>z<left>", "<Plug>RNLeftPart", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>z<left>", "<Esc><Leader>z<left>i", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>z<right>", "<Plug>RNRightPart", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>z<right>", "<Esc><Leader>z<right>i", {})
          -- Advanced
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>zh", "<Plug>RHelp", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>zh", "<Esc><Leader>zhi", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>zo", "<Plug>RInsertLineOutput", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>zo", "<Esc><Leader>zoi", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>zp", "<Plug>RObjectPr", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>zp", "<Esc><Leader>zvi", {})
          vim.api.nvim_buf_set_keymap(0, "n", "<Leader>za", "<Plug>RShowArgs", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<Leader>za", "<Esc><Leader>zai", {})
          -- That should work with the current buffer path
          vim.api.nvim_buf_set_keymap(0, "n", "<LocalLeader>dg", "<Cmd>lua require('r.run').action('debugonce')<CR>", {})
          vim.api.nvim_buf_set_keymap(0, "i", "<LocalLeader>dg", "<Esc><Leader>dgi", {})
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
