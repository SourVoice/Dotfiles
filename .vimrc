" =============
" BasicSetting
" =============
  

" set everyline with number
set number
" Show line number on the current line and relative numbers on all other lines.
set relativenumber
" will not carrage return when line within symbol below
set iskeyword+=_,$,@,%,#,-,/
" switch no line wrap
set nowrap

" shift and tab setting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Enable mouse support
set mouse=a
" Disable noerrorbells
set noerrorbells visualbell t_vb=
" Highlight the line currently under cursor.
" set cursorline
" enable hightlight searching
set hlsearch
" See ":help leader" for more information.
let mapleader = ","

set encoding=utf-8
set hidden
set nobackup
set nowritebackup
" set cmdheight=2

" Proper Search
set incsearch
set ignorecase
set smartcase
set gdefault

" Status Bar
" default the statusline to green when entering Vim
" hi statusline guifg=Blue ctermfg=8 guifg=Blue ctermbg=15
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=Blue ctermfg=8 guifg=White ctermbg=15


set laststatus=2
" set statusline=
" set statusline+=%#PmenuSel#
" set statusline+=%{StatuslineGit()}
" set statusline+=%#LineNr#
" set statusline+=\ %f
" set statusline+=%m\
" set statusline+=%=
" set statusline+=%#CursorColumn#
" set statusline+=\ %y                    " Filetype
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\[%{&fileformat}\]
" set statusline+=\ %p%%                  " Percentage
" set statusline+=\ %l:%c                 " Line number: Column relative
" set statusline+=\


function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
"if has("nvim-0.5.0") || has("patch-8.1.1564")
"  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes:1
"endif
set signcolumn=yes


" Open file remember history status
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif
endif

" Popup menu color, see :help hi /PmenuSel
" colors ron
" hi PmenuSul ctermbg=LightRed

" =====================Customize colors=====================
func! s:my_colors_setup() abort
    " this is an example
    hi Pmenu guibg=#d7e5dc gui=NONE
    hi PmenuSel guibg=#b7c7b7 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858
endfunc

augroup colorscheme_coc_setup | au!
    au ColorScheme * call s:my_colors_setup()
augroup END

au ColorScheme * hi! link CocMenuSel PmenuSel
au ColorScheme * hi! link CocPumMenu Pmenu
au ColorScheme * hi! link CocPumVirtualText Comment


" =====================Customize Functions=====================

" use <leader> y to translate 
nmap <leader>y :!echo --=<C-R><C-w>==-- ;ici <C-R><C-W><CR>


" =====================KeyBinding=====================


" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>
" nmap R <Nop>


" back to normal mod
" set 'jj' into normal mod
inoremap jj <esc>

