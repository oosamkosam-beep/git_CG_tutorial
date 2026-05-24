local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "ucs-bom", "utf-8", "cp932", "sjis", "euc-jp", "latin1" }
vim.opt.fileencoding = ""

vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd("colorscheme torte")
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftround = true

vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { underline = true, sp = "#4E8AF0", })

--Snacks.pickerのキーマップ
vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files()
  end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function()
  Snacks.picker.grep()
  end, { desc = "Grep search" })
vim.keymap.set("n", "<leader>fw", function()
    Snacks.picker.grep({
      search = vim.fn.expand("<cword>"),
      on_show = function()
        vim.cmd("stopinsert")
      end,
    })
  end)


vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  --------------------------------------------------------------------
  -- ★★ 最優先: nvim-web-devicons を絶対にロードする設定 ★★
  --------------------------------------------------------------------
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,          -- ← 必ず起動時に読み込む
    priority = 1000,       -- ← すべてのプラグインより先にロード
    config = function()
      require("nvim-web-devicons").setup({ default = true })
      vim.g.loaded_webdevicons = 1
    end,
  },

  -- ★★ oil.nvim★★
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      local oil = require("oil")

      oil.setup({
        view_options = {
          show_hidden = true,
        },

        columns = {
          "icon",     -- ← アイコン表示が有効になる
        },

        keymaps = {

          ["gp"] = {
            function()
              local oil = require("oil")
              local entry = oil.get_cursor_entry()
              if not entry then return end
              local fullpath = oil.get_current_dir() .. entry.name

              if entry.name:match("%.exe$") and vim.fn.has("win64") == 1 then
                vim.fn.jobstart({ "cmd.exe", "/c", "start", "", fullpath }, { detach = true })
                return
              end
              oil.open_preview()
            end,
            desc = "Open exe or preview",
          },

          ["gy"] = {
            function()
              local oil = require("oil")
              local entry = oil.get_cursor_entry()
              if not entry then return end
              local fullpath = oil.get_current_dir() .. entry.name
              vim.fn.setreg("+", fullpath)
              print("Copied: " .. fullpath)
            end,
            desc = "Copy full file path",
          },
        },
      })
    end,
  },

  -- ★★ snacks.nvim★★
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      picker = { enabled = true },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
    },
  }
})
