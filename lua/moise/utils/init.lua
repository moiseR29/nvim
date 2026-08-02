local M = {}

function M.keymap(mode, key, result, options)
  options = options or { noremap = true, silent = true }
  -- vim.api.nvim_set_keymap(mode, key, result, options)
  vim.keymap.set(mode, key, result, options)
end

function M.buf_keymap(buff, mode, key, result, options)
  options = options or { noremap = true, silent = true }
  --vim.api.nvim_buf_set_keymap(buff, mode, key, result, options)
  options.buffer = buff
  vim.keymap.set(mode, key, result, options)
end

function M.global(key, value)
  vim.g[key] = value
end

function M.addOpt(key, value)
  vim.opt[key] = value
end

function M.merge(t1, t2)
  return vim.tbl_deep_extend("force", t1, t2)
end

function M.reverseMerge(t1, t2)
  return vim.tbl_deep_extend("force", t2, t1)
end

function M.close_buffer(force)
  if vim.bo.buftype == "terminal" then
    vim.api.nvim_win_hide(0)
    return
  end

  local fileExists = vim.fn.filereadable(vim.fn.expand "%p")
  local modified = vim.api.nvim_buf_get_option(vim.fn.bufnr(), "modified")

  -- if file doesnt exist & its modified
  if fileExists == 0 and modified then
    print "no file name? add it now!"
    return
  end

  force = force or not vim.bo.buflisted or vim.bo.buftype == "nofile"

  -- if not force, change to prev buf and then close current
  local close_cmd = force and ":bd!" or ":bp | bd" .. vim.fn.bufnr()
  vim.cmd(close_cmd)
end

_G.utils = M
return M

