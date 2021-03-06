
-- Map leader keys
vim.g.mapleader = ','
vim.g.maplocalleader = ';'


require('settings')


-- Auto install packer.nvim if not exists
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                install_path)
end
vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

-- Install plugins
require('plugins')


-- 
-- local fn = vim.fn
-- local execute = vim.api.nvim_command
-- 
-- -- Sensible defaults
-- 
-- 
-- -- Key mappings
-- require('keymappings')
-- 
-- -- LSP
-- require('lang')
-- 
-- -- Another option is to groups configuration in one folder
-- require('config')
-- 
-- -- DAP
-- require('dbg')
-- 
-- -- OR you can invoke them individually here
-- -- require('config.colorscheme')  -- color scheme
-- -- require('config.completion')   -- completion
-- -- require('config.fugitive')     -- fugitive
