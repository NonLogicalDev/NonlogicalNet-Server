import json

def read_config(filename):
    with open(filename) as data_file:
        return json.load(data_file)
