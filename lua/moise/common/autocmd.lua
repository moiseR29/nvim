local group = vim.api.nvim_create_augroup("UserConfig", {
  clear = true,
})

-- retomar ultima vez
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,

  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')

    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- quitar espacios al final
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,

  callback = function()
    local save_cursor = vim.fn.getpos "."

    vim.cmd [[%s/\s\+$//e]]

    vim.fn.setpos(".", save_cursor)
  end,
})
