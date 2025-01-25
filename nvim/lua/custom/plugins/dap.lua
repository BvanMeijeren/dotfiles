return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui', opts = {} },
      { 'mfussenegger/nvim-dap-python' },
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      local dap_python = require 'dap-python'

      -- Python Debug Adapter Setup
      dap_python.setup '~/.virtualenvs/debugpy/bin/python' -- Adjust path to match debugpy's Python
      dap_python.test_runner = 'pytest'

      -- Configure DAP-UI
      dapui.setup()

      -- Automatically open/close dap-ui on debugging events
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- DAP Keybindings
      vim.keymap.set('n', '<F5>', function()
        dap.continue()
      end, { desc = 'Start/Continue Debugging' })
      vim.keymap.set('n', '<F10>', function()
        dap.step_over()
      end, { desc = 'Step Over' })
      vim.keymap.set('n', '<F11>', function()
        dap.step_into()
      end, { desc = 'Step Into' })
      vim.keymap.set('n', '<F12>', function()
        dap.step_out()
      end, { desc = 'Step Out' })
      vim.keymap.set('n', '<leader>db', function()
        dap.toggle_breakpoint()
      end, { desc = 'Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Set Conditional Breakpoint' })
      vim.keymap.set('n', '<leader>dr', function()
        dap.repl.open()
      end, { desc = 'Open REPL' })
      vim.keymap.set('n', '<leader>dl', function()
        dap.run_last()
      end, { desc = 'Run Last Debugging Session' })

      -- Optional: Add virtual text for inline debugging info
      require('nvim-dap-virtual-text').setup()

      -- Debug log settings (optional for troubleshooting)
      vim.cmd [[command! DapShowLog :lua require('dap').show_log()]]
    end,
  },
}
