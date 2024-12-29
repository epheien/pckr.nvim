--- @param mode string|string[]
--- @param key string
--- @param _rhs? string|fun()
--- @param opts? vim.keymap.set.Opts
--- @return fun(_: fun())
return function(mode, key, _rhs, opts)
  opts = opts or {}

  opts.desc = opts.desc or 'pckr.nvim lazy load'

  if opts.silent == nil then
    opts.silent = true
  end

  --- @param loader fun()
  return function(loader)
    vim.keymap.set(mode, key, function()
      local dopts = opts --[[@as vim.keymap.del.Opts]]
      -- always delete the mapping immediately to prevent recursive mappings
      vim.keymap.del(mode, key, dopts)
      loader()
      vim.api.nvim_input(key)
    end, opts)
  end
end
