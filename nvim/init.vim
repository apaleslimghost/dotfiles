call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'junegunn/vim-slash'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

Plug 'pangloss/vim-javascript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'hail2u/vim-css3-syntax'
Plug 'neoclide/vim-jsx-improve'
Plug 'kchmck/vim-coffee-script'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-sleuth'
Plug 'moll/vim-bbye'
Plug 'roman/golden-ratio'
Plug 'bfrg/vim-jqplay'

Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'

Plug '~/Projects/aura'
" Plug '~/Projects/etherline'

call plug#end()

colorscheme aura-dark

set fillchars+=vert:│
set updatetime=100
set signcolumn=yes
set number
set noshowmode
set list
set listchars=eol:⁋,tab:┊\ \ ,space:∙,extends:⤸,precedes:⤹
set shortmess+=c

set tabstop=3
set shiftwidth=3
set noexpandtab

set smartcase
set ignorecase

set hidden
set autoread

set cursorline

set splitbelow splitright

set wildmode=longest:full,full

" fucking, you what CoC
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup TerminalStuff
	au!
	autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no nolist
	autocmd BufEnter term://* startinsert
augroup END

let g:startify_custom_header = startify#pad([
			\ '┌─╮ ╭─╮ ╭─╮ ╷ ╷ ╷ ┌─┬─╮',
			\ '│ │ ├─╯ │ │ │╭╯ │ │ │ │',
			\ '╵ ╵ ╰─  ╰─╯ └╯  ╵ ╵   ╵' ])
let g:startify_enable_special = 0
let g:startify_change_to_vcs_root = 1
let g:startify_session_sort = 1
let g:startify_session_persistence = 1

let g:golden_ratio_autocommand = 0

function! OpenProject(root)
	let project = fnamemodify(a:root, ':p:s!/$!!:t')
	call startify#session_load(0, project)

	if empty(v:this_session)
		execute 'lcd' a:root
		execute 'e' a:root
		call startify#session_save(1, project)
	end
endfunction

function! GetProject()
	return fnamemodify(v:this_session, ':t:r')
endfunction

command! -complete=dir -bang -nargs=1 Project call OpenProject(<f-args>)

let g:lightline = {
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'filename', 'readonly', 'modified' ],
\             [ 'fugitive', 'session', 'diagnostics' ] ]
\ },
\ 'component_function': {
\   'session': 'GetProject',
\   'diagnostics': 'coc#status',
\   'fugitive': 'FugitiveHead'
\ },
\ 'mode_map': {
\   'n': '№',
\   'i': '✍︎',
\   'v': '⌶',
\   'V': '⍖',
\   "\<C-v>": '⍆',
\   'c': '⚙︎',
\   's': '⎁',
\   'S': '⎀',
\   "\<C-s>": '⎂',
\   't': '⎚'
\ }
\ }

hi CocErrorHighlight cterm=underline gui=undercurl guisp=red
hi CocWarningHighlight cterm=underline gui=undercurl guisp=orange
hi VertSplit gui=NONE

let g:which_key_use_floating_win = 0
augroup Which
	au!
	autocmd FileType which_key setlocal nonumber norelativenumber signcolumn=no nolist
	autocmd FileType which_key highlight WhichKeyFloating guibg=bg
augroup END

augroup Fugitive
  au!
  autocmd FileType fugitive setlocal nonumber norelativenumber signcolumn=no nolist
augroup END

hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
let g:fzf_command_prefix = 'Fzf'

