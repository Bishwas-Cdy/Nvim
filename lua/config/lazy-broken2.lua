-- /* ---- 💫 Lazy.nvim Plugin Manager Setup 💫 ---- */
-- Complete professional IDE configuration

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

-- Setup lazy.nvim with all professional plugins
require("lazy").setup({
  spec = {
    -- ===============================================
    -- COLORSCHEME AND UI
    -- ===============================================
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        require("catppuccin").setup({
          flavour = "mocha",
          transparent_background = false,
          integrations = {
            telescope = true,
            nvimtree = true,
            treesitter = true,
            gitsigns = true,
            cmp = true,
            which_key = true,
          }
        })
        vim.cmd.colorscheme("catppuccin")
      end,
    },

    -- Status line
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = {
            theme = "catppuccin",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
          },
        })
      end,
    },

    -- File explorer
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("nvim-tree").setup({
          disable_netrw = true,
          hijack_netrw = true,
          view = { width = 30 },
        })
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
      end,
    },

    -- ===============================================
    -- TELESCOPE FUZZY FINDER
    -- ===============================================
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("telescope").setup({
          defaults = {
            prompt_prefix = "   ",
            selection_caret = "  ",
            file_ignore_patterns = { "node_modules", ".git/" },
          },
        })
        
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      end,
    },

    -- ===============================================
    -- TREESITTER
    -- ===============================================
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "lua", "python", "javascript", "typescript", "tsx", "json", 
            "html", "css", "markdown", "bash", "yaml", "toml"
          },
          sync_install = false,
          auto_install = true,
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = { enable = true },
        })
      end,
    },

    -- ===============================================
    -- LSP CONFIGURATION
    -- ===============================================
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup({
          ui = { border = "rounded" }
        })
      end,
    },

    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "lua_ls", "pyright", "tsserver", "html", "cssls", 
            "jsonls", "bashls", "yamlls"
          },
          automatic_installation = true,
        })
      end,
    },

    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
      },
      config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        
        local capabilities = cmp_nvim_lsp.default_capabilities()
        
        local on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, remap = false }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end

        -- Configure servers
        local servers = { "lua_ls", "pyright", "tsserver", "html", "cssls", "jsonls", "bashls", "yamlls" }
        for _, server in pairs(servers) do
          local opts = {
            on_attach = on_attach,
            capabilities = capabilities,
          }

          if server == "lua_ls" then
            opts.settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                telemetry = { enable = false },
              },
            }
          end

          lspconfig[server].setup(opts)
        end
      end,
    },

    -- ===============================================
    -- COMPLETION
    -- ===============================================
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
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
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
            { name = "buffer" },
            { name = "path" },
          }),
        })
      end,
    },

    -- ===============================================
    -- GIT INTEGRATION
    -- ===============================================
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup({
          signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
          },
        })
      end,
    },

    -- ===============================================
    -- TERMINAL
    -- ===============================================
    {
      "akinsho/toggleterm.nvim",
      config = function()
        require("toggleterm").setup({
          size = 20,
          open_mapping = [[<c-\>]],
          direction = "float",
          float_opts = { border = "curved" },
        })
      end,
    },

    -- ===============================================
    -- UTILITIES
    -- ===============================================
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup({})
      end,
    },

    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    },

    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      config = function()
        local wk = require("which-key")
        wk.setup({
          preset = "modern",
        })
        
        wk.add({
          { "<leader>f", group = "Find" },
          { "<leader>g", group = "Git" },
          { "<leader>l", group = "LSP" },
          { "<leader>t", group = "Terminal" },
        })
      end,
    },

    -- Enhanced modules (load after core is working)
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
  },
  
  -- Performance optimizations
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
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
})
