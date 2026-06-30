local function lsp_keymaps(ev)
  local opts = { buffer = ev.buf, silent = true }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Goto Definition' }))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Goto Declaration' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'References' }))
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'Goto Implementation' }))
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = 'Goto Type Definition' }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover' }))
  vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature Help' }))
  vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature Help' }))
  vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code Action' }))
  vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename' }))
  vim.keymap.set('n', '<leader>cl', '<cmd>LspInfo<cr>', vim.tbl_extend('force', opts, { desc = 'Lsp Info' }))
end

local function vtsls_clients(bufnr)
  if vim.lsp.get_clients then
    return vim.lsp.get_clients({ bufnr = bufnr, name = 'vtsls' })
  end

  return vim.lsp.get_active_clients({ bufnr = bufnr, name = 'vtsls' })
end

local function lsp_clients(bufnr, name)
  if vim.lsp.get_clients then
    return vim.lsp.get_clients({ bufnr = bufnr, name = name })
  end

  return vim.lsp.get_active_clients({ bufnr = bufnr, name = name })
end

local function execute_lsp_command(bufnr, client_name, command, arguments, callback)
  for _, client in ipairs(lsp_clients(bufnr, client_name)) do
    client:request('workspace/executeCommand', {
      command = command,
      arguments = arguments,
    }, callback, bufnr)
    return
  end
end

local function execute_vtsls_command(bufnr, command, arguments, callback)
  execute_lsp_command(bufnr, 'vtsls', command, arguments, callback)
end

local function mason_package_path(package, path)
  return vim.fn.stdpath('data') .. '/mason/packages/' .. package .. (path or '')
end

local function jump_to_first_location(result)
  if not result then
    return
  end

  local location = vim.islist(result) and result[1] or result
  if not location then
    return
  end

  vim.lsp.util.show_document(location, 'utf-16', { focus = true })
end

local function set_qflist_from_locations(result, title)
  if not result or vim.tbl_isempty(result) then
    return
  end

  local items = vim.lsp.util.locations_to_items(result, 'utf-16')
  vim.fn.setqflist({}, ' ', {
    title = title,
    items = items,
  })
  vim.cmd('copen')
end

local function vtsls_keymaps(ev)
  local opts = { buffer = ev.buf, silent = true }

  vim.keymap.set('n', 'gD', function()
    local params = vim.lsp.util.make_position_params(vim.api.nvim_get_current_win(), 'utf-16')
    execute_vtsls_command(ev.buf, 'typescript.goToSourceDefinition', {
      params.textDocument.uri,
      params.position,
    }, function(_, result)
      vim.schedule(function()
        jump_to_first_location(result)
      end)
    end)
  end, vim.tbl_extend('force', opts, { desc = 'Goto Source Definition' }))

  vim.keymap.set('n', 'gR', function()
    execute_vtsls_command(ev.buf, 'typescript.findAllFileReferences', {
      vim.uri_from_bufnr(ev.buf),
    }, function(_, result)
      vim.schedule(function()
        set_qflist_from_locations(result, 'File References')
      end)
    end)
  end, vim.tbl_extend('force', opts, { desc = 'File References' }))

  vim.keymap.set('n', '<leader>cM', function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { 'source.addMissingImports.ts' },
        diagnostics = {},
      },
    })
  end, vim.tbl_extend('force', opts, { desc = 'Add Missing Imports' }))

  vim.keymap.set('n', '<leader>cD', function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { 'source.fixAll.ts' },
        diagnostics = {},
      },
    })
  end, vim.tbl_extend('force', opts, { desc = 'Fix All Diagnostics' }))

  vim.keymap.set('n', '<leader>cV', function()
    execute_vtsls_command(ev.buf, 'typescript.selectTypeScriptVersion', {})
  end, vim.tbl_extend('force', opts, { desc = 'Select TS Workspace Version' }))
end

