local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (os.rename(lazypath, lazypath) and true or false) then
    print("[I]: Installing lazy.nvim...")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

local config = require("byut.lazy.config")
local plugins = require("byut.lazy.plugins")

vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, config)
