return {
  "numToStr/Comment.nvim",
  -- event = { "BufReadPre", "BufNewFile" },
  -- keys = {
  --   { "gc", mode = { "n", "v" } }, {"gb", mode = {"n", "v" }}
  -- },
  config = function ()
    local present, nvim_comment = pcall(require, "Comment")

    if not present then
      return
    end

    local options = {
      opleader = {
        line = 'cl',
        block = 'cb'
      },
    }

    nvim_comment.setup(options)

  end
}