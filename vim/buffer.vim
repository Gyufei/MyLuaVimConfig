function! DeleteAllBuffersInWindow()
    let s:curWinNr = winnr()
    if winbufnr(s:curWinNr) == 1
        ret
    endif

    let s:curBufNr = bufnr("%")
    exe "bn"

    let s:nextBufNr = bufnr("%")

    while s:nextBufNr != s:curBufNr
        exe "bn"
        exe "bdel ".s:nextBufNr
        let s:nextBufNr = bufnr("%")
    endwhile
endfun

noremap <leader>bm :call DeleteAllBuffersInWindow()<CR>
