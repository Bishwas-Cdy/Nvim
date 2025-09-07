-- /* ---- 💫 Telescope Configuration 💫 ---- */
-- Fuzzy finder and searcher

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "truncate" },
    
    file_ignore_patterns = {
      "%.git/",
      "node_modules/",
      "__pycache__/",
      "%.pyc",
      "%.pyo",
      "%.pyd",
      "%.so",
      "%.dll",
      "%.class",
      "%.jar",
      "%.zip",
      "%.tar.gz",
      "%.rar",
    },
    
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-x>"] = actions.delete_buffer,
      },
      n = {
        ["<C-x>"] = actions.delete_buffer,
      },
    },
  },
  
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
      hidden = true,
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "normal",
    },
  },
  
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- Load extensions
telescope.load_extension("fzf")

-- Custom telescope functions
local builtin = require("telescope.builtin")

-- Custom keymaps
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fc", builtin.commands, {})
vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})

-- Git related
vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
vim.keymap.set("n", "<leader>gs", builtin.git_status, {})

-- LSP related
vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, {})
vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, {})
vim.keymap.set("n", "<leader>lt", builtin.lsp_type_definitions, {})
vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>lw", builtin.lsp_workspace_symbols, {})
