-- /* ---- 💫 Bufferline Configuration 💫 ---- */
-- Buffer tabs configuration

require("bufferline").setup({
  options = {
    mode = "buffers",
    style_preset = require("bufferline").style_preset.default,
    themable = true,
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator = {
      icon = "▎",
      style = "icon",
    },
    buffer_close_icon = "󰅖",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 30,
    max_prefix_length = 30,
    truncate_names = true,
    tab_size = 21,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    color_icons = true,
    get_element_icon = function(element)
      local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    persist_buffer_sort = true,
    move_wraps_at_ends = false,
    separator_style = "slant",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = {"close"},
    },
    sort_by = "insert_after_current",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      }
    },
  },
})

-- Keymaps for buffer navigation
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<leader>bd", ":BufferLinePickClose<CR>", opts)
vim.keymap.set("n", "<leader>bp", ":BufferLinePick<CR>", opts)
vim.keymap.set("n", "<leader>bse", ":BufferLineSortByExtension<CR>", opts)
vim.keymap.set("n", "<leader>bsd", ":BufferLineSortByDirectory<CR>", opts)