nnoremap <C-[> <esc>
vnoremap <C-[> <esc>
snoremap <C-[> <esc>
xnoremap <C-[> <esc>
onoremap <C-[> <esc>

" ========================Window Managemnt=========================

" Navigate window
nnoremap <silent> <space>h <C-w>h
nnoremap <silent> <space>l <C-w>l
nnoremap <silent> <space>j <C-w>j
nnoremap <silent> <space>k <C-w>k

" Resize split screen
nmap <silent><nowait> <leader>j :res +5<CR>
nmap <silent><nowait> <leader>k :res -5<CR>
nmap <silent><nowait> <leader>l :vertical res-5<CR>
nmap <silent><nowait> <leader>h :vertical res+5<CR>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap <leader>u :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap <leader>o :set splitbelow<CR>:split<CR>
noremap <leader>p :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap <leader>i :set splitright<CR>:vsplit<CR>


" ========================Tab Managemnt=========================

" Open a NewTab with tu
noremap tu :tabnew<CR>
noremap tU :tab split<CR>
" Move around tabs with tn and tp
noremap tn :+tabnext<CR>
noremap tp :-tabnext<CR>
" Move the tabs with tmn and tmp
noremap tmn :+tabmove<CR>
noremap tmp :-tabmove<CR>
" Close current tab
noremap tc <C-w>c


" ========================Cursor support=========================


noremap <silent> E 5j
noremap <silent> W 5k
" <Ctrl-h>: go to the start of the line
noremap <silent><nowait> <C-h> ^
" <Ctrl-l>: go to the end of the line
noremap <silent><nowait> <C-l> $


" =============
" PluginManager
" =============


" use vim-plug to manage, install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" =============
" PluginBegin
" =============


call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" file explore
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" fast commenter 
Plug 'scrooloose/nerdcommenter'

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" use git in vim
Plug 'tpope/vim-fugitive'

" git diff in vim
Plug 'airblade/vim-gitgutter'

Plug 'ryanoasis/vim-devicons'

" icon for nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" highlight
Plug 'jackguo380/vim-lsp-cxx-highlight'

" nerd tree highlight
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" plugin from http://vim-scripts.org/vim/scripts.html
Plug 'vim-scripts/L9'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}

" auto complete pairs
Plug 'jiangmiao/auto-pairs'

" Plug 'Valloric/Youcompleteme'

" lsp and completion, use the branch release
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" statusline profile
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" vim time statistics
Plug 'wakatime/vim-wakatime'

" provides for the visualization, navigation and management of vim's marks
Plug 'kshenoy/vim-signature'

" much simpler way to use motions 
Plug 'easymotion/vim-easymotion'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()


" ================
" Plugins Settings
" ================


" ======YouComleteSet=====


" ======NERDTree======


" show hidden file
let NERDTreeShowHidden=1
nnoremap <leader>n :NERDTreeToggle<CR>
" nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

set termencoding=utf-8   
set fileencoding=chinese 
set fileencodings=ucs-bom,utf-8,chinese   
set langmenu=zh_CN.utf-8  
"自动开启Nerdtree
augroup autoNerdtree
    autocmd vimenter * NERDTree 
    autocmd vimenter * if (exists("b: NERDTree") && b:NERDTree.isTabTree()) | exe "NERD <space>l" | endif
augroup END
" let g:NERDTreeWinSize = 25 "设定 NERDTree 视窗大小
" 开启/关闭nerdtree快捷键
" map <F5> :NERDTreeToggle<CR>
" 打开vim时如果没有文件自动打开NERDTree
" autocmd vimenter * if !argc()|NERDTree|endif
" 当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeHidden=0     "不显示隐藏文件
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1


" ============vim-devicons============


set encoding=UTF-8
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1


" ==================vim-nerdtree-syntax-highlight==================


let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:Turquoise = "40E0D0"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = "FE405F"
let s:git_orange = "F54D27"
let s:gray = "808A87"
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['o'] = s:gray " sets the color of o files to blue
let g:NERDTreeExtensionHighlightColor['h'] = s:blue " sets the color of h files to blue
let g:NERDTreeExtensionHighlightColor['c'] = s:green " sets the color of c files to blue
let g:NERDTreeExtensionHighlightColor['cpp'] = s:green " sets the color of cpp files to blue
let g:NERDTreeExtensionHighlightColor['c++'] = s:green


" ================nerdtree-git-plugin===================


let g:NERDTreeGitStatusIgnored = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ 'Ignored'   : '☒',
			\ "Unknown"   : "?"
			\ }


" ====== vim-lsp-cxx-highlight======


hi default link LspCxxHlSymFunction cxxFunction
hi default link LspCxxHlSymFunctionParameter cxxParameter
hi default link LspCxxHlSymFileVariableStatic cxxFileVariableStatic
hi default link LspCxxHlSymStruct cxxStruct
hi default link LspCxxHlSymStructField cxxStructField
hi default link LspCxxHlSymFileTypeAlias cxxTypeAlias
hi default link LspCxxHlSymClassField cxxStructField
hi default link LspCxxHlSymEnum cxxEnum
hi default link LspCxxHlSymVariableExtern cxxFileVariableStatic
hi default link LspCxxHlSymVariable cxxVariable
hi default link LspCxxHlSymMacro cxxMacro
hi default link LspCxxHlSymEnumMember cxxEnumMember
hi default link LspCxxHlSymParameter cxxParameter
hi default link LspCxxHlSymParameter cxxTypeAlias


" ======Coc.nvimSet=======


" Coc need the newest nodejs and npm, some extensions need yarn to get packed
" Coc extensions
" ccls need to installl from github instaed of npm(use: sudo apt-get install ccls)
let g:coc_global_extensions = [
\ 'coc-clangd', 
\ 'coc-vimlsp',
\ 'coc-sh',
\ 'coc-cmake',
\ 'coc-pyright',
\ 'coc-json',
\ 'coc-prettier',
\ 'coc-marketplace',
\ 'coc-highlight',
\ 'coc-rust-analyzer'
\]


" Add this to avoid version message
" or just update to new vim version with
" sudo add-apt-repository -r ppa:jonathonf/vim (this to update cache in apt)
" sudo apt-get install vim
" let g:coc_disable_startup_warning = 1


" Trigger negiative in suggent pop menu
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Trigger completion
if has('nvim')
	inoremap <silent><expr> <c-o> coc#refersh()
else 
	inoremap <silent><expr> <c-@> coc#refersh()
endif


" Diagnostic info and navigation
nnoremap <silent><nowait> <leader>d :CocList diagnostic<CR>
nmap <silent> <leader>- <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>= <Plug>(coc-diagnostic-next)
nmap <leader>qf <Plug>(coc-fix-current)


" Goto code navigation.
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function s:show_documentation()
   if CocAction('hasProvider', 'hover')
	   call CocActionAsync('doHover')
   else
	   call feedkeys('K', 'in')
	endif
endfunction


" scroll float window/popips
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
	inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ?  "\<c-r>=coc#float#scroll(1)\<cr>" : "\<right>"
	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ?  "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1)
	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0)
endif


" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')


" Format selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)


" Rename 
nmap <leader>rn <Plug>(coc-rename)


" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" Setup Prettier command 
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand','editor.action.organizeImport')"


" ==========================Mappings for CocList===========================
" Open CocList
nnoremap <silent> <space>g :<C-u>CocList --normal gstatus<CR>

" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>n  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>p  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>r  :<C-u>CocListResume<CR>

"====================Use for coc-marketplace================


" :CocList marketplace list all available extensions
" :CocList marketplace python to search extension that name contains python
" You can "Tab" on an extension to do install, uninstall, homepage actions.

"==========
" help function for autocomplicate in vscode
"==========

" a function to generate compile command to .vscode
function! s:generate_compile_commands()
	if empty(glob('CMakeLists.txt'))
		echo "Can't find CMakeLists.txt"
		return 
	endif
	execute '!cmake -DCMAKE_BUILD_TYPE=debug
				\ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_commands()


" ======Custom Coc Settings=======
" highlight CocFloating ctermbg=Black guifg=#1e1e1e
" highlight CocInlayhint ctermfg=Red ctermbg=White guifg=#15aabf
" set no bg color
" highlight CocInlayhint ctermfg=White ctermbg=0 guifg=#15aabf
" use <C-j>\<C-k> to taggle betweent argument after auto completion


" ======vim-airline=======


let g:airline_section_z="%p%%"
let g:airline_theme='qwq'

let g:airline#extensions#coc#enabled = 0
let airline#extensions#coc#error_symbol = 'Error:'
let airline#extensions#coc#warning_symbol = 'Warning:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'


" ====================GitGutter====================

" let g:gitgutter_signs = 1
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
nnoremap <leader>gf :GitGutterFold<CR>
nnoremap <leader>gd :GitGutterPreviewHunk<CR>
nnoremap <leader>g- :GitGutterPrevHunk<CR>
nnoremap <leader>g= :GitGutterNextHunk<CR>


" ====================ultisnips=====================

let g:UltiSnipsExpandTrigger="<C-tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"


" ====================nerdcommenter=====================
" toggle comments with <leader>c<space>


" use leading space, but delete trailing space
let g:NERDSpaceDelims=1             " 让注释符与语句之间留一个空格
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCompactSexyComs=1         " 多行注释时样子更好看
let g:NERDDefaultAlign = 'left'     " 将多行注释符左对齐 

" do not nest by default
let g:NERDDefaultNesting = 1
let g:NERDAltDelims_javascript = 0
" nmap 'c <leader>c
" xmap 'c <leader>c
" comment text objects and movements
nmap <leader>c<down> V<down><plug>NERDCommenterInvert
nmap <leader>c<up>   V<up><plug>NERDCommenterInvert
nmap        'c<down> V<down><plug>NERDCommenterComment
nmap        'c<up>   V<up><plug>NERDCommenterComment
for mov in ['j', 'k', 'gg', 'G', '(', ')', '{', '}', 'as', 'is', 'ap', 'ip']
    exe "nmap \<leader\>c" . mov . " V" . mov . "\<plug\>NERDCommenterInvert"
    exe "nmap 'c"          . mov . " V" . mov . "\<plug\>NERDCommenterComment"
endfor
for i in range(1, 50)
    exe "nmap \<leader\>c" . i . "j        V" . i . "j\<plug\>NERDCommenterInvert"
    exe "nmap \<leader\>c" . i . "\<down\> V" . i . "j\<plug\>NERDCommenterInvert"
    exe "nmap \<leader\>c" . i . "k        V" . i . "k\<plug\>NERDCommenterInvert"
    exe "nmap \<leader\>c" . i . "\<up\>   V" . i . "k\<plug\>NERDCommenterInvert"
    exe "nmap 'c"          . i . "j        V" . i . "j\<plug\>NERDCommenterComment"
    exe "nmap 'c"          . i . "\<down\> V" . i . "j\<plug\>NERDCommenterComment"
    exe "nmap 'c"          . i . "k        V" . i . "k\<plug\>NERDCommenterComment"
    exe "nmap 'c"          . i . "\<up\>   V" . i . "k\<plug\>NERDCommenterComment"
endfor
" duplicate a line and comment out the first one
nmap <leader>cd <leader>cyp
" do not comment on new lines (except when already in insert mode)
nnoremap o o<esc>S
nnoremap O O<esc>S


" ====================vim-fugitive=====================
 
" To learn more see:
" :h fugitive
" :h :Git
" :h :Gw
" :h :Git commit
" :h :windo
" :h :x
" to add file: 
"     in command line :Git
"     then use '-' to add or remove file
"     Start committing via cc whilst in the status window
"
" Or use a more easy way:
" :windo Gw
" :Git commit




