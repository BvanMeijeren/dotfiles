-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keymaps for managing splits
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'Open a new tab' })
vim.keymap.set('n', '<leader>tj', ':tabnext<CR>', { desc = 'Move to the next tab' })
vim.keymap.set('n', '<leader>tk', ':tabprevious<CR>', { desc = 'Move to the previous tab' })
vim.keymap.set('n', '<leader>to', ':tabonly<CR>', { desc = 'Close all other tabs except the current one' })

-- Key mappings for Code Runner
vim.api.nvim_set_keymap('n', '<leader>rr', ':RunCode<CR>', { noremap = true, silent = true }) -- Run the current file
vim.api.nvim_set_keymap('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = true }) -- Run the current file and close output
vim.api.nvim_set_keymap('v', '<leader>rs', ':RunCode<CR>', { noremap = true, silent = true }) -- Run selected code
vim.api.nvim_set_keymap('n', '<leader>rx', ':w<CR>:!gcc % -o ./a.out && ./a.out<CR>', { desc = 'Run C code', noremap = true, silent = true })

-- Key mappings for venv-selector
vim.keymap.set('n', '<leader>vs', ':VenvSelect<CR>', { noremap = true, silent = true }) -- Open venv-selector
vim.keymap.set('n', '<leader>vc', ':VenvSelectCached<CR>', { noremap = true, silent = true }) -- Open cached venv list

-- Neo tree mapping
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- DBUI / dadbod keymaps ---
-- auto initialize DBUI when opening an sql file
-- Automatically initialize DBUI when opening an SQL file
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sql', -- Trigger for SQL files
  callback = function()
    -- Check if DBUI is initialized; if not, initialize it
    if vim.fn.bufexists 'DBUI' == 0 then
      vim.cmd 'DBUI'
      vim.cmd 'DBUIToggle' -- Close DBUI right after opening, so it doesn't stay open
    end
  end,
  desc = 'Initialize DBUI when opening an SQL file',
})

-- Function to toggle DBUI
vim.keymap.set('n', '<leader>du', ':DBUIToggle<CR>', { desc = 'Toggle Database UI' })

-- sql auto completion
vim.cmd [[
  autocmd FileType sql,mysql,plsql setlocal omnifunc=vim_dadbod_completion#omni
]]

-- vim: ts=2 sts=2 sw=2 et
