
return {
	"folke/lazy.nvim",
	{
		"catppuccin/nvim",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = {
					light = "latte",
					dark = "mocha",
				},
				integrations = {
					noice = true
				}
			})
			vim.cmd([[colorscheme catppuccin]])
		end
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			'catppuccin/nvim',
			"SmiteshP/nvim-navic",
		},
		config = function()
			local colors = require("catppuccin.palettes").get_palette()

			local theme = {
				normal = {
					a = { fg = colors.base, bg = colors.mauve },
					b = { fg = colors.text, bg = colors.surface1 },
					c = { fg = colors.text },
				},

				insert = { a = { fg = colors.base, bg = colors.lavender } },
				visual = { a = { fg = colors.base, bg = colors.teal } },
				replace = { a = { fg = colors.base, bg = colors.red } },
				command = { a = { fg = colors.base, bg = colors.rosewater } },

				inactive = {
					a = { fg = colors.text, bg = colors.surface1 },
					b = { fg = colors.text, bg = colors.surface0 },
					c = { fg = colors.text },
				},
			}

			local function indentation()
				local indent_type = vim.opt.expandtab:get() and 'spaces' or 'tabs'
				return indent_type .. ': ' .. (vim.opt.shiftwidth:get() or vim.opt.tabstop:get())
			end

			local function breadcrumbs()
				return require('nvim-navic').get_location()
			end

			local filename_section = {
				'filename',
				path = 4,
				symbols = {
					modified = '',
					readonly = '',
					unnamed = '(unnamed) ',
					newfile = '(new file) ',
				}
			}

			require("lualine").setup({
				options = {
					theme = theme,
					component_separators = '│',
					section_separators = { left = '', right = '' },
					icons_enabled = true,
				},
				sections = {
					lualine_a = { { 'mode', separator = { left = '', right = '' }, right_padding = 2 } },
					lualine_b = {
						require('auto-session.lib').current_session_name,
						'branch',
						{
							'diff',
							symbols = {
								modified = '±',
							}
						}
					},
					lualine_c = {
						{
							'diagnostics',
							symbols = {
								error = '',
								warn = '',
								info = '',
								hint = ''
							},
						}
					},
					lualine_x = { breadcrumbs },
					lualine_y = {
						filename_section,
						'filetype',
						indentation
					},
					lualine_z = {
						{ 'location', separator = { right = '' }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = {
						{ require('auto-session.lib').current_session_name, separator = { left = '', right = '' }, right_padding = 2 },
						'branch'
					},
					lualine_b = {
						{
							'diff',
							symbols = {
								modified = '±',
							}
						}
					},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {
						filename_section,
					},
					lualine_z = {
						{ 'location', separator = { right = '' }, left_padding = 2 }
					}
				}
			})
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },

	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				presets = {
					command_palette = true
				}
			})
		end
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,

		opts = {
			preset = "helix",

			spec =  {
				{ "<leader><leader>", ":", desc = "Commands" },
				{ "<leader>w", group = "Window" },
				{ "<leader>ws", "<Cmd>split<CR>", desc = "Split" },
				{ "<leader>wv", "<Cmd>vsplit<CR>", desc = "VSplit" },
			}
		}
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}},
	{
		'rmagatti/auto-session',
		dependencies = {
			-- 'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
		},
		config = function()
			require('auto-session').setup({
				auto_session_suppress_dirs = { '~/', '~/Code', '~/Downloads', '/' },
				cwd_change_handling = {
					restore_upcoming_session = true, -- Disabled by default, set to true to enable
					pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
					post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
						require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
					end,
				},

			})
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup {
			}
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects', -- Add treesitter groups as textobjects
		},
		lazy = true,
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { "typescript", "javascript", "lua" },
				auto_install = true,
				highlight = {
					enable = true
				},
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["av"] = "@assignment.outer",
							["iv"] = "@assignment.inner",
							["as"] = "@statement.outer",
							["a?"] = "@conditional.outer",
							["i?"] = "@conditional.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ia"] = "@parameter.inner",
							["aa"] = "@parameter.outer",
							["i/"] = "@regex.inner",
							["a/"] = "@regex.outer",
						},
					}
				},
				matchup = {
					enable = true
				}
			}
		end
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = { 'hrsh7th/cmp-nvim-lsp' },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			require('lspconfig').tsserver.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = require('lspconfig').util.find_package_json_ancestor,
				single_file_support = false,
				init_options = {
					hostInfo = 'neovim',
					preferences = {
						disableSuggestions = true
					}
				}
			})
		end
	},
	{
		'hrsh7th/nvim-cmp',
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',                -- Use LSP for autocompletion
			'hrsh7th/cmp-nvim-lsp-signature-help', -- View function signature when filling parameters
			'hrsh7th/cmp-buffer',                  -- Autocompletion for strings in buffer
			'hrsh7th/cmp-path',                    -- Autocompletion for file paths
			'hrsh7th/cmp-cmdline',                 -- Autocompletion for vim's cmdline
		},
		config = function()
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			local cmp = require('cmp')

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
					['<S-CR>'] = function(fallback)
						cmp.abort()
						fallback()
					end,
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'buffer' },
					{ name = 'path' },
				})
			})
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})
		end
	},
	{
		"lewis6991/hover.nvim",
		config = function()
			require("hover").setup {
				init = function()
					require("hover.providers.lsp")
					require('hover.providers.gh')
					require('hover.providers.gh_user')
					require('hover.providers.jira')
					-- require('hover.providers.dap') TODO enable when you've set up DAP
					require('hover.providers.diagnostic')
				end,
				preview_opts = {
					border = 'single'
				},
				preview_window = false,
				title = true,
				mouse_providers = {
					'LSP',
					'Diagnostics',
				},
				mouse_delay = 1000
			}


			vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
			vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
			vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, {desc = "hover.nvim (previous source)"})
			vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, {desc = "hover.nvim (next source)"})


			vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
			vim.o.mousemoveevent = true
		end
	},
	"tpope/vim-sleuth",
	"tpope/vim-vinegar",
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"sindrets/diffview.nvim",        -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			require("neogit").setup({
				kind = "auto",
			})
		end
	}
}
