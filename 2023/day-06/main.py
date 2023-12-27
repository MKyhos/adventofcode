
FILE = "input.txt"


def get_dist(t_push, t_total):
    if t_push >= t_total:
        return 0
    else:
        return t_push * (t_total - t_push)


def get_alternatives(msec: int, dist: int) -> int:
    count = 0
    for i in range(msec):
        if get_dist(i, msec) > dist:
            count += 1

    return count


# Part I
data = {}
with open(FILE, "r") as file:
    for line in file:
        words = line.split()
        if len(words) > 1:
            if words[0] == "Time:":
                data["time"] = [int(word) for word in words[1:]]
            if words[0] == "Distance:":
                data["distance"] = [int(word) for word in words[1:]]


alternatives_list = []
for t, d in zip(data["time"], data["distance"]):
    alternatives_list.append(get_alternatives(t, d))


output = 1
for a in alternatives_list:
    output *= a

print(f"Output for Part I: {output}")

# Part II

data_2 = {}
for key, value in data.items():
    conc = int("".join(map(str, value)))
    data_2[key] = conc


output_2 = get_alternatives(data_2["time"], data_2["distance"])
print(f"Output for Part II: {output_2}")

