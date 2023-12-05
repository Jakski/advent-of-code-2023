import std/[
  strutils,
  sequtils,
]

type
  Range = tuple
    destination, source, length: int
  Map = seq[Range]

converter toRange(x: seq[int]): Range =
  result.destination = x[0]
  result.source = x[1]
  result.length = x[2]

iterator iterNumbers(numbers: seq[int]): int =
  for i in numbers.distribute((numbers.len / 2).toInt):
    for i in i[0]..i[0] + i[1] - 1:
      yield i

func readMaps(lines: seq[string]): seq[Map] =
  var cursor = 3
  result.add(@[])
  while cursor < lines.len:
    if lines[cursor].len != 0:
      result[^1].add(lines[cursor].split(" ").map(proc (x: string): int = parseInt(x)))
      cursor += 1
    else:
      result.add(@[])
      cursor += 2

proc main() =
  var min = high(int)
  let
    lines = splitLines(readFile("input"))
    maps = lines.readMaps
    numbers = lines[0].split(":")[1].strip.split(" ").map(proc (x: string): int = parseInt(x))
  for i in iterNumbers(numbers):
    var n = i
    for map in maps:
      for range in map:
        if n >= range.source and n < range.source + range.length:
          n = n - range.source + range.destination
          break
    if n < min:
      min = n
  echo min

when isMainModule:
  main()
