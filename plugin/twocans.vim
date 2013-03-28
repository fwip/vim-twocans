"=============================================================================
" File: twocans.vim
" Author: Jemma Nelson <pink.fwip@gmail.com>
" WebPage: http://github.com/Fwip/vim-twocans
" License: BSD
" script type: plugin

if &cp || (exists('g:loaded_twocans_vim') && g:loaded_twocans_vim)
  finish
endif

let g:loaded_twocans_vim = 1
if ! exists('g:tc_cookie_file')
  let g:tc_cookie_file = '~/.tccookie'
endif

let g:tc_username = 'fwip_tests_things'
let g:tc_password  = 'fwippy'
let g:TC_logged_in = 0
nnoremap <leader>tc :call twocans#TCGetQuestion()<CR>
