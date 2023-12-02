import std/strutils

proc main() =
  var sum = 0
  for l in splitLines(readFile("input")):
    if len(l) == 0:
      continue
    var found = false
    var digit: char
    for c in l:
      if isDigit(c):
        digit = c
        if not found:
          found = true
          sum += parseInt($digit) * 10
    sum += parseInt($digit)
  echo sum

when isMainModule:
  main()
