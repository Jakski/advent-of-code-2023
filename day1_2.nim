import std/strutils

type
  Branch = tuple
    character: char
    subtree: DeepBTree
  DeepBTree = ref object
    branches: seq[Branch]
    value: int

proc next(b: DeepBTree, c: char): DeepBTree =
  for branch in b.branches:
    if branch.character == c:
      return branch.subtree
  return nil

proc find(b: DeepBTree, w: string): DeepBTree =
  if len(w) == 0:
    return nil
  result = b
  for c in w:
    result = result.next(c)
    if result == nil:
      break

proc add(b: DeepBTree, w: string, v: int) =
  var tree: DeepBTree = b
  var next: DeepBTree
  for c in w:
    next = tree.next(c)
    if next == nil:
      next = new DeepBTree
      tree.branches.add((character: c, subtree: next))
      tree = next
    else:
      tree = next
  tree.value = v

proc getFirst(b: DeepBTree, line: string): int =
  var
    word = ""
    cursor = b
  for c in line:
    if isDigit(c):
      return parseInt($c)
    else:
      word = word & $c
      cursor = cursor.next(c)
      while cursor == nil and len(word) != 0:
        word = word[1 .. ^1]
        cursor = b.find(word)
      if cursor == nil:
        cursor = b
      if len(cursor.branches) == 0:
        return cursor.value

proc main() =
  var
    sum = 0
    words = new DeepBTree
    reversedWords = new DeepBTree
    reversed: string
  for i in [
    ("one", 1),
    ("two", 2),
    ("three", 3),
    ("four", 4),
    ("five", 5),
    ("six", 6),
    ("seven", 7),
    ("eight", 8),
    ("nine", 9),
  ]:
    words.add(i[0], i[1])
    reversed = ""
    for i in i[0]:
      reversed = $i & reversed
    reversedWords.add(reversed, i[1])
  for l in splitLines(readFile("input")):
    if len(l) == 0:
      continue
    sum += getFirst(words, l) * 10
    reversed = ""
    for i in l:
      reversed = $i & reversed
    sum += getFirst(reversedWords, reversed)
  echo sum

when isMainModule:
  main()
