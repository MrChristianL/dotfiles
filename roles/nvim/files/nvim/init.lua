vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },

  {
    "neovim/nvim-lspconfig" -- LSP Configurations
  },
  -- Tokyo-Night Theme with Custom Colors
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Load immediately
    priority = 1000, -- Ensure it loads before other UI elements
    config = function()
      require("tokyonight").setup({
        style = "night", -- Options: "storm", "moon", "night", "day"
        transparent = false, -- Use true if you want a transparent background
        terminal_colors = true, -- Enable terminal colors
        -- Custom color palette
        on_colors = function(colors)
          -- Primary colors
          colors.bg = "#1a1b26"          -- background
          colors.fg = "#a9b1d6"          -- foreground
          
          -- Cursor colors
          colors.bg_highlight = "#4CA89A" -- selection background
          colors.fg_highlight = "#eeeeee" -- selection foreground
          
          -- Normal colors
          colors.black = "#414868"
          colors.red = "#f7768e"
          colors.green = "#73daca"
          colors.yellow = "#e0af68"
          colors.blue = "#7aa2f7"
          colors.magenta = "#bb9af7"
          colors.cyan = "#7dcfff"
          colors.white = "#c0caf5"
          
          -- Bright colors (using same values as normal in your config)
          colors.black_bright = "#414868"
          colors.red_bright = "#f7768e"
          colors.green_bright = "#73daca"
          colors.yellow_bright = "#e0af68"
          colors.blue_bright = "#7aa2f7"
          colors.magenta_bright = "#bb9af7"
          colors.cyan_bright = "#7dcfff"
          colors.white_bright = "#c0caf5"
          
          -- Additional colors
          colors.comment = "#414868"     -- using black as comment color
          colors.git = {
            add = "#73daca",
            change = "#e0af68",
            delete = "#f7768e",
          }
          colors.hint = "#7dcfff"        -- cyan
          colors.info = "#7aa2f7"        -- blue
          colors.warning = "#e0af68"     -- yellow
          colors.error = "#f7768e"       -- red
          colors.border = "#414868"      -- using black for borders
          colors.link = "#9ece6a"        -- url color
        end,
        -- Custom highlights
        on_highlights = function(highlights, colors)
          highlights.Cursor = {
            fg = "#1a1b26",             -- cursor text
            bg = "#c0caf5"              -- cursor background
          }
          highlights.Visual = {
            fg = "#eeeeee",             -- selection foreground
            bg = "#4CA89A"              -- selection background
          }
          highlights.CursorLine = {
            bg = "#252631"              -- slightly lighter than bg
          }
          highlights.LineNr = {
            fg = "#414868"              -- line numbers
          }
          highlights.CursorLineNr = {
            fg = "#c0caf5"              -- current line number
          }
        end,
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.opt.list = false

-- Add your window settings as global vim options
vim.opt.columns = 100    -- window width
vim.opt.lines = 30       -- window height
vim.opt.winwidth = 100   -- minimum window width
vim.opt.winheight = 30   -- minimum window height

-- Set font (Note: GUI Neovim required for font settings)
vim.opt.guifont = "JetBrainsMono Nerd Font:h22"
