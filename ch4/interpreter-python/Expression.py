from io import StringIO
from tokenize import generate_tokens
from functools import *
from Environment import Environment

class ExpressionException(Exception): pass
class BadExpression(ExpressionException): pass
class PureVirtualFunctionCall(ExpressionException): pass    # lol, abstract methods


# expr.raw is Python list, that represents Scheme list like
#  ['(', 'define', '(', 'square', 'x', ')', '(', '*', 'x', 'x', ')', ')']
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
            
    @staticmethod
    def cons(e1, e2):
        raw1 = reduce(lambda a, b: a + " " + b, e1.raw)
        raw2 = reduce(lambda a, b: a + " " + b, e2.raw)
        return Expression.makeExpression(raw2[0:1] + raw1 + raw2[1:])
    
    @staticmethod
    def list(*arg):
        lst = ""
        for it in arg:
            lst += " "
            if isinstance(it, Expression):
                lst += reduce(lambda a, b: a + " " + b, it.raw)
            else:
                lst += str(it)
        return Expression.makeExpression("(" + lst + ")")
    
    @staticmethod
    def makeExpression(string):
        lst = [token[1] for token 
                in generate_tokens(StringIO(string).readline)
                if token[1]]
        return Expression(lst)

    def eval(self, env):
        raise PureVirtualFunctionCall

    def apply(self):
        pass


class AssignmentExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)
        
    def __assignmentVariable(self):
        return VariableExpression([self.cdr().car().raw])
        
    def __assignmentValue(self):
        return Expression([self.cdr().cdr().car().raw])

    def eval(self, env):
        print("Eval assignment:", self.raw)
        env.set(
            self.__assignmentVariable(),
            schemeEval(self.__assignmentValue(), env)
        )
        return "ok"
    
    def apply(self):
        pass


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
            return LambdaExpression.makeLambda(
                    Expression(self.cdr().car().cdr().raw),
                    Expression(self.cdr().cdr().raw))

    def eval(self, env):
        print("Eval definition:", self.raw)
        env.define(
            self.__definitionVariable(),
            schemeEval(self.__definitionValue(), env)
        )
        return "ok"
        
    def apply(self):
        pass


class IfExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)
        
    def eval(self, env):
        print("Eval if:", self.raw)
        pass


class LambdaExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)

    def __params(self):
        return Expression(self.cdr().car().raw)
        
    def __body(self):
        return Expression(self.cdr().cdr().raw)
        
    @staticmethod
    def makeLambda(params, body):
        paramsBody = Expression.cons(params, body)
        return Expression.cons(Expression.makeExpression("lambda"), paramsBody)

    def eval(self, env):
        print("Eval lambda:", self.raw)
        compoundProc = Expression.list("procedure", self.__params(), self.__body())
        compoundProc.raw.insert(-1, env)
        return compoundProc

    def apply(self):
        pass


class NumberExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)

    def eval(self, env):
        print("Eval number:", self.raw)
        return self.raw[0]

    def apply(self):
        pass


class VariableExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)

    def eval(self, env):
        print("Eval variable:", self.raw)
        return env.lookup(self)

    def apply(self):
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
