-- /* ---- ☁️ Cloud & Remote Development ☁️ ---- */
-- Support for remote development and cloud services

return {
  -- Remote development
  {
    "chipsenkbeil/distant.nvim",
    branch = "v0.3",
    config = function()
      require("distant"):setup({
        -- Configuration will be prompted when first connecting
        servers = {},
      })
      
      -- Remote development keymaps
      vim.keymap.set("n", "<leader>rc", "<cmd>DistantConnect<cr>", { desc = "Connect to remote" })
      vim.keymap.set("n", "<leader>rl", "<cmd>DistantLaunch<cr>", { desc = "Launch distant server" })
      vim.keymap.set("n", "<leader>rs", "<cmd>DistantSessionInfo<cr>", { desc = "Session info" })
      vim.keymap.set("n", "<leader>rk", "<cmd>DistantKill<cr>", { desc = "Kill remote session" })
    end,
  },
  
  -- SSH file manager
  {
    "nosduco/remote-sshfs.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("remote-sshfs").setup({
        connections = {
          ssh_configs = true,
          scp_dirs = {},
          hosts = {},
        },
        mounts = {
          base_dir = vim.fn.expand("~/remote-sshfs/"),
          unmount_on_exit = true,
        },
        handlers = {
          on_connect = {
            change_dir = true,
          },
          on_disconnect = {
            clean_mount_folders = false,
          },
          on_edit = {
            ensure_write = false,
          },
        },
        ui = {
          select_prompts = false,
          confirm = {
            connect = true,
            change_dir = false,
          },
        },
        log = {
          enable = false,
          truncate = false,
          types = {
            all = false,
            util = false,
            handler = false,
            sshfs = false,
          },
        },
      })
      
      require("telescope").load_extension("remote-sshfs")
      
      -- SSH keymaps
      vim.keymap.set("n", "<leader>sc", "<cmd>RemoteSSHFSConnect<cr>", { desc = "SSH Connect" })
      vim.keymap.set("n", "<leader>sd", "<cmd>RemoteSSHFSDisconnect<cr>", { desc = "SSH Disconnect" })
      vim.keymap.set("n", "<leader>se", "<cmd>RemoteSSHFSEdit<cr>", { desc = "SSH Edit" })
      vim.keymap.set("n", "<leader>sf", "<cmd>Telescope remote-sshfs<cr>", { desc = "SSH Files" })
    end,
  },
  
  -- GitHub integration
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        use_local_fs = false,
        enable_builtin = true,
        default_remote = {"upstream", "origin"},
        default_merge_method = "commit",
        ssh_aliases = {},
        reaction_viewer_hint_icon = "💡",
        user_icon = " ",
        timeline_marker = "",
        timeline_indent = 2,
        right_bubble_delimiter = "",
        left_bubble_delimiter = "",
        github_hostname = "",
        snippet_context_lines = 4,
        gh_env = {},
        timeout = 5000,
        ui = {
          use_signcolumn = true,
          use_signstatus = true,
        },
        issues = {
          order_by = {
            field = "CREATED_AT",
            direction = "DESC"
          }
        },
        pull_requests = {
          order_by = {
            field = "CREATED_AT",
            direction = "DESC"
          },
          always_select_remote_on_create = false
        },
        file_panel = {
          size = 10,
          use_icons = true
        },
        mappings = {
          issue = {
            close_issue = { lhs = "<space>ic", desc = "close issue" },
            reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
            list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload issue" },
            open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            add_assignee = { lhs = "<space>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
            create_label = { lhs = "<space>lc", desc = "create label" },
            add_label = { lhs = "<space>la", desc = "add label" },
            remove_label = { lhs = "<space>ld", desc = "remove label" },
            goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
          },
          pull_request = {
            checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
            merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
            squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
            list_commits = { lhs = "<space>pc", desc = "list PR commits" },
            list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
            show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
            add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
            remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
            close_issue = { lhs = "<space>ic", desc = "close PR" },
            reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
            list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload PR" },
            open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            goto_file = { lhs = "gf", desc = "go to file" },
            add_assignee = { lhs = "<space>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
            create_label = { lhs = "<space>lc", desc = "create label" },
            add_label = { lhs = "<space>la", desc = "add label" },
            remove_label = { lhs = "<space>ld", desc = "remove label" },
            goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
          },
          review_thread = {
            goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
          },
          submit_win = {
            approve_review = { lhs = "<C-a>", desc = "approve review" },
            comment_review = { lhs = "<C-m>", desc = "comment review" },
            request_changes = { lhs = "<C-r>", desc = "request changes review" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          },
          review_diff = {
            add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
            add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            next_thread = { lhs = "]t", desc = "move to next thread" },
            prev_thread = { lhs = "[t", desc = "move to previous thread" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
            goto_file = { lhs = "gf", desc = "go to file" },
          },
          file_panel = {
            next_entry = { lhs = "j", desc = "move to next changed file" },
            prev_entry = { lhs = "k", desc = "move to previous changed file" },
            select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
            refresh_files = { lhs = "R", desc = "refresh changed files panel" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
          }
        }
      })
      
      -- GitHub keymaps
      vim.keymap.set("n", "<leader>ghI", "<cmd>Octo issue list<cr>", { desc = "List issues" })
      vim.keymap.set("n", "<leader>ghP", "<cmd>Octo pr list<cr>", { desc = "List PRs" })
      vim.keymap.set("n", "<leader>ghr", "<cmd>Octo repo view<cr>", { desc = "View repo" })
      vim.keymap.set("n", "<leader>ghs", "<cmd>Octo search<cr>", { desc = "Search GitHub" })
    end,
  },
  
  -- Live Share
  {
    "azratul/live-share.nvim",
    dependencies = { "jbyuki/instant.nvim" },
    config = function()
      require("live-share").setup({
        port_internal = 8765,
        max_attempts = 40,
        service = "serveo.net", -- or "localhost.run"
      })
      
      -- Live Share keymaps
      vim.keymap.set("n", "<leader>ls", "<cmd>LiveShareServer<cr>", { desc = "Start live share server" })
      vim.keymap.set("n", "<leader>lj", "<cmd>LiveShareJoin<cr>", { desc = "Join live share" })
      vim.keymap.set("n", "<leader>lx", "<cmd>LiveShareClose<cr>", { desc = "Close live share" })
    end,
  },
}
