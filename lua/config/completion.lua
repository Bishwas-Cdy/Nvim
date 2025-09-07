-- /* ---- 💫 Completion Configuration 💫 ---- */
-- This is just a placeholder - main completion is in nvim-cmp.lua

-- Language-specific completion settings can go here
local cmp = require("cmp")

-- Python specific completion
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Add Python-specific completion sources
    cmp.setup.buffer({
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
      })
    })
  end,
})

-- Web development specific completion
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    cmp.setup.buffer({
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 2 },
        { name = "path" },
      })
    })
  end,
})
