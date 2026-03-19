vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = function() end,
    ["*"] = function() end,
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
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<F17>",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<F23>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
    },
  },
}
