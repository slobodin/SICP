from Environment import Environment, globalEnvironment

class ExpressionException(Exception): pass
class BadExpression(ExpressionException): pass
class PureVirtualFunctionCall(ExpressionException): pass    # lol, abstract methods

class Expression:
    
    def __init__(self, exprList):
        self.raw = exprList
        
    def car(self):
        if not len(self.raw):
            raise BadExpression
        
        if self.raw[1] == "(":
            return Expression(self.raw[1:self.raw.index(")") + 1])
        else:
            return Expression(self.raw[1])

    def cdr(self):
        if not len(self.raw) or self.raw[0] != "(":
            raise BadExpression
            
        if self.raw[1] == "(":
            temp = self.raw[self.raw.index(")"):]
            temp = temp[temp.index("("):]
            temp.insert(0, "(")
            return Expression(temp)
        else:
            temp = self.raw[2:]
            temp.insert(0, "(")
            return Expression(temp)
        
    def eval(self):
        raise PureVirtualFunctionCall
        #pass
        
    # def __repr__ maybe I should use this function?


class AssignmentExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)
        
    def __assignmentVariable(self):
        return VariableExpression([self.cdr().car().raw])
        
    def __assignmentValue(self):
        return Expression([self.cdr().cdr().car().raw])

    def eval(self):
        print("Eval assignment:", self.raw)
        globalEnvironment.setVariableValue(
            self.__assignmentVariable(),
            schemeEval(self.__assignmentValue(), globalEnvironment)
        )


class DefinitionExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)
        
    def __definitionVariable(self):
        var = self.cdr().car().raw
        if isinstance(var, str):
            # define variable
            return VariableExpression([var])
        else:
            # suppose, it's `(` symbol
            # define procedure
            return VariableExpression([self.cdr().car().car().raw]) 
        
    def __definitionValue(self):
        var = self.cdr().car().raw
        if isinstance(var, str):
            return Expression([self.cdr().cdr().car().raw])
        else:
            raise BadExpression         # make lambda
        
    def eval(self):
        print("Eval definition:", self.raw)
        globalEnvironment.defineVariable(
            self.__definitionVariable(),
            schemeEval(self.__definitionValue(), globalEnvironment)
        )


class IfExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)
        
    def eval(self):
        print("Eval if:", self.raw)
        pass


class LambdaExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)

    def eval(self):
        print("Eval lambda:", self.raw)
        pass


class NumberExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)

    def eval(self):
        print("Eval number:", self.raw)
        pass
        
        
class VariableExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)

    def eval(self):
        print("Eval variable:", self.raw)
        pass


class ExpressionsFactory:
    
    __objects = { 
        "set" : AssignmentExpression,
        "define" : DefinitionExpression,
        "if" : IfExpression,
        "lambda" : LambdaExpression
    }
    
    def create(self, expr):
        return self.__objects[expr.car().raw](expr.raw)
        
from EvalApply import schemeEval
