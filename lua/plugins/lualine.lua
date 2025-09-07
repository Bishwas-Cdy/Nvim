-- /* ---- 💫 Lualine Configuration 💫 ---- */
-- Status line configuration

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
    },
    lualine_b = {
      "branch",
      "diff",
      {
        "diagnostics",
        sources = { "nvim_lsp", "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        diagnostics_color = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
        },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      },
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        newfile_status = false,
        path = 1,
        symbols = {
          modified = "[+]",
          readonly = "[-]",
          unnamed = "[No Name]",
          newfile = "[New]",
        }
      }
    },
    lualine_x = {
      {
        "encoding",
        cond = function()
          return vim.bo.fileencoding ~= "utf-8"
        end,
      },
      "fileformat",
      "filetype"
    },
    lualine_y = { "progress" },
    lualine_z = { "location" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { "nvim-tree", "trouble", "toggleterm" }
})
