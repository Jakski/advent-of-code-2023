import std/strutils
import std/tables
import std/sets

type
  Row = Table[int, ref int]
  Symbols = HashSet[int]

proc main() =
  var
    sum = 0
    prevNumbers: Row
    prevSymbols: Symbols
    numbers: Row
    symbols: Symbols
  for line in splitLines(readFile("input")):
    prevNumbers = numbers
    numbers = Row()
    prevSymbols = symbols
    symbols = Symbols()
    var
      column = 0
      word = ""
      number = new int
    if len(line) == 0:
      continue
    for c in line:
      if isDigit(c):
        word = word & $c
        numbers[column] = number
      else:
        if len(word) != 0:
          number[] = parseInt(word)
          number = new int
          word = ""
        if c != '.':
          symbols.incl(column)
      column += 1
    if len(word) != 0:
      number[] = parseInt(word)
    for symbol in symbols:
      for number in [
        prevNumbers.getOrDefault(symbol - 1),
        prevNumbers.getOrDefault(symbol),
        prevNumbers.getOrDefault(symbol + 1),
        numbers.getOrDefault(symbol - 1),
        numbers.getOrDefault(symbol + 1),
      ]:
        if number != nil:
          sum += number[]
          number[] = 0
    for symbol in prevSymbols:
      for number in [
        numbers.getOrDefault(symbol - 1),
        numbers.getOrDefault(symbol),
        numbers.getOrDefault(symbol + 1),
      ]:
        if number != nil:
          sum += number[]
          number[] = 0
  echo sum

when isMainModule:
  main()
