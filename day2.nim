import std/strutils

const
  redCubes = 12
  greenCubes = 13
  blueCubes = 14

proc main() =
  var sum = 0
  for line in splitLines(readFile("input")):
    if len(line) == 0:
      continue
    var
      startIndex = line.find(" ") + 1
      endIndex = line.find(":") - 1
      gameId = parseInt(line[startIndex .. endIndex])
      matching = true
    for s in line[endIndex + 2 .. ^1].split(";"):
      for r in s.split(","):
        var
          attrs = strip(r).split(" ")
          n = parseInt(attrs[0])
          c = attrs[1]
        if 
          (c == "red" and n > redCubes) or
          (c == "green" and n > greenCubes) or
          (c == "blue" and n > blueCubes)
        :
          matching = false
          break
      if not matching:
        break
    if matching:
      sum += gameId
  echo sum

when isMainModule:
  main()
