-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more informationali
--
local wk = require 'which-key'

return {

  -- Mapeando os atalhos para o which-k
  wk.add {
    { '<leader>te', '<cmd>Texplorer', desc = 'Open file explorer' },
    { '<leader>tt', '<cmd>terminal', desc = 'Open terminal' }, -- group
  },

  -- Configuração do LSP  'neovim/nvim-lspconfig',
  opts = {
    -- Configuração de servidores LSP
    servers = {
      rust_analyzer = {},
      clangd = {},
      pyright = {},
      gopls = {},
      ltex_ls = {},
      lua_language_server = {},
    },
  },
  config = function()
    local lspconfig = require 'lspconfig'

    -- Configurar os servidores
    local servers = {
      rust_analyzer = {},
      clangd = {},
      pyright = {},
      gopls = {},
      ltex_ls = {},
      lua_language_server = {},
    }

    for server, config in pairs(servers) do
      lspconfig[server].setup(config)
    end

    -- Configuração para autocompletar
    local cmp = require 'cmp'
    cmp.setup {
      mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ['<S-Tab>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ['<CR>'] = cmp.mapping.confirm { select = true },
      },
    }

    -- Configurar análise de sintaxe ao pressionar ESC
    vim.keymap.set('n', '<Esc>', function()
      vim.lsp.buf.format { async = true } -- Formatar código ao pressionar Esc
      vim.diagnostic.setloclist() -- Mostrar diagnósticos no LocalList
    end, { desc = 'Formatar código e verificar diagnósticos' })
  end,
}
