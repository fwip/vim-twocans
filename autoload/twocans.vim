"=============================================================================
" File: twocans.vim
" Author: Jemma Nelson <pink.fwip@gmail.com>
" WebPage: http://github.com/Fwip/vim-twocans
" License: BSD


function! twocans#Login()

  let submit = 'Loggest+In'
  let loginurl = 'http://twocansandstring.com/login/'
  let params = '-F login_username=' . g:tc_username . ' -F login_password=' . g:tc_password . ' -F submit=' . submit
  execute 'r !curl '  . params . ' '. loginurl . ' -c ' . g:tc_cookie_file . ' -s '
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

function! twocans#OpenAnswerBuffer(line)
  execute '5new'
  call setline('.', a:line)
endfunction

function! twocans#AnswerQuestion()
  let id = substitute(getline('1'), '\s.*', '', '')

  let answer = join(getline(2,'$'), "\n")
  let answer = substitute(answer, '^\n\+', '', '')
  let answer = substitute(answer, '\n\+$', '', '')
  call twocans#SendAnswer(id, answer)
endfunction

function! twocans#SendAnswer(id, answer)
  let answer = substitute(a:answer, '\n', '\\\\n', 'g')
  let url = 'http://twocansandstring.com/apiw/qa/answer/' . a:id . '/'
  let params = "-d text='" . answer . "'"
  execute 'r !curl ' . params . ' ' . url . ' -b ' . g:tc_cookie_file . ' -s '
endfunction

function! twocans#OpenBuffer()
  execute '11new'
  nnoremap <buffer> q :call twocans#GetQuestion()<CR>
  nnoremap <buffer> a :call twocans#OpenAnswerBuffer(getline('.'))<CR>
  for i in range(0)
    call twocans#GetQuestion()
  endfor

endfunction
