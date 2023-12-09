import std/[
  strutils,
  sequtils,
  tables,
  re,
]

type
  Pair = ref object
    final: bool
    left: Pair
    right: Pair

proc main() =
  var pairs: Table[string, Pair]
  let
    lines = readFile("input").strip.splitLines
    route = lines[0]
    routeLength = route.len
  for line in lines[2..^1]:
    let words = line.split(re"[= ,()]+")
    for word in words:
      if not pairs.hasKey(word):
        pairs[word] = Pair()
    pairs[words[0]].left = pairs[words[1]]
    pairs[words[0]].right = pairs[words[2]]
    pairs[words[0]].final = words[0] == "ZZZ"
  var
    cursor = pairs["AAA"]
    count = 0
  while not cursor.final:
    let direction = route[count mod routeLength]
    if direction == 'L':
      cursor = cursor.left
    else:
      cursor = cursor.right
    count += 1
  echo count

when isMainModule:
  main()
