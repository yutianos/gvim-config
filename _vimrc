filetype off
syntax on
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'https://hub.fastgit.org/mhinz/vim-startify' 
Plugin 'scrooloose/nerdtree'              
Plugin 'sickill/vim-monokai'               
Plugin 'vim-airline/vim-airline'           
Plugin 'vim-airline/vim-airline-themes'    
Plugin 'plasticboy/vim-markdown'           
Plugin 'octol/vim-cpp-enhanced-highlight' 
Plugin 'mhinz/vim-signify'
Plugin 'dense-analysis/ale'
Plugin 'morhetz/gruvbox'
Plugin 'luochen1990/rainbow'
Plugin 'majutsushi/tagbar'
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'Yggdroot/LeaderF'
Plugin 'ludovicchabant/vim-gutentags'
call vundle#end()

"------------------------------------
"-------------keyboard map-----------
"-----------------------------------
inoremap jj <esc>
let mapleader=","
nmap <leader>e :e $MYVIMRC<cr>
"-----------------------------------
"让vimrc配置变更立即生效'
autocmd BufWritePost $MYVIMRC source $MYVIMRC
colorscheme gruvbox
set background=dark 
filetype on
set signcolumn=yes "强制显示侧边栏，防止时有时无
syntax on 
set shiftwidth=4
set tabstop=4
let g:ycm_clangd_binary_path='clangd'
set number
"搜索忽略大小写
set ignorecase
"搜索逐字符高亮
set hlsearch
set incsearch
" 为C程序提供自动缩进
set smartindent
set cursorline " 突出显示当前行
"光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号"
set showmatch

" Enable clipboard support
set clipboard=unnamedplus


" vim 文件折叠方式为 marker
augroup ft_vim
    au!

    autocmd FileType vim setlocal foldmethod=marker

    " 打开文件总是定位到上次编辑的位置
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    augroup END
augroup END
" }}}
" General {{{
set list!
set listchars=tab:>~,trail:.
set rnu!
set nocompatible
set nobackup
set noswapfile
set history=1024
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed
" 设置 alt 键不映射到菜单栏
set winaltkeys=no
" }}}

nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" flod 
"set foldmethod=syntax
set foldmethod=indent

"end
"--------------
" LeaderF start
"--------------
if has('nvim')
    let s:cachedir = expand(stdpath('cache'))
    let s:configdir = expand(stdpath('config'))
else
    "vim will share same folder with nvim
    if has('win32')
        let s:cachedir = expand('D:\ctags\.cache\nvim')
        let s:configdir = expand('~/AppData/Local/nvim')
    else
        let s:cachedir = expand('~/.cache/nvim')
        let s:configdir = expand('~/.config/nvim')
    endif
endif

"let g:Lf_Gtagsconf='D:\00-Install\gtags\share\gtags\gtags.conf'
let g:Lf_GtagsSkipSymlink = ''
"let g:Lf_Gtags = 'D:\00-Install\gtags\bin\gtags.exe'
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_GtagsSource = 1
"let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

"let g:Lf_Ctags="ctags"
let g:Lf_WorkingDirectoryMode = 'AF'
let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.root']
let g:Lf_UseVersionControlTool=1 "default value, can ignore
let g:Lf_DefaultExternalTool='rg'
let g:Lf_PreviewInPopup = 1
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = s:cachedir
"let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {
        \ 'File': 0,
        \ 'Buffer': 0,
        \ 'Mru': 0,
        \ 'Tag': 0,
        \ 'BufTag': 1,
        \ 'Function': 1,
        \ 'Line': 1,
        \ 'Colorscheme': 0,
        \ 'Rg': 0,
        \ 'Gtags': 0
        \}

let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<c-l>'
"noremap <leader>f :LeaderfSelf<cr>
noremap <leader>fm :LeaderfMru<cr>
noremap <leader>ff :LeaderfFunction<cr>
noremap <leader>fb :LeaderfBuffer<cr>
noremap <leader>ft :LeaderfBufTag<cr>
noremap <leader>fl :LeaderfLine<cr>
noremap <leader>fw :LeaderfWindow<cr>
noremap <leader>frr :LeaderfRgRecall<cr>

