-- /* ---- 💫 Python Development Enhancement 💫 ---- */
-- Advanced Python IDE features

return {
  {
    "microsoft/python-type-stubs",
    ft = "python",
  },
  
  {
    "roobert/f-string-toggle.nvim",
    ft = "python",
    config = function()
      require("f-string-toggle").setup({
        key_binding = "<leader>f",
        key_binding_desc = "Toggle f-string",
      })
    end,
  },
  
  {
    "AckslD/swenv.nvim",
    ft = "python",
    config = function()
      require("swenv").setup({
        get_venvs = function(venvs_path)
          return require("swenv.api").get_venvs(venvs_path)
        end,
        venvs_path = vim.fn.expand("~/miniconda3/envs"),
        post_set_venv = nil,
      })
      
      vim.keymap.set("n", "<leader>pv", "<cmd>lua require('swenv.api').pick_venv()<cr>", { desc = "Choose Python venv" })
    end,
  },
  
  {
    "jeetsukumaran/vim-pythonsense",
    ft = "python",
  },
  
  {
    "vim-python/python-syntax",
    ft = "python",
    config = function()
      vim.g.python_highlight_all = 1
      vim.g.python_highlight_space_errors = 0
    end,
  },
  
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },
}
