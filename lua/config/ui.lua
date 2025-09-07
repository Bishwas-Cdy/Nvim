-- /* ---- 💫 UI Configuration 💫 ---- */
-- UI enhancements and theme configuration

-- This file contains UI-related configurations
-- Individual plugin configs are in their respective files

-- Global UI settings
vim.o.termguicolors = true
vim.o.background = "dark"

-- Transparency settings (if desired)
-- vim.g.transparency = 0.8

-- Custom highlights for better visibility
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Custom highlight groups
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#313244" })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#313244", bg = "NONE" })
    
    -- Make background transparent for certain elements
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
  end,
})

-- UI-related keymaps
local opts = { noremap = true, silent = true }

-- Toggle various UI elements
vim.keymap.set("n", "<leader>un", ":set number!<CR>", opts)
vim.keymap.set("n", "<leader>ur", ":set relativenumber!<CR>", opts)
vim.keymap.set("n", "<leader>uw", ":set wrap!<CR>", opts)
vim.keymap.set("n", "<leader>us", ":set spell!<CR>", opts)
