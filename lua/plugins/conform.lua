return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      python = { "black" },
      json = { "jq" },
      jsonc = { "jq" },
    },
  },
}
