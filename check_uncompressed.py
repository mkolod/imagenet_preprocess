#!/usr/bin/python

import glob
import re
import sys
import tarfile

if __name__ == '__main__':
  tar_file_name = sys.argv[1]
  path_to_check = sys.argv[2]
  tar_file = tarfile.open(tar_file_name)
  tar_paths = set([_i.path for _i in tar_file])
  uncompressed_paths = files = [re.sub('(\.?\/)?(.+)', '\g<2>', _f) for _f in glob.glob(path_to_check + "/*")]
  for _f in tar_paths:
    if _f not in uncompressed_paths:
      print("%s is not fully uncompressed" % tar_file_name)
      print("Missing file: %s in %s" % (_f, path_to_check))
      sys.exit(1)
  print("%s is already fully uncompressed" % tar_file_name)

