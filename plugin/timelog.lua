
if vim.g.loaded_timelog then
  return
end
vim.g.loaded_timelog = true

require("timelog").setup()
