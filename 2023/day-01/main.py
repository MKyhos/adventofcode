import re

def getValue1(line: str) -> int:
    f_match = re.search(r'\d', line)
    l_match = re.search(r'\d', line[::-1])

    if f_match is None or l_match is None:
        print(line)

    try:
        value = int(f"{f_match.group(0)}{l_match.group(0)}")
    except:
        value = 0
        print(line)

    return value


def getValue2(line: str) -> int:

    num_map = {
        'zero': '0',
        'one': '1',
        'two': '2',
        'three': '3',
        'four': '4',
        'five': '5',
        'six': '6',
        'seven': '7',
        'eight': '8',
        'nine': '9',
    }

    written = '|'.join(num_map.keys())
    pattern = r"\d|" + written
    pattern_rev = r"\d|" + written[::-1]

    try:
        f_match = re.search(pattern, line)
        l_match = re.search(pattern_rev, line[::-1])

        f_val = f_match.group(0)
        l_val = l_match.group(0)

        if f_val in num_map.keys():
            f_val = num_map[f_val]

        if l_val[::-1] in num_map.keys():
            l_val = num_map[l_val[::-1]]

        return int(f"{f_val}{l_val}")
    except Exception as e:
        print(f"Failed on line: {line} with error {e}")
        return 0


if __name__ == "__main__":

    examples = [
            "two1nine",
            "eightwothree",
            "abcone2threexyz",
            "xtwone3four",
            "4nineeightseven2",
            "zoneight234",
            "7pqrstsixteen",
    ]

    sum_example = 0
    for ex in examples:
        val_example = getValue2(ex)
        sum_example += val_example
        print(f"Line: {ex}, value: {val_example}")

    print(f"Sum of example: {sum_example}")


    with open("input.txt", "r") as f:
        sum1 = 0
        sum2 = 0

        for line in f:
            sum1 += getValue1(line)
            sum2 += getValue2(line)

    print(f"Sum:\n - Part 1: {sum1}\n - Part 2: {sum2}")
