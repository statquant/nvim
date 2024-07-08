local config = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  -- cmp.setup({ 
  --   sources = {
  --     { name = "cmp_r" }
  --   }
  -- })
  cmp.setup({
    formatting = {
      fields = {'abbr', 'kind', 'menu'},
      format = lspkind.cmp_format({
        mode = 'symbol', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters
        ellipsis_char = '...', -- the truncated part when popup menu exceed maxwidth
        before = function(entry, item)
          local menu_icon = {
            nvim_lsp = '',
            vsnip = '',
            path = '',
            cmp_zotcite = 'z',
            cmp_r = 'R'
          }
          item.menu = menu_icon[entry.source.name]
          return item
        end,
      })
    },
    sources = cmp.config.sources({
      { name = 'vsnip' },
      { name = 'cmp_zotcite' },
      { name = 'cmp_r' },
      { name = 'nvim_lsp' },
      { name = 'path', option = { trailing_slash = true } },
    }),
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert, }),
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert, }),
    }),
    require("cmp_r").setup({ })
  })
end

return {
  "hrsh7th/nvim-cmp",
  config = config,
  enabled = true,
}
