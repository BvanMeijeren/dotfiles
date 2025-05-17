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

-- Toogle terminal
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
vim.keymap.set("t", "<leader>tt", "<C-\\><C-n><cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- Assign a new way to escape INSERT mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

-- Commentary
vim.keymap.set("n", "<leader>cc", ":Commentary<CR>", { desc = "Toggle comment line" })
vim.keymap.set("v", "<leader>cc", ":Commentary<CR>", { desc = "Toggle comment selected" })

-- Key mappings for Code Runner
vim.api.nvim_set_keymap("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = true }) -- Run the current file
vim.api.nvim_set_keymap("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = true }) -- Run the current file and close output
vim.api.nvim_set_keymap("v", "<leader>rs", ":RunCode<CR>", { noremap = true, silent = true }) -- Run selected code

--------------
---SQL keymaps
--------------

-- sql auto completion
vim.cmd([[
  autocmd FileType sql,mysql,plsql setlocal omnifunc=vim_dadbod_completion#omni
]])

-- sql hacks
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		local opts = { buffer = true, noremap = true, silent = true }

		-- Run current query or visual selection
		-- vim.keymap.set("n", "<leader>r", ":DB<CR>", opts)
		-- vim.keymap.set("v", "<leader>r", ":DB<CR>", opts)

		-- Toggle DB UI
		-- vim.keymap.set("n", "<leader>du", ":DBUI<CR>", opts)

		-- Describe table under cursor (DESCRIBE)
		vim.keymap.set("n", "<leader>dD", "yiw:exec 'DB desc ' . @\"<CR>", opts)

		-- Select * from table under cursor (PREVIEW)
		vim.keymap.set("n", "<leader>dP", "yioconSELECT * FROM <C-r>0 LIMIT 10;<Esc>", opts)

		-- Quick count from table (COUNT)
		vim.keymap.set("n", "<leader>dC", "yioconSELECT COUNT(*) FROM <C-r>0;<Esc>", opts)
	end,
})

-- select distict values of selected columnname in sql file (DISTINCT)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		local opts = { buffer = true, noremap = true, silent = true }

		vim.keymap.set("v", "<leader>dD", function()
			-- Get visually selected column name
			local mode = vim.fn.mode()
			if mode ~= "v" and mode ~= "V" then
				return
			end

			local _, ls, cs = unpack(vim.fn.getpos("'<"))
			local _, le, ce = unpack(vim.fn.getpos("'>"))
			local lines = vim.api.nvim_buf_get_lines(0, ls - 1, le, false)
			local column = lines[1]:sub(cs, ce):gsub("[^%w_]", "")

			-- Search for the next line with FROM and extract table name
			local bufnr = vim.api.nvim_get_current_buf()
			local all_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			local table = nil

			for i = ls, #all_lines do
				local line = all_lines[i]
				local from_start, from_end = string.find(string.upper(line), "FROM ")
				if from_start then
					local after_from = line:sub(from_end + 1)
					table = after_from:match("([%w_]+)")
					if table then
						break
					end
				end
			end

			if column and table then
				local query = string.format("SELECT DISTINCT %s FROM %s;", column, table)
				-- Use Dadbod to run it
				vim.cmd("DB " .. query)
			else
				vim.notify("Could not find column or table.", vim.log.levels.WARN)
			end
		end, opts)
	end,
})
