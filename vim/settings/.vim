let currentdir=expand('<sfile>:p:h')

exec 'source ' . currentdir . '/plug.vim'
exec 'source ' . currentdir . '/common.vim'

let plugindir=expand(currentdir . '/../plugins')

" Plugins
call plug#begin(plugindir)

" Russian keymap
Plug 'lyokha/vim-xkbswitch'
if has('win32')
    Plug 'DeXP/xkb-switch-win'
endif

Plug 'gioele/vim-autoswap'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'mbbill/undotree'
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'PProvost/vim-ps1'

call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Compatibility with vi
set nocompatible

" Encoding
set encoding=utf-8

" Files
let filesdir=expand(currentdir . '/../files') 
let &backupdir=expand(filesdir . '/backups')
let &directory=expand(filesdir . '/swaps')
let &undodir=expand(filesdir . '/undo')
set backup
set writebackup

" Tabs
set tabstop=4
set shiftwidth=0
set et

" Syntax
syntax on

" Russian keymap enable
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчняю;abcdefghijklmnopqrstuvwxyz.

if has('win32')
    let g:XkbSwitchLib = plugindir . '/xkb-switch-win/bin/libxkbswitch64.dll'
else
    let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'
endif
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']

" Buffers
set hidden

" Fonts
if has('gui_running')
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set background=dark
    colorscheme solarized8
    set lines=60 columns=108 linespace=0
    if has('gui_win32')
        set guifont=Consolas:h11
    endif
endif

" Save last size and position
" from https://vim.fandom.com/wiki/Restore_screen_size_and_position
if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif

" Handy buffer closing
nnoremap <leader>q :Bdelete<CR>
nnoremap <leader>й :Bdelete<CR>

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

