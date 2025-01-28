vim.api.nvim_set_keymap("i", "fd", "<Esc>", {noremap=false})
vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee > /dev/null %", {noremap=false, silent=true})
-- twilight
vim.api.nvim_set_keymap("n", "tw", ":Twilight<enter>", {noremap=false})
-- buffers
vim.api.nvim_set_keymap("n", "bk", ":blast<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "bj", ":bfirst<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "bh", ":bprev<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "bl", ":bnext<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "bd", ":bdelete<enter>", {noremap=false})
-- files
-- vim.api.nvim_set_keymap("n", "QQ", ":q!<enter>", {noremap=false})
-- vim.api.nvim_set_keymap("n", "WW", ":w!<enter>", {noremap=false})
-- vim.api.nvim_set_keymap("n", "E", "$", {noremap=false})
-- vim.api.nvim_set_keymap("n", "B", "^", {noremap=false})
vim.api.nvim_set_keymap("n", "TT", ":TransparentToggle<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "ss", ":noh<CR>", {noremap=true})
-- splits
-- vim.api.nvim_set_keymap("n", "<C-W>,", ":vertical resize -10<CR>", {noremap=true})
-- vim.api.nvim_set_keymap("n", "<C-W>.", ":vertical resize +10<CR>", {noremap=true})
-- vim.keymap.set('n', '<space><space>', "<cmd>set nohlsearch<CR>")

-- Quicker close split
vim.keymap.set("n", "<leader>qq", ":q<CR>",
  {silent = true, noremap = true}
)
-- Comments
vim.keymap.set("n", "<leader>c", "gcc")
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Noice
vim.api.nvim_set_keymap("n", "<leader>nn", ":Noice dismiss<CR>", {noremap=true})
vim.keymap.set("n", "<leader>ee", "<cmd>GoIfErr<cr>",
  {silent = true, noremap = true}
)
