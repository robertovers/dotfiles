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
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local bufnr = args.buf
        vim.keymap.set('n', '<leader>a', vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
        vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Go to Definition" })
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = "LSP Format" })
      end,
    })

    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- Lua Language Server
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "nvim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
        },
      },
    })

    -- Haskell Language Server
    vim.lsp.config('hls', {
      root_dir = function() return vim.fn.getcwd() end,
    })

    -- Python Language Server
    vim.lsp.config('pylsp', {
      settings = {
        pylsp = {
          plugins = {
            flake8 = { enabled = true },
            pylint = { enabled = false },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            pylsp_mypy = { enabled = true },
            jedi_completion = { fuzzy = true },
            pyls_isort = { enabled = true },
          },
        },
      },
    })

    -- TypeScript Language Server
    vim.lsp.config('tsserver', {
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
        typescript = {
          tsdk = "node_modules/typescript/lib",
        },
        javascript = {
          format = {
            insertSpaceBeforeFunctionParenthesis = true,
          },
        },
      },
    })

    vim.lsp.enable({ 'lua_ls', 'rust_analyzer', 'hls', 'pylsp', 'tsserver' })
  end,
}
