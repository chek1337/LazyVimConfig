return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  event = "VeryLazy",
  opts = {
    ensure_installed = {
      "clangd",
      "clang-format",
      "basedpyright",
      "debugpy",
      "black",
      "jq",
      "ast-grep",
    },
  },
}
