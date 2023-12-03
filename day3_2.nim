import std/strutils
import std/enumerate
import std/tables

type
  NumberSet = seq[ref int]
  Row = tuple
    stars: Table[int, NumberSet]
    numbers: Table[int, ref int]
  Rows = seq[Row]

proc addNumber(s: var NumberSet, v: ref int) =
  if v == nil:
    return
  for i in s:
    if i == v:
      return
  s.add(v)

proc detectGears(rows: var Rows) =
  for column, numbers in mpairs(rows[^1].stars):
    if len(rows) >= 2:
      for i in [-1, 0, 1]:
        numbers.addNumber(rows[^2].numbers.getOrDefault(column + i, nil))
    for i in [-1, 1]:
      numbers.addNumber(rows[^1].numbers.getOrDefault(column + i, nil))
  if len(rows) >= 2:
    for column, number in pairs(rows[^1].numbers):
      for i in [-1, 0, 1]:
        if rows[^2].stars.hasKey(column + i):
          rows[^2].stars[column + i].addNumber(number)

func sumGears(row: Row): int =
  for n in values(row.stars):
    if len(n) == 2:
      result += n[0][] * n[1][]

proc readRow(line: string): Row =
  var
    word = ""
    number = new int
  for column, char in enumerate(line):
    if isDigit(char):
      word = word & $char
      result.numbers[column] = number
    else:
      if len(word) != 0:
        number[] = parseInt(word)
        number = new int
        word = ""
      if char == '*':
        result.stars[column] = @[]
  if len(word) != 0:
    number[] = parseInt(word)

proc main() =
  var
    rows: Rows
    sum = 0
  for line in splitLines(readFile("input")):
    if len(line) == 0:
      continue
    if len(rows) > 1:
      sum += rows[0].sumGears()
      rows.delete(0)
    rows.add(readRow(line))
    rows.detectGears()
  sum += rows[0].sumGears() + rows[1].sumGears()
  echo sum

when isMainModule:
  main()
