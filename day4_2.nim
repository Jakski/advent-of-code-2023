import std/[
  strutils,
  sets,
  sequtils,
  re,
  enumerate,
]

func getScore(line: string): int = 
    let matched = line
      .split(":")[1]
      .split("|")
      .map(proc (x: string): HashSet[int] =
        x.strip.split(re"\s+").map(proc (x: string): int = parseInt(x)).toHashSet
      )
      .foldl(a * b)
    return matched.len

proc main() =
  var
    sum = 0
    copies: seq[int]
  for row, line in enumerate(splitLines(readFile("input"))):
    if len(line) == 0:
      continue
    var repetitions = 1
    let score = line.getScore
    if copies.len != 0:
      repetitions += copies[0]
      copies = copies[1..^1]
    sum += repetitions
    while copies.len < score:
      copies.add(0)
    for i in 1..score:
      copies[i-1] += repetitions
  echo sum

when isMainModule:
  main()
