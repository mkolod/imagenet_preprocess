#!/usr/bin/python
import os, subprocess, pexpect, psutil
from getpass import getpass

free_mem = lambda: psutil.virtual_memory().free / pow(1024, 3)


print("Need to purge caches to safely run training set protobuf generation.")
print("Free memory in GB before purging: %s" % free_mem())


if free_mem() < 30.0:

    cmd =  'sudo bash -c "echo 3 > /proc/sys/vm/drop_caches"'
    user = pexpect.spawn('whoami').read().strip()
    child = pexpect.spawn(cmd)

    if user != 'root':
        print("The memory is too full to process the training set.")
        print("Please enter sudo password to purge unused virtual memory.")
        print("If you choose to ignore this, purging will not happen and the app can fail at runtime.")
        purge = raw_input("Would you like to purge caches? Y/n: ")
        if purge.lower() == "y":
            sudo_pass = getpass("Enter sudo password: ")
            prompt = r'\[sudo\] password for %s: ' % user           
            idx = child.expect([prompt, pexpect.EOF], 3) 
            child.sendline(sudo_pass)
        else:
            print("Y/y not selected, will continue without purging, app may fail!")
            child.kill(9)
    child.expect(pexpect.EOF)

print("Free memory now, in GB: %s" % free_mem())
