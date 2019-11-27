#! /usr/bin/env python
# -*- coding: utf-8 -*-

class ValidateAction(Action):
    def run(self, filters, stdout):
        stderr = ""
        try:
            type_stdout=type(stdout)
            print("type(stdout): {type}".format(
                type=type_stdout
            ))
        except:
            stdout = ""

        return stdout, stderr