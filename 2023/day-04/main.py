import re

FILE = "input.txt"


def parseCard(line: str):
    line = line.replace("\n", "")

    card, values = line.split(":")
    winning, having = values.split("|")

    card_id = int(re.search(r"\d+", card).group())

    winning = {int(s) for s in winning.split(" ") if s != ""}
    having = {int(s) for s in having.split(" ") if s != ""}

    n_intersect = len(having.intersection(winning))

    return {
        "id": card_id,
        "value": n_intersect,
    }


def getValue(x: int) -> int:
    if x > 1:
        return 2 ** (x - 1)
    else:
        return x


def getCards(card_id: int) -> int:
    val = 1
    if cards[card_id] > 0:
        new_ids = range(card_id + 1, card_id + 1 + cards[card_id])

        for child_card_id in new_ids:
            val += getCards(child_card_id)

    return val


# Solution
cards = {}

# Part I (and reading)

with open(FILE, "r") as f:
    for line in f:
        res = parseCard(line)
        cards[res["id"]] = res["value"]

result_01 = sum(getValue(s) for s in cards.values())
print(f"Result for part 1: {result_01}")

# Part II

maxCards = max(cards.keys())
flashCards = 0

for id in cards.keys():
    flashCards += getCards(id)

print(f"Result for part 2: {flashCards}")
