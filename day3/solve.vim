" This is so bad
function! ReadSchematicFromFile(filename)
  return readfile(a:filename)
endfunction

function! IsSymbol(c)
  return a:c !~# '[0-9.]'
endfunction

function! IsAdjacentToSymbol(schematic, y, x)
  for dy in range(-1, 1)
    for dx in range(-1, 1)
      if dy == 0 && dx == 0
        continue
      endif
      let ny = a:y + dy
      let nx = a:x + dx
      if ny >= 0 && ny < len(a:schematic) && nx >= 0 && nx < len(a:schematic[ny])
        if IsSymbol(a:schematic[ny][nx])
          return 1
        endif
      endif
    endfor
  endfor
  return 0
endfunction

function! CalculateSums(schematic)
  let partNumbers = {}
  let sumPartNumbers = 0
  let sumGearRatios = 0

  " Part 1
  for y in range(len(a:schematic))
    let line = a:schematic[y]
    let x = 0
    while x < len(line)
      if line[x] =~# '[0-9]'
        let num = ''
        let partOfNumber = 0
        let startX = x
        while x < len(line) && line[x] =~# '[0-9]'
          if IsAdjacentToSymbol(a:schematic, y, x)
            let partOfNumber = 1
          endif
          let num .= line[x]
          let x += 1
        endwhile
        if partOfNumber
          let sumPartNumbers += str2nr(num)
          for i in range(startX, x-1)
            if !has_key(partNumbers, y . ',' . i)
              let partNumbers[y . ',' . i] = []
            endif
            call add(partNumbers[y . ',' . i], str2nr(num))
          endfor
        endif
      else
        let x += 1
      endif
    endwhile
  endfor

  " Part 2
  for y in range(len(a:schematic))
    let line = a:schematic[y]
    for x in range(len(line))
      if line[x] ==# '*'
        let matches = {}
        let adjacentParts = []
        let prod = 1
        for dy in range(-1, 1)
          for dx in range(-1, 1)
            let ny = y + dy
            let nx = x + dx
            if ny >= 0 && ny < len(a:schematic) && nx >= 0 && nx < len(a:schematic[ny])
              if has_key(partNumbers, ny . ',' . nx)
                if !has_key(matches, partNumbers[ny . ',' . nx][0])
                  let matches[partNumbers[ny . ',' . nx][0]] = 1
                  let prod = prod * partNumbers[ny . ',' . nx][0]
                endif
              endif
            endif
          endfor
        endfor
        if len(matches) == 2
          let sumGearRatios += prod
        endif
      endif
    endfor
  endfor

  return [sumPartNumbers, sumGearRatios]
endfunction

function! Main()
  let schematic = ReadSchematicFromFile('input.txt')
  let sums = CalculateSums(schematic)
  echo "Part 1: " . sums[0]
  echo "Part 2: " . sums[1]
endfunction
