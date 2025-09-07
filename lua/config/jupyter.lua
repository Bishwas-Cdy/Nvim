-- /* ---- 💫 Jupyter Configuration 💫 ---- */
-- Jupyter notebook support for AI/ML work

-- This configuration sets up Jupyter integration
-- Requires magma-nvim plugin

-- Magma configuration
vim.g.magma_automatically_open_output = false
vim.g.magma_image_provider = "ueberzug"

-- Jupyter keymaps
local opts = { noremap = true, silent = true }

-- Magma keymaps for Jupyter-style workflow
vim.keymap.set("n", "<leader>jr", ":MagmaEvaluateOperator<CR>", opts)
vim.keymap.set("n", "<leader>jl", ":MagmaEvaluateLine<CR>", opts)
vim.keymap.set("x", "<leader>jr", ":<C-u>MagmaEvaluateVisual<CR>", opts)
vim.keymap.set("n", "<leader>jc", ":MagmaReevaluateCell<CR>", opts)
vim.keymap.set("n", "<leader>jd", ":MagmaDelete<CR>", opts)
vim.keymap.set("n", "<leader>jo", ":MagmaShowOutput<CR>", opts)

-- Initialize magma for Python files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "<leader>mi", ":MagmaInit<CR>", { buffer = true, silent = true })
    vim.keymap.set("n", "<leader>md", ":MagmaDeinit<CR>", { buffer = true, silent = true })
  end,
})

-- Auto-start magma for .py files in specific directories
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function()
    local filepath = vim.fn.expand("%:p")
    -- Auto-initialize for notebooks or ML projects
    if string.match(filepath, "notebook") or string.match(filepath, "ml") or string.match(filepath, "ai") then
      vim.cmd("MagmaInit python3")
    end
  end,
})
