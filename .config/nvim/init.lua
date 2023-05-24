-- Basic settings
require('basic')

-- Load plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = require('custom_keys').leader
vim.g.maplocalleader = '\\'

require('lazy').setup({
    spec = {
        {import = 'plugins'},
        {import = 'languages'},
--        {import = 'my_plugins'},
    },
    ui = {
        border = 'rounded',
    },
    change_detection = {
        enabled = true,
        notify = false, -- get a notification when changes are found
    },
})

-- Final settings
require('settings')
pcall(require, 'custom')


-- custom settings

-- use 'jj' to exit insert mode
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true})
vim.api.nvim_exec([[
    " Open file remember history status
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif
    endif
]], false)

-- move cursor faster
vim.api.nvim_set_keymap('n', 'E', '5j', {noremap = true})
vim.api.nvim_set_keymap('v', 'E', '5j', {noremap = true})
vim.api.nvim_set_keymap('n', 'W', '5k', {noremap = true})
vim.api.nvim_set_keymap('v', 'W', '5k', {noremap = true})



