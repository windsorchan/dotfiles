-- Bootstrap lazy.nvim
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
vim.opt.rtp:prepend(lazypath)

-- Set leader key before lazy
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- General settings
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.hidden = true
vim.opt.lazyredraw = true
vim.opt.showmode = true
vim.opt.wrapscan = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.visualbell = true
vim.opt.backspace = "indent,eol,start"
vim.opt.laststatus = 2
vim.opt.timeoutlen = 500
vim.opt.updatetime = 250
vim.opt.history = 100
vim.opt.foldopen = "block,insert,jump,mark,percent,quickfix,search,tag,undo"
vim.opt.scrolloff = 8
vim.opt.incsearch = true
vim.opt.number = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true

-- Tab settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Python-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.fileformat = "unix"
  end,
})

-- Go-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode" })
vim.keymap.set("n", ",pp", ":set invpaste<CR>:set paste?<CR>", { silent = true, desc = "Toggle paste mode" })
vim.keymap.set("n", ",tw", ":set nowrap!<CR>", { silent = true, desc = "Toggle word wrap" })
vim.keymap.set("n", ",cd", ":lcd %:h<CR>", { silent = true, desc = "Change to file directory" })
vim.keymap.set("n", ",cc", ":close<CR>", { silent = true })
vim.keymap.set("n", ",cw", ":cclose<CR>", { silent = true })
vim.keymap.set("n", ",ev", ":e $MYVIMRC<CR>", { silent = true, desc = "Edit init.lua" })
vim.keymap.set("n", ",/", ":set invhlsearch<CR>:set hlsearch?<CR>", { silent = true, desc = "Toggle highlight search" })

-- Plugin setup
require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup()
      telescope.load_extension("fzf")
      vim.keymap.set("n", "<Leader>bb", ":Telescope buffers<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>bl", ":Telescope current_buffer_fuzzy_find<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>gg", ":Telescope live_grep<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>ct", ":Telescope tags<CR>", { silent = true })
      vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { silent = true })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        filters = {
          custom = {
            "\\.ncb$", "\\.suo$", "\\.obj$", "\\.ilk$", "^BuildLog.htm$",
            "\\.pdb$", "\\.idb$", "\\.embed\\.manifest$", "\\.embed\\.manifest\\.res$",
            "\\.intermediate\\.manifest$", "^mt.dep$", "\\.o$", "\\.vcproj$",
            "\\.so$", "\\.so\\.1$", "\\.so\\.1\\.0$"
          },
        },
      })
      vim.keymap.set("n", "<Leader>ta", ":NvimTreeToggle<CR>", { silent = true })
    end,
  },

  {
    "preservim/tagbar",
    config = function()
      vim.keymap.set("n", "<Leader>ts", ":TagbarToggle<CR>", { silent = true })
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    config = function()
      vim.g.tmux_navigator_no_wrap = 1
      vim.g.tmux_navigator_disable_when_zoomed = 1
      vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { silent = true })
      vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { silent = true })
      vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { silent = true })
      vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { silent = true })
    end,
  },

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                 desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
})

-- Terminal settings for better integration with vim-tmux-navigator
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("startinsert")
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.lsp.config['rust-analyzer'] = {
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml', 'rust-project.json' },
  filetypes = { 'rust' },
}

vim.lsp.config['pyright'] = {
  cmd = { 'pyright' },
  filetypes = { 'py' },
}

vim.lsp.enable({ 'rust-analyzer', 'pyright' })
vim.diagnostic.config({ virtual_text = true })
