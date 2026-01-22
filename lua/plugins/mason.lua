return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  event = "VeryLazy",
  opts = {
    ensure_installed = {
      "clangd",
      "clang-format",
      "black",
      "basedpyright",
      "jq",
      "debugpy",
    },
  },
}
