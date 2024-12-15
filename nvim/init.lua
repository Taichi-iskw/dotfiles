vim.opt.fileencoding = "utf-8"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.directory = '$HOME/.swqpfiles'

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- keymaping
vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>g", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<Leader>b", ":Telescope buffers<CR>")
vim.keymap.set("n", "<Leader>t", ":NvimTreeToggle<CR>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{
			"hrsh7th/nvim-cmp",
			dependencies = {
					"hrsh7th/cmp-nvim-lsp",
					"hrsh7th/cmp-buffer",
					"hrsh7th/cmp-path",
					"hrsh7th/cmp-cmdline",
					"L3MON4D3/LuaSnip",
					"saadparwaiz1/cmp_luasnip",
			},
	},
	{ "neovim/nvim-lspconfig" },
	{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "nvim-lualine/lualine.nvim" },
  { "numToStr/Comment.nvim" },
	{ "windwp/nvim-autopairs" },
})


-- LSP -----
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body) 
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})

local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

lspconfig.gopls.setup({
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- LSP END --- 

-- nvim-autopairs
require("nvim-autopairs").setup({
	check_ts = true,
})

-- nvim-tree
require("nvim-tree").setup({
    view = {
        width = 30,
        side = "left",
    },
    renderer = {
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
            },
        },
    },
})

