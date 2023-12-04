import std/[
  strutils,
  sets,
  sequtils,
  re,
]

proc main() =
  var sum = 0
  for line in splitLines(readFile("input")):
    if len(line) == 0:
      continue
    let matched = line
      .split(":")[1]
      .split("|")
      .map(proc (x: string): HashSet[int] =
        x.strip.split(re"\s+").map(proc (x: string): int = parseInt(x)).toHashSet
      )
      .foldl(a * b)
    var lineSum = 0
    for i in matched:
      if lineSum == 0:
        lineSum = 1
      else:
        lineSum *= 2
    sum += lineSum
  echo sum

when isMainModule:
  main()
