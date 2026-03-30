return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- 1. Increase the timeout for LazyVim's <space>cf formatter
      opts.default_format_opts = opts.default_format_opts or {}
      opts.default_format_opts.timeout_ms = 100000

      -- 2. Map sqlfluff to SQL files
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.sql = { "sqlfluff" }

      -- 3. Fix the dbt templater issue by overriding args
      opts.formatters = opts.formatters or {}
      opts.formatters.sqlfluff = {
        args = { "fix", "--templater", "jinja", "--force", "-" },
        stdin = true,
      }
    end,
  },
}
