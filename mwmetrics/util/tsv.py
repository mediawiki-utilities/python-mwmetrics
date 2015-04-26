import json


def read(f, header=False):
    if header:
        headers = decode_row(f.readline())
    else:
        headers = None

    for line in f:
        yield decode_row(line, headers=headers)

def encode(value):
    return json.dumps(value)

def encode_row(values, headers=None):
    if headers is None:
        return "\t".join(encode(v) for v in values)
    else:
        return "\t".join(encode(values[h]) for h in headers)

def decode(value):
    return json.loads(value)

def decode_row(line, headers=None):
    if headers is None:
        return [decode(v) for v in line.strip().split("\t")]
    else:
        return {h:decode(v) for h, v in zip(headers, decode_row(line))}