" search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search word under cursor, the pattern is treated as regex,
" append the result to previous search results.
noremap <C-G> :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>
" search word under cursor literally only in current buffer
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>
" search word under cursor literally in all listed buffers
noremap <C-D> :<C-U><C-R>=printf("Leaderf! rg -F --all-buffers -e %s ", expand("<cword>"))<CR>
" search visually selected text literally, don't quit LeaderF after accepting an entry
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>
" recall last search. If the result window is closed, reopen it.
noremap go :<C-U>Leaderf! rg --recall<CR>

" search word under cursor in *.h and *.cpp files.
noremap <Leader>a :<C-U><C-R>=printf("Leaderf! rg -e %s -g *.h -g *.cpp -g *.c", expand("<cword>"))<CR>
" the same as above
noremap <Leader>a :<C-U><C-R>=printf("Leaderf! rg -g *.{h,cpp,c,s,S} -e %s", expand("<cword>"))<CR>
" search word under cursor in cpp and java files.
noremap <Leader>b :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -t java", expand("<cword>"))<CR>
" search word under cursor in cpp files, exclude the *.hpp files
noremap <Leader>c :<C-U><C-R>=printf("Leaderf! rg -e %s -t c -g !*.h", expand("<cword>"))<CR>

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif

let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

let g:gutentags_gtags_cscope_executable = 'D:\00-Install\gtags\bin\gtags-cscope.exe'
let g:gutentags_ctags_executable = 'D:\00-Install\ctags-p6.1.20240512.0-clang-x64\ctags.exe'
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('D:\ctags\.cache\tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"括号自动匹配补全"
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap { {<CR>}<Esc>O
" C++的编译和运行
map <F5> :call CompileRunGpp()<CR>
func! CompileRunGpp()
exec "w"
exec "!g++ % -o %<"
exec "! ./%<"
endfunc

"rainbow parenthesis
let g:rainbow_active = 1
" 文件树的设置
nmap <Leader><Leader> :NERDTreeToggle<CR>
let NERDTreeWinSize=32
" 设置NERDTree子窗口宽度
let NERDTreeWinPos="left"      " 设置NERDTree子窗口位置
let NERDTreeShowHidden=1        " 显示隐藏文件
let NERDTreeMinimalUI=1         " NERDTree 子窗口中不显示冗余帮助信息
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,\|+\|-_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'css': 0,
\   }
\}
" 绑定F2到NERDTreeToggle
map <F8> :NERDTreeToggle<CR>

nmap <F9> :TagbarToggle<CR>
" tagbar默认去这个目录中寻找ctags，ctags的默认安装路径也是这个目录
let g:tagbar_ctags_bin='D:\00-Install\ctags-p6.1.20240512.0-clang-x64\ctags.exe' 
let g:tagbar_width=26                      " Default is 40, seems too wide
noremap <Leader>y :TagbarToggle<CR>        " Display panel with (,y)

let g:tagbar_autofocus = 1

"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*\\node_modules\\*,*.git*,*.svn*,*.zip*,*.exe* " 使用vim的忽略文件


"" airline
let laststatus = 2
let g:airline_powerline_fonts = 1
let g:airline_theme = "dark"
let g:airline#extensions#tabline#enabled = 1

set guifont=CaskaydiaCove_NFM:h16:cANSI


"" vim-monokai
" colorscheme monokai

"" vim-markdown
" Github风格markdown语法
let g:vim_markdown_no_extensions_in_markdown = 1

"" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1

" 自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
" 显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]' 
"设置状态栏显示的内容,这里必须添加%{ALEGetStatusLine()到状态栏里
"设置ale显示内容
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
" 对verilog、c++、c、python单独设置linter
let g:ale_linters = { 'verilog': ['vlog'],
\   'c++': ['clangd'],
\   'c': ['gcc'],
\   'python': ['pylint'],
\}

let g:ale_lint_on_text_changed = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
