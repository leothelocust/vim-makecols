" makecols.vim - Makecolumns
" Author:       Levi Olson <http://leviolson.com/>
" Version:      1.0

if !exists("g:makecols_orientation") || ! g:makecols_orientation
    let g:makecols_orientation = "horz"
endif
if !exists("g:makecols_cols") || ! g:makecols_cols
    let g:makecols_cols = 5
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
    
    " Remove the current selection
    execute lnum1 . "," . lnum2 . "delete"
    let selection = join(lines, ",")
    return selection
endfunction


function! s:convert_selection()
    let new_string = ""

    if g:makecols_orientation == "horz"
        let new_string = s:convert_selection_horz()
    else
        let new_string = s:convert_selection_vert()
    endif

    return new_string
endfunction

function! s:convert_selection_horz()
    " Setup some variables
    let c = 0
    let new_string = ""
    let selection = s:get_visual_selection()
    let old_selection = split(selection, ",")
    let @z = ""

    " For Loopage Goes here
    for i in old_selection
        if (c == 0)
            " If first selected line
            let new_string = join([new_string, i], "")
        else
            if (c % g:makecols_cols)
                " If regular column
                let new_string = join([new_string, i], "\t")
            else
                " If end of row
                let new_string = join([new_string, i], "\n")
            endif
        endif
        let c += 1
    endfor

    return join([new_string, ""], "\n")
endfunction

function! s:convert_selection_vert()
    " Setup some variables
    let c = 0
    let new_string = ""
    let list = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    let selection = s:get_visual_selection()
    let old_selection = split(selection, ",")
    let lines = len(old_selection) * 1.0
    let rows = (lines / g:makecols_cols) * 1.0
    let rows = float2nr(ceil(rows))
    let cols = list["g:makecols_cols":]
    echom string(cols)
    let @z = ""

    " For Loopage Goes here
    let a = rows
    for i in old_selection
        " echom old_selection[c]
        " echom old_selection[a]
        let a += 1
        let c += 1
    endfor

    return join([new_string, ""], "\n")
endfunction

function! s:replace_selected_text(converted_text)
    let @z = a:converted_text
    execute "normal! \"zP"
    " echom "Just replaced the selection."
    let @z = ""
    return ""
endfunction



function! s:makecols(orient, cols) range
    " backup the globals
    let default_orientation = g:makecols_orientation
    let default_cols = g:makecols_cols

    let g:makecols_orientation = a:orient
    if (v:count > 0)
        let g:makecols_cols = v:count
    else
        let g:makecols_cols = a:cols
    endif
    echom "Orient: " . g:makecols_orientation . ", No Cols: " . g:makecols_cols
    let mode = visualmode()

    if (mode !=# "V")
        echo "You must be in linewise visual mode"
        return s:beep()
    endif

    let converted_text = s:convert_selection()


    let g:makecols_orientation = default_orientation
    let g:makecols_cols = default_cols

    return s:replace_selected_text(converted_text)
endfunction


vnoremap <silent> mc :<C-U>call <SID>makecols(g:makecols_orientation, g:makecols_cols)<CR>
vnoremap <silent> mch :<C-U>call <SID>makecols("horz", g:makecols_cols)<CR>
vnoremap <silent> mcv :<C-U>call <SID>makecols("vert", g:makecols_cols)<CR>










" vim:set ft=vim sw=4 sts=4 et:
