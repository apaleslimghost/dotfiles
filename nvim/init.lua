require("config.lazy")

vim.g.mapleader = ' '

if vim.g.neovide then
	vim.keymap.set('n', '<D-s>', '<Cmd>w<CR>') -- Save
	vim.keymap.set('i', '<D-s>', '<ESC><Cmd>w<CR>i') -- Save
	vim.keymap.set('v', '<D-c>', '"+y') -- Copy
	vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
	vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
	vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
	vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

vim.g.neovide_padding_top = 16
vim.g.neovide_padding_bottom = 16
vim.g.neovide_padding_right = 16
vim.g.neovide_padding_left = 16
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0.1


vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.o.showmode = false
vim.o.number = true
vim.o.numberwidth = 6
vim.o.cursorline = true
vim.o.tabstop = 3
vim.o.undofile = true
vim.o.mousemoveevent = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.hidden = true

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true
})

vim.api.nvim_create_autocmd("WinEnter", {
	pattern = "*",
	callback = function()
		vim.wo.cursorline = true
	end,
})

vim.api.nvim_create_autocmd("WinLeave", {
	pattern = "*",
	callback = function()
		vim.wo.cursorline = false
	end,
})

for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
	vim.fn.sign_define("DiagnosticSign" .. diag, {
		text = "",
		texthl = "DiagnosticSign" .. diag,
		linehl = "",
		numhl = "DiagnosticSign" .. diag,
	})
end

vim.diagnostic.config({
	float = {
		header = ''
	}
})

