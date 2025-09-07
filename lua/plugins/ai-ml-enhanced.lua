-- /* ---- 💫 AI/ML Development Enhancement 💫 ---- */
-- Advanced AI/ML and Data Science IDE features

return {
  {
    "goerz/jupytext.vim",
    ft = { "python", "jupyter" },
    config = function()
      vim.g.jupytext_enable = 1
      vim.g.jupytext_command = "jupytext"
      vim.g.jupytext_fmt = "py:percent"
    end,
  },
  
  {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
    dependencies = {
      "rcarriga/nvim-notify",
      "stevearc/dressing.nvim",
    },
    ft = { "python", "jupyter" },
    config = function()
      require("jupynium").setup({
        python_host = { "python3", "-m", "jupynium", "--attach" },
        default_notebook_URL = "localhost:8888",
        
        -- Automatically start notebook server
        auto_start_server = {
          enable = true,
          file_pattern = { "*.ju.*" },
        },
        
        -- Automatically attach to notebook
        auto_attach_to_server = {
          enable = true,
          file_pattern = { "*.ju.*", "*.md" },
        },
        
        -- Automatically start sync
        auto_start_sync = {
          enable = true,
          file_pattern = { "*.ju.*", "*.md" },
        },
        
        -- Automatically download ipynb
        auto_download_ipynb = true,
        
        -- Use default keybindings
        use_default_keybindings = true,
        
        -- Textobjects
        textobjects = {
          use_default_keybindings = true,
        },
        
        -- Syntax highlighting
        syntax_highlight = {
          enable = true,
        },
        
        -- Shorcuts
        shorcuts = true,
      })
      
      -- Additional keymaps for Jupyter
      vim.keymap.set("n", "<leader>jj", "<cmd>JupyniumStartAndAttachToServer<cr>", { desc = "Start Jupyter server" })
      vim.keymap.set("n", "<leader>js", "<cmd>JupyniumStartSync<cr>", { desc = "Start sync" })
      vim.keymap.set("n", "<leader>jS", "<cmd>JupyniumStopSync<cr>", { desc = "Stop sync" })
      vim.keymap.set("n", "<leader>jr", "<cmd>JupyniumExecuteSelectedCells<cr>", { desc = "Execute selected cells" })
      vim.keymap.set("n", "<leader>jc", "<cmd>JupyniumClearSelectedCellsOutputs<cr>", { desc = "Clear cell outputs" })
      vim.keymap.set("n", "<leader>jk", "<cmd>JupyniumKernelHover<cr>", { desc = "Kernel hover" })
      vim.keymap.set("n", "<leader>ji", "<cmd>JupyniumScrollToCell<cr>", { desc = "Scroll to cell" })
      vim.keymap.set("n", "<leader>jI", "<cmd>JupyniumScrollFromCell<cr>", { desc = "Scroll from cell" })
    end,
  },
  
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    dependencies = { "willothy/wezterm.nvim" },
    ft = { "python", "jupyter" },
    config = function()
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      
      -- Molten keymaps
      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten" })
      vim.keymap.set("n", "<leader>mr", ":MoltenEvaluateOperator<CR>", { desc = "Run operator" })
      vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>", { desc = "Evaluate line" })
      vim.keymap.set("n", "<leader>mc", ":MoltenReevaluateCell<CR>", { desc = "Re-evaluate cell" })
      vim.keymap.set("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate visual" })
      vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Delete cell" })
      vim.keymap.set("n", "<leader>mo", ":MoltenShowOutput<CR>", { desc = "Show output" })
      vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", { desc = "Hide output" })
    end,
  },
  
  {
    "ahmedkhalf/jupyter-nvim",
    ft = { "python", "jupyter" },
    build = ":UpdateRemotePlugins",
    config = function()
      require("jupyter-nvim").setup({
        command = "jupyter",
        timeout = 0.5,
      })
      
      -- Jupyter keymaps
      vim.keymap.set("n", "<leader>jr", "<Cmd>JupyterRunFile<CR>", { desc = "Run file in Jupyter" })
      vim.keymap.set("n", "<leader>jI", "<Cmd>PythonImportThisFile<CR>", { desc = "Import this file" })
      vim.keymap.set("n", "<leader>jd", "<Cmd>JupyterCd %:p:h<CR>", { desc = "Change directory" })
      vim.keymap.set("n", "<leader>jX", "<Cmd>JupyterSendCell<CR>", { desc = "Send cell" })
      vim.keymap.set("n", "<leader>jE", "<Cmd>JupyterSendRange<CR>", { desc = "Send range" })
      vim.keymap.set("n", "<leader>je", "<cmd>JupyterRunTextObj<cr>", { desc = "Send text object" })
      vim.keymap.set("v", "<leader>je", "<esc>:JupyterSendRange<cr>", { desc = "Send selection" })
    end,
  },
  
  -- NotebookNavigator disabled due to configuration conflicts with hydra.nvim
  -- Using Molten for Jupyter notebook support instead
}
