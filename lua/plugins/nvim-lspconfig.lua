return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false, -- Hide inline text messages
    },
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
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              library = {
                -- "~/.local/share/nvim/lazy/",
              },
            },
          },
        },
      },
    },
  },
}
