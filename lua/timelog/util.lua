local M = {}

local obsidian = require("obsidian")

-- Function to get the path of today's Obsidian note
M.get_today_note_buffer = function()
  local client = obsidian.get_client()
  local today_note = client:today()
  local buf = today_note.bufnr
  if not buf then
    local util = require("obsidian.util")
    buf = util.open_buffer(today_note.path)
  end
  return buf
end

return M
