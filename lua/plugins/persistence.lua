-- /* ---- 💫 Persistence Plugin Configuration 💫 ---- */
-- Session management

require("persistence").setup({
  dir = vim.fn.stdpath("state") .. "/sessions/",
  options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
  pre_save = nil,
  post_save = nil,
})
