#! /usr/bin/env python
# -*- coding: utf-8 -*-

class ValidateAction(Action):
    def run(self, filters, stdout):
        stderr = None
        print(type(stdout))

        return stdout, stderr