# encoding: utf-8
import os
import sys
from common import *

host_name = sys.argv[1]
config_file = sys.argv[2]
key_loc = sys.argv[3]

config = read_config(config_file)

if not os.path.exists(key_loc):
    exs = "Key File does not exist [{path}]" .format(path=key_loc)
    raise Exception(exs)

print("""
Host {name}
  HostName {host}
  Port 22
  User {user}
  IdentityFile {loc}
""".format(loc=key_loc, name=host_name, host=config["HOST_LOCATION"], user=config["HOST_USER"]))

