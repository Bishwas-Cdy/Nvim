-- /* ---- 💫 DevOps & Cloud Development Enhancement 💫 ---- */
-- Advanced DevOps, Docker, Kubernetes, and Cloud IDE features

return {
  {
    "esensar/nvim-dev-container",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("devcontainer").setup({
        generate_commands = true,
        auto_create_commands = true,
        log_level = "info",
      })
      
      -- DevContainer keymaps
      vim.keymap.set("n", "<leader>dc", "<cmd>DevcontainerStart<cr>", { desc = "Start devcontainer" })
      vim.keymap.set("n", "<leader>ds", "<cmd>DevcontainerStop<cr>", { desc = "Stop devcontainer" })
      vim.keymap.set("n", "<leader>dr", "<cmd>DevcontainerRestart<cr>", { desc = "Restart devcontainer" })
      vim.keymap.set("n", "<leader>dl", "<cmd>DevcontainerLogs<cr>", { desc = "Devcontainer logs" })
    end,
  },
  
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  
  -- Kubernetes support
  {
    "ramilito/kubectl.nvim",
    config = function()
      require("kubectl").setup({
        auto_refresh = {
          enabled = true,
          interval = 300,
        },
        diff = {
          bin = "kubediff",
        },
        kubectl_cmd = { cmd = "kubectl", env = {}, args = {} },
        namespace = "default",
      })
      
      -- Kubernetes keymaps
      vim.keymap.set("n", "<leader>k", "<cmd>Kubectl<cr>", { desc = "Kubectl" })
      vim.keymap.set("n", "<leader>kp", "<cmd>lua require('kubectl').open_pods()<cr>", { desc = "K8s Pods" })
      vim.keymap.set("n", "<leader>ks", "<cmd>lua require('kubectl').open_services()<cr>", { desc = "K8s Services" })
      vim.keymap.set("n", "<leader>kd", "<cmd>lua require('kubectl').open_deployments()<cr>", { desc = "K8s Deployments" })
      vim.keymap.set("n", "<leader>kn", "<cmd>lua require('kubectl').switch_namespace()<cr>", { desc = "Switch namespace" })
    end,
  },
  
  -- Terraform support
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "hcl" },
    config = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fold_sections = 1
      vim.g.terraform_fmt_on_save = 1
      
      -- Terraform keymaps
      vim.keymap.set("n", "<leader>ti", "<cmd>!terraform init<cr>", { desc = "Terraform init" })
      vim.keymap.set("n", "<leader>tp", "<cmd>!terraform plan<cr>", { desc = "Terraform plan" })
      vim.keymap.set("n", "<leader>ta", "<cmd>!terraform apply<cr>", { desc = "Terraform apply" })
      vim.keymap.set("n", "<leader>td", "<cmd>!terraform destroy<cr>", { desc = "Terraform destroy" })
      vim.keymap.set("n", "<leader>tf", "<cmd>!terraform fmt<cr>", { desc = "Terraform format" })
      vim.keymap.set("n", "<leader>tv", "<cmd>!terraform validate<cr>", { desc = "Terraform validate" })
    end,
  },
  
  -- AWS support (alternative)
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  },
  
  -- Ansible support
  {
    "pearofducks/ansible-vim",
    ft = { "yaml", "yml" },
    config = function()
      vim.g.ansible_unindent_after_newline = 1
      vim.g.ansible_yamlKeyName = "yamlKey"
      vim.g.ansible_attribute_highlight = "ob"
      vim.g.ansible_name_highlight = "b"
      vim.g.ansible_extra_keywords_highlight = 1
      vim.g.ansible_normal_keywords_highlight = "Constant"
      vim.g.ansible_with_keywords_highlight = "Constant"
    end,
  },
  
  -- Docker Compose support (alternative)
  {
    "ekalinin/Dockerfile.vim",
    ft = { "dockerfile" },
  },
}
