return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          { "<C-k>", false, mode = "i" },
        },
      },
      clangd = {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      },
    },
  },
}
