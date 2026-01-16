return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      python = { "black" },
      json = { "jq" },
      jsonc = { "jq" }, -- если используете json с комментариями
    },
  },
}
