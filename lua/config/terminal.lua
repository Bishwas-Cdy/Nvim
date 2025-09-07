-- /* ---- 💫 ToggleTerm Configuration 💫 ---- */
-- Terminal integration

require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  on_create = function(t)
    vim.opt.foldcolumn = "0"
    vim.opt.signcolumn = "no"
  end,
  hide_numbers = true,
  shade_filetypes = {},
  autochdir = false,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
  winbar = {
    enabled = false,
    name_formatter = function(term)
      return term.name
    end
  },
})

-- Terminal keymaps
local opts = { noremap = true, silent = true }

-- Toggle different terminal types
vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>", opts)
vim.keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", opts)
vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical size=80<CR>", opts)

-- Terminal navigation
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", opts)
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", opts)
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", opts)
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", opts)

-- Custom terminal functions
local Terminal = require("toggleterm.terminal").Terminal

-- Python REPL
local python = Terminal:new({
  cmd = "python3",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
})

function _PYTHON_TOGGLE()
  python:toggle()
end

-- Node.js REPL
local node = Terminal:new({
  cmd = "node",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
})

function _NODE_TOGGLE()
  node:toggle()
end

-- Custom keymaps for specific terminals
vim.keymap.set("n", "<leader>tp", ":lua _PYTHON_TOGGLE()<CR>", opts)
vim.keymap.set("n", "<leader>tn", ":lua _NODE_TOGGLE()<CR>", opts)
