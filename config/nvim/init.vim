:set number 
:set relativenumber 
:set autoindent
:set smarttab
:set mouse+=a
:set syntax=on
:set clipboard+=unnamedplus
:set tabstop=4
:set shiftwidth=4
:set softtabstop=4
:set expandtab
"автоподстановка
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"плагины
call plug#begin()
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/folke/tokyonight.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'romgrk/barbar.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
"Plug 'mhinz/vim-startify'
Plug 'https://github.com/goolord/alpha-nvim'
"Plug 'andweeb/presence.nvim'
call plug#end()
"тема
colorscheme gruvbox
"let g:airline_theme='deus'
"barbar
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:true
let bufferline.auto_hide = v:true
let bufferline.highlight_alternate = v:true
let bufferline.highlight_inactive_file_icons = v:true
let bufferline.icons = v:true
"конфиг закладок
let bufferline.icon_separator_active = '▎'
let bufferline.icon_separator_inactive = '▎'
let bufferline.icon_close_tab = ''
let bufferline.icon_close_tab_modified = '●'
let bufferline.icon_pinned = '車'
"бинды nerdtree
nnoremap <C-t> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
"бинды выход
"nnoremap <C-r> :wq<CR>
"nnoremap <C-y> :qa<CR>
"бинды telescope
nnoremap <C-f> :Telescope find_files<CR>
nnoremap <C-r> :Telescope oldfiles<CR>
"скрытые файлы nerdtree 
let NERDTreeShowHidden=1
"картинка
"let g:startify_custom_header = [
"            \ '███╗   ██╗██╗   ██╗      ██╗██████╗ ███████╗',
"            \ '████╗  ██║██║   ██║      ██║██╔══██╗██╔════╝',
"            \ '██╔██╗ ██║██║   ██║█████╗██║██║  ██║█████╗',
"            \ '██║╚██╗██║╚██╗ ██╔╝╚════╝██║██║  ██║██╔══╝',
"            \ '██║ ╚████║ ╚████╔╝       ██║██████╔╝███████╗',
"            \ '╚═╝  ╚═══╝  ╚═══╝        ╚═╝╚═════╝ ╚══════╝',
"            \ ]
"панель
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#formatter = 'unique_tailo'
"кодировка
set encoding=UTF-8
"lua config
lua << EOF
--alpha
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
' ▄▄    ▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄   ',
'█  █  █ █       █       █  █ █  █   █  █▄█  █  ',
'█   █▄█ █    ▄▄▄█   ▄   █  █▄█  █   █       █  ',
'█       █   █▄▄▄█  █ █  █       █   █       █  ',
'█  ▄    █    ▄▄▄█  █▄█  █       █   █       █  ',
'█ █ █   █   █▄▄▄█       ██     ██   █ ██▄██ █  ',
'█▄█  █▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█ █▄▄▄█ █▄▄▄█▄█   █▄█  ',

}
dashboard.section.buttons.val = {
    dashboard.button( "o", "  > Open file manager", ":NERDTree<CR>" ),
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":cd $HOME/ | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}

--Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
--telescope
require("telescope").setup { 
    pickers = {
        live_grep = {
            additional_args = function(opts)
            end
        },
    },
}
--treesitter
require'nvim-treesitter.configs'.setup {
   ensure_installed = { "javascript", "lua", "cpp" },

    sync_install = false,

    auto_install = false,

    ignore_install = { "python" },

 
  highlight = {
       enable = true,


    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

       additional_vim_regex_highlighting = false,
  },
}
--indent_blankline
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}
--выпадающее меню coc.nvim
-- highlight
-- for custom pop menu
vim.api.nvim_set_hl(0, "CocCustomPopup", { fg = "#ebdbb2", bg = "#282828" })
-- border
vim.api.nvim_set_hl(0, "CocCustomPopupBoder", { fg = "#5F5F5F", bold = true })
-- selected row
vim.api.nvim_set_hl(0, "CocMenuSel", { bg = "#3c3836", bold = true })
-- matched_text
vim.api.nvim_set_hl(0, "CocSearch", { fg = "#fabd2f" })
-- unused code
vim.api.nvim_set_hl(0, "CocUnusedHighlight", { underline = true })
--lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
		  lualine_a = { 'mode'},
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {},
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
--discord
--require("presence").setup({
--auto_update         = true,
--neovim_image_text   = "The One True Text Editor",
--main_image          = "neovim", 
--client_id           = "793271441293967371",
--log_level           = nil,
--debounce_timeout    = 10,
--enable_line_number  = true,
--blacklist           = {},
--buttons             = true,
--file_assets         = {},
--show_time           = true,
--editing_text        = "Editing %s",
--file_explorer_text  = "Browsing %s",
--git_commit_text     = "Committing changes",
--plugin_manager_text = "Managing plugins",
--reading_text        = "Reading %s",
--workspace_text      = "Working on %s",
--line_number_text    = "Line %s out of %s",
--})
EOF
