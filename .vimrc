" Theme
if has("gui_running")
  colo   blackboard
else
 colo ron
endif
"temporary storage for swap files
set backupdir=/tmp
set directory=/tmp

set guioptions-=T
set guifont="Terminus 16"
set nocompatible
set ruler showcmd nu incsearch nohlsearch scrolljump=7 scrolloff=7 novisualbell t_vb= mousemodel=popup 
set termencoding=utf-8  ch=1  mousehide  autoindent backspace=indent,eol,start whichwrap+=<,>,[,] statusline=~ smartindent
syntax on
" KEys
ino <Down> <C-O>gj
ino <Up> <C-O>gk
nno <Down> gj
nno <Up> gk
set pt=<F5> shm=I tm=750 nomore modelines=5 hls!
map <S-Insert> <MiddleMouse>
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/
nno <F4> :set nu!<bar>set nu?<CR>
map <F1> :MarksBrowser<cr>
map <F3> :w!<CR>:!aspell check %<CR>:e! %<CR>
:autocmd FileType mail :nmap <F8> :w<CR>:!aspell -d en,uk,ru -e -c %<CR>:e<CR>

" F1 - bookmarks browser
map <F1> :MarksBrowser<cr>
vmap <F1> <esc>:MarksBrowser<cr>
imap <F1> <esc>:MarksBrowser<cr>
" F2 Explore
map <F2> :Texplore<cr>
vmap <F2> <esc>:Texplore<cr>i
imap <F2> <esc>:Texplore<cr>i

"Ctags hotkey
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
imap <C-F12> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

set wildmenu
set wcm=<Tab> 
menu Enc.koi8-r :e ++enc=koi8-r<CR>
menu Enc.windows-1251 :e ++enc=cp1251<CR>
menu Enc.cp866 :e ++enc=cp866<CR>
menu Enc.utf-8 :e ++enc=utf8 <CR>
map <F7>   :emenu Enc.<TAB>
" Auto complete
function InsertTabWrapper()
     let col = col('.') - 1
     if !col || getline('.')[col - 1] !~ '\k'
         return "\<tab>"
     else
         return "\<c-p>"
     endif
endfunction
imap <tab> <c-r>=InsertTabWrapper()<cr>
set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t
set completeopt-=preview
set completeopt+=longest
set mps-=[:]
