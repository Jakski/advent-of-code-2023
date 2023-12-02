import std/strutils

proc main() =
  var sum = 0
  for line in splitLines(readFile("input")):
    if len(line) == 0:
      continue
    let endIndex = line.find(":") + 1
    var
      red = 0
      green = 0
      blue = 0
    for s in line[endIndex .. ^1].split(";"):
      for r in s.split(","):
        var
          attrs = strip(r).split(" ")
          n = parseInt(attrs[0])
          c = attrs[1]
        if c == "red" and n > red:
          red = n
        elif c == "green" and n > green:
          green = n
        elif c == "blue" and n > blue:
          blue = n
    sum += red * green * blue
  echo sum

when isMainModule:
  main()
