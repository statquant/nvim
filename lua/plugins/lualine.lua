local config = function()
  local theme = require("lualine.themes.nightfox")
  theme.normal.c.bg = nil

  require("lualine").setup({
    options = {
      theme = theme,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      -- disable buffers given we have barbar.nvim
      -- lualine_b = { "buffers" },
      lualine_b = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
        }
      },
      lualine_c = { },
      lualine_x = { 'branch', 'diff', 'diagnostics', "encoding", "fileformat", "filetype" },
      -- honnestly useless information
      lualine_y = { 
        -- "progress" 
      },
      lualine_z = { 
        -- "location" 
      },
    },
    tabline = {},
  })
end

return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = config,
  enabled = true,
}
