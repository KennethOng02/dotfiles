-- i18n virtual text: shows translations for t('ns:key') calls inline
-- Works with projects using src/i18n/locales/{locale}/{ns}.json structure

local M = {}
local ns_id = vim.api.nvim_create_namespace 'i18n_vtext'

local config = {
  locale = 'zh-Hans',
  hl_group = 'Comment',
  -- filetypes to activate on
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
}

-- per-project cache: locales_root -> { ns -> table }
local json_cache = {}
local root_cache = {} -- bufnr -> locales_root | false

local function find_locales_root(bufname)
  local dir = vim.fn.fnamemodify(bufname, ':h')
  local prev = nil
  while dir ~= prev do
    local candidate = dir .. '/src/i18n/locales'
    if vim.fn.isdirectory(candidate) == 1 then
      return candidate
    end
    prev = dir
    dir = vim.fn.fnamemodify(dir, ':h')
  end
  return nil
end

local function load_ns(locales_root, ns)
  local ckey = locales_root .. '|' .. ns
  if json_cache[ckey] ~= nil then
    return json_cache[ckey]
  end
  local path = locales_root .. '/' .. config.locale .. '/' .. ns .. '.json'
  local lines = vim.fn.readfile(path)
  if not lines or #lines == 0 then
    json_cache[ckey] = false
    return false
  end
  local ok, data = pcall(vim.json.decode, table.concat(lines, '\n'))
  json_cache[ckey] = ok and data or false
  return json_cache[ckey]
end

-- resolve nested key like "sendEmail.title"
local function resolve(data, key)
  local cur = data
  for part in key:gmatch '[^.]+' do
    if type(cur) ~= 'table' then
      return nil
    end
    cur = cur[part]
  end
  return type(cur) == 'string' and cur or nil
end

local function render(bufnr)
  local locales_root = root_cache[bufnr]
  if locales_root == nil then
    local name = vim.api.nvim_buf_get_name(bufnr)
    locales_root = find_locales_root(name) or false
    root_cache[bufnr] = locales_root
  end
  if not locales_root then
    return
  end

  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for lnum, line in ipairs(lines) do
    if not line:find 't%(' then goto continue end
    for ns, key in line:gmatch "['\"]([%a][%w_%-]*):([%a_][%w%._%-]*)['\"]" do
      local data = load_ns(locales_root, ns)
      if data then
        local val = resolve(data, key)
        if val then
          vim.api.nvim_buf_set_extmark(bufnr, ns_id, lnum - 1, 0, {
            virt_text = { { '  ⟨' .. val .. '⟩', config.hl_group } },
            virt_text_pos = 'eol',
            priority = 10,
          })
        end
      end
    end
    ::continue::
  end
end

-- debounce: avoid re-rendering on every keystroke
local timers = {}
local function schedule_render(bufnr)
  if timers[bufnr] then
    timers[bufnr]:stop()
  end
  timers[bufnr] = vim.defer_fn(function()
    timers[bufnr] = nil
    if vim.api.nvim_buf_is_valid(bufnr) then
      render(bufnr)
    end
  end, 150)
end

local function should_activate(bufnr)
  local ft = vim.bo[bufnr].filetype
  for _, f in ipairs(config.ft) do
    if ft == f then
      return true
    end
  end
  return false
end

local group = vim.api.nvim_create_augroup('I18nVtext', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
  group = group,
  callback = function(ev)
    if should_activate(ev.buf) then
      schedule_render(ev.buf)
    end
  end,
})

-- invalidate cache when locale files change
vim.api.nvim_create_autocmd('BufWritePost', {
  group = group,
  pattern = '*/i18n/locales/*/*.json',
  callback = function()
    json_cache = {}
    -- re-render all active bufs
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) and should_activate(bufnr) then
        schedule_render(bufnr)
      end
    end
  end,
})

-- commands
vim.api.nvim_create_user_command('I18nToggle', function()
  -- toggle per-tab/global disable
  vim.g.i18n_vtext_disabled = not vim.g.i18n_vtext_disabled
  if vim.g.i18n_vtext_disabled then
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    end
    vim.notify 'i18n vtext: off'
  else
    local bufnr = vim.api.nvim_get_current_buf()
    render(bufnr)
    vim.notify 'i18n vtext: on'
  end
end, {})

vim.api.nvim_create_user_command('I18nLocale', function(opts)
  local locale = opts.args
  if locale == '' then
    vim.notify('current locale: ' .. config.locale)
    return
  end
  config.locale = locale
  json_cache = {}
  local bufnr = vim.api.nvim_get_current_buf()
  render(bufnr)
  vim.notify('i18n locale → ' .. locale)
end, { nargs = '?' })

return M
