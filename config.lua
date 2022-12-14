--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.cursorline = false
vim.opt.lazyredraw = true
vim.opt.regexpengine = 1
-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	pattern = "*.lua",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- -- Change theme settings
--   lvim.colorscheme = "lunar"
-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.illuminate.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
-- lvim.builtin.lualine.style = "default"
-- Automatically install missing parsers when entering buffer
-- lvim.builtin.treesitter.auto_install = true
-- lvim.builtin.treesitter.ignore_install = { "haskell" }
-- lvim.builtin.treesitter.ignore_install = { "html" }
-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>
-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false
-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)
---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
---`:LvimInfo` lists which server(s) are skipped for the current filetype
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
	return server ~= "emmet_ls"
end, lvim.lsp.automatic_configuration.skipped_servers)
-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua" },
	{
		command = "prettier",
		extra_args = { "--print-with", "100" },
		filetypes = { "typescript", "typescriptreact", "css", "scss", "javascript" },
	},
	{
		command = "black",
		extra_args = { "--fast" },
	},

	{ command = "shfmt", filetypes = { "sh", "zsh", "bash" } },
})
vim.filetype.add({
	extension = {
		zsh = "zsh",
	},
})

-- null-ls_format_on_save

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "bashls" })

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("bashls", {
	filetypes = { "sh", "zsh" },
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "flake8", filetypes = { "python" } },
	-- {
	-- 	command = "shellcheck",
	-- 	args = { "--severity", "warning" },
	-- },
})

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }
--
-- lisandrojm
-- -- Change theme settings
lvim.colorscheme = "tokyonight-night"
-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.indentlines.active = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.bufferline.options.always_show_bufferline = true
-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
	{
		"tpope/vim-fugitive",
	},
	{
		"ThePrimeagen/harpoon",
	},
	{
		"tzachar/cmp-tabnine",
		config = function()
			local tabnine = require("cmp_tabnine.config")
			tabnine:setup({
				max_lines = 1000,
				max_num_results = 20,
				sort = true,
				run_on_every_keystroke = true,
				snippet_placeholder = "..",
				ignored_file_types = { -- default is not to ignore
					-- uncomment to ignore in lua:
					-- lua = true
				},
			})
		end,
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
	},
	{ "p00f/nvim-ts-rainbow" },
	{ "phaazon/hop.nvim" },
	{ "andymass/vim-matchup" },
	{ "lunarvim/vim-solidity" },
	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({
				-- optional configuration
			})
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	-- neural - openai_AI
	-- {
	-- 	"dense-analysis/neural",
	-- 	config = function()
	-- 		require("neural").setup({
	-- 			open_ai = {
	-- 				api_key = "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",
	-- 			},
	-- 		})
	-- 	end,
	-- 	requires = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"ElPiloto/significant.nvim",
	-- 	},
	-- },
}
-- vim options
vim.opt.colorcolumn = "80"
vim.opt.timeoutlen = 40
vim.opt.updatetime = 50
vim.opt.showtabline = 2 -- always show tabs
vim.opt.sidescrolloff = 8
-- vim.opt.guicursor = "i:block"
-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
--
lvim.keys.normal_mode["<A-l>"] = "$"
lvim.keys.normal_mode["<A-h>"] = "_"
-- whitespaces
-- lvim.keys.normal_mode["<A-??>"] = ":g/^$/d<CR>"
-- Navigate buffers
lvim.keys.normal_mode["<S-l>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":bprevious<CR>_"
lvim.keys.insert_mode["jk"] = "<Esc>"
lvim.keys.insert_mode["<C-l>"] = "<Del>"
-- quick semi
lvim.keys.normal_mode["<A-,>"] = "$a;<Esc>"
-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["??"] = {
	"<cmd>:g/^$/d<cr>",
	"Whitespaces",
}
lvim.builtin.which_key.mappings["m"] = {
	name = "Fugitive",
	a = { "<cmd>:G<cr>", "Status" },
	c = { "<cmd>:G commit<cr>", "Commit" },
	p = { "<cmd>:G push<cr>", "Push" },
	u = { "<cmd>:G pull<cr>", "Pull" },
}
lvim.builtin.which_key.mappings["."] = {
	name = "Dap_Debug",
	A = { "<cmd>lua require'debugHelper'.attachToRemote()<cr>", "AttachToRemote" },
	a = { "<cmd>lua require'debugHelper'.attach()<cr>", "Attach" },
	b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
	c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
	i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
	o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
	O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
	r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
	l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
	u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
	x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
	s = { "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<cr>", "Scopes" },
	p = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Scopes" },
	H = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Set Breakpoint" },
	n = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to cursor" },
	R = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear Breakpoints" },
	e = { "<cmd>lua require'dap'.set_exception_breakpoints({})<cr>", "Set Exception Breakpoints" },
	h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover" },
	k = { "<cmd>lua require'dap'.up()<cr>zz", "Up" },
	j = { "<cmd>lua require'dap'.down()<CR>zz]", "Down" },
}
-- javascript_dap
local dap = require("dap")
dap.adapters.node2 = {
	type = "executable",
	command = "node",
	-- args = { os.getenv "HOME" .. "/vscode-node-debug2/out/src/nodeDebug.js" },
	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}
dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}
-- lag_solution
local augroup = vim.api.nvim_create_augroup
ThePrimeagenGroup = augroup("ThePrimeagen", {})
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- treesitter

lvim.builtin.treesitter.rainbow = {
	enable = true,
	extended_mode = false,
	colors = {
		"DodgerBlue",
		"Orchid",
		"Gold",
	},
	disable = { "html" },
}

-- hop

local status_ok, hop = pcall(require, "hop")
if not status_ok then
	return
end
hop.setup()
vim.api.nvim_set_keymap("", "s", ":HopChar2<cr>", { silent = true })
vim.api.nvim_set_keymap("", "S", ":HopWord<cr>", { silent = true })

-- null-ls_timeout

lvim.builtin.which_key.mappings["l"]["f"] = {
	function()
		require("lvim.lsp.utils").format({ timeout_ms = 5000 })
	end,
	"Format",
}

-- lvim.transparent_window = true
lvim.builtin.which_key.mappings["c"] = {
	"<cmd>BufferKill<CR><cmd>:q!<CR>",
	"Close Buffer",
}
