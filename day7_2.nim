import std/[
  strutils,
  algorithm,
]

type
  CardGroup = tuple[typ: char, count: int]

proc getHandValue(hand: string): int =
  var groups: array[0..4, CardGroup]
  var jokers = 0
  for char in hand[0..4]:
    if char == 'J':
      jokers += 1
      continue
    var i = 0
    for j in 0..groups.len - 1:
      if groups[i].count == 0:
        groups[i].typ = char
        groups[i].count += 1
        break
      elif groups[i].typ == char:
        groups[i].count += 1
        break
      i += 1
    while i != 0 and groups[i - 1].count < groups[i].count:
      let g = groups[i - 1]
      groups[i - 1] = groups[i]
      groups[i] = g
      i -= 1
  groups[0].count += jokers
  if groups[0].count == 5:
    return 7
  elif groups[0].count == 4:
    return 6
  elif groups[0].count == 3:
    if groups[1].count == 2:
      return 5
    else:
      return 4
  elif groups[0].count == 2:
    if groups[1].count == 2:
      return 3
    else:
      return 2
  else:
    return 1

proc getCardValue(card: char): int =
  let order = ['J', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'Q', 'K', 'A']
  result = 0
  for i in order:
    if i == card:
      break
    result += 1

proc compareHands(hand1, hand2: string): int =
  result = cmp(hand1.getHandValue(), hand2.getHandValue())
  if result == 0:
    var i = 0
    while result == 0 and i < 5:
      result = cmp(hand1[i].getCardValue(), hand2[i].getCardValue())
      i += 1

proc main() =
  var
    sum = 0
    weight = 1
  for i in readFile("input").strip.splitLines.sorted(compareHands):
    sum += weight * i.split(" ")[1].parseInt
    weight += 1
  echo sum

when isMainModule:
  main()
