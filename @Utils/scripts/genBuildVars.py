import sys
from common import *

config_file = sys.argv[1]

def produce_config(data):
    makefile = "# Generated By ["+__file__+"] script\n"
    for key in data:
        makefile += "{var}={val}\n".format(var=key, val=data[key])
    print makefile

produce_config(read_config(config_file))