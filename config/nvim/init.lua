require("oskar.config")
require("oskar.lazy")
vim.g.actions_preview_start_line = 5
vim.cmd [[
au VimLeave,VimSuspend * set guicursor=a:hor50-blinkon0
]]
