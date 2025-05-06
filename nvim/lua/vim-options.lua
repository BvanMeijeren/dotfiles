-- vim options
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Set leader key
vim.g.mapleader = " "

vim.opt.swapfile = false

-- Toggle term
vim.keymap.set("n", "<leader>q", ":ToggleTerm<CR>")

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.wo.number = true

-- Assign a new way to escape INSERT mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

-- Commentary
vim.keymap.set("n", "<leader>cc", ":Commentary<CR>", { desc = "Toggle comment line" })
vim.keymap.set("v", "<leader>cc", ":Commentary<CR>", { desc = "Toggle comment selected" })

-- Key mappings for Code Runner
vim.api.nvim_set_keymap("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = true }) -- Run the current file
vim.api.nvim_set_keymap("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = true }) -- Run the current file and close output
vim.api.nvim_set_keymap("v", "<leader>rs", ":RunCode<CR>", { noremap = true, silent = true }) -- Run selected code

-- sql auto completion
vim.cmd([[
  autocmd FileType sql,mysql,plsql setlocal omnifunc=vim_dadbod_completion#omni
]])
