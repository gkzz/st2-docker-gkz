#! /usr/bin/env python
# -*- coding: utf-8 -*-

class ValidateAction(Action):
    def run(self, filters, stdout):
        stderr = ""
        if type(stdout) is str:
            print('type: stdout => str')
        elif type(stdout) is int:
            print('type: stdout => int')
        elif type(stdout) is list:
            print('type: stdout => list')
        else:
            print('type: stdout => Unknowon')


        return stdout, stderr