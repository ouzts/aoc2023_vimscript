function! F(s)
    let l:words = {'zero': '0', 'one': '1', 'two': '2', 'three': '3', 'four': '4', 'five': '5', 'six': '6', 'seven': '7', 'eight': '8', 'nine': '9'}
    let l:y = ''
    let l:i = 0
    while l:i < len(a:s)
        let l:matched = 0
        for l:word in keys(l:words)
            if a:s[l:i : l:i+len(l:word)-1] == l:word
                let l:y .= l:words[l:word]
                let l:matched = 1
                break
            endif
        endfor
        if !l:matched
            if a:s[l:i] =~ '\d'
                let l:y .= a:s[l:i]
            endif
        endif
        let l:i += 1
    endwhile
    if len(l:y) > 0
        return str2nr(l:y[0] . strpart(l:y, len(l:y) - 1, 1))
    else
        return 0
    endif
endfunction

function! Solve(filename)
    let l:lines = readfile(a:filename)
    let l:sum = 0
    for l:line in l:lines
        let l:sum += F(l:line)
    endfor
    return l:sum
endfunction

echo Solve('input.txt')
