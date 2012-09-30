from functools import *
import copy
from Environment import Environment

class ExpressionException(Exception): pass
class BadExpression(ExpressionException): pass
class PureVirtualFunctionCall(ExpressionException): pass    # lol, abstract methods

# expr.raw is Python list, that represents Scheme list like
#  ['define', ['square', 'x'], ['*', 'x', 'x']]
class Expression:
    
    def __init__(self, exprList):
        self.raw = exprList

    def car(self):
        if not len(self.raw):
            raise BadExpression
        return Expression(self.raw[0])

    def cdr(self):
        if not len(self.raw):
            raise BadExpression
        return Expression(self.raw[1:])
            
    @staticmethod
    def cons(e1, e2):
        lst2 = copy.deepcopy(e2.raw)
        lst1 = copy.deepcopy(e1.raw)
        lst2.insert(0, lst1)
        return Expression(lst2)
        
    @staticmethod
    def fromPythonList(lst):
        # check for variables or just numbers
        if not isinstance(lst, list):
            try:
                floatNum = float(lst)
                return NumberExpression([floatNum])
            except ValueError:
                return VariableExpression([lst])
        # and return concrete expression
        concreteExpression = ExpressionsFactory.create(Expression(lst))
        if concreteExpression:
            return concreteExpression
        else:
            return ApplicationExpression(lst)

    @staticmethod
    def fromSchemeList(string):
        def createList(tokens):
            token = tokens.pop(0)
            if token == "(":
                newList = []
                while tokens[0] != ")":
                    newList.append(createList(tokens))
                tokens.pop(0)
                return newList
            elif token == ")":
                raise BadExpression
            else:
                try: return int(token)
                except ValueError:
                    try: return float(token)
                    except ValueError: return token
        
        # tokenize expression list
        tokens = string.replace("(", " ( ").replace(")", " ) ").split()
        if not len(tokens):
            raise BadExpression
        
        # create Python list, that's looks like Scheme list
        resList = createList(tokens)
        return Expression.fromPythonList(resList)

    def eval(self, env):
        return self
        #raise PureVirtualFunctionCall


class AssignmentExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)

    def __assignmentVariable(self):
        return VariableExpression([self.cdr().car().raw])
        
    def __assignmentValue(self):
        return Expression([self.cdr().cdr().car().raw])

    def eval(self, env):
        env.set(
            self.__assignmentVariable(),
            schemeEval(self.__assignmentValue(), env)
        )
        return "ok"


class DefinitionExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)
        
    def __definitionVariable(self):
        var = self.cdr().car().raw
        if isinstance(var, str):
            # define variable
            return VariableExpression([var])
        else:
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
        env.define(
            self.__definitionVariable(),
            schemeEval(self.__definitionValue(), env)
        )
        return "ok"


class IfExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)

    def __ifPredicate(self):
        return Expression.fromPythonList(self.cdr().car().raw)
        
    def __ifConsequent(self):
        return Expression.fromPythonList(self.cdr().cdr().car().raw)
    
    def __ifAlternative(self):
        return Expression.fromPythonList(self.cdr().cdr().cdr().car().raw)

    def eval(self, env):
        if schemeEval(self.__ifPredicate(), env):
            return schemeEval(self.__ifConsequent(), env)
        else:
            return schemeEval(self.__ifAlternative(), env)


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
        lambdaExpr = Expression("lambda")
        return LambdaExpression(Expression.cons(lambdaExpr, paramsBody).raw)

    def eval(self, env):
        paramsAndBody = Expression.cons(self.__params(), self.__body())
        compoundProc = Expression.cons(Expression("procedure"), paramsAndBody)
        compoundProc.raw.append(env)
        return compoundProc


class NumberExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)

    def eval(self, env):
        return self.raw[0]


class VariableExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)

    def eval(self, env):
        return env.lookup(self)


class ApplicationExpression(Expression):
    
    def __init__(self, exprList):
        super().__init__(exprList)
        
    def __operator(self):
        return VariableExpression([self.car().raw])
    
    def __operands(self):
        return Expression(self.cdr().raw)
        
    def __listOfValues(self, exprs, env):
        res = []
        for e in exprs.raw:
            if isinstance(e, list):
                evaled = schemeEval(Expression.fromPythonList(e), env)
            else:
                evaled = schemeEval(Expression([e]), env)
            res.append(evaled)
        return res

    def eval(self, env):
        return schemeApply(
            schemeEval(self.__operator(), env),
            self.__listOfValues(self.__operands(), env)
        )


class ExpressionsFactory:
    
    __objects = { 
        "set" : AssignmentExpression,
        "define" : DefinitionExpression,
        "if" : IfExpression,
        "lambda" : LambdaExpression
    }
    
    @staticmethod
    def create(expression):
        if expression.car().raw in ExpressionsFactory.__objects.keys():
            return ExpressionsFactory.__objects[expression.car().raw](expression.raw)
        else:
            return None


from EvalApply import schemeEval, schemeApply
