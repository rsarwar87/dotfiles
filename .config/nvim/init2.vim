" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

" Airline is a plugin that makes the status line look fancier.
" It requires a custom font (with arrows), and is completely optional
Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

" A more convenient (than default) directory browser for Vim
Plug 'scrooloose/nerdtree'

" This is a core plugin to support autocompletion for most of the things.
" This is also the messiest one, as it requires manual (and periodic) 
" invocation of the build script.
Plug 'Valloric/YouCompleteMe'

" Autocompletion for Python
Plug 'davidhalter/jedi-vim'

" Highlights new/mofified/deleted lines in the "gutter"
Plug 'airblade/vim-gitgutter'

" Later in the config I'll bind this plugin to "gc"
" Typing "gc" will comment out a block or line of code in any language
Plug 'tpope/vim-commentary'

" A Git plugin with a crazy useful command :GitBlame
" Don't wait, blame someone else!
Plug 'tpope/vim-fugitive'

" A collection of colorschemes. Doesn't include my favorite one though.
Plug 'flazz/vim-colorschemes'



" A wrapper around silversearcher-ag
Plug 'rking/ag.vim'

" A Vim plugin for all things Go. Supports autocompletion,
" smart code navigation, linting, and much more
Plug 'fatih/vim-go'

" Never got used to this one, but it allows for wrapping a piece of
" text into "", '', or custom tags
Plug 'tpope/vim-surround'

" Fzf for ffffuzzzy search~
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Neomake for asynchronous linting and building
Plug 'neomake/neomake'

" A beautiful autopep8. Have it bound to "ap"
Plug 'tell-k/vim-autopep8'

" Import sorter for Python
Plug 'fisadev/vim-isort'

" The Most Recently Used (MRU) plugin provides an easy access to a list of
" recently opened/edited files in Vim
Plug 'vim-scripts/mru.vim'

" It allows you to yank and delete things without worrying about 
" losing the text that you yanked previously. 
Plug 'maxbrunsfeld/vim-yankstack'

"ALE makes use of NeoVim and Vim 8 job control functions and timers to run 
"linters on the contents of text buffers and return errors as text is changed in Vim
Plug 'w0rp/ale'


"This plugin was designed as a Vim frontend for the programmer's search tool ack. 
"ack can be used as a replacement for 99% of the uses of grep. The plugin allows 
"you to search with ack from within Vim and shows the results in a split window.<Paste>

Plug 'mileszs/ack.vim'

Plug 'junegunn/goyo.vim'

Plug 'amix/vim-zenroom2'

Plug 'terryma/vim-expand-region'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'terryma/vim-multiple-cursors' 

Plug 'amix/open_file_under_cursor.vim'

Plug 'fatih/vim-go'

Plug 'vim-scripts/bufexplorer.zip'

" Initialize plugin system
call plug#end()

set updatetime=500


" Airline setup

set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = "jellybeans"

" Jedi-vim configuration
let g:jedi#show_call_signatures = 1 
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 0
autocmd FileType python setlocal completeopt-=preview


" Turn on line numbers
set nu
" Turn on syntax highlighting
syntax on
" It hides buffers instead of closing them.
" https://medium.com/usevim/vim-101-set-hidden-f78800142855
set hidden
" Highlights search results as you type vs after you press Enter
set incsearch
" Ignore case when searching
set ignorecase
set smartcase 
" Turns search highlighting on
set hlsearch
" Expands TABs into whitespaces
set expandtab
set shiftwidth=4  
" Exclude these files from *
set wildignore=*.swp,*.bak,*.pyc,*.class
" Turn on TrueColor
set termguicolors

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore .git --ignore build-out --ignore build-opt --ignore build-dbg -g ""'

endif

" This colorscheme mimics a default Atom colorscheme which I quite like
 colorscheme onedark

" Ctrl+P opens a fuzzy filesearch window (powered by Fzf)
nnoremap <C-p> :Files<CR>


" Switch to last active tab
let g:lasttab = 1
" I really like tt for switching between recent tabs
nmap tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

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

" Don't expland tabs for Go
autocmd BufRead,BufNewFile   *.go setlocal noexpandtab

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

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
 let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

""""""""""""""""""""""""""""""
" => ZenCoding
"""""""""""""""""""""""""""""""
 " Enable all functions in all modes
 let g:user_zen_mode='a'


""""""""""""""""""""""""""""""
" => snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
 ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
 snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>
"
"
""""""""""""""""""""""""""""""
" " => Vim grep
""""""""""""""""""""""""""""""
 let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
 set grepprg=/bin/grep\ -nH
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:NERDTreeWinPos = "right"
 let NERDTreeShowHidden=0
 let NERDTreeIgnore = ['\.pyc$', '__pycache__']
 let g:NERDTreeWinSize=35
 map <leader>nn :NERDTreeToggle<cr>
 map <leader>nb :NERDTreeFromBookmark<Space>
 map <leader>nf :NERDTreeFind<cr>
"
"
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
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => surround.vim config
 " Annotate strings with gettext 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 vmap Si S(i_<esc>f)
 au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:lightline = {
       \ 'colorscheme': 'wombat',
       \ }

 let g:lightline = {
       \ 'colorscheme': 'wombat',
       \ 'active': {
       \   'left': [ ['mode', 'paste'],
       \             ['fugitive', 'readonly', 'filename', 'modified'] ],
       \   'right': [ [ 'lineinfo' ], ['percent'] ]
       \ },
       \ 'component': {
       \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:goyo_width=100
 let g:goyo_margin_top = 2
 let g:goyo_margin_bottom = 2
 nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => Vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:go_fmt_command = "goimports"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => Syntastic (syntax checker)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:ale_linters = {
 \   'javascript': ['jshint'],
 \   'python': ['flake8'],
 \   'go': ['go', 'golint', 'errcheck']
 \}

 nmap <silent> <leader>a <Plug>(ale_next_wrap)

 " Disabling highlighting
 let g:ale_set_highlights = 0

 " Only run linting when saving the file
 let g:ale_lint_on_text_changed = 'never'
 let g:ale_lint_on_enter = 0
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => Git gutter (Git diff)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:gitgutter_enabled=0
 nnoremap <silent> <leader>d :GitGutterToggle<cr>





" Persistant undo
if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature  
  set undodir=$HOME/.config/nvim/undo  "directory where the undo files will be stored
endif 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Map ½ to something useful
map ½ $
cmap ½ $
imap ½ $



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>g :Ack 

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ack, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""
" => Shell section
" """"""""""""""""""""""""""""""

if exists('$TMUX') 
    if has('nvim')
      set termguicolors
    else
      set term=screen-256color 
    endif
endif

""""""""""""""""""""""""""""""
" => bufExplorer plugin
" """"""""""""""""""""""""""""""
 let g:bufExplorerDefaultHelp=0
 let g:bufExplorerShowRelativePath=1
 let g:bufExplorerFindActive=1
 let g:bufExplorerSortBy='name'
 map <leader>o :BufExplorer<cr>

