
"-------------------------
" Базовые настройки
"-------------------------

" Включаем несовместимость настроек с Vi (ибо Vi нам и не понадобится).
set nocompatible

" Показывать положение курсора всё время.
set ruler  

" Показывать незавершённые команды в статусбаре
set showcmd  

" Включаем нумерацию строк
set nu

" Фолдинг по отсупам
set foldmethod=syntax

" Поиск по набору текста (очень полезная функция)
set incsearch

" Отключаем подстветку найденных вариантов, и так всё видно.
set nohlsearch

" Теперь нет необходимости передвигать курсор к краю экрана, чтобы подняться в режиме редактирования
set scrolljump=7

" Теперь нет необходимости передвигать курсор к краю экрана, чтобы опуститься в режиме редактирования
set scrolloff=7

" Выключаем надоедливый "звонок"
set novisualbell
set t_vb=   

" Поддержка мыши
"set mouse=a
set mousemodel=popup

" Кодировка текста по умолчанию
set termencoding=utf-8

" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз
" когда переключаешься между ними
set hidden


" Сделать строку команд высотой в одну строку
set ch=1

" Скрывать указатель мыши, когда печатаем
set mousehide

" Включить автоотступы
set autoindent

" Влючить подстветку синтаксиса
syntax on

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Преобразование Таба в пробелы
set expandtab

" Размер табулации по умолчанию
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Формат строки состояния
set statusline=%<%f%h%m%r\ \%l,%c%V\ %P 
set laststatus=2

" Включаем "умные" отспупы ( например, автоотступ после {)
set smartindent

" Fix <Enter> for comment
set fo+=cr

" Опции сесссий
set sessionoptions=curdir,buffers,tabpages



ino <Down> <C-O>gj
ino <Up> <C-O>gk
nno <Down> gj
nno <Up> gk



if has("gui_running")
  colo   blackboard
else
 colo ron
endif
"set guioptions-=m
set guioptions-=T
set guifont="Terminus 16"
"-------------------------
" Горячие клавишы
"-------------------------

" Пробел в нормальном режиме перелистывает страницы
nmap <Space> <PageDown>

" CTRL-F для omni completion
imap <C-F> <C-X><C-O>

set pt=<F5> shm=I tm=750 nomore modelines=5 hls!

" C-c and C-v - Copy/Paste в "глобальный клипборд"
vmap <C-C> "+yi
imap <C-V> <esc>"+gPi

" Заставляем shift-insert работать как в Xterm
map <S-Insert> <MiddleMouse>

" C-y - удаление текущей строки
nmap <C-y> dd
imap <C-y> <esc>ddi

" C-d - дублирование текущей строки
imap <C-d> <esc>yypi

" Поиск и замена слова под курсором
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/


nno <F4> :set nu!<bar>set nu?<CR>

map <C-t> <ESC>:tabnew<cr>
map <S-Left> <ESC>gt<cr>
map <S-Right> <ESC>gT<cr>


" F6 - просмотр списка буферов
nmap <F6> <Esc>:BufExplorer<cr>
vmap <F6> <esc>:BufExplorer<cr>
imap <F6> <esc><esc>:BufExplorer<cr>

" F8 - список закладок
map <F8> :MarksBrowser<cr>
vmap <F8> <esc>:MarksBrowser<cr>
imap <F8> <esc>:MarksBrowser<cr>


" F10 - удалить табу
map <F10> :tabclose<cr>

" F11 - показать окно Taglist
map <F11> :TlistToggle<cr>
vmap <F11> <esc>:TlistToggle<cr>
imap <F11> <esc>:TlistToggle<cr>

" F2 - обозреватель файлов
map <F2> :Texplore<cr>
vmap <F2> <esc>:Texplore<cr>i
imap <F2> <esc>:Texplore<cr>i

" < & > - делаем отступы для блоков
vmap < <gv
vmap > >gv

" Выключаем ненавистный режим замены
imap >Ins> <Esc>i

" Меню выбора кодировки текста (koi8-r, cp1251, cp866, utf8)
set wildmenu
set wcm=<Tab> 
menu Enc.koi8-r :e ++enc=koi8-r<CR>
menu Enc.windows-1251 :e ++enc=cp1251<CR>
menu Enc.cp866 :e ++enc=cp866<CR>
menu Enc.utf-8 :e ++enc=utf8 <CR>

map <F7>   :emenu Enc.<TAB>
" Редко когда надо [ без пары =)
imap [ []<LEFT>
" Аналогично и для {
imap {<CR> {<CR>}<Esc>O

" С-q - выход из Vim 
map <C-Q> <Esc>:qa<cr>


" Автозавершение слов по tab =)
function InsertTabWrapper()
     let col = col('.') - 1
     if !col || getline('.')[col - 1] !~ '\k'
         return "\<tab>"
     else
         return "\<c-p>"
     endif
endfunction
imap <tab> <c-r>=InsertTabWrapper()<cr>

" Слова откуда будем завершать
set complete=""
" Из текущего буфера
set complete+=.
" Из словаря
set complete+=k
" Из других открытых буферов
set complete+=b
" из тегов 
set complete+=t

" Включаем filetype плугин. Настройки, специфичные для определынных файлов мы разнесём по разным местам
filetype plugin on
au BufRead,BufNewFile *.phps    set filetype=php
au BufRead,BufNewFile *.thtml    set filetype=php

" Настройки для SessionMgr
let g:SessionMgr_AutoManage = 0
let g:SessionMgr_DefaultName = "mysession"

" Настройки для Tlist (показвать только текущий файл в окне навигации по  коду)
let g:Tlist_Show_One_File = 1

set completeopt-=preview
set completeopt+=longest
set mps-=[:]


"//----- AES 
augroup aes256
  autocmd!
  autocmd BufReadPre,FileReadPre      *.aes set bin
  autocmd BufReadPost,FileReadPost    *.aes '[,']!openssl enc -d -aes-256-cbc
  autocmd BufReadPost,FileReadPost    *.aes set nobin
  autocmd BufReadPost,FileReadPost    *.aes execute ":doautocmd BufReadPost " . expand("%:r")
  autocmd BufWritePost,FileWritePost  *.aes !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost  *.aes !openssl enc -e -aes-256-cbc -in <afile>:r -out <afile>

  autocmd FileAppendPre               *.aes !openssl enc -d -aes-256-cbc -in <afile> -out <afile>:r
  autocmd FileAppendPre               *.aes !mv <afile>:r <afile>
  autocmd FileAppendPost              *.aes !mv <afile> <afile>:r
  autocmd FileAppendPost              *.aes !openssl enc -e -aes-256-cbc -in <afile>:r -out <afile>
augroup END
"//

