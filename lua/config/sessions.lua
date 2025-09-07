-- /* ---- 💫 Session Management Configuration 💫 ---- */
-- Automatic session saving and restoration

-- This file manages session-related configurations
-- Main persistence config is in plugins/persistence.lua

-- Session management keymaps
local opts = { noremap = true, silent = true }

-- Session keymaps
vim.keymap.set("n", "<leader>sr", ":lua require('persistence').load()<CR>", opts)
vim.keymap.set("n", "<leader>sl", ":lua require('persistence').load({ last = true })<CR>", opts)
vim.keymap.set("n", "<leader>sd", ":lua require('persistence').stop()<CR>", opts)

-- Auto-session for specific project types
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Auto-load session for git repositories
    if vim.fn.isdirectory(".git") == 1 then
      vim.defer_fn(function()
        require("persistence").load()
      end, 100)
    end
  end,
})
