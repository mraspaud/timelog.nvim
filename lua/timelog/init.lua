local M = {}

M.setup = function(opts)
  M.log = require("timelog.log")
  M.summary = require("timelog.summary")
  vim.keymap.set("n", "<leader>tb", M.log.log_start_time, { desc = "Log start time in Obsidian daily" })
  vim.keymap.set("n", "<leader>te", M.log.log_end_time, { desc = "Log end time in Obsidian daily" })
  vim.keymap.set("n", "<leader>ts", M.summary.summarize_time, { desc = "Summarize time per activity in Obsidian daily" })
  vim.keymap.set("n", "<leader>tc", M.log.log_continue, { desc = "Log time on same activity as before in Obsidian daily" })
  vim.api.nvim_create_user_command("TimeLogStart", M.log.log_start_time, { desc = "Log start time in Obsidian daily" })
  vim.api.nvim_create_user_command("TimeLogContinue", M.log.log_continue, { desc = "Log time in Obsidian daily on the previous activity" })
  vim.api.nvim_create_user_command("TimeLogStop", M.log.log_end_time, { desc = "Log end time in Obsidian daily" })
  vim.api.nvim_create_user_command("TimeLogSummary", M.summary.summarize_time, { desc = "Summarize time per activity" })
end

return M

-- vim: ts=2 sts=2 sw=2 et
