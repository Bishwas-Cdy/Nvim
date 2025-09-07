-- /* ---- 💫 Python Configuration 💫 ---- */
-- Python-specific enhancements and settings

-- Python-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Set Python-specific options
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "88"  -- Black's line length
    vim.opt_local.textwidth = 88
    
    -- Python-specific keymaps
    local opts = { buffer = true, silent = true }
    
    -- Run Python file
    vim.keymap.set("n", "<leader>pr", ":!python3 %<CR>", opts)
    
    -- Python REPL
    vim.keymap.set("n", "<leader>pp", ":TermExec cmd='python3'<CR>", opts)
    
    -- Install requirements
    vim.keymap.set("n", "<leader>pi", ":!pip install -r requirements.txt<CR>", opts)
    
    -- Create virtual environment
    vim.keymap.set("n", "<leader>pv", ":!python3 -m venv venv<CR>", opts)
    
    -- Activate virtual environment
    vim.keymap.set("n", "<leader>pa", ":!source venv/bin/activate<CR>", opts)
  end,
})

-- Python project detection and setup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local cwd = vim.fn.getcwd()
    
    -- Detect Python project and set appropriate settings
    if vim.fn.filereadable(cwd .. "/requirements.txt") == 1 or
       vim.fn.filereadable(cwd .. "/pyproject.toml") == 1 or
       vim.fn.filereadable(cwd .. "/setup.py") == 1 then
      
      -- Set Python project flag
      vim.g.python_project = true
      
      -- Auto-activate virtual environment if it exists
      if vim.fn.isdirectory(cwd .. "/venv") == 1 then
        vim.env.VIRTUAL_ENV = cwd .. "/venv"
        vim.env.PATH = cwd .. "/venv/bin:" .. vim.env.PATH
      elseif vim.fn.isdirectory(cwd .. "/.venv") == 1 then
        vim.env.VIRTUAL_ENV = cwd .. "/.venv"
        vim.env.PATH = cwd .. "/.venv/bin:" .. vim.env.PATH
      end
    end
  end,
})

-- AI/ML specific configurations
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    local filename = vim.fn.expand("%:t")
    local filepath = vim.fn.expand("%:p")
    
    -- Detect if this is an AI/ML file
    if string.match(filename, "model") or 
       string.match(filename, "train") or
       string.match(filename, "ml_") or
       string.match(filename, "ai_") or
       string.match(filepath, "machine_learning") or
       string.match(filepath, "deep_learning") or
       string.match(filepath, "ai") or
       string.match(filepath, "ml") then
      
      -- Set AI/ML specific settings
      vim.opt_local.colorcolumn = "120"  -- Longer lines for ML code
      
      -- AI/ML specific keymaps
      local opts = { buffer = true, silent = true }
      
      -- Run with GPU support
      vim.keymap.set("n", "<leader>mg", ":!CUDA_VISIBLE_DEVICES=0 python3 %<CR>", opts)
      
      -- Jupyter notebook style execution
      vim.keymap.set("n", "<leader>mj", ":MagmaInit python3<CR>", opts)
    end
  end,
})
