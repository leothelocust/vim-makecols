" makecols.vim - Makecolumns
" Author:       Levi Olson <http://leviolson.com/>
" Version:      1.0

if !exists("g:makecols_orientation") || ! g:makecols_orientation
    let g:makecols_orientation = "horz"
endif
if !exists("g:makecols_cols") || ! g:makecols_cols
    let g:makecols_cols = "5"
endif


function! s:beep()
    exe "norm! \<Esc>"
    return ""
endfunction

function! s:get_visual_selection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    " let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    " let lines[0] = lines[0][col1 - 1:]
    execute lnum1 . "," . lnum2 . "delete"
    let selection = join(lines, ",")
    return selection
endfunction


function! s:convert_selection(selection)
    " Remove the current selection
    " Setup some variables
    let c = 0
    let selection = a:selection
    let old_selection = split(selection, ",")
    let no_of_cols = 6
    let new_string = ""
    let @z = ""

    " Let's print out some info
    echom "Old Selection: "
    echom join(old_selection, ", ")

    " For Loopage Goes here
    for i in old_selection
        if (c == 0)
            " If first selected line
            let new_string = join([new_string, i], "")
        else
            if (c % no_of_cols)
                " If regular column
                let new_string = join([new_string, i], "\t")
            else
                " If end of row
                let new_string = join([new_string, i], "\n")
            endif
        endif
        let c += 1
    endfor

    let @z = join([new_string, ""], "\n")
    return @z
endfunction

function! s:replace_selected_text()
    execute "normal! \"zP"
    echo "Just tried to replace the selection."
    return ""
endfunction



function! s:makecols(orient, cols) range
    let default_orientation = g:makecols_orientation
    let default_cols = g:makecols_cols
    let g:makecols_orientation = a:orient
    if (v:count > 0)
        let g:makecols_cols = v:count
    else
        let g:makecols_cols = a:cols
    endif
    echom "Orientation: " . g:makecols_orientation
    echom "Number of Columns: " . g:makecols_cols
    let mode = visualmode()
    if (mode !=# "V")
        echo "You must be in linewise visual mode"
        return s:beep()
    else
        echo "You are in the right mode"
    endif
    let selection = s:get_visual_selection()
    echo selection
    let converted_text = s:convert_selection(selection)


    let g:makecols_orientation = default_orientation
    let g:makecols_cols = default_cols

    return s:replace_selected_text()
endfunction


vnoremap <silent> mc :<C-U>call <SID>makecols(g:makecols_orientation, g:makecols_cols)<CR>
vnoremap <silent> mch :<C-U>call <SID>makecols("horz", g:makecols_cols)<CR>
vnoremap <silent> mcv :<C-U>call <SID>makecols("vert", g:makecols_cols)<CR>










" vim:set ft=vim sw=4 sts=4 et:
