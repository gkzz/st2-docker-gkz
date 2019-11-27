#! /usr/bin/env python
# -*- coding: utf-8 -*-

class ValidateAction(Action):
    def run(self, stdout):
        print(type(stdout))

        return stdout