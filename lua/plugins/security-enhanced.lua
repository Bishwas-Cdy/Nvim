-- /* ---- 🔒 Security & Code Analysis 🔒 ---- */
-- Security scanning, vulnerability detection, and code quality

return {
  -- Security vulnerability scanning
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        width = 50,
        icons = true,
        mode = "workspace_diagnostics",
        fold_open = "",
        fold_closed = "",
        group = true,
        padding = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = {"<cr>", "<tab>"},
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = {"o"},
          toggle_mode = "m",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = {"zM", "zm"},
          open_folds = {"zR", "zr"},
          toggle_fold = {"zA", "za"},
          previous = "k",
          next = "j"
        },
        indent_lines = true,
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = {"lsp_definitions"},
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠"
        },
        use_diagnostic_signs = false
      })
      
      -- Security-focused trouble keymaps
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle trouble" })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location list" })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix list" })
    end,
  },
  
  -- Code quality and linting
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      
      -- Helper function to check if a linter is available
      local function linter_available(name)
        return vim.fn.executable(name) == 1
      end
      
      -- Only configure linters that are actually installed
      lint.linters_by_ft = {}
      
      -- JavaScript/TypeScript - only if eslint is available
      if linter_available("eslint") then
        lint.linters_by_ft.javascript = {"eslint"}
        lint.linters_by_ft.typescript = {"eslint"}
        lint.linters_by_ft.javascriptreact = {"eslint"}
        lint.linters_by_ft.typescriptreact = {"eslint"}
      end
      
      -- Python - only if tools are available
      local python_linters = {}
      if linter_available("bandit") then
        table.insert(python_linters, "bandit")
      end
      if linter_available("flake8") then
        table.insert(python_linters, "flake8")
      end
      if #python_linters > 0 then
        lint.linters_by_ft.python = python_linters
      end
      
      -- Shell scripts
      if linter_available("shellcheck") then
        lint.linters_by_ft.sh = {"shellcheck"}
      end
      
      -- JSON
      if linter_available("jsonlint") then
        lint.linters_by_ft.json = {"jsonlint"}
      end
      
      -- Auto-lint on save (with error handling)
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          local status, err = pcall(function()
            lint.try_lint()
          end)
          if not status then
            -- Silently ignore linting errors to avoid annoying popups
            vim.notify("Linting failed: " .. tostring(err), vim.log.levels.DEBUG)
          end
        end,
      })
      
      -- Manual lint command
      vim.keymap.set("n", "<leader>ll", function() 
        local status, err = pcall(function()
          lint.try_lint()
        end)
        if not status then
          vim.notify("Linting failed: " .. tostring(err), vim.log.levels.WARN)
        end
      end, { desc = "Lint file" })
    end,
  },
  
  -- Secret detection
  {
    "laytan/cloak.nvim",
    config = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        highlight_group = "Comment",
        patterns = {
          {
            file_pattern = {
              ".env*",
              "wrangler.toml",
              ".dev.vars",
            },
            cloak_pattern = "=.+",
          },
          {
            file_pattern = {
              "*.py",
              "*.js",
              "*.ts",
              "*.jsx",
              "*.tsx",
              "*.go",
              "*.rs",
            },
            cloak_pattern = {
              "password%s*=%s*['\"].-['\"]",
              "api_key%s*=%s*['\"].-['\"]",
              "secret%s*=%s*['\"].-['\"]",
              "token%s*=%s*['\"].-['\"]",
              "access_key%s*=%s*['\"].-['\"]",
            },
          },
        },
      })
      
      -- Cloak keymaps
      vim.keymap.set("n", "<leader>ct", "<cmd>CloakToggle<cr>", { desc = "Toggle cloak" })
      vim.keymap.set("n", "<leader>cp", "<cmd>CloakPreviewLine<cr>", { desc = "Preview line" })
    end,
  },
  
  -- Git security
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup({
        date_format = "%m.%d.%Y",
        virtual_style = "right_align",
        views = {
          default = {
            width = 40,
            spacing = 1,
          },
          minimal = {
            width = 25,
            spacing = 0,
          },
        },
        merge_consecutive = false,
        max_summary_width = 30,
        colors = nil,
        commit_detail_view = "vsplit",
        format_fn = function(line_porcelain, config, idx)
          return line_porcelain.author .. " " .. line_porcelain.date
        end,
      })
      
      -- Git blame keymaps
      vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle<cr>", { desc = "Toggle git blame" })
    end,
  },
  
  -- Code complexity analysis
  {
    "chrisgrieser/nvim-dr-lsp",
    config = function()
      require("dr-lsp").setup({
        border = "rounded",
        max_width = 60,
        max_height = 20,
        keymaps = {
          next = "<Tab>",
          prev = "<S-Tab>",
          close = { "q", "<Esc>" },
        },
      })
      
      -- Code analysis keymaps
      vim.keymap.set("n", "<leader>ca", "<cmd>DrLsp<cr>", { desc = "Code analysis" })
    end,
  },
  
  -- Dependency security
  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("wtf").setup({
        popup_type = "popup",
        providers = {
          openai = {
            model_id = "gpt-3.5-turbo",
          },
        },
        language = "english",
        additional_instructions = "Focus on security implications and potential vulnerabilities.",
        search_engine = "google",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      })
      
      -- Security analysis keymaps
      vim.keymap.set("n", "<leader>ws", function() require("wtf").search() end, { desc = "Search error online" })
      vim.keymap.set("n", "<leader>wa", function() require("wtf").ai() end, { desc = "Analyze with AI" })
    end,
  },
}
