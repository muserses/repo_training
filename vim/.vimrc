" ~/.vimrc
"

" Do not try to be bi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Initialize vundle
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" Start- all plugins below

Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'taglist.vim'
Plugin 'gnattishness/cscope_maps'
Plugin 'aperezdc/vim-template'

" Stop - all plugins above
call vundle#end()

" For plugins to load correctly
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" TODO: Pick a leader key, default is \
let mapleader = ","

" Keep 50 command lines in history
set history=50

" Show line number
set number


set sidescrolloff=5


" Appearance
"colorscheme lyla
"colorscheme desert
set t_Co=256
set textwidth=79

set background=dark

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_number_column='bg1'
let g:gruvbox_vert_split='fg0'

colorscheme gruvbox

let g:lightline = {'colorscheme': 'PaperColor', }

" Mouse settings
set mouse=a

" Encoding settings
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" Lightline fix
set laststatus=2

" Indentation 
set autoindent

" Tab and whitespace
set shiftwidth=8
set softtabstop=8
set tabstop=8
"set expandtab

" Visualize tabs and newlines
set listchars=tab:▸\-,trail:.
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR>

" Search settings
set ignorecase
set smartcase
set hlsearch
"set nohlsearch
nnoremap <leader><space> :nohlsearch<CR>

"nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
"nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

"nnoremap * :keepjumps normal! mi*`i<CR>: set hls!<CR>

"nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

let s:curr_match = -1

function! HighlightSearch()
    if expand('<cword>') != ''
        if s:curr_match == -1
            let @/ = ''
        endif
        if @/ == expand('<cword>')
            let @/ = ''
            call matchdelete(s:curr_match)
            let s:curr_match = -1
        else
    	    if s:curr_match != -1
                call matchdelete(s:curr_match)
            endif
            let @/ = expand('<cword>')
            let s:curr_match = matchadd('search', expand('<cword>'))
        endif
    endif
endfunction

nnoremap <F8> :call HighlightSearch()<CR>:echo @/<CR>


" NERDTree hotkey
" Open or close NERTree windows
map <F4> :NERDTreeToggle<CR>

" NERDTree Configuratioin
let NERDTreeWinPos="right"
let NERDTreeWinSize=18
let NERDTreeMouseMode=3


" Taglist hotkey
map <F3> :TlistToggle<CR>

" TagList Configuration
let Tlist_Show_One_File=1
let Tlist_Use_SingleClick=1
let Tlist_WinWidth=24
let Tlist_Exit_OnlyWindow=1


map <F9> :cs kill 0<CR>:!cscope -b -q -k -u<CR><CR>:cs add cscope.out<CR><CR>


function! CloseLeftWindow()
    if winnr('$') >= 1
        let i = 1
        while i <= winnr('$')
            if getbufvar(winbufnr(i), '&buftype') == 'help' ||
            \  getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
            \  exists('t:NERDTreeBufName') &&
            \  bufname(winbufnr(i)) == t:NERDTreeBufName ||
            \  bufname(winbufnr(i)) == '__Tag_List__'
                let i += 1
            else
                break
            endif
        endwhile
        if i == winnr('$') + 1
            if tabpagenr('$') == 1
                exec 'qall'
            else
                exec 'tabclose'
            endif
        endif
        unlet i
    endif
endfunction


autocmd bufenter * call CloseLeftWindow()


