import std/[
  strutils,
  sequtils,
  re,
]

proc main() =
  var sum = 0
  let
    lines = splitLines(readFile("input"))
    times = lines[0].split(":")[1].strip.split(re"\s+").map(proc (x: string): int = parseInt(x))
    distances = lines[1].split(":")[1].strip.split(re"\s+").map(proc (x: string): int = parseInt(x))
  for i in 0..times.len - 1:
    var better = 0
    for j in 1..times[i]:
      if (times[i] - j) * j > distances[i]:
        better += 1
    if sum == 0:
      sum = better
    else:
      sum *= better
  echo sum

when isMainModule:
  main()
