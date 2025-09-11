return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  keys = {
    { "<leader>a", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "LSP Hover" },
    { "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "LSP Go to Definition" },
  },
  config = function()
    local lsp = require("lspconfig")
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local on_attach = function(client, bufnr)
      -- You can add common LSP keybindings here if needed
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
      vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Go to Definition" })
      vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = "LSP Format" })
    end

    -- Lua Language Server
    lsp.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "nvim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false
          },
        },
      },
    }

    -- Rust Analyzer
    lsp.rust_analyzer.setup {
      on_attach = on_attach,
      capabilities = capabilities
    }

    -- Haskell Language Server
    lsp.hls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = function() return vim.fn.getcwd() end
    }

    -- Python Language Server
    lsp.pylsp.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            -- linter options
            flake8 = { enabled = true },
            pylint = { enabled = false },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            -- type checker
            pylsp_mypy = { enabled = true },
            -- auto-completion options
            jedi_completion = { fuzzy = true },
            -- import sorting
            pyls_isort = { enabled = true },
          }
        }
      }
    }

    -- TypeScript Language Server
    lsp.tsserver.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      -- Recommended settings for tsserver
      -- This ensures features like auto-imports work correctly.
      settings = {
        completions = {
          completeFunctionCalls = true
        },
        typescript = {
          tsdk = "node_modules/typescript/lib", -- Adjust this path if your tsc is elsewhere
        },
        javascript = {
          format = {
            insertSpaceBeforeFunctionParenthesis = true
          }
        }
      }
    }
  end,
}
