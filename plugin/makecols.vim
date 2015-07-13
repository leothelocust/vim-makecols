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
    let cols = g:makecols_cols
    let selection = s:get_visual_selection()
    let old_selection = split(selection, ",")
    let lines = len(old_selection) * 1.0
    let rows = (lines / g:makecols_cols) * 1.0
    let rows = float2nr(ceil(rows))
    let @z = ""

    "   12 item example below
    "   0   4   8
    "   1   5   9
    "   2   6   10
    "   3   7   11
    let new_string = ""
    let row = 0
    let col = 0
    while row < rows
        let pos = row
        echom "ROW: " . row . " COL: " . col . " POS: " . pos
        if (row == 0 && col == 0)
            let content = get(old_selection, 0, "blank")
            let new_string = join([new_string, content], "")
        else
            let content = get(old_selection, row, "huh")
            let new_string = join([new_string, content], "\n")
        endif

        let col = 0
        while col < cols - 1
            let col += 1
            let pos = pos + rows
            echom "ROW: " . row . " COL: " . col . " POS: " . pos
            let content = get(old_selection, pos, "blank")
            let new_string = join([new_string, content], "\t")
        endwhile
        let row += 1
    endwhile

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
