local M = {}
local util = require("timelog.util")

-- Function to calculate time spent per activity
M.summarize_time = function()
  local buf = util.get_today_note_buffer()
  if not buf then return end

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local activity_times = {}
  local summary_start = nil
  local summary_end = nil

  for i, line in ipairs(lines) do
    local start_time, end_time, activity = line:match("| (%d+:%d%d) | (%d+:%d%d) | (.+) |")
    if start_time and end_time and activity then
      local start_hour, start_min = start_time:match("(%d+):(%d%d)")
      local end_hour, end_min = end_time:match("(%d+):(%d%d)")

      local start_sec = (tonumber(start_hour) * 3600) + (tonumber(start_min) * 60)
      local end_sec = (tonumber(end_hour) * 3600) + (tonumber(end_min) * 60)
      local duration = end_sec - start_sec
      activity_times[activity] = (activity_times[activity] or 0) + duration
    end

    -- Detect existing summary section
    if line:match("^### Time Summary") then
      summary_start = i - 1
    end
    if summary_start and i > summary_start + 2 then
      if line:match("^|") then
        summary_end = i + 1 -- Keep updating index as long as we see table rows
      else
        break  -- Stop tracking if we leave the table
      end
    end
  end

  -- Remove old summary
  if not summary_start then
    summary_start = #lines + 1
    summary_end = #lines + 1
  end
  if not summary_end then
    summary_end = summary_start
  end

  -- Append new summary
  local new_lines = {}
  if lines[summary_start] ~= "" then
    table.insert(new_lines, "")
  end
  table.insert(new_lines, "### Time Summary")
  table.insert(new_lines, "")
  table.insert(new_lines, "| Activity | Total Time | Total Time (h) |")
  table.insert(new_lines, "|----------|------------|---------------:|")

  for activity, total_seconds in pairs(activity_times) do
    local hours = math.floor(total_seconds / 3600)
    local minutes = math.floor((total_seconds % 3600) / 60)
    local decimal_hours = total_seconds / 3600
    table.insert(new_lines, string.format("| %s | %d h %d min | %.1f |", activity, hours, minutes, decimal_hours))
  end
  table.insert(new_lines, "")

  vim.api.nvim_buf_set_lines(buf, summary_start, summary_end, false, new_lines)
  print("Time summary updated in Obsidian.")
end

return M


