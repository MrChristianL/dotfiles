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
  -- Tokyo-Night Theme
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Load immediately
    priority = 1000, -- Ensure it loads before other UI elements
    config = function()
      require("tokyonight").setup({
        style = "night", -- Options: "storm", "moon", "night", "day"
        transparent = false, -- Use true if you want a transparent background
        terminal_colors = true, -- Enable terminal colors
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },
}, lazy_config)

-- LSP Servers
local lspconfig = require("lspconfig")

-- Setup LSP servers
lspconfig.bashls.setup{}  -- Bash Language Server
lspconfig.clangd.setup{}  -- C++ Language Server (cpplint, cpptools)
lspconfig.golangci_lint_ls.setup{}  -- GolangCI Lint Language Server
lspconfig.gopls.setup{}  -- Go Language Server
lspconfig.jsonls.setup{}  -- JSON Language Server
lspconfig.lua_ls.setup{}  -- Lua Language Server
lspconfig.pyright.setup{}  -- Python Language Server
lspconfig.rust_analyzer.setup{}  -- Rust Analyzer Language Server
lspconfig.solargraph.setup{}  -- Ruby Language Server
lspconfig.tailwindcss.setup{}  -- TailwindCSS Language Server
lspconfig.yamlls.setup{}  -- YAML Language Server


-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.opt.list = false
