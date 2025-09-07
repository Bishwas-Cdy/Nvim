-- /* ---- 💫 Database Development Enhancement 💫 ---- */
-- Advanced database and SQL IDE features

return {
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      -- Database connections
      vim.g.db_ui_save_location = vim.fn.expand("~/.config/nvim/db_ui")
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_tmp_query_location = vim.fn.expand("~/.config/nvim/db_ui/tmp")
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_winwidth = 30
      
      -- Key mappings
      vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<cr>", { desc = "Database UI" })
      vim.keymap.set("n", "<leader>df", "<cmd>DBUIFindBuffer<cr>", { desc = "Find DB buffer" })
      vim.keymap.set("n", "<leader>dr", "<cmd>DBUIRenameBuffer<cr>", { desc = "Rename DB buffer" })
      vim.keymap.set("n", "<leader>dl", "<cmd>DBUILastQueryInfo<cr>", { desc = "Last query info" })
      
      -- Auto-completion for SQL
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          require("cmp").setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
              { name = "luasnip" },
            },
          })
        end,
      })
    end,
  },
  
  {
    "nanotee/sqls.nvim",
    ft = { "sql", "mysql", "plsql" },
    config = function()
      require("lspconfig").sqls.setup({
        on_attach = function(client, bufnr)
          require("sqls").on_attach(client, bufnr)
          
          -- SQL specific keymaps
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "<leader>se", "<cmd>SqlsExecuteQuery<cr>", opts)
          vim.keymap.set("v", "<leader>se", "<cmd>SqlsExecuteQuery<cr>", opts)
          vim.keymap.set("n", "<leader>sv", "<cmd>SqlsExecuteQueryVertical<cr>", opts)
          vim.keymap.set("n", "<leader>sr", "<cmd>SqlsShowDatabases<cr>", opts)
          vim.keymap.set("n", "<leader>st", "<cmd>SqlsShowTables<cr>", opts)
          vim.keymap.set("n", "<leader>sd", "<cmd>SqlsShowSchemas<cr>", opts)
          vim.keymap.set("n", "<leader>sc", "<cmd>SqlsShowConnections<cr>", opts)
        end,
        settings = {
          sqls = {
            connections = {
              {
                driver = "mysql",
                dataSourceName = "root:password@tcp(127.0.0.1:3306)/world",
              },
              {
                driver = "postgresql",
                dataSourceName = "host=127.0.0.1 port=5432 user=postgres password=password dbname=sample sslmode=disable",
              },
            },
          },
        },
      })
    end,
  },
}
