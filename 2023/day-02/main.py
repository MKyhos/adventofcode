import re


FILE = "input.txt"

# red green blue
# SETTING = (12, 13, 14)
SETTING = (12, 13, 14)


def subtractTuple(t1, t2):
    return tuple(a - b for a, b in zip(t1, t2))


def anyNegative(tup):
    for e in tup:
        if e < 0:
            return True
    return False


def parseRow(row) -> bool:
    id_str, games_str = row.split(":")
    id = int(re.search(r'\d', id_str).group())
    games = [s.split(",") for s in games_str.split(";")]

    for game in games:
        colors = {
            "red": 0,
            "green": 0,
            "blue": 0,
        }

        colors_game = {
            parts[1]: int(parts[0])
            for item in game
            for parts in [item.strip().split()]
        }

        colors.update(colors_game)
        color_tup = (colors["red"], colors["green"], colors["blue"])
        diff = subtractTuple(SETTING, color_tup)

        if anyNegative(diff):
            return 0

    return id


count = 0
with open(FILE, "r") as f:
    for row in f:
        count += parseRow(row)

print(f"Final count: {count}")
