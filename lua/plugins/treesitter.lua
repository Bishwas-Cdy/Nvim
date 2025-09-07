-- /* ---- 💫 Treesitter Configuration 💫 ---- */
-- Syntax highlighting and parsing

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    -- Core languages
    "lua", "vim", "vimdoc", "query",
    
    -- Python and AI/ML
    "python", "toml",
    
    -- Web Development
    "html", "css", "scss", "javascript", "typescript",
    "tsx", "json", "yaml",
    
    -- Java
    "java",
    
    -- Other useful languages
    "bash", "markdown", "dockerfile", "sql",
    "regex", "gitignore", "git_config", "git_rebase",
  },
  
  sync_install = false,
  auto_install = true,
  
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  
  indent = {
    enable = true,
  },
  
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})
