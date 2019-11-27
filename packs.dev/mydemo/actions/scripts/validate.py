#! /usr/bin/env python
# -*- coding: utf-8 -*-

class ValidateAction(Action):
    def run(self, filters, stdout):
        stderr = ""
        print("type(stdout): {type}".format(
            type=type(stdout)
        ))

        return stdout, stderr