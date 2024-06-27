--- @param mode string
--- @param key string
--- @param rhs? string|fun()
--- @param opts? vim.api.keyset.keymap
--- @return fun(_: fun())
return function(mode, key, rhs, opts)
  opts = opts or {}

  if opts.desc == nil then
    opts.desc = 'pckr.nvim lazy load'
  end

  if opts.silent == nil then
    opts.silent = true
  end

  --- @param loader fun()
  return function(loader)
    local rhs_func = function()
      -- TODO(epheien): run rhs
      -- TODO(lewis6991): detect is mapping already exists
      -- TODO(Zhou-Yicheng): delete mapping if exists
      vim.keymap.del(mode, key)
      loader()
      if mode == 'n' then
        vim.api.nvim_input(key)
      else
        vim.api.nvim_feedkeys(key, mode, false)
      end
    end

    vim.keymap.set(mode, key, rhs_func, opts)
  end
end
