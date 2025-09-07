-- /* ---- 💫 Lazy.nvim Plugin Manager Setup 💫 ---- */
-- Plugin management and loading configuration

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with modular plugin imports
require("lazy").setup({
  -- Load core plugins only to start
  spec = {
    -- Core plugins from plugins/ directory
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        require("catppuccin").setup({
          flavour = "mocha",
          transparent_background = false,
        })
        vim.cmd.colorscheme("catppuccin")
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = { theme = "catppuccin" },
        })
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("telescope").setup({})
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "lua", "python", "javascript", "typescript" },
          highlight = { enable = true },
        })
      end,
    },
    -- Add enhanced modules one by one
    { import = "plugins.luasnip-extended" },
    { import = "plugins.typescript-tools" },
    { import = "plugins.python-enhanced" },
    { import = "plugins.web-enhanced" },
    { import = "plugins.java-enhanced" },
    { import = "plugins.ai-ml-enhanced" },
    { import = "plugins.code-intelligence" },
    { import = "plugins.database-enhanced" },
    { import = "plugins.devops-enhanced" },
    { import = "plugins.testing-enhanced" },
    { import = "plugins.security-enhanced" },
    -- Temporarily disabled until we fix dependencies
    -- { import = "plugins.cloud-enhanced" },
  },
  
  -- Plugin manager configuration
  defaults = {
    lazy = false,
    version = false,
  },
  
  -- UI configuration
  ui = {
    border = "rounded",
    size = {
      width = 0.8,
      height = 0.8,
    },
    wrap = true,
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      require = "󰢱 ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
  
  -- Performance optimizations
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  
  -- Checker configuration
  checker = {
    enabled = true,
    notify = false,
    frequency = 3600,
  },
  
  -- Change detection
  change_detection = {
    enabled = true,
    notify = false,
  },
})
