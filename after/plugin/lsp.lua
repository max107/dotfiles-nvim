local ok, _ = pcall(require, "lspconfig")
if not ok then
  return
end

local saga = require("lspsaga")

saga.init_lsp_saga({
  -- show outline
  show_outline = {
    win_position = "right",
    win_with = "",
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = "┃",
    jump_key = "<cr>",
    -- auto refresh when change buffer
    auto_refresh = true,
  },
})

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
vim.keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Rename
vim.keymap.set("n", "<leader>gr", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostics
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnostic jump can use `<c-o>` to jump back
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
vim.keymap.set("n", "[D", function()
  require("lspsaga.diagnostic").goto_prev({
    severity = vim.diagnostic.severity.ERROR,
  })
end, { silent = true })

vim.keymap.set("n", "]D", function()
  require("lspsaga.diagnostic").goto_next({
    severity = vim.diagnostic.severity.ERROR,
  })
end, { silent = true })

-- Outline
vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })

-- Hover Doc
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(args)
-- 		keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
-- 	end,
-- })

vim.keymap.set("n", "<F6>", "<cmd>LspInfo<cr>", { silent = true })

require("fidget").setup({})

local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions

  local opts = { noremap = true, silent = true }
  -- api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  -- api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  -- api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

  -- lua print(vim.inspect(vim.lsp.get_client_by_id(1).server_capabilities))
  -- print(vim.inspect(client.server_capabilities))

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.server_capabilities.hoverProvider then
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  end

  -- Server capabilities spec:
  -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end

  if client.server_capabilities.documentFormattingProvider then
    -- You can make the format request manually.
    -- Like format then save instead of autoformat on save.
    -- vim.keymap.set('n', '<leader>w', function()
    --   local params = vim.lsp.util.make_formatting_params({})
    --   local handler = function(err, result)
    --     if not result then return end

    --     vim.lsp.util.apply_text_edits(result, bufnr, client.offset_encoding)
    --     vim.cmd('write')
    --   end

    --   client.request('textDocument/formatting', params, handler, bufnr)
    -- end, { buffer = bufnr })

    -- default code format keybinding
    vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, {
      buffer = bufnr,
    })

    -- autoformat code on save
    -- vim.api.nvim_create_autocmd('BufWritePre', {
    --   -- pattern or buffer
    --   -- pattern = '*.lua',
    --   buffer = args.buf,
    --   callback = function()
    --     vim.lsp.buf.format()
    --   end,
    -- })
  end
end

-- same as above but via autocmd
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     on_attach(
--       vim.lsp.get_client_by_id(args.data.client_id),
--       args.buf
--     )
--   end,
-- })
local default_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
default_capabilities.textDocument.completion.completionItem.snippetSupport = true

local capabilities = vim.tbl_deep_extend("force", nvim_lsp.util.default_config.capabilities, default_capabilities)

local servers = {
  "html",
  "cssls",
  "terraformls",
  "vimls",
  "pyright",
  "dockerls",
  "tsserver",
  "gopls",
  "intelephense",
  "vuels",
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    server_capabilities = capabilities,
  })
end

nvim_lsp.sumneko_lua.setup({
  on_attach = on_attach,
  server_capabilities = capabilities,
  init_options = {
    documentFormatting = false,
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "use" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("lua", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

local null_ls = require("null-ls")
null_ls.setup({
  on_attach = on_attach,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.black,
    -- null_ls.builtins.formatting.ruff,
    null_ls.builtins.formatting.terrafmt,
    -- null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.xmlformat,
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.formatting.sql_formatter,
    null_ls.builtins.formatting.phpcsfixer,
    null_ls.builtins.formatting.protolint,
    null_ls.builtins.formatting.reorder_python_imports,
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "scss",
        "css",
        "json",
        "yaml",
        "markdown",
        "graphql",
        "vue",
      },
    }),
  },
})
