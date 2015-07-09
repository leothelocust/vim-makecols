" makecols.vim - Makecolumns
" Author:       Levi Olson <http://leviolson.com/>
" Version:      1.0

function! s:beep()
    exe "norm! \<Esc>"
    return ""
endfunction

function! s:makecols(no_of_cols)
    return s:beep()
endfunction





nnoremap <Plug>MakeCols :<C-U>call <SID>makecols(4)<CR>


if !exists("g:makecols_no_mappings") || ! g:makecols_no_mappings
    nmap mc <Plug>MakeCols
endif











" vim:set ft=vim sw=4 sts=4 et:
