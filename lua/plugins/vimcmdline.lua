local config = function ()
  -- common mappings
  vim.g.cmdline_map_start          = '<LocalLeader>rf'
  vim.g.cmdline_map_send           = '<Space>'
  vim.g.cmdline_map_send_and_stay  = '<LocalLeader><Space>'
  vim.g.cmdline_map_source_fun     = '<LocalLeader>f'
  vim.g.cmdline_map_send_paragraph = '<LocalLeader>p'
  vim.g.cmdline_map_send_block     = '<LocalLeader>b'
  vim.g.cmdline_map_send_motion    = '<LocalLeader>m'
  vim.g.cmdline_map_quit           = '<LocalLeader>rq'
  -- which app to start
  vim.g.cmdline_app = {
    sh = 'bash',
    python = 'python',
  }
  -- actions to be sent
  vim.g.cmdline_actions = {
    bash = {
      {'<LocalLeader>l', 'ls()'},
      {'<LocalLeader>s', 'summary(%s)'},
      {'<LocalLeader>r', 'print(%s)'},
      {'<LocalLeader>t', 'str(%s)'},
      {'<LocalLeader>h', 'help(%s)'},
      {'<LocalLeader>a', 'args(%s)'},
    },
    python = {
      {'<LocalLeader>l', 'locals()'},
      {'<LocalLeader>g', 'globals()'},
      {'<LocalLeader>p', 'print(%s)'},
      {'<LocalLeader>t', 'type(%s)'},
      {'<LocalLeader>d', 'dir(%s)'},
    }
  }
  -- follow colorscheme for output
  vim.g.cmdline_follow_colorscheme = 1
  -- open in tmux
  vim.g.cmdline_in_buffer = 0
  -- 
  vim.g.cmdline_tmux_conf = "~/.tmux.conf" -- "~/vimcmdline_tmux.conf"


end

return {
  "jalvesaq/vimcmdline",
  lazy = false,
  config = config,
  enabled = true,
}
