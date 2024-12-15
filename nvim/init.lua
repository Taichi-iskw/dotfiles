vim.opt.fileencoding = "utf-8"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- キーマッピング
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
  -- Telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  -- LSPサポート
	{
			"hrsh7th/nvim-cmp",
			dependencies = {
					"hrsh7th/cmp-nvim-lsp",     -- LSP用補完ソース
					"hrsh7th/cmp-buffer",       -- 現在のバッファ内の補完
					"hrsh7th/cmp-path",         -- ファイルパスの補完
					"hrsh7th/cmp-cmdline",      -- コマンドライン補完
					"L3MON4D3/LuaSnip",         -- スニペットエンジン
					"saadparwaiz1/cmp_luasnip", -- スニペット補完ソース
			},
	},
	{ "neovim/nvim-lspconfig" }, -- LSP設定用	
  -- 自動補完
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp" } },
  -- スニペット
  { "L3MON4D3/LuaSnip" },
  -- ファイラー
	{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  -- ステータスライン
  { "nvim-lualine/lualine.nvim" },
  -- コメント用プラグイン
  { "numToStr/Comment.nvim" },
	-- かっこ補完
	{ "windwp/nvim-autopairs" },
})


-- LSP -----
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- LuaSnipをスニペットエンジンとして使用
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- ドキュメントをスクロール
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- 補完を手動で呼び出し
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enterで補完確定
        ["<Tab>"] = cmp.mapping.select_next_item(), -- Tabで次の候補へ
        ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Shift+Tabで前の候補へ
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },    -- LSP補完
        { name = "luasnip" },    -- スニペット補完
        { name = "buffer" },     -- 現在のバッファ補完
        { name = "path" },       -- ファイルパス補完
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

-- pair
require("nvim-autopairs").setup({
	check_ts = true,
})

require("nvim-tree").setup({
    view = {
        width = 30, -- ファイラーの幅
        side = "left", -- 左に表示
    },
    renderer = {
        icons = {
            show = {
                git = true, -- Gitステータスの表示
                folder = true,
                file = true,
            },
        },
    },
})