function! FloatingFZF()
	let height = float2nr(&lines / 2)
	let width = float2nr(&columns * 2 / 3)
	let col = float2nr((&columns - width) / 2)
	let row = float2nr((&lines - height) / 2)

	let top = '╭' . repeat('─', width - 2) . '╮'
	let mid = '│' . repeat(' ', width - 2) . '│'
	let bot = '╰' . repeat('─', width - 2) . '╯'
	let lines = [top] + repeat([mid], height - 2) + [bot]

	let opts = {
				\ 'relative': 'editor',
				\ 'row': row,
				\ 'col': col,
				\ 'width': width,
				\ 'height': height,
				\ 'style': 'minimal'
				\ }

	let s:b_buf = nvim_create_buf(v:false, v:true)
	call nvim_buf_set_lines(s:b_buf, 0, -1, v:true, lines)
	call nvim_open_win(s:b_buf, v:true, opts)

	set winhl=Normal:Floating
	let opts.row += 1
	let opts.height -= 2
	let opts.col += 2
	let opts.width -= 4
	let s:f_buf = nvim_create_buf(v:false, v:true)
	call nvim_open_win(s:f_buf, v:true, opts)
	augroup fzf_preview_floating_window
		autocmd WinLeave <buffer> silent! execute 'bdelete! ' . s:f_buf . ' ' . s:b_buf
	augroup END
endfunction

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang FzfRipgrep call RipgrepFzf(<q-args>, <bang>0)

command! -bang FzfSession call fzf#vim#files('~/.local/share/nvim/session', {'sink': 'SLoad'})
command! -bang FzfOpenProject call fzf#run(fzf#wrap({ 'source': 'fd -d 1 -t d . ~/Projects ~/Work', 'sink': 'Project'}, <bang>0))
command! -bang FzfBranches call fzf#run(fzf#wrap({ 'source': 'git branch --format="%(refname:short)"', 'sink': 'Git checkout'}, <bang>0))

function! Input(prompt, ...)
  call inputsave()
  let response = input(a:prompt . ' ', get(a:, 1, ''))
  call inputrestore()
  redraw
  return response
endfunction

function! CreateBranch()
  exec 'Git checkout -b' Input('⋌ new branch:')
endfunction

function! QuickCommit()
  exec 'silent Gcommit -am "' . Input('⊶ commit message:') . '"'
endfunction

function! Clone()
	let repo_url = Input('⎘ repo url:')
	let default_path = '~/Projects/' . fnamemodify(repo_url, ':t:r')
	let path = fnamemodify(Input('⎘ clone path:', default_path), ':p')
	exec 'Git clone' repo_url path
	exec 'Project' path
endfunction

let mapleader = "\<Space>"
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>

let g:which_key_map = {
			\ '/': ['FzfRipgrep', 'find'],
			\ "'": ['terminal', 'terminal'],
			\ ' ': ['FzfCommands', 'commands']
			\}

let g:which_key_map.f = {
			\ 'name': '+file',
			\ 's': ['w', 'save'],
			\ 'c': ['e', 'create'],
			\ 'f': ['FzfGitFiles', 'find files']
			\}

let g:which_key_map.w = {
			\ 'name': '+window',
			\ 'v': ['vs', 'split vertical'],
			\ 's': ['sp', 'split horizontal'],
			\ 'd': ['q', 'close'],
			\ 'o': ['<C-w>o', 'close others'],
			\ '=': ['<C-w>=', 'normalise sizes'],
			\ '+': ['GoldenRatioResize', 'golden ratio']
			\}

let g:which_key_map.b = {
			\ 'name': '+buffer',
			\ 'd': ['Bdelete', 'close'],
			\ 'b': ['FzfBuffers', 'preview']
			\}

let g:which_key_map.g = {
			\ 'name': '+git',
			\ 's': [':vert Git', 'status'],
			\ 'h': {
			\  'name': '+github',
			\  'o': ['Gbrowse', 'browse']
			\ },
			\ 'm': {
			\  'name': '+fugitive',
			\  'b': {'name': '+branch', 'b': ['FzfBranches', 'checkout'], 'c': [':call CreateBranch()', 'create']},
			\  'c': {'name': '+commit', 'c': ['Gcommit', 'create'], 'C': [':call QuickCommit()', 'quick commit']}
			\ }
			\}

let g:which_key_map.p = {
			\ 'name': '+project',
			\ 'p': ['FzfSession', 'preview'],
			\ 'f': ['FzfGitFiles', 'files'],
			\ 'c': ['FzfOpenProject', 'open'],
			\ 'd': ['SClose', 'close']
			\}

