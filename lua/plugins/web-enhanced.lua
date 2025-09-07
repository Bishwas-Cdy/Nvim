-- /* ---- 💫 Web Development Enhancement 💫 ---- */
-- Advanced React, HTML, CSS, JavaScript IDE features

return {
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
    "turbio/bracey.vim",
    ft = { "html", "css", "javascript" },
    build = "npm install --prefix server",
    config = function()
      vim.g.bracey_browser_command = "firefox"
      vim.g.bracey_auto_start_browser = 1
      vim.g.bracey_refresh_on_save = 1
      vim.g.bracey_eval_on_save = 1
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
    "mattn/emmet-vim",
    ft = { "html", "css", "scss", "sass", "less", "xml", "xsl", "xslt", "xhtml", "jsx", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      vim.g.user_emmet_mode = "a"
      vim.g.user_emmet_leader_key = "<C-Z>"
      vim.g.user_emmet_settings = {
        javascript = {
          extends = "jsx",
        },
        typescript = {
          extends = "tsx",
        },
      }
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
    "saadparwaiz1/cmp_luasnip",
    dependencies = "hrsh7th/vim-vsnip",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },
  
  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    build = "yarn install --frozen-lockfile && yarn compile",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },
}
