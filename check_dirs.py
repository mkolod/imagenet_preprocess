import os
from collections import defaultdict

def get_dir_structure(root_dir, absolute_path = False):
    file_d = defaultdict(list)
    for folder, sub, files in os.walk(root_dir):        
        for file in files:
            f = folder if absolute_path else folder.replace(root_dir, "").strip("/")
            file_d[f].append(file)
    for key, value in file_d.iteritems():
        value.sort()
    return file_d

file_dict = get_dir_structure('/home/marek/src', absolute_path = False)

for key, value in file_dict.iteritems():
    print("%s:\n%s\n\n" % (key, value))
