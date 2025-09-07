-- /* ---- 💫 Project Plugin Configuration 💫 ---- */
-- Project management

require("project_nvim").setup({
  detection_methods = { "lsp", "pattern" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml", "requirements.txt", "pyproject.toml" },
  ignore_lsp = {},
  exclude_dirs = {},
  show_hidden = false,
  silent_chdir = true,
  scope_chdir = "global",
  datapath = vim.fn.stdpath("data"),
})
