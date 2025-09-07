-- /* ---- 💫 Vim-slime Configuration 💫 ---- */
-- REPL integration for interactive development

vim.g.slime_target = "tmux"
vim.g.slime_default_config = {
  socket_name = "default",
  target_pane = "{last}"
}

-- Python-specific slime configuration
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.g.slime_python_ipython = 1
    
    local opts = { buffer = true, silent = true }
    
    -- Send current line to REPL
    vim.keymap.set("n", "<leader>sl", "<Plug>SlimeLineSend", opts)
    
    -- Send visual selection to REPL
    vim.keymap.set("x", "<leader>sr", "<Plug>SlimeRegionSend", opts)
    
    -- Send current paragraph to REPL
    vim.keymap.set("n", "<leader>sp", "<Plug>SlimeParagraphSend", opts)
    
    -- Send entire file to REPL
    vim.keymap.set("n", "<leader>sf", "ggVG<Plug>SlimeRegionSend", opts)
  end,
})
