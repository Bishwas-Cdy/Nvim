-- /* ---- 💫 Venv-selector Configuration 💫 ---- */
-- Python virtual environment selector

require("venv-selector").setup({
  dap_enabled = true,
  name = {
    "venv",
    ".venv",
    "env", 
    ".env",
  },
  auto_refresh = false,
})

-- Keymaps for venv selection
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>vs", ":VenvSelect<CR>", opts)
vim.keymap.set("n", "<leader>vc", ":VenvSelectCached<CR>", opts)
