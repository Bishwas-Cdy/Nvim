-- /* ---- 💫 Git Integration Configuration 💫 ---- */
-- Git-related configurations

-- This file contains git-related configurations
-- Main gitsigns config is in plugins/gitsigns.lua

-- Additional git keymaps
local opts = { noremap = true, silent = true }

-- LazyGit
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", opts)

-- Git diffview (if installed)
vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", opts)
vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory<CR>", opts)
