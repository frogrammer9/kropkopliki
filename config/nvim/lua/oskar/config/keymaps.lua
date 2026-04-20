local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end

-- gengeral

map("n", "<A-j>", ":m .+1<CR>==")     -- move line up(n)
map("n", "<A-k>", ":m .-2<CR>==")     -- move line down(n)
map("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
map("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)
map("n", "<leader>qq", ":q!<CR>")     -- exit without saveing
map("n", "<leader>wq", ":wqa<CR>")    -- save and exit
map("n", "<leader>ww", ":w<CR>")      -- save
map("n", "<leader>d", "Vyp")          -- duplicate line
map("n", "<leader>ft", ":TodoTelescope<CR>")
map("n", "<leader>fr", vim.lsp.buf.format)

map("v", "<C-s>", function()
	vim.cmd("normal! y")
    local txt = vim.fn.getreg('"')
    local cmd = string.format(":%%s/%s//g", txt)
	vim.cmd("normal! :")
	vim.fn.feedkeys(cmd, 'n')
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true), 'n', true)
end)

map('n', '<C-h>', function()
  local current_file = vim.api.nvim_buf_get_name(0)
  local alt_file = nil

  if current_file:match("%.h$") then
    alt_file = current_file:gsub("%.h$", ".c")
  elseif current_file:match("%.c$") then
    alt_file = current_file:gsub("%.c$", ".h")
  elseif current_file:match("%.hpp$") then
    alt_file = current_file:gsub("%.hpp$", ".cpp")
  elseif current_file:match("%.cpp$") then
    alt_file = current_file:gsub("%.cpp$", ".hpp")
  else
    vim.notify("Not a recognized header/source file", vim.log.levels.INFO)
    return
  end

  if vim.fn.filereadable(alt_file) == 1 then
    vim.cmd("edit " .. alt_file)
  else
    vim.notify("Alternate file not found: " .. alt_file, vim.log.levels.WARN)
  end
end, { desc = "Toggle between header/source file", noremap = true, silent = true })

map("v", '<C-c>', '"+y')
