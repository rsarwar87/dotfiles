
"Clang settings
let g:clang_format#code_style='llvm'
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true", "AlignConsecutiveDeclarations" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true", "AlignConsecutiveAssignments" : "true",
            \ "Standard" : "C++11", "AlignTrailingComments" : "true", "AllowAllParametersOfDeclarationOnNextLine" : "false",
            \ "BreakBeforeBraces" : "Allman", "AllowShortLoopsOnASingleLine" : "true"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

set mouse=a
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic o" Makes search act like search in modern browsers
set incsearch 
n
set magic

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
  endif
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore .git --ignore build-out --ignore build-opt --ignore build-dbg -g ""'

endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
" it deletes everything until the last slash 
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
" A bit of autopep8 config
let g:autopep8_disable_show_diff=1
" ap for a quick .py file formatting
nnoremap ap  :Autopep8<CR>
" This is a quick way to call search-and-replace on a current word
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
" cc now hides those annoying search highlihghts after you're done searching
nnoremap cc :let @/ = ""<cr>
" \e to open a NerdTree at in the directory of the currently viewed file
nnoremap <Leader>e :Ex<CR>
" I said write it!
cmap w!! w !sudo tee % >/dev/null
" P" Ctrl+P opens a fuzzy filesearch window (powered by Fzf)
nnoremap <C-p> :Files<CR>


" Switch to last active tab
let g:lasttab = 1
" I really like tt for switching between recent tabs
nmap tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()lugins
""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']

nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste

""""""""""""""""""""""""""""""
" => CTRL-P
"""""""""""""""""""""""""""""""
 let g:ctrlp_working_path_mode = 0

 let g:ctrlp_map = '<c-f>'
 map <leader>j :CtrlP<cr>
 map <c-b> :CtrlPBuffer<cr>

 let g:ctrlp_max_height = 20
 let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee' let g:gitgutter_enabled=1
 nnoremap <silent> <leader>d :GitGutterToggle<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:multi_cursor_use_default_mapping=0

 " Default mapping
 let g:multi_cursor_start_word_key      = '<C-s>'
 let g:multi_cursor_select_all_word_key = '<A-s>'
 let g:multi_cursor_start_key           = 'g<C-s>'
 let g:multi_cursor_select_all_key      = 'g<A-s>'
 let g:multi_cursor_next_key            = '<C-s>'
 let g:multi_cursor_prev_key            = '<C-p>'
 let g:multi_cursor_skip_key            = '<C-x>'
 let g:multi_cursor_quit_key            = '<Esc>'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:multi_cursor_use_default_mapping=0

 " Default mapping
 let g:multi_cursor_start_word_key      = '<C-s>'
 let g:multi_cursor_select_all_word_key = '<A-s>'
 let g:multi_cursor_start_key           = 'g<C-s>'
 let g:multi_cursor_select_all_key      = 'g<A-s>'
 let g:multi_cursor_next_key            = '<C-s>'
 let g:multi_cursor_prev_key            = '<C-p>'
 let g:multi_cursor_skip_key            = '<C-x>'
 let g:multi_cursor_quit_key            = '<Esc>'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! DeleteTillSlash()
	let g:cmd = getcmdline()
	if has("win16") || has("win32")
           let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
        else
           let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
        endif

        if g:cmd == g:cmd_edited
              if has("win16") || has("win32")
                 let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
              else
               let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
              endif
        endif   
    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
        return a:cmd . " " . expand("%:p:h") . "/"
endfunc


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

""""""""""""""""""""""""""""""
" => bufExplorer plugin
" """"""""""""""""""""""""""""""
 let g:bufExplorerDefaultHelp=0
 let g:bufExplorerShowRelativePath=1
 let g:bufExplorerFindActive=1
 let g:bufExplorerSortBy='name'
 map <leader>o :BufExplorer<cr>

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
" map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry


