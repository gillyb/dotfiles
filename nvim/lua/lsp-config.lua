local nvim_lsp = require('lspconfig')

local function init_lsp(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Define mappings
  -- buf_set_keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', { noremap=true, silent=true })
  buf_set_keymap('n', '<C-u>', ':lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true })
  buf_set_keymap('n', '<C-i>', ':lua vim.lsp.buf.implementation()<CR>', { noremap=true, silent=true })

  -- Give us completions!
  -- I currently use nvim-compe for completion. It seems to be much faster!
  --require('completion').on_attach()
end

-- Attach to language servers
nvim_lsp.tsserver.setup{ on_attach=init_lsp }



-- I use nvim-compe for completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = false;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}
