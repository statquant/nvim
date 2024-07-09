local keymap = vim.keymap

-- Directory navigation
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Pane navigation
--keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-left>", "<C-w>h", opts)
--keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-down>", "<C-w>j", opts)
--keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-up>", "<C-w>k", opts)
--keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<C-right>", "<C-w>l", opts)

-- Move to previous/next
vim.api.nvim_set_keymap('n', '<C-S-Left>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Right>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })

-- Re-order to previous/next
vim.api.nvim_set_keymap('n', '<C-S-Up>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Down>', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true })

-- Pane navigation
-- keymap.set("n", "<leader><left>", ":bp<CR>", opts)
-- keymap.set("n", "<leader><right>", ":bn<CR>", opts)
-- keymap.set("i", "<leader><left>", "<Esc>:bp<CR>i", opts)
-- keymap.set("i", "<leader><right>", "<Esc>:bn<CR>i", opts)

-- Split
--keymap.set("n", "<leader>sv", ":vsplit<CR>", opts)
--keymap.set("n", "<leader>sh", ":split<CR>", opts)
--keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts)

-- Indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Comments
vim.api.nvim_set_keymap("n", "<leader>cc", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>cc", "gcc", { noremap = false })
