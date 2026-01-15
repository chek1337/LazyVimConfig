return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  lazy = false,
  opts = {
    ensure_installed = {
      "clangd",
      "clang-format",
      "jq",
    },
  },
}
