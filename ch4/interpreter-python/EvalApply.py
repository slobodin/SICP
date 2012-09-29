from Expression import *
from Environment import *

def analyzeExpr(expr):
    if len(expr.raw) == 1 and "(" not in expr.raw and ")" not in expr.raw:
        if expr.raw[0].isdigit():
            return NumberExpression(expr.raw)
        else:
            return VariableExpression(expr.raw)
            
    factory = ExpressionsFactory()
    return factory.create(expr)


def schemeEval(expr, env):
    exp = analyzeExpr(expr)    
    return exp.eval(env)


def schemeApply(proc, args):
    pass


def Eval(exprString, env):
    ret = schemeEval(Expression.makeExpression(exprString), env)
    if isinstance(ret, Expression):
        ret.apply()


# debug
if __name__ == "__main__":
    Eval("(define (square x) (* x x))", globalEnvironment)
    #Eval("(define x 2)", globalEnvironment)
    #Eval("(set x 15)", globalEnvironment)
