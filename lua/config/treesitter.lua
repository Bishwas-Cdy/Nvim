-- /* ---- 💫 Treesitter Configuration 💫 ---- */
-- This is just a placeholder - main treesitter config is in plugins/treesitter.lua

-- Additional treesitter-related configurations can go here
-- For example, specific folding or indentation settings

-- Set up folding based on treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- Language-specific treesitter settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
  end,
})
