-- Neovide needs this defined very early
if vim.fn.has('mac') == 1 then
  vim.opt.guifont = "Hasklug Nerd Font:h18"
else
  vim.opt.guifont = "Hasklug Nerd Font:h9"
end
vim.g.loaded_matchit = 1 -- disable early

-- Ensure vendored local plugins are on runtimepath (e.g., fluoromachine.nvim)
local function _prepend_local_rtp(dir)
  local ok, info = pcall(debug.getinfo, 1, 'S')
  if ok and info and type(info.source) == 'string' and info.source:sub(1, 1) == '@' then
    local base = info.source:sub(2):match("(.*/)") or ''
    local path = base .. dir
    local uv = vim.uv or vim.loop
    if uv and uv.fs_stat(path) then
      vim.opt.rtp:prepend(path)
    end
  end
end
_prepend_local_rtp('fluoromachine.nvim')

require('pwnvim.filetypes').config()
require('pwnvim.options').defaults()
-- Use Fluoromachine as the default theme
pcall(function()
  require('pwnvim.options').colors_fluoromachine()
end)
require('pwnvim.options').gui()
require('pwnvim.mappings').config()
require('pwnvim.abbreviations')
require('pwnvim.plugins').ui()
require('pwnvim.plugins').diagnostics()
require('pwnvim.plugins').telescope()
require('pwnvim.plugins').completions()
require('pwnvim.plugins').llms()
require('pwnvim.plugins').notes()
require('pwnvim.plugins').misc()
