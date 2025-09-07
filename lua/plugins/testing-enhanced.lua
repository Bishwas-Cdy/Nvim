-- /* ---- 💫 Testing & QA Enhancement 💫 ---- */
-- Advanced testing framework for all languages

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Adapters
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "rouge8/neotest-rust",
      "rcasia/neotest-java",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
            python = "python3",
            pytest_discover_instances = true,
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-vitest"),
          require("neotest-java")({
            ignore_wrapper = false,
          }),
        },
        discovery = {
          enabled = true,
          concurrent = 1,
        },
        running = {
          concurrent = true,
        },
        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
        },
        icons = {
          child_indent = "│",
          child_prefix = "├",
          collapsed = "─",
          expanded = "╮",
          failed = "✘",
          final_child_indent = " ",
          final_child_prefix = "╰",
          non_collapsible = "─",
          passed = "✓",
          running = "◐",
          skipped = "○",
          unknown = "?",
        },
        floating = {
          border = "rounded",
          max_height = 0.6,
          max_width = 0.6,
          options = {},
        },
      })
      
      -- Test keymaps
      vim.keymap.set("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Run nearest test" })
      vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run file tests" })
      vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, { desc = "Debug nearest test" })
      vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Test summary" })
      vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({enter = true}) end, { desc = "Test output" })
      vim.keymap.set("n", "<leader>tO", function() require("neotest").output_panel.toggle() end, { desc = "Toggle output panel" })
      vim.keymap.set("n", "<leader>tS", function() require("neotest").run.stop() end, { desc = "Stop tests" })
      vim.keymap.set("n", "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, { desc = "Watch file" })
    end,
  },
  
  -- Coverage display
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("coverage").setup({
        commands = true,
        highlights = {
          covered = { fg = "#C3E88D" },
          uncovered = { fg = "#F07178" },
        },
        signs = {
          covered = { hl = "CoverageCovered", text = "▎" },
          uncovered = { hl = "CoverageUncovered", text = "▎" },
        },
        summary = {
          min_coverage = 80.0,
        },
        lang = {
          python = {
            coverage_command = "coverage json --fail-under=0 -q -o -",
          },
          javascript = {
            coverage_command = "npx nyc report --reporter=json-summary",
          },
        },
      })
      
      -- Coverage keymaps
      vim.keymap.set("n", "<leader>cc", function() require("coverage").load(true) end, { desc = "Load coverage" })
      vim.keymap.set("n", "<leader>cs", function() require("coverage").summary() end, { desc = "Coverage summary" })
      vim.keymap.set("n", "<leader>ct", function() require("coverage").toggle() end, { desc = "Toggle coverage" })
      vim.keymap.set("n", "<leader>ch", function() require("coverage").hide() end, { desc = "Hide coverage" })
    end,
  },
  
  -- Performance testing
  {
    "t-troebst/perfanno.nvim",
    config = function()
      local perfanno = require("perfanno")
      local util = require("perfanno.util")
      
      perfanno.setup({
        line_highlights = util.make_bg_highlights(util.bg_highlight_color_map, "#CC7A00", 0.15),
        vt_highlight = util.make_fg_highlight("#6C7086"),
      })
      
      -- Performance annotation keymaps
      vim.keymap.set("n", "<leader>plf", function() perfanno.load_flamegraph() end, { desc = "Load flamegraph" })
      vim.keymap.set("n", "<leader>plo", function() perfanno.load() end, { desc = "Load perf data" })
      vim.keymap.set("n", "<leader>pls", function() perfanno.load_stat() end, { desc = "Load perf stat" })
      vim.keymap.set("n", "<leader>ple", function() perfanno.show_percentage() end, { desc = "Show percentage" })
      vim.keymap.set("n", "<leader>plh", function() perfanno.toggle_heat() end, { desc = "Toggle heat map" })
      vim.keymap.set("n", "<leader>pla", function() perfanno.annotate() end, { desc = "Annotate" })
    end,
  },
}
