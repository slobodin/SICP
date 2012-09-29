class Environment:
    
    def __init__(self, initialFrame, baseEnv = None):
        self.frame = initialFrame
        self.baseEnv = baseEnv

    def defineVariable(self, variable, value):
        pass

    def setVariableValue(self, variable, value):
        pass


globalEnvironment = Environment({ "+" : lambda x, y: x + y,
                                  "-" : lambda x, y: x - y,
                                  "*" : lambda x, y: x * y,
                                  "/" : lambda x, y: x / y })

from Expression import *
