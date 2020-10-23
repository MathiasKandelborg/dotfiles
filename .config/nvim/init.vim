" Vim Plug
" Specify a directory for plugins
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" Language Detection
" Plug 'google/vim-maktaba'
"Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" Plug 'google/vim-glaive'
Plug 'jreybert/vimagit'
Plug 'preservim/nerdtree' |
			\ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Colors and statusbar
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'dylanaraps/wal'
Plug 'sheerun/vim-polyglot'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
 " WIKIIII
Plug 'vimwiki/vimwiki'
" Functionality
Plug 'Quramy/vim-js-pretty-template'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
" Plug 'Shougo/vimproc.vim',  {'do' : 'make'}
call plug#end()
" NATIVE SETTINGS
" set mouse+=a " Not good for my arm

" Set leader to <space>
let mapleader = " "

" Always set a window title
set title

set encoding=utf-8
set re=0
set nocompatible
set awa
set aw
" Get plugin configuration options
filetype plugin on

" Make search better
set incsearch ignorecase smartcase hlsearch
set wildmode=longest,list,full

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see coc.nvim #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

"
"VISUAL / UI
"

set noruler
" Show linenumber and make them relative!
set number relativenumber

" Give more space for displaying messages.
set cmdheight=2

" Wrap text beyond the 80 column mark to the next line (visually, this has no effect on actual lines in the file)
set wrap breakindent
" Don't start a comment on next line, if currently on a commented line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Show trailing characters
set list listchars=trail:»,tab:»-
set fillchars+=vert:┃

" Split to bottom and right, as sane people think it would
set splitbelow splitright

"
" COLORS
"
" Colors are made by generating a color scheme based on a picture.
" This functionality is enabled through https://github.com/dylanaraps/pywal

" Enable syntax coloring
syntax enable
syntax on

" Use patched fonts
" WARNING: You need powerline fonts installed
let g:airline_powerline_fonts = 1
" WARNING: You need NERDTree installed
let g:NERDTreeGitStatusUseNerdFonts = 1

" Usa the wal colortheme
colorscheme wal
" WARNING: Need airline + airline-themes installed (customized airline-themes/wal file)
let g:airline_theme='wal'

" NERDTree Highlight curent line
" INFO: Setting this off can improve NERDTree performance
let NERDTreeHighlightCursorline = 1

" Make custom highlights after declaring other colors, they might override
hi CursorColumn ctermbg=4 ctermfg=7 guibg=4
" Highlight current line number
hi CursorLineNr ctermfg=12

" Highlight trailing whitespace
hi link ExtraWhitespace Comment

" Make floating menu have proper colors
hi Pmenu ctermfg=3 ctermbg=0 guibg=0

" Set concealment color for Goyo/Limelight
let g:limelight_conceal_ctermfg = 8
let g:limelight_conceal_guifg = 8

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Always show the signcolumn, otherwise it would shift the text each time
" symbols appear/become resolved.
if has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one:
	set signcolumn=number
else
	set signcolumn=yes
endif

"
" AIRLINE
"

" Remove buffers from bottom, show them on top to make space for plugins
let g:airline#extensions#tabline#enabled = 1

" Do not display empty sections
" INFO: Setting this off may slightly improve performance
let g:airline_skip_empty_sections = 1

" Display CoC warnings in airline
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'Err:'
let airline#extensions#coc#warning_symbol = 'Warn:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

"
" PLUGINS
"

" Do delete untracked files when pressing DDD in Magit
let g:magit_discard_untracked_do_delete=1

" Fuzzy finder preview command
let g:fzf_preview_command = 'bat --color=always --plain {-1}'

" Pretiier formatting
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1

" use clang-format for C family files
augroup autoformat_settings
	autocmd FileType c,cpp,proto,arduino AutoFormatBuffer clang-format
augroup END

" Autoclose tags e.g. <div> in following files
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.ts,*.tsx,*.jsx'

" Goyo!!
function! s:goyo_enter()
	set noshowmode
	set noshowcmd
	set scrolloff=999
	Limelight
endfunction

function! s:goyo_leave()
	set showmode
	set showcmd
	set scrolloff=5
	Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" NerdCommenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
" let g:NERDDefaultAlign = 'left'

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1


"
" MAPS & REMAPS
"

" Map w!! to writing current buffer as sudo
cnoremap w!! execute 'silent! write sudo tee % >/dev/null' <bar> edit!
" Edit this configration
nnoremap <Leader>ve :e $MYVIMRC<CR>
" Reload this configuration
nnoremap <Leader>vr :source $MYVIMRC<CR>

map <C-x> :NERDTreeToggle<CR>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" fzf-preview
nmap <C-p> [fzf-p]
xmap <C-p> [fzf-p]

nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.ProjectFiles<CR>
nnoremap <silent> [fzf-p]a     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>


" CoC Settings
"


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocActionAsync('doHover')
	endif
endfunction


" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
"	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent<nowait> <space>p  :<C-u>CocListResume<CR>>

" -----------------------------------------------------------------------
" UPDATE FILE WHEN WRITTEN. TRY AND ALWAYS SHOW UPDATED INFORMATION

augroup AutoSwap
	autocmd!
	autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

function! AS_HandleSwapfile (filename, swapname)
	" if swapfile is older than file itself, just get rid of it
	if getftime(v:swapname) < getftime(a:filename)
		call delete(v:swapname)
		let v:swapchoice = 'e'
	endif
endfunction
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
			\ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

augroup checktime
	au!
	if !has("gui_running")
		"silent! necessary otherwise throws errors when using command
		"line window.
		autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
	endif
augroup END

" Futher ensure the current file is updated when it's updated:
luafile $XDG_CONFIG_HOME/nvim/watch_file.lua

" -----------------------------------------------------------------------
