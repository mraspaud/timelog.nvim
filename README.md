# timelog.nvim

A lightweight and efficient time-tracking plugin for Neovim. **timelog.nvim** allows you to quickly log timestamps, track time spent on tasks, and manage your time efficiently—all without leaving your editor.

## 📌 Features

- 🚀 **Quick Timestamp Logging** – Instantly insert timestamps into a log file or buffer.
- ⏳ **Task Timer** – Start, stop, and record time spent on tasks.
- 📂 **Custom Log Files** – Save time entries in a structured format.
- 📝 **Inline Editing** – Modify time entries without disrupting your workflow.
- 🔍 **Search & Filter** – Quickly find logs based on date, task name, or tags.
- 🔄 **Configurable Format** – Customize timestamps and log formats.
- 🛠 **Minimal & Fast** – Built with Lua for optimal performance in Neovim.

## 📦 Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    "mraspaud/timelog.nvim",
    opts = {},
}
```

## ⚙️ Configuration

You can customize **timelog.nvim** by passing options to `opts`. Example:

```lua
require("timelog").setup({
    log_file = "~/timelog.md",  -- Default log file
    timestamp_format = "%H:%M", -- Custom timestamp format
    show_notifications = true,  -- Show notifications when logging
})
```

### Default Configuration:
```lua
{
    log_file = "~/.timelog",
    timestamp_format = %H:%M",
    show_notifications = true,
}
```

## 🚀 Usage

| Command | Description |
|---------|-------------|
| `:TimeLogStart` | Start tracking time for a task |
| `:TimeLogStop` | Stop the current task timer |
| `:TimeLogContinue` | Continue tracking time on previous task |
| `:TimeLogSummarizeTime` | Summarize the day's logs |

### Example Usage
1. Start tracking a task:
   ```vim
   :TimeLogStart "Writing README"
   ```
2. Stop tracking:
   ```vim
   :TimeLogStop
   ```
3. View logs:
   ```vim
   :TimeLogShow
   ```

## 🔧 Keybindings (Optional)
If you prefer keybindings, you can add them in your `init.lua`:
```lua
vim.api.nvim_set_keymap("n", "<leader>tb", ":TimeLogStart<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":TimeLogContinue<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>te", ":TimeLogStop<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ts", ":TimeLogShow<CR>", { noremap = true, silent = true })
```

## 🎯 Roadmap
- [ ] Task categories/tags
- [ ] Reports & statistics
- [ ] Export logs to CSV/JSON
- [ ] UI improvements (e.g., floating window for logs)

## 🤝 Contributing
Contributions are welcome! Feel free to open an issue or submit a pull request.

## 📄 License
Apache v2 License. See [LICENSE](./LICENSE) for details.
