from io import StringIO
from tokenize import generate_tokens
from Expression import *

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
    exp.eval()


def schemeApply(proc, args):
    pass


def Eval(exprString, env):
    lst = [token[1] for token 
           in generate_tokens(StringIO(exprString).readline)
           if token[1]]
    schemeEval(Expression(lst), env)


# debug
if __name__ == "__main__":
    #schemeEval("(define (square x) (* x x))", None)
    Eval("(define x 2)", None)
    Eval("(set x 15)", None)
