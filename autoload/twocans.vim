"=============================================================================
" File: twocans.vim
" Author: Jemma Nelson <pink.fwip@gmail.com>
" WebPage: http://github.com/Fwip/vim-twocans
" License: BSD


function! twocans#Login()

  let submit = 'Loggest+In'
  let loginurl = 'http://twocansandstring.com/login/'
  let params = '-F login_username=' . g:tc_username . ' -F login_password=' . g:tc_password . ' -F submit=' . submit
  execute '!curl '  . params . ' '. loginurl . ' -c ' . g:tc_cookie_file
  let g:TC_logged_in = 1
endfunction

function! twocans#GetQuestion()
  if !g:TC_logged_in
    call twocans#Login()
  endif

  let url = "http://twocansandstring.com/apiw/qa/getquestion"

  execute 'r !curl -s -b ' . g:tc_cookie_file . ' ' . url
  execute 's/^.*id\^i//'
  execute 's/\^stext\^s/ /'
  execute 's/\^\^\?//'
endfunction

function! twocans#AnswerQuestion(line)
  execute '5new'
  call setline('.', a:line)
endfunction

function! twocans#OpenBuffer()
  execute '11new'
  nnoremap <buffer> q :call twocans#GetQuestion()<CR>
  nnoremap <buffer> a :call twocans#AnswerQuestion(getline('.'))<CR>
  for i in range(0)
    call twocans#GetQuestion()
  endfor

endfunction
