let lines = readfile('5.in')
let seeds = map(split(strpart(lines[0], 7), ' '), 'str2nr(v:val)')
let seedPairs = []
for i in range(0, len(seeds)-1, 2)
  call add(seedPairs, [seeds[i], seeds[i] + seeds[i+1]])
endfor

let maps = []
let cur = []
for line in lines[2:]
  if line == ''
    call add(maps, cur)
    let cur = []
  else
    let parts = split(line, ' ')
    if len(parts) == 3
      call add(cur, map(copy(parts), 'str2nr(v:val)'))
    endif
  endif
endfor
call add(maps, cur)

for i in range(len(maps))
  let m = []
  for entry in maps[i]
    call add(m, entry)
  endfor
  let next = []
  for seed in seedPairs
    let res = [[seed[0], seed[1], 0]]
    for thisMap in m
      let [start, prev, stride] = thisMap
      let end = prev + stride
      let delta = start - prev
      let i = 0
      while i < len(res)
        let [first, second, skip] = res[i]
        let [s1,s2,s3] = [first + delta, second + delta, end + delta]
        if skip
          let i+=1
          continue
        endif

        if prev <= first && second <= end
          let res[i] = [s1,s2,!skip]
        elseif prev <= first && first < end
          let res[i] = [s1,s3,!skip]
          call add(res, [end,second,skip])
        endif
        let i += 1
      endwhile
    endfor
    let next += res
  endfor
  let seedPairs = next
endfor

echo min(map(seedPairs, 'v:val[0]'))
