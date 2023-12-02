function! Solve()
  let l:lines = readfile('input.txt')
  let l:total_power = 0
  for l:line in l:lines
    let l:colors = {'red': 0, 'green': 0, 'blue': 0}
    for l:part in split(l:line, ';')
      for item in split(l:part, ',\s\+')
        let l:matches = matchlist(item, '\v(\d+)\s*(red|green|blue)')
        let colors[l:matches[2]] = max([colors[l:matches[2]], str2nr(l:matches[1])])
      endfor
    endfor
    let l:total_power += colors['red'] * colors['green'] * colors['blue']
  endfor
  return total_power
endfunction
echo Solve()
