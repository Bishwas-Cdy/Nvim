-- /* ---- 💫 Which-key Configuration 💫 ---- */
-- Key binding helper

return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    local wk = require("which-key")
    
    wk.setup({
      preset = "modern",
      delay = 200,
      expand = 1,
      notify = true,
      
      spec = {
        -- File/Find operations
        { "<leader>f", group = "file/find" },
        { "<leader>ff", desc = "Find files" },
        { "<leader>fg", desc = "Live grep" },
        { "<leader>fb", desc = "Find buffers" },
        { "<leader>fh", desc = "Help tags" },
        { "<leader>fr", desc = "Recent files" },
        { "<leader>fc", desc = "Commands" },
        { "<leader>fk", desc = "Keymaps" },
        { "<leader>fs", desc = "Grep string" },
        { "<leader>fd", desc = "Diagnostics" },

        -- Git operations
        { "<leader>g", group = "git" },
        { "<leader>gg", desc = "LazyGit" },
        { "<leader>gf", desc = "Git files" },
        { "<leader>gc", desc = "Git commits" },
        { "<leader>gb", desc = "Git branches" },
        { "<leader>gs", desc = "Git status" },
        { "<leader>gd", desc = "Git diff" },
        { "<leader>gh", desc = "Git file history" },

        -- LSP operations
        { "<leader>l", group = "lsp" },
        { "<leader>lr", desc = "References" },
        { "<leader>ld", desc = "Definitions" },
        { "<leader>li", desc = "Implementations" },
        { "<leader>lt", desc = "Type definitions" },
        { "<leader>ls", desc = "Document symbols" },
        { "<leader>lw", desc = "Workspace symbols" },
        { "<leader>lf", desc = "Format" },

        -- Debug operations
        { "<leader>d", group = "debug" },
        { "<leader>db", desc = "Toggle breakpoint" },
        { "<leader>dB", desc = "Conditional breakpoint" },
        { "<leader>dc", desc = "Continue" },
        { "<leader>da", desc = "Continue" },
        { "<leader>dx", desc = "Terminate" },
        { "<leader>dr", desc = "Restart" },
        { "<leader>ds", desc = "Step over" },
        { "<leader>di", desc = "Step into" },
        { "<leader>do", desc = "Step out" },
        { "<leader>du", desc = "Toggle UI" },
        { "<leader>de", desc = "Evaluate" },

        -- Terminal/Toggle operations
        { "<leader>t", group = "terminal/toggle" },
        { "<leader>tf", desc = "Float terminal" },
        { "<leader>th", desc = "Horizontal terminal" },
        { "<leader>tv", desc = "Vertical terminal" },
        { "<leader>tp", desc = "Python REPL" },
        { "<leader>tn", desc = "Node REPL" },

        -- Explorer operations
        { "<leader>e", group = "explorer" },
        { "<leader>ee", desc = "Toggle tree" },
        { "<leader>ef", desc = "Find file in tree" },
        { "<leader>ec", desc = "Collapse tree" },
        { "<leader>er", desc = "Refresh tree" },

        -- Window operations
        { "<leader>w", group = "window" },
        { "<leader>ws", desc = "Split window" },
        { "<leader>wv", desc = "Vertical split" },
        { "<leader>wx", desc = "Close window" },

        -- Buffer operations
        { "<leader>b", group = "buffer" },
        { "<leader>bd", desc = "Delete buffer" },
        { "<leader>bp", desc = "Pick buffer" },

        -- Python operations
        { "<leader>p", group = "python" },
        { "<leader>pr", desc = "Run file" },
        { "<leader>pp", desc = "Python REPL" },
        { "<leader>pi", desc = "Install requirements" },
        { "<leader>pv", desc = "Create venv" },
        { "<leader>pa", desc = "Activate venv" },

        -- Magma/ML operations
        { "<leader>m", group = "magma/ml" },
        { "<leader>mi", desc = "Init magma" },
        { "<leader>md", desc = "Deinit magma" },
        { "<leader>mg", desc = "Run with GPU" },
        { "<leader>mj", desc = "Jupyter mode" },

        -- Jupyter operations
        { "<leader>j", group = "jupyter" },
        { "<leader>jr", desc = "Run operator" },
        { "<leader>jl", desc = "Run line" },
        { "<leader>jc", desc = "Re-run cell" },
        { "<leader>jd", desc = "Delete cell" },
        { "<leader>jo", desc = "Show output" },

        -- UI operations
        { "<leader>u", group = "ui" },
        { "<leader>un", desc = "Toggle numbers" },
        { "<leader>ur", desc = "Toggle relative numbers" },
        { "<leader>uw", desc = "Toggle wrap" },
        { "<leader>us", desc = "Toggle spell" },

        -- Code operations
        { "<leader>c", group = "code" },
        { "<leader>ca", desc = "Code action" },
        { "<leader>cf", desc = "Format" },
        { "<leader>cr", desc = "Rename" },

        -- Session operations
        { "<leader>s", group = "session" },

        -- Direct mappings
        { "<leader>h", desc = "Clear search" },
        { "<leader>q", desc = "Quit" },
        { "<leader>Q", desc = "Quit all" },
        { "<leader>x", desc = "Save" },
      },
    })
  end,
}
