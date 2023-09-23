local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if treesitter_status then
    treesitter.setup({
        auto_install = true,
        sync_install = false,
        indent = { enable = true, disable = {} },
        highlight = { enable = true, disable = {} },
    })
end

local autopairs_status, autopairs = pcall(require, "nvim-autopairs")
if autopairs_status then
    autopairs.setup({})
end 

local autotag_status, autotag = pcall(require, "nvim-ts-autotag")
if autotag_status then
    autotag.setup({})
end
