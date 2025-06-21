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
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Key mappings
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode" })
vim.keymap.set("n", ",pp", ":set invpaste<CR>:set paste?<CR>", { silent = true, desc = "Toggle paste mode" })
vim.keymap.set("n", ",tw", ":set nowrap!<CR>", { silent = true, desc = "Toggle word wrap" })
vim.keymap.set("n", ",cd", ":lcd %:h<CR>", { silent = true, desc = "Change to file directory" })

-- Window navigation
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true })
vim.keymap.set("n", ",cc", ":close<CR>", { silent = true })
vim.keymap.set("n", ",cw", ":cclose<CR>", { silent = true })

-- vim.keymap.set('t', '<C-h>', '<C-\\><C-n>:TmuxNavigateLeft<CR>')
-- vim.keymap.set('t', '<C-j>', '<C-\\><C-n>:TmuxNavigateDown<CR>')
-- vim.keymap.set('t', '<C-k>', '<C-\\><C-n>:TmuxNavigateUp<CR>')
-- vim.keymap.set('t', '<C-l>', '<C-\\><C-n>:TmuxNavigateRight<CR>')

-- Config editing
vim.keymap.set("n", ",ev", ":e $MYVIMRC<CR>", { silent = true, desc = "Edit init.lua" })

-- Search
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

  -- I thought this would be cool, but why do you need to display buffers
  -- {'akinsho/bufferline.nvim', version = "*", dependencies =
  --   'nvim-tree/nvim-web-devicons',
  --   config = function()
  --     require("bufferline").setup({})
  --   end
  -- },

  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          layout_strategy = "bottom_pane",
          layout_config = {
            height = 0.2,
            prompt_position = "bottom",
          },
          sorting_strategy = "ascending",
          border = false,
        },
      })
      telescope.load_extension("fzf")
      
      -- Key mappings
      vim.keymap.set("n", "<Leader>bb", ":Telescope buffers<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>bl", ":Telescope current_buffer_fuzzy_find<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>ll", ":Telescope live_grep<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>ct", ":Telescope tags<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>pa", function()
        require("telescope.builtin").find_files({ cwd = "~/src/ems/" })
      end, { silent = true })
      vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { silent = true })
    end,
  },

  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    config = function()
      require("telescope").load_extension("live_grep_args")
      vim.keymap.set("n", "<Leader>gg", ":Telescope live_grep_args<CR>", { silent = true })
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
      vim.keymap.set("n", "<Leader>aa", ":NvimTreeToggle<CR>", { silent = true })
    end,
  },

  -- {
  --   "preservim/tagbar",
  --   config = function()
  --     vim.keymap.set("n", "<Leader>as", ":TagbarToggle<CR>", { silent = true })
  --   end,
  -- },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  "famiu/bufdelete.nvim",

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP Support
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      
      -- Autocompletion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      -- Mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "jsonls", "rust_analyzer" },
      })
      
      -- nvim-cmp setup
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
      
      -- LSP setup
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- Use LspAttach autocommand to only map keys after LSP attaches to buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          
          -- Navigate diagnostics
          vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
          
          -- GoTo code navigation
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        end,
      })
      
      -- Configure servers
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.jsonls.setup({ capabilities = capabilities })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      })
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          rust = { "rustfmt" },
          python = { "black", "isort" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    config = function()
      vim.g.tmux_navigator_no_wrap = 1
      -- Disable tmux navigator when zooming the Vim pane
      vim.g.tmux_navigator_disable_when_zoomed = 1
      -- Custom navigation mappings that work in terminal mode
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
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      -- { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      -- { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
})

-- Additional settings
vim.g.c_no_curly_error = 1

-- Auto-show diagnostics on cursor hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
  end,
})

-- Terminal settings for better integration with vim-tmux-navigator
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    -- Start in insert mode when opening terminal
    vim.cmd("startinsert")
    -- Disable line numbers in terminal
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    -- Map Esc to exit terminal mode
    -- vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = 0 })
    -- Map double Esc to send Esc to terminal
    -- vim.keymap.set('t', '<Esc><Esc>', '<Esc>', { buffer = 0 })
  end,
})
