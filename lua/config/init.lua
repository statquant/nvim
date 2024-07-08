local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Will load globals (where mapleader is configured)
require('config.globals')

-- Will load options 
require('config.options')

-- Will load keymaps 
require('config.keymaps')

-- Setup lazy
local opts = {
	defaults = {
		lazy = true, -- should plugins be lazy-loaded?
	},
	install = {
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "nightfox" },
	},
	rtp = {
		disabled_plugins = {
			"gzip",
			"matchit",
			"matchparen",
			"netrwPlugin",
			"tarPlugin",
			"tohtml",
			"tutor",
			"zipPlugin",
		},
		change_detection = {
			notify = true,
		},
	},
}
require("lazy").setup('plugins', opts)
