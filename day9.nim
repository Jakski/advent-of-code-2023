import std/[
  strutils,
  sequtils,
]

proc solve(firstRow: seq[int]): int =
  var
    rightMost = newSeq[int]()
    row = firstRow
  while not row.all(proc (x: int): bool = x == 0):
    let lastRow = row
    rightMost.add(lastRow[^1])
    row = newSeq[int]()
    var lastNumber = lastRow[0]
    for number in lastRow[1..^1]:
      row.add(-(lastNumber - number))
      lastNumber = number
  return rightMost.foldl(a + b)

proc main() =
  var
    sum = 0
  echo readFile("input")
    .strip
    .splitLines
    .map(proc (x: string): seq[int] = x.split(" ").map(proc (x: string): int = parseInt(x)))
    .map(proc (x: seq[int]): int = solve(x))
    .foldl(a + b)

when isMainModule:
  main()
