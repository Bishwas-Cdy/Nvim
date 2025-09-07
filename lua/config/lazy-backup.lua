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

-- Setup lazy.nvim
require("lazy").setup({
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
        background = {
          light = "latte",
          dark = "mocha",
        },
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
      require("plugins.lualine")
    end,
  },

  -- Buffer line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins.bufferline")
    end,
  },

  -- ===============================================
  -- FILE EXPLORER AND NAVIGATION
  -- ===============================================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins.nvim-tree")
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("plugins.telescope")
    end,
  },

  -- ===============================================
  -- LSP AND COMPLETION
  -- ===============================================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("plugins.lsp")
    end,
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("plugins.mason")
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "mason.nvim",
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("plugins.nvim-cmp")
    end,
  },

  -- ===============================================
  -- SYNTAX HIGHLIGHTING
  -- ===============================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- ===============================================
  -- GIT INTEGRATION
  -- ===============================================
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- ===============================================
  -- TERMINAL INTEGRATION
  -- ===============================================
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("plugins.toggleterm")
    end,
  },

  -- ===============================================
  -- CODE FORMATTING AND LINTING
  -- ===============================================
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.null-ls")
    end,
  },

  -- ===============================================
  -- DEBUGGING
  -- ===============================================
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      require("plugins.dap")
    end,
  },

  -- ===============================================
  -- AI/ML SPECIFIC PLUGINS
  -- ===============================================
  {
    "jpalardy/vim-slime",
    config = function()
      require("plugins.vim-slime")
    end,
  },

  -- Jupyter support
  {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins",
    config = function()
      require("plugins.magma")
    end,
  },

  -- ===============================================
  -- PRODUCTIVITY PLUGINS
  -- ===============================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.which-key")
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.autopairs")
    end,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- ===============================================
  -- PROJECT MANAGEMENT
  -- ===============================================
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.project")
    end,
  },

  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("plugins.persistence")
    end,
  },

  -- ===============================================
  -- LANGUAGE SPECIFIC PLUGINS
  -- ===============================================
  
  -- Python
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    config = function()
      require("plugins.venv-selector")
    end,
  },

  -- Web development
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- CSS color preview
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Emmet for HTML/CSS
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },

  -- ===============================================
  -- UTILITY PLUGINS
  -- ===============================================
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.trouble")
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("plugins.indent-blankline")
    end,
  },

  -- Search and replace
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.spectre")
    end,
  },

  -- ===============================================
  -- ENHANCED IDE FEATURES
  -- ===============================================
  
  -- Enhanced snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
    },
    config = function()
      require("plugins.luasnip-extended")
    end,
  },

  -- TypeScript/React auto-imports
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      require("plugins.typescript-tools")
    end,
  },

  -- Enhanced Python development
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

  -- Enhanced web development
  {
    "styled-components/vim-styled-components",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    branch = "main",
  },
  {
    "maxmellon/vim-jsx-pretty",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  {
    "prettier/vim-prettier",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "less", "scss", "json", "graphql", "markdown", "yaml", "html" },
    build = "yarn install --frozen-lockfile --production",
    config = function()
      vim.g["prettier#autoformat"] = 1
      vim.g["prettier#autoformat_require_pragma"] = 0
      vim.g["prettier#config#single_quote"] = "true"
      vim.g["prettier#config#trailing_comma"] = "es5"
      vim.g["prettier#config#semi"] = "true"
      vim.g["prettier#config#tab_width"] = 2
    end,
  },
  {
    "AndrewRadev/tagalong.vim",
    ft = { "html", "xml", "jsx", "eruby", "ejs", "eco", "php", "htmldjango", "javascriptreact", "typescriptreact" },
  },
  {
    "alvan/vim-closetag",
    ft = { "html", "xhtml", "phtml", "jsx", "javascript.jsx", "typescript.jsx" },
    config = function()
      vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx,*.js,*.tsx,*.ts"
      vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx,*.tsx"
      vim.g.closetag_filetypes = "html,xhtml,phtml,jsx,javascript.jsx,typescript.jsx"
      vim.g.closetag_xhtml_filetypes = "xhtml,jsx,javascript.jsx,typescript.jsx"
      vim.g.closetag_emptyTags_caseSensitive = 1
      vim.g.closetag_regions = {
        ["typescript.tsx"] = "jsxRegion,tsxRegion",
        ["javascript.jsx"] = "jsxRegion",
        ["typescriptreact"] = "jsxRegion,tsxRegion",
        ["javascriptreact"] = "jsxRegion",
      }
      vim.g.closetag_shortcut = ">"
      vim.g.closetag_close_shortcut = "<leader>>"
    end,
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    ft = { "html", "css", "scss", "sass", "less", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },
  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    build = "yarn install --frozen-lockfile && yarn compile",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },

  -- Enhanced Java development
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      require("plugins.java-enhanced")
    end,
  },

  -- Enhanced AI/ML development
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
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    ft = { "python", "jupyter" },
    config = function()
      vim.g.molten_image_provider = "image.nvim"
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

  -- Code intelligence features
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = { border = "rounded" },
        floating_window = true,
        floating_window_above_cur_line = true,
        fix_pos = false,
        hint_enable = true,
        hint_prefix = "🐼 ",
        hint_scheme = "String",
        hi_parameter = "LspSignatureActiveParameter",
        max_height = 12,
        max_width = 80,
      })
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    config = function()
      require("nvim-lightbulb").setup({
        priority = 10,
        hide_in_unfocused_buffer = true,
        link_highlights = true,
        sign = {
          enabled = true,
          text = "💡",
          hl = "LightBulbSign",
        },
        autocmd = {
          enabled = true,
          updatetime = 200,
          events = { "CursorHold", "CursorHoldI" },
          pattern = { "*" },
        },
      })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufRead",
    config = function()
      require("refactoring").setup({})
      
      -- Refactoring keymaps
      vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Extract function" })
      vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Extract to file" })
      vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Extract variable" })
      vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Inline variable" })
      vim.keymap.set("n", "<leader>rI", ":Refactor inline_func", { desc = "Inline function" })
      vim.keymap.set("n", "<leader>rb", ":Refactor extract_block", { desc = "Extract block" })
      vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file", { desc = "Extract block to file" })
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
        check_syntax_error = true,
        max_join_length = 120,
        cursor_behavior = "hold",
        notify = true,
        dot_repeat = true,
      })
      
      vim.keymap.set("n", "<leader>m", require("treesj").toggle, { desc = "Toggle split/join" })
      vim.keymap.set("n", "<leader>j", require("treesj").join, { desc = "Join lines" })
      vim.keymap.set("n", "<leader>s", require("treesj").split, { desc = "Split lines" })
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        on_attach = function(bufnr)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
        layout = {
          max_width = { 40, 0.2 },
          width = nil,
          min_width = 10,
          default_direction = "prefer_right",
          placement = "window",
        },
        attach_mode = "window",
        backends = { "lsp", "treesitter", "markdown", "man" },
        show_guides = true,
        filter_kind = {
          "Class",
          "Constructor",
          "Enum",
          "Function",
          "Interface",
          "Module",
          "Method",
          "Struct",
        },
      })
      
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle aerial" })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        highlight = {
          multiline = true,
          multiline_pattern = "^.",
          multiline_context = 10,
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },
      })
      
      vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
      vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
      vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })
      vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Todo" })
    end,
  },

}, {
  -- Lazy.nvim configuration
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
