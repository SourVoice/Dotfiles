
" =============
" BasicSetting
" =============
  

" set everyline with number
set number
" Show line number on the current line and relative numbers on all other lines.
set relativenumber
" will not carrage return when line within symbol below
set iskeyword+=_,$,@,%,#,-


" shift and tab setting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

" Enable mouse support
set mouse+=a
" Disable noerrorbells
set noerrorbells visualbell t_vb=
" Highlight the line currently under cursor.
set cursorline
" enable hightlight searching
set hlsearch
"  see ":help leader" for more information.
let mapleader = ","

set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2

" Proper Search
set incsearch
set ignorecase
set smartcase
set gdefault

" Status Bar
set laststatus=2
" set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y                    " Filetype
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%                  " Percentage
set statusline+=\ %l:%c                 " Line number: Column relative
" set statusline+=\


function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction


" Resize split screen
nmap <leader>k :res +5<CR>
nmap <leader>j :res -5<CR>
nmap <leader>h :vertical res-5<CR>
nmap <leader>l :vertical res+5<CR>

" Open file remember history status
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" =============
" KeyBinding
" =============


" set 'jj' into normal mod
inoremap jj <esc>

nnoremap <C-[> <esc>
vnoremap <C-[> <esc>
snoremap <C-[> <esc>
xnoremap <C-[> <esc>
onoremap <C-[> <esc>

" =============
" PluginManager
" =============


if empty(glob('~/.vim/bundle/Vundle.vim'))
	:exe 'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
	an VimEnter * PluginInstal --sync | source $MYVIMRC
endif 


" =============
" PluginBegin
" =============


set nocompatible              " be iMproved, required
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" use git in vim
Plugin 'tpope/vim-fugitive'

" file explore
Plugin 'preservim/nerdtree'

" highlight
Plugin 'jackguo380/vim-lsp-cxx-highlight'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

"auto complete pairs
Plugin 'jiangmiao/auto-pairs'

"Plugin 'Valloric/Youcompleteme'

" lsp and completion
Plugin 'neoclide/coc.nvim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
Plugin 'wakatime/vim-wakatime'



" ================
" Plugins Settings
" ================


" ======YouComleteSet=====


" set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" "回车即选中当前项
" "上下左右键的行为 会显示其他信息
" inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
" inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" youcompleteme 默认tab s-tab 和自动补全冲突
" let g:ycm_key_list_select_completion=['<c-n>']
" let g:ycm_key_list_select_completion = ['<Tab>', '<Down>']
" let g:ycm_key_list_previous_completion=['<c-p>']
"let g:ycm_key_list_previous_completion = ['<S-Tab>', '<Up>']
"let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
" close completion menu
"let g:ycm_key_list_stop_completion = ['<C-y>']
"let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
"let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
"let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项,每次都重新生成匹配项
"let g:ycm_seed_identifiers_with_syntax=1 " 语法关键字补全
" force recomile with syntastic
"inoremap <F5> :YcmForceCompileAndDiagnostics<CR> 
" nnoremap <leader>lo :lopen<CR> "open locationlist
" nnoremap <leader>lc :lclose<CR> "close locationlist
"inoremap <leader><leader> <C-x><C-o>
" 在注释输入中也能补全
"let g:ycm_complete_in_comments = 1
" 在字符串输入中也能补全
"let g:ycm_complete_in_strings = 1
" 注释和字符串中的文字也会被收入补全
"let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 跳转到定义处
"inoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> 



" ======NERDTree======

" show hidden file
let NERDTreeShowHidden=1
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" ======vim-lsp-cxx-highlight======


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


" Coc extensions
let g:coc_global_extensions = [
\ 'coc-vimlsp',
\ 'coc-cmake',
\ 'coc-pyright',
\ 'coc-json'
\]


" Trigger negiative
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap  <silent><expr><TAB>
\ pumvisible() ? "\<C-n>":
\ <SID>check_back_space() ? "\<TAB>":
\ coc#refersh()
inoremap  <expr><S-TAB> 
\ pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline(',')[col-1] =~# '\s'
endfunction


" Trigger completion
if has('nvim')
inoremap <silent><expr> <c-space> coc#refersh()
else 
inoremap <silent><expr> <c-@> coc#refersh()
endif


" Use <CR> auto select the first completion item
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
		\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"  


" Goto code navigation.
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)


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
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


