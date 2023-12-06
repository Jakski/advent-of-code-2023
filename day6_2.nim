import std/[
  strutils,
  sequtils,
  re,
]

proc main() =
  let
    lines = splitLines(readFile("input"))
    time = lines[0].split(":")[1].strip.split(re"\s+").foldl(a & b).parseInt
    distance = lines[1].split(":")[1].strip.split(re"\s+").foldl(a & b).parseInt
  var sum = 0
  for i in 0..time - 1:
    if (time - i) * i > distance:
      sum += 1
  echo sum

when isMainModule:
  main()
