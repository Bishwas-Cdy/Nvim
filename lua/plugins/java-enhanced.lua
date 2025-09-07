-- /* ---- 💫 Java Development Enhancement 💫 ---- */
-- Advanced Java IDE features

return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local jdtls = require("jdtls")
      local jdtls_setup = require("jdtls.setup")
      
      -- Java configuration
      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
          "-Xmx4g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens", "java.base/java.util=ALL-UNNAMED",
          "--add-opens", "java.base/java.lang=ALL-UNNAMED",
          "-jar", vim.fn.glob("~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration", vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_" .. vim.fn.has("mac") == 1 and "mac" or "linux"),
          "-data", vim.fn.expand("~/.cache/jdtls-workspace/") .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
        },
        
        root_dir = jdtls_setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
        
        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
              runtimes = {
                {
                  name = "JavaSE-11",
                  path = "/usr/lib/jvm/java-11-openjdk/",
                },
                {
                  name = "JavaSE-17",
                  path = "/usr/lib/jvm/java-17-openjdk/",
                },
                {
                  name = "JavaSE-21",
                  path = "/usr/lib/jvm/java-21-openjdk/",
                },
              },
            },
            maven = {
              downloadSources = true,
            },
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            format = {
              enabled = true,
              settings = {
                url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
                profile = "GoogleStyle",
              },
            },
          },
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            importOrder = {
              "java",
              "javax",
              "com",
              "org",
            },
          },
          extendedClientCapabilities = jdtls.extendedClientCapabilities,
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
          },
        },
        
        init_options = {
          bundles = {},
        },
        
        capabilities = (function()
          local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
          if ok then
            return cmp_nvim_lsp.default_capabilities()
          else
            return vim.lsp.protocol.make_client_capabilities()
          end
        end)(),
        
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr }
          
          -- Java specific keymaps
          vim.keymap.set("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
          vim.keymap.set("n", "<leader>crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
          vim.keymap.set("x", "<leader>crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
          vim.keymap.set("n", "<leader>crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
          vim.keymap.set("x", "<leader>crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
          vim.keymap.set("x", "<leader>crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
          vim.keymap.set("n", "<leader>cf", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
          
          -- Java debugging
          jdtls.setup_dap({ hotcodereplace = "auto" })
          require("jdtls.dap").setup_dap_main_class_configs()
          
          vim.keymap.set("n", "<leader>df", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
          vim.keymap.set("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
        end,
      }
      
      jdtls.start_or_attach(config)
    end,
  },
  
  {
    "JavaHello/spring-boot.nvim",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "ibhagwan/fzf-lua",
    },
    config = function()
      require("spring_boot").setup({})
    end,
  },
}
