" makecols.vim - Makecolumns
" Author:       Levi Olson <http://leviolson.com/>
" Version:      1.0

function! s:makecols()
    return s:get_visual_selection()
endfunction

function! s:get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return lines
  " return join(lines, "\n")
endfunction




vnoremap mc :call <SID>makecols()<CR>











" vim:set ft=vim sw=4 sts=4 et:
