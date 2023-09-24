local luasnip_status, luasnip = pcall(require, "luasnip")
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    return
end

if luasnip_status then
    require("luasnip.loaders.from_vscode").lazy_load()
end

local kinds = {
    Class = "󰠱 ",
    Color = "󰏘 ",
    Constant = " ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = "",
    Field = "󰜢 ",
    File = "󰈙 ",
    Folder = "󰉋 ",
    Function = "󰊕",
    Interface = " ",
    Keyword = "󰌋 ",
    Method = "󰆧 ",
    Module = " ",
    Operator = "󰆕 ",
    Property = "󰜢 ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = "",
    Unit = " ",
    Value = "󰎠 ",
    Variable = " ",
}

cmp.setup({
    completion = {},
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "path" },
        { name = "calc" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip_status and luasnip.expandable() then
                luasnip.expand()
            elseif luasnip_status and luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip_status and luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    }),
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, item)
            item.kind = ("%s"):format(kinds[item.kind])
            item.menu = ({
                nvim_lsp_signature_help = "[LSP]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                calc = "[Math]",
                path = "[Path]",
            })[entry.source.name]
            return item
        end,
    },
})
