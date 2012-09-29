class EnvironmentException(Exception): pass

class Environment:
    
    def __init__(self, initialFrame, baseEnv = None):
        self.frame = initialFrame
        self.baseEnv = baseEnv

    def define(self, variable, value):
        self.frame[variable.raw[0]] = value
        print("Environment after define var:val", self.frame)

    def set(self, variable, value):
        if variable.raw[0] in self.frame.keys():
            self.frame[variable.raw[0]] = value
        else:
            if self.baseEnv:
                self.baseEnv.set(variable, value)
            else:
                raise EnvironmentException                
        print("Environment after setting var:val", self.frame)
        
    def lookup(self, variable):
        if variable.raw[0] in self.frame.keys():
            return self.frame[variable.raw[0]]
        else:
            if self.baseEnv:
                self.baseEnv.lookup(variable)
            else:
                raise EnvironmentException


globalEnvironment = Environment({ "+" : lambda x, y: x + y,
                                  "-" : lambda x, y: x - y,
                                  "*" : lambda x, y: x * y,
                                  "/" : lambda x, y: x / y })

from Expression import *
