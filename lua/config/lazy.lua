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
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        
        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
          }, {
            { name = "buffer" },
            { name = "path" },
          }),
        })
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("neo-tree").setup({
          close_if_last_window = false,
          popup_border_style = "rounded",
          enable_git_status = true,
          enable_diagnostics = true,
          filesystem = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = false,
          },
        })
        vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
        vim.keymap.set("n", "<leader>e", ":Neotree focus<CR>", { desc = "Focus Neo-tree" })
      end,
    },
    {
      "romgrk/barbar.nvim",
      dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("barbar").setup({
          animation = true,
          auto_hide = false,
          tabpages = true,
          clickable = true,
        })
        -- Buffer navigation
        vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
        vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
        vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "lua_ls", "pyright", "ts_ls", "eslint" },
        })

        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Setup language servers
        lspconfig.lua_ls.setup({ capabilities = capabilities })
        lspconfig.pyright.setup({ capabilities = capabilities })
        lspconfig.ts_ls.setup({ capabilities = capabilities })
        lspconfig.eslint.setup({ capabilities = capabilities })

        -- LSP keymaps
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspConfig", {}),
          callback = function(ev)
            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          end,
        })
      end,
    },
    -- Add enhanced modules one by one
    { import = "plugins.luasnip-extended" },
    -- { import = "plugins.typescript-tools" }, -- DISABLED - broken
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
