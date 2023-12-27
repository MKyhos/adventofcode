



def parseMappingLine(str):

    vals = [int(s) for s in str.split(" ") if s != ""]

    dest_range = range(vals[0], vals[0] + vals[2])
    source_range = range(vals[1], vals[1] + vals[2])
    mapping = {}

    for key, value in zip(source_range, dest_range):
        mapping[key] = value

    return mapping


