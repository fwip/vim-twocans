"=============================================================================
" File: twocans.vim
" Author: Jemma Nelson <pink.fwip@gmail.com>
" WebPage: http://github.com/Fwip/vim-twocans
" License: BSD


function! TCLogin()
  if ! (exists('g:TC_logged_in') && g:TC_logged_in)
    finish
  endif

  let submit = 'Loggest+In'
  let loginurl = 'http://twocansandstring.com/login/'
  let params = '-F login_username=' . g:tc_username . ' -F login_password=' . g:tc_password . ' -F submit=' . submit
  let cookie = '/home/jnelson/.tccookie'
  execute '!curl '  . params . ' '. loginurl . ' -c ' . g:tc_cookie_file
  let g:TC_logged_in = 1
endfunction

function! TCGetQuestion()
  let url = "http://twocansandstring.com/apiw/qa/getquestion"

  execute 'r !curl -s -b ' . g:tc_cookie_file . ' ' . url
  execute 's/^.*id\^i//'
  execute 's/\^stext\^s/ /'
  execute 's/\^\^\?//'
endfunction
