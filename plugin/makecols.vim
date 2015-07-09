" makecols.vim - Makecolumns
" Author:       Levi Olson <http://leviolson.com/>
" Version:      1.0

function! s:beep()
    exe "norm! \<Esc>"
    return ""
endfunction

function! s:makecols()
    let selection = $selection
    let lines = getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]]
    return lines
endfunction





if !exists("g:makecols_no_mappings") || ! g:makecols_no_mappings
    vnoremap mc :call <SID>makecols()<CR>
endif











" vim:set ft=vim sw=4 sts=4 et:
