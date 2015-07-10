" makecols.vim - Makecolumns
" Author:       Levi Olson <http://leviolson.com/>
" Version:      1.0

function! s:beep()
    exe "norm! \<Esc>"
    return ""
endfunction

function! s:get_visual_selection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let no_of_lines = lnum2 - lnum1
    let no_of_cols = 5
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    execute lnum1 . "," . lnum2 . "delete"

    let new_string = ""

    let c = 0
    for i in lines
        " start combining
        if (c == 0)
            let new_string = lines[i]
        else
            if (i % no_of_cols)
                let new_string = join([new_string, lines[i]], "\t")
            else
                let new_string = join([new_string, lines[i]], "\n")
            endif
        endif
        let c += 1
    endfor

    let @a = new_string
    return lines
endfunction

function! s:replace_selected_text()
    execute "normal! \"ap"
    echo "Just tried to replace the selection with the lines."
    return ""
endfunction



function! s:makecols() range
    let mode = visualmode()
    if (mode !=# "V")
        echo "You must be in linewise visual mode"
        return s:beep()
    else
        echo "You are in the right mode"
    endif
    echo s:get_visual_selection()
    return s:replace_selected_text()
endfunction


vnoremap <silent> mc :<C-U>call <SID>makecols()<CR>











" vim:set ft=vim sw=4 sts=4 et:
