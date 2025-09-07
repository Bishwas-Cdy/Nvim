-- /* ---- 💫 Trouble Configuration 💫 ---- */
-- Diagnostics and quickfix list

require("trouble").setup({
  position = "bottom",
  height = 10,
  width = 50,
  icons = true,
  mode = "workspace_diagnostics",
  fold_open = "",
  fold_closed = "",
  group = true,
  padding = true,
  action_keys = {
    close = "q",
    cancel = "<esc>",
    refresh = "r",
    jump = { "<cr>", "<tab>" },
    open_split = { "<c-x>" },
    open_vsplit = { "<c-v>" },
    open_tab = { "<c-t>" },
    jump_close = { "o" },
    toggle_mode = "m",
    toggle_preview = "P",
    hover = "K",
    preview = "p",
    close_folds = { "zM", "zm" },
    open_folds = { "zR", "zr" },
    toggle_fold = { "zA", "za" },
    previous = "k",
    next = "j"
  },
  indent_lines = true,
  auto_open = false,
  auto_close = false,
  auto_preview = true,
  auto_fold = false,
  auto_jump = { "lsp_definitions" },
  signs = {
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠"
  },
  use_diagnostic_signs = false
})

-- Trouble keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>xx", ":TroubleToggle<CR>", opts)
vim.keymap.set("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>xl", ":TroubleToggle loclist<CR>", opts)
vim.keymap.set("n", "<leader>xq", ":TroubleToggle quickfix<CR>", opts)
vim.keymap.set("n", "gR", ":TroubleToggle lsp_references<CR>", opts)
