return {
	{ "folke/tokyonight.nvim", opts = {
		lazy = false,
	} },
	"folke/neodev.nvim",
	{
		"folke/which-key.nvim",
		opts = {},
		config = function(_, opts)
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup(opts)
		end,
	},
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
		},
		opts = {
			file_ignore_patterns = {
				".git/*",
				".node_modules/*",
				".cache",
				"%.o",
				"%.a",
				"%.out",
				"%.class",
				"%.pdf",
				"%.mkv",
				"%.mp4",
				"%.zip",
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzy_native")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			lazy = true,
			opt = true,
		},
		opts = {
			filters = {
				dotfiles = false,
			},
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,

			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				adaptive_size = false,
				side = "left",
				width = 30,
				preserve_window_proportions = true,
			},
			git = {
				enable = false,
				ignore = true,
			},
			filesystem_watchers = {
				enable = true,
			},
			actions = {
				open_file = {
					resize_window = true,
				},
			},
			renderer = {
				root_folder_label = false,
				highlight_git = false,
				highlight_opened_files = "none",
				indent_markers = {
					enable = false,
				},

				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = false,
					},
					glyphs = {
						default = "󰈚",
						symlink = "",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
							symlink_open = "",
							arrow_open = "",
							arrow_closed = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-tree").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
					local opts = require("lazy.core.plugin").values(plugin, "opts", false)
					local enabled = false
					if opts.textobjects then
						for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
							if opts.textobjects[mod] and opts.textobjects[mod].enable then
								enabled = true

								break
							end
						end
					end
					if not enabled then
						require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					end
				end,
			},
		},
		opts = {
			ensure_installed = "all",

			highlight = {
				enable = true,
				use_languagetree = true,
			},
			indent = {
				enable = true,
			},
			autotag = {
				enable = true,
			},

			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			refactor = {
				highlight_definitions = {
					enable = true,
				},
				highlight_current_scope = {

					enable = false,
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x", opts = { autoformat = false } },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "williamboman/mason.nvim" },
	{

		-- Statusline
		-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
		"nvim-lualine/lualine.nvim",
		config = function(_)
			local lualine = require("lualine")
			local lualine_require = require("lualine_require")

			local function loadcolors()
				local colors = require("tokyonight.colors")

				-- Try to load pywal colors
				local modules = lualine_require.lazy_require({
					utils_notices = "lualine.utils.notices",
				})
				local sep = package.config:sub(1, 1)

				local wal_colors_path = table.concat({ os.getenv("HOME"), ".cache", "wal", "colors.sh" }, sep)
				local wal_colors_file = io.open(wal_colors_path, "r")

				if wal_colors_file == nil then
					modules.utils_notices.add_notice("lualine.nvim: " .. wal_colors_path .. " not found")

					return colors
				end

				local ok, wal_colors_text = pcall(wal_colors_file.read, wal_colors_file, "*a")
				wal_colors_file:close()

				if not ok then
					modules.utils_notices.add_notice(
						"lualine.nvim: " .. wal_colors_path .. " could not be read: " .. wal_colors_text
					)
					return colors
				end

				local wal = {}

				for line in vim.gsplit(wal_colors_text, "\n") do
					if line:match("^[a-z0-9]+='#[a-fA-F0-9]+'$") ~= nil then
						local i = line:find("=")
						local key = line:sub(0, i - 1)
						local value = line:sub(i + 2, #line - 1)
						wal[key] = value
					end
				end

				-- Color table for highlights
				colors = {
					bg = wal.background,
					fg = wal.foreground,
					yellow = wal.color3,
					cyan = wal.color4,
					black = wal.color0,
					green = wal.color2,
					white = wal.color7,
					magenta = wal.color5,
					blue = wal.color6,
					red = wal.color1,
				}

				return colors
			end

			local colors = loadcolors()

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,

				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			-- Config
			local config = {
				options = {
					-- Disable sections and component separators
					component_separators = "",
					section_separators = "",
					disabled_filetypes = { "Lazy", "NvimTree" },
					theme = {

						-- We are going to use lualine_c an lualine_x as left and
						-- right section. Both are highlighted by c theme .  So we
						-- are just setting default looks o statusline
						normal = {
							c = {
								fg = colors.fg,
								bg = colors.bg,
							},
						},

						inactive = {
							c = {
								fg = colors.fg,
								bg = colors.bg,
							},
						},
					},
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},

					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			-- Inserts a component in lualine_c at left section
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			-- Inserts a component in lualine_x ot right section
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			ins_left({
				-- mode component
				function()
					return "▶"
				end,
				color = function()
					-- auto change color according to neovims mode
					local mode_color = {
						n = colors.red,
						i = colors.green,
						v = colors.blue,
						[""] = colors.blue,
						V = colors.blue,
						c = colors.magenta,
						no = colors.red,
						s = colors.yellow,
						S = colors.yellow,
						[""] = colors.yellow,
						ic = colors.yellow,
						R = colors.white,

						Rv = colors.white,
						cv = colors.red,
						ce = colors.red,

						r = colors.cyan,
						rm = colors.cyan,
						["r?"] = colors.cyan,
						["!"] = colors.red,
						t = colors.red,
					}
					return {
						fg = mode_color[vim.fn.mode()],
					}
				end,
			})

			ins_left({
				"filename",
				cond = conditions.buffer_not_empty,
				color = {

					fg = colors.magenta,
					gui = "bold",
				},
			})

			ins_left({

				"branch",
				icon = " ",
				color = {

					fg = colors.blue,
					gui = "bold",
				},
			})

			ins_left({
				"diff",
				-- Is it me or the symbol for modified us really weird
				symbols = {
					added = " ",

					modified = " ",
					removed = " ",
				},
				diff_color = {
					added = {
						fg = colors.green,
					},
					modified = {
						fg = colors.yellow,
					},
					removed = {
						fg = colors.red,
					},
				},
				cond = conditions.hide_in_width,
			})

			-- Insert mid section. You can make any number of sections in neovim :)
			-- for lualine it"s any number greater then 2
			ins_left({
				function()
					return "%="
				end,
			})

			ins_right({
				-- Lsp server name .
				function()
					local msg = "null"
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = " LSP:",
				color = {

					fg = colors.cyan,
					gui = "bold",
				},
			})

			ins_right({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hints = "󰛩 ",
				},
				diagnostics_color = {
					color_error = {
						fg = colors.red,
					},
					color_warn = {
						fg = colors.yellow,
					},
					color_info = {
						fg = colors.cyan,
					},
					color_hints = {
						fg = colors.magenta,
					},
				},

				always_visible = true,
			})

			ins_right({
				"o:encoding", -- option component same as &encoding in viml
				fmt = string.upper,
				cond = conditions.hide_in_width,
				color = {
					fg = colors.green,
					gui = "bold",
				},
			})

			ins_right({
				"fileformat",
				fmt = string.upper,
				icons_enabled = true,
				color = {
					fg = colors.green,
					gui = "bold",
				},
			})

			ins_right({
				"location",
				color = {

					fg = colors.fg,
					gui = "bold",
				},
			})

			ins_right({
				"progress",

				color = {
					fg = colors.fg,
					gui = "bold",
				},
			})

			-- Now don"t forget to initialize lualine
			lualine.setup(config)
		end,
	},
	{
		-- Git integration for buffers
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = {
					hl = "GitSignsAdd",
					text = "│",
					numhl = "GitSignsAddNr",
					linehl = "GitSignsAddLn",
				},
				change = {
					hl = "GitSignsChange",
					text = "│",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = {
					hl = "GitSignsDelete",
					text = "_",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				topdelete = {
					hl = "GitSignsDelete",
					text = "‾",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "~",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				untracked = {
					hl = "GitSignsAdd",
					text = "┆",
					numhl = "GitSignsAddNr",
					linehl = "GitSignsAddLn",
				},
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
				delay = 1000,

				ignore_whitespace = false,
			},
			current_line_blame_formatter_opts = {
				relative_time = false,
			},
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000,
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",

				relative = "cursor",
				row = 0,
				col = 1,
			},

			yadm = {
				enable = false,
			},
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
	{ -- Floating terminal
		"itmecho/neoterm.nvim",
		opts = {
			clear_on_run = true, -- run clear command before user specified commands
			mode = "horizontal", -- vertical/horizontal/fullscreen
			noinsert = false, -- disable entering insert mode when opening the neoterm window
		},
		config = function(_, opts)
			require("neoterm").setup(opts)
		end,
	},
	{
		"numToStr/Comment.nvim",

		opts = {
			toggler = {
				line = "<C-/>",
			},
			-- add any options here
		},
		opleader = {
			line = "gc",
			block = "gb",
		},
		lazy = false,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,

		opts = {

			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = {
			theme = "hyper",
		},
		config = function(_, opts)
			require("dashboard").setup(opts)
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
