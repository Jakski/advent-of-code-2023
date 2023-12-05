import std/[
  strutils,
  sequtils,
  algorithm,
]
import system

type
  Range = tuple
    destination, source, length: int

converter toRange(x: seq[int]): Range =
  result.destination = x[0]
  result.source = x[1]
  result.length = x[2]

proc main() =
  var numbers, newNumbers: seq[int]
  let lines = splitLines(readFile("input"))
  numbers = lines[0]
    .split(":")[1]
    .strip
    .split(" ")
    .map(proc (x: string): int =
      parseInt(x)
    )
  var cursor = 3
  while cursor < lines.len:
    if lines[cursor].len != 0:
      let range: Range = lines[cursor].split(" ").map(proc (x: string): int = parseInt(x))
      numbers = numbers.filter(proc (x: int): bool =
        if x >= range.source and x <= range.source + range.length:
          newNumbers.add(x - range.source + range.destination)
          return false
        else:
          return true
      )
      cursor += 1
    else:
      numbers = concat(newNumbers, numbers)
      newNumbers = newSeq[int]()
      cursor += 2
  echo numbers.sorted(system.cmp[int])[0]

when isMainModule:
  main()
