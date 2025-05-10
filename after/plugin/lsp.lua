local lsp = require("lsp-zero")

lsp.preset("recommended")

-- 1. REMOVE lsp.ensure_installed()
-- This is now handled by `mason-lspconfig.nvim` in your plugins.lua

-- 2. REMOVE lsp.nvim_workspace()
-- If you were using this for Lua development for Neovim itself,
-- and you have 'lua-language-server' (or 'lua_ls') installed via Mason,
-- you would configure it like this (uncomment if needed):
-- lsp.configure('lua_ls', { -- or 'lua-language-server'
--   settings = {
--     Lua = {
--       runtime = { version = 'LuaJIT' },
--       diagnostics = { globals = { 'vim' } },
--       workspace = { library = vim.api.nvim_get_runtime_file("", true) },
--       telemetry = { enable = false },
--     },
--   },
-- })


-- 3. Setup nvim-cmp directly
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  vim.notify("nvim-cmp not found!", vim.log.levels.ERROR)
  return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
  vim.notify("LuaSnip not found! Snippets might not work.", vim.log.levels.WARN)
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = {
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Common mapping
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  -- Your Tab preferences (ensure they don't conflict if you use snippets that also use Tab)
  -- ['<Tab>'] = nil, -- If you want to disable Tab for cmp
  -- ['<S-Tab>'] = nil, -- If you want to disable S-Tab for cmp
}

-- If you want Tab completion, you might use something like this,
-- but it requires careful integration with snippets:
-- cmp_mappings['<Tab>'] = cmp.mapping(function(fallback)
--   if cmp.visible() then
--     cmp.select_next_item()
--   elseif luasnip_ok and luasnip.expand_or_jumpable() then
--     luasnip.expand_or_jump()
--   else
--     fallback()
--   end
-- end, { "i", "s" })

-- cmp_mappings['<S-Tab>'] = cmp.mapping(function(fallback)
--   if cmp.visible() then
--     cmp.select_prev_item()
--   elseif luasnip_ok and luasnip.jumpable(-1) then
--     luasnip.jump(-1)
--   else
--     fallback()
--   end
-- end, { "i", "s" })


cmp.setup({
  snippet = {
    expand = function(args)
      if luasnip_ok then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  mapping = cmp_mappings,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- if you use LuaSnip
    { name = 'buffer' },
    { name = 'path' },
    -- { name = 'nvim_lua' }, -- if you want completion for Neovim Lua API
  }),
  -- Optional: Add window appearance, formatting with lspkind, etc.
  -- window = {
  --   completion = cmp.config.window.bordered(),
  --   documentation = cmp.config.window.bordered(),
  -- },
  -- formatting = {
  --   fields = {'abbr', 'kind', 'menu'},
  --   format = require('lspkind').cmp_format({ -- if you use lspkind.nvim
  --       mode = 'symbol_text',
  --       maxwidth = 50,
  --   })
  -- }
})

-- This function should still be valid in lsp-zero v3.x
lsp.set_preferences({
    suggest_lsp_servers = false, -- You manage servers with Mason
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup() -- This tells lsp-zero to configure the LSPs that mason-lspconfig has set up.

vim.diagnostic.config({
    virtual_text = true
})
