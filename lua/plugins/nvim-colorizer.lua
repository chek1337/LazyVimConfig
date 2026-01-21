return {
  -- https://github.com/nvim-mini/mini.hipatterns maybe letter use it
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    user_default_options = {
      names = false,
    },
  },
}
