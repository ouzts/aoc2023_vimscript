let input_lines = readfile('input.txt')
let t = 0
let i = 0
let s = repeat([1], len(input_lines))

for line in input_lines
  let parts = split(substitute(line, ":", "|", ""), "|")
  let haves = split(parts[2], '\s\+')
  let n = len(filter(copy(split(parts[1], '\s\+')), 'index(h_list, v:val) >= 0'))
  let t += pow(2, n-1) * (n > 0)
  for j in range(1, min([len(input_lines), n + 1]) - 1)
    let s[i+j] += s[i]
  endfor
  let i += 1
endfor

echo float2nr(t) . " " . reduce(s, {a, v -> a + v})
