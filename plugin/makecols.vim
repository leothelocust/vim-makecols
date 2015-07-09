" makecols.vim - Makecolumns
" Author:       Levi Olson <http://leviolson.com/>
" Version:      1.0

function! s:beep()
    exe "norm! \<Esc>"
    return ""
endfunction

function! s:makecols()
    let lines = getpos("'<")-getpos("'>")
    echo lines
    return s:beep()
endfunction





vnoremap mc :call <SID>makecols()<CR>











" vim:set ft=vim sw=4 sts=4 et:
