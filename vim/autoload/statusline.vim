augroup FUCUS
  autocmd!
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * call statusline#focus()
  autocmd FocusLost,WinLeave * call statusline#blur()
  autocmd User FerretAsyncStart call statusline#setjobs()
  autocmd User FerretAsyncFinish call statusline#unsetjobs()

  if exists('#TextChangedI')
    autocmd BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * call statusline#check_modified()
  else
    autocmd BufWinEnter,BufWritePost,FileWritePost,WinEnter * call statusline#check_modified()
  endif

augroup end

function! statusline#sneaking() abort
  if sneak#is_sneaking()
    return 'Jump'
  endif
  return ' '
endfunction

function! statusline#check_modified() abort
  if &modified
    " execute 'hi! link User3 User8' " with bold
    exec 'hi User3 gui=bold' .
          \' guibg=' . synIDattr(synIDtrans(hlID('User8')), 'bg', 'gui')
          \' guifg=' . synIDattr(synIDtrans(hlID('User8')), 'fg', 'gui')
  else
    " hi! link User3 User1 " with bold
    exec 'hi User3 gui=bold' .
          \' guibg=' . synIDattr(synIDtrans(hlID('User1')), 'bg', 'gui')
          \' guifg=' . synIDattr(synIDtrans(hlID('User1')), 'fg', 'gui')

  endif

endfunction

function! statusline#fileprefix() abort
  if exists('b:term_title')
    return ''
  endif
  let l:basename=expand('%:h')
  if l:basename == '' || l:basename == '.'
    return ''
  else
    " Make sure we show $HOME as ~.
    return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
  endif
endfunction

function! statusline#ft() abort
  if strlen(&ft)
    return ',' . &ft
  else
    return ''
  endif
endfunction

let g:async = 0

function! statusline#setjobs()
  let g:async = 1
endfunction

function! statusline#unsetjobs()
  let g:async = 0
endfunction

function! statusline#jobs() abort
  if g:async == 1
    return 'async'
  end
  return ''
endfunction

function! statusline#fenc() abort
  if strlen(&fenc) && &fenc !=# 'utf-8'
    return ',' . &fenc
  else
    return ''
  endif
endfunction

function! statusline#blur() abort
  " Default blurred statusline (buffer number: filename).
  let l:blurred=''
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='%<' " truncation point
  let l:blurred.='%{statusline#fileprefix()}' " Switch to User3 highlight group (bold).
  if &modified
    " modified User Color
    let l:blurred.='%8*' " Switch to User$(modif or not) highlight group (bold).
  end
  let l:blurred.='%t' " Filename.
  let l:blurred.='%=' " split left/right halves (makes background cover whole)
  call s:update_statusline(l:blurred, 'blur')
endfunction

function! statusline#focus() abort
  " `setlocal statusline=` will revert to global 'statusline' setting.
  call s:update_statusline('', 'focus')
endfunction

function! s:update_statusline(default, action) abort
  let l:statusline = s:get_custom_statusline(a:action)
  if type(l:statusline) == type('')
    " Apply custom statusline.
    execute 'setlocal statusline=' . l:statusline
  elseif l:statusline == 0
    " Do nothing.
    "
    " Note that order matters here because of Vimscript's insane coercion rules:
    " when comparing a string to a number, the string gets coerced to 0, which
    " means that all strings `== 0`. So, we must check for string-ness first,
    " above.
    return
  else
    execute 'setlocal statusline=' . a:default
  endif
endfunction

function! s:get_custom_statusline(action) abort
  let fname = expand('%:t')
  if &ft == 'command-t'
    " Will use Command-T-provided buffer name, but need to escape spaces.
    return '\ \ ' . substitute(bufname('%'), ' ', '\\ ', 'g')
  elseif &ft == 'diff' && exists('t:diffpanel') && t:diffpanel.bufname == bufname('%')
    return 'Undotree\ preview' " Less ugly, and nothing really useful to show.
  elseif &ft == 'undotree'
    return 0 " Don't override; undotree does its own thing.
  elseif &ft == 'nerdtree'
    return 0 " Don't override; NERDTree does its own thing.
  elseif fname == '__Mundo__'
    return 'Gundo'
  elseif fname == '__Mundo_Preview__'
    return 'Gundo\ Diff'
  elseif &ft == 'qf'
    if a:action == 'blur'
      return '\ Quickfix'
    else
      return '\ Quickfix%<\ %=\ ℓ\ %l/%L\ @\ %c%V\ %1*%p%%%*'
    endif
  endif
  return 1 " Use default.
endfunction

function! statusline#wc()
  if &spell
    let lnum = 1
    let n = 0
    while lnum <= line('$')
      let n = n + len(split(getline(lnum)))
      let lnum = lnum + 1
    endwhile
    return "Words:" . n . " "
  endif
  return ""
endfunction

" Ctrlp statusline
" Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
"            a:1    a:2      a:3       a:4  a:5   a:6  a:7
fu! CtrlP_main_status(...)
  let item = ' ' . (a:5 == 'mru files' ? 'mru' : a:5) . ' '
  let dir = fnamemodify(getcwd(), ':~') . ' %*'

  " only outputs current mode
  retu '%7*' . item . ' %4*%* ' . '%=%<' . '%6*%5* ' . dir
endf

" Argument: len
"           a:1
fu! CtrlP_progress_status(...)
  let len = '%#Function# '.a:1.' %*'
  let dir = ' %=%<%#LineNr# '.getcwd().' %*'
  retu len.dir
endf
