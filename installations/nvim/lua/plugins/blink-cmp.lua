local ts_utils = require("nvim-treesitter.ts_utils")
local noice = require("noice")

local query = require("vim.treesitter.query")
local parsers = require("nvim-treesitter.parsers")

local function is_cursor_in_comment()
  local bufnr = vim.api.nvim_get_current_buf()
  local lang = parsers.get_buf_lang(bufnr)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local ok, parsed_query = pcall(vim.treesitter.query.get, lang, "highlights")
  if not ok or not parsed_query then
    return false
  end

  local parser = parsers.get_parser(bufnr, lang)
  if not parser then
    return false
  end

  local tree = parser:parse()[1]
  local root = tree:root()

  for id, node, _ in parsed_query:iter_captures(root, bufnr, row, row + 1) do
    local name = parsed_query.captures[id]
    if name == "comment" then
      local sr, sc, er, ec = node:range()
      if row >= sr and row <= er and col >= sc and col <= ec then
        return true
      end
    end
  end

  return false
end

return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = function()
          local is_comment = is_cursor_in_comment()

          if is_comment then
            -- Don't show any suggestions inside comments
            return {}
          elseif vim.bo.filetype == "lua" then
            return { "lsp", "path" }
          else
            return { "lsp", "path", "snippets", "buffer" }
          end
        end,
      },
    },
  },
}
