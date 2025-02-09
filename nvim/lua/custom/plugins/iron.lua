return {
  {
    'Vigemus/iron.nvim',
    config = function()
      require('iron.core').setup {
        config = {
          -- Highlight the region being sent to the REPL
          highlight = {
            enabled = true,
            timeout = 250,
          },
          -- Define preferred REPLs for filetypes
          repl_definition = {
            python = {
              command = { 'python3' }, -- check python version if not executable
            },
          },
          repl_open_cmd = 'botright 10split', -- Open REPL in a vertical split
        },
        keymaps = {
          send_motion = '<leader>sc', -- Send selected text to REPL
          visual_send = '<leader>sc', -- Send selected text in visual mode
          send_file = '<leader>sa', -- Send entire all text in the file to REPL
          send_line = '<leader>sl', -- Send current line to REPL
          send_until_cursor = '<leader>sU', -- Send code until the cursor
          send_mark = '<leader>sm', -- Send marked text to REPL
          mark_motion = '<leader>sm', -- Mark a motion for sending
          mark_visual = '<leader>sm', -- Mark visual selection for sending
        },
        ignore_blank_lines = true, -- Ignore blank lines when sending commands
      }
    end,
  },
}
