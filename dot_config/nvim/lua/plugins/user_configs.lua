vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = function() end,
    ['*'] = function() end,
  },
}

vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  if path ~= "" then
    vim.fn.setreg("+", path)
    vim.notify("Copied absolute path: " .. path)
  else
    vim.notify("No file path to copy", vim.log.levels.WARN)
  end
end, { desc = "Copy absolute file path" })

vim.keymap.set("n", "<leader>yr", function()
  local path = vim.fn.expand("%:.")
  if path ~= "" then
    vim.fn.setreg("+", path)
    vim.notify("Copied relative path: " .. path)
  else
    vim.notify("No file path to copy", vim.log.levels.WARN)
  end
end, { desc = "Copy relative file path" })

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
