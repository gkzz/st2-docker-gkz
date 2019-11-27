#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys

from st2actions.runners.pythonrunner import Action

class ValidateAction(Action):
    def run(self, filters, stdout):
        stderr = " "
        if stdout is None:
            stdout = " "
        elif type(stdout) is str:
            print('type: stdout => str')
        elif type(stdout) is int:
            print('type: stdout => int')
        elif type(stdout) is list:
            print('type: stdout => list')
        else:
            print('type: stdout => Unknowon')