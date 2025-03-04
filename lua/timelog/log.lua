local M = {}


local obsidian = require("obsidian")  -- Ensure obsidian.nvim is installed and loaded
local summary = require("timelog.summary")
local time_format = "%-H:%M"
local summarize_time = nil
M.log_end_time = nil

-- Function to insert a row in the time log table
M.log_start_time = function(continue)
  local note_buffer = summary.get_today_note_buffer()

  local lines = vim.api.nvim_buf_get_lines(note_buffer, 0, -1, false)
  local insert_idx = #lines + 1
  local found_table = false
  local activity = nil
  for i, line in ipairs(lines) do
    if line:match("| Start | End | Activity |") then
      found_table = true
    end
    -- Detect unfinished entry
    if line:match("| (%d+:%d%d) |  | (.+) |") then
      print("Warning: Found a previous activity with no end time, setting it now!")
      M.log_end_time()
    end
    -- If we are inside the table, track the last row for inserting
    if found_table then
      if line:match("^|") then
        insert_idx = i  -- Keep updating index as long as we see table rows
        _, _, activity = line:match("| (%d+:%d%d) | (%d+:%d%d) | (.+) |")
      else
        break  -- Stop tracking if we leave the table
      end
    end
  end
  -- If table is not found, create it
  if not found_table then
    vim.api.nvim_buf_set_lines(note_buffer, insert_idx, insert_idx, false, {
      "# Time Log",
      "| Start | End | Activity |",
      "|------:|-----|----------|"
    })
    insert_idx = insert_idx + 3
  end

  -- Get the current timestamp
  local timestamp = os.date(time_format)

  -- Prompt the user for the activity name
  if not continue or not activity then
    vim.ui.input({ prompt = "Enter activity: " }, function(activity)
      if activity then
        local line = string.format("| %s |  | %s |", timestamp, activity)
        vim.api.nvim_buf_set_lines(note_buffer, insert_idx, insert_idx, false, { line })

        print("Logged start time for: " .. activity)
      end
    end)
  else
    local line = string.format("| %s |  | %s |", timestamp, activity)
    vim.api.nvim_buf_set_lines(note_buffer, insert_idx, insert_idx, false, { line })

    print("Logged start time for: " .. activity)
  end
end

M.log_continue = function()
  return M.log_start_time(true)
end

-- Function to log end time
M.log_end_time = function()
  local note_buffer = summary.get_today_note_buffer()

  local lines = vim.api.nvim_buf_get_lines(note_buffer, 0, -1, false)
  local last_unfinished_index = nil

  for index, line in ipairs(lines) do
    if line:match("| (%d+:%d%d) |  | (.+) |") then
      last_unfinished_index = index
    end
  end

  if last_unfinished_index then
    local timestamp = os.date(time_format)
    local line = lines[last_unfinished_index]:gsub("|  |", "| " .. timestamp .. " |", 1)

    vim.api.nvim_buf_set_lines(note_buffer, last_unfinished_index - 1, last_unfinished_index, false, { line })
    print("Logged end time: " .. timestamp)
    -- Auto-update the summary
    summary.summarize_time()
  else
    print("No open time entry found!")
  end
end


return M
