#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import subprocess


class Common:
    """ Common for Mydemo """
    
    def __init__(self):
        pass
    
    def execute_command(self, command):
        bool = False
        try:
            stdout, stderr = Popen(
                command, shell=True, stdout=PIPE, stderr=PIPE
            ).communicate()
            stdout = stdout.splitlines()
            stderr = stderr.splitlines()
            bool = True
        except:
            stdout = None
            stderr = traceback.format_exc()
                
        return bool, stdout, stderr