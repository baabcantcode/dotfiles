return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,

        lazy = false,
		opts = {

			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			lazy = true,
			opt = true,
		},
        lazy = false,
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
}
