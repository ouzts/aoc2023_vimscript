let lines = readfile('input.txt')
let times = split(lines[0])[1:]
let dist = split(lines[1])[1:]

let rv = 1
for i in range(len(times))
  let ways = 0
  let time = str2nr(times[i])
  let distance = str2nr(dist[i])
  for j in range(time)
    if ((time - j) * j) > distance
      let ways += 1
    endif
  endfor
  let rv *= ways
endfor

echo rv