local function eslint_keymaps(ev)
  local opts = { buffer = ev.buf, silent = true }

  vim.keymap.set('n', '<leader>cF', function()
    execute_lsp_command(ev.buf, 'eslint', 'eslint.applyAllFixes', {
      uri = vim.uri_from_bufnr(ev.buf),
      version = vim.lsp.util.buf_versions[ev.buf],
    })
  end, vim.tbl_extend('force', opts, { desc = 'Fix All ESLint Problems' }))
end

local function setup_server(server, opts)
  if vim.lsp.config then
    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
  else
    require('lspconfig')[server].setup(opts)
  end
end

local function lsp_capabilities(capabilities)
  capabilities = vim.tbl_deep_extend('force', {}, capabilities or {}, {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false,
        },
      },
    },
  })

  local blink_ok, blink = pcall(require, 'blink.cmp')
  if blink_ok then
    return blink.get_lsp_capabilities(capabilities)
  end

  return capabilities
end

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  cond = not vim.g.vscode,
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'saghen/blink.cmp',
  },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '●',
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = 'E',
          [vim.diagnostic.severity.WARN] = 'W',
          [vim.diagnostic.severity.HINT] = 'H',
          [vim.diagnostic.severity.INFO] = 'I',
        },
      },
    },
    inlay_hints = {
      enabled = true,
      exclude = { 'vue' },
    },
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = 'Replace',
            },
            doc = {
              privateName = { '^_' },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = 'Disable',
              semicolon = 'Disable',
              arrayIndex = 'Disable',
            },
          },
        },
      },
      eslint = {
        settings = {
          workingDirectories = { mode = 'auto' },
          format = true,
        },
      },
      vtsls = {
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
          'vue',
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            tsserver = {
              globalPlugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = mason_package_path('vue-language-server', '/node_modules/@vue/language-server'),
                  languages = { 'vue' },
                  configNamespace = 'typescript',
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
            experimental = {
              maxInlayHintLength = 30,
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = 'literals' },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      },
      vue_ls = {},
    },
  },
  config = function(_, opts)
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
      callback = function(ev)
        lsp_keymaps(ev)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == 'vtsls' then
          vtsls_keymaps(ev)
        end
        if client and client.name == 'eslint' then
          eslint_keymaps(ev)
          vim.api.nvim_buf_create_user_command(ev.buf, 'EslintFixAll', function()
            execute_lsp_command(ev.buf, 'eslint', 'eslint.applyAllFixes', {
              uri = vim.uri_from_bufnr(ev.buf),
              version = vim.lsp.util.buf_versions[ev.buf],
            })
          end, { desc = 'Fix all ESLint problems' })
        end

        local inlay_hint_excluded = vim.tbl_contains(opts.inlay_hints.exclude or {}, vim.bo[ev.buf].filetype)
        if opts.inlay_hints.enabled and not inlay_hint_excluded and vim.lsp.inlay_hint then
          pcall(vim.lsp.inlay_hint.enable, true, { bufnr = ev.buf })
        end
      end,
    })

    local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
    local ensure_installed = {}
    local capabilities = lsp_capabilities(opts.capabilities)

    for server, server_opts in pairs(opts.servers) do
      if server == 'vtsls' and server_opts.settings and server_opts.settings.typescript then
        server_opts.settings.javascript =
          vim.tbl_deep_extend('force', {}, server_opts.settings.typescript, server_opts.settings.javascript or {})
      end

      local server_config = vim.tbl_deep_extend('force', {
        capabilities = capabilities,
      }, server_opts)

      setup_server(server, server_config)
      ensure_installed[#ensure_installed + 1] = server
    end

    if mason_lspconfig_ok then
      mason_lspconfig.setup({
        ensure_installed = ensure_installed,
        automatic_enable = false,
      })
    end

    vim.schedule(function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
          vim.api.nvim_exec_autocmds('FileType', {
            buffer = buf,
            modeline = false,
          })
        end
      end
    end)
  end,
}
