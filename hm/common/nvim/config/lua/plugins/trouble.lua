require("trouble").setup {}
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qfList toggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  {silent = true, noremap = true}
)

-- Diagnostic signs
-- https://github.com/folke/trouble.nvim/issues/52
local signs = {
    Error = "E",
    Warning = "W",
    Hint = "H",
    Information = " "
}
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warning,
      [vim.diagnostic.severity.HINT] = signs.Hint,
      [vim.diagnostic.severity.INFO] = signs.Information,
    }
  }
})
