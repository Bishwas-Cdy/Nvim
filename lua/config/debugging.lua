-- /* ---- 💫 DAP Debugging Configuration 💫 ---- */
-- Debug Adapter Protocol setup

local dap = require("dap")
local dapui = require("dapui")

-- ===============================================
-- DAP UI SETUP
-- ===============================================
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25,
      position = "bottom",
    },
  },
  controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
    max_value_lines = 100,
  },
})

-- ===============================================
-- PYTHON DAP CONFIGURATION
-- ===============================================
require("dap-python").setup("python")

-- Python configurations
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return "python"
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch file with arguments",
    program = "${file}",
    args = function()
      local args_string = vim.fn.input("Arguments: ")
      return vim.split(args_string, " ")
    end,
    pythonPath = function()
      return "python"
    end,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach remote",
    connect = function()
      local host = vim.fn.input("Host [127.0.0.1]: ")
      host = host ~= "" and host or "127.0.0.1"
      local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
      return { host = host, port = port }
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch Django",
    program = vim.fn.getcwd() .. "/manage.py",
    args = { "runserver", "--noreload" },
    console = "integratedTerminal",
    pythonPath = function()
      return "python"
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch Flask",
    module = "flask",
    env = { FLASK_APP = "app.py" },
    args = { "run", "--debug" },
    console = "integratedTerminal",
    pythonPath = function()
      return "python"
    end,
  },
}

-- ===============================================
-- JAVASCRIPT/NODE.JS DAP CONFIGURATION
-- ===============================================
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = {vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"},
}

dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

dap.configurations.typescript = dap.configurations.javascript

-- ===============================================
-- JAVA DAP CONFIGURATION
-- ===============================================
dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
}

-- ===============================================
-- DAP SIGNS AND UI
-- ===============================================
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "🔍", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "", linehl = "DapStoppedLine", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "", linehl = "", numhl = "" })

-- ===============================================
-- DAP VIRTUAL TEXT
-- ===============================================
require("nvim-dap-virtual-text").setup({
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  filter_references_pattern = "<module",
  virt_text_pos = "eol",
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil,
})

-- ===============================================
-- DAP KEYMAPS
-- ===============================================
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Debug session management
keymap("n", "<leader>db", dap.toggle_breakpoint, opts)
keymap("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)
keymap("n", "<leader>dc", dap.continue, opts)
keymap("n", "<leader>da", dap.continue, opts)
keymap("n", "<leader>dx", dap.terminate, opts)
keymap("n", "<leader>dr", dap.restart, opts)

-- Step commands
keymap("n", "<leader>ds", dap.step_over, opts)
keymap("n", "<leader>di", dap.step_into, opts)
keymap("n", "<leader>do", dap.step_out, opts)

-- UI commands
keymap("n", "<leader>du", dapui.toggle, opts)
keymap("n", "<leader>de", dapui.eval, opts)

-- ===============================================
-- DAP EVENTS
-- ===============================================
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
