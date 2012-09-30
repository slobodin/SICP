import types

# check for self evaluating or single variable
def checkSelfEvaluating(expr, env):
    if len(expr.raw) == 1 and "(" not in expr.raw and ")" not in expr.raw:
        try:
            floatNum = float(expr.raw[0])
            return NumberExpression([floatNum]).eval(env)
        except ValueError:
            return VariableExpression([expr.raw[0]]).eval(env)
    else:
        return None

def schemeEval(expr, env):
    selfEv = checkSelfEvaluating(expr, env)
    if selfEv:
        return selfEv
    else:
        return expr.eval(env)


def schemeApply(proc, args):
    if isinstance(proc, Expression):    # compound procedure        
        procParams = proc.cdr().car()
        if len(procParams.raw) != len(args):
            return "Invalid number of arguments supplied"

        procBaseEnv = proc.cdr().cdr().cdr().car()
        frame = {}
        for i in range(len(procParams.raw)):
            frame[procParams.raw[i]] = args[i]

        procEnv = Environment(frame, procBaseEnv.raw)
        procBody = proc.cdr().cdr().car()
        return schemeEval(Expression.fromPythonList(procBody.raw), procEnv)
    elif isinstance(proc, types.FunctionType):  # built-in proc
        return proc(*args)
    else:
        print("PROC", proc)
        raise Exception


def Eval(exprString, env):
    expression = Expression.fromSchemeList(exprString)
    return schemeEval(expression, env)


# debug
if __name__ == "__main__":
    out = Eval("(define x 3.55)", globalEnvironment)
    print(out)
    out = Eval("(set x 15)", globalEnvironment)
    print(out)
    out = Eval("x", globalEnvironment)
    print(out)
    out = Eval("(define (square x) (* x x))", globalEnvironment)
    print(out)
    out = Eval("(define (fact n) (if (<= n 1) 1 (* n (fact (- n 1)))))", globalEnvironment)
    print(out)
    out = Eval("(* 3 4)", globalEnvironment)
    print(out)
    out = Eval("(square x)", globalEnvironment)
    print(out)
    out = Eval("(+ 2 2 3 (* 6 7 2))", globalEnvironment)
    print(out)
    out = Eval("(>= 2 3)", globalEnvironment)
    print(out)
    out = Eval("(fact 6)", globalEnvironment)
    print(out)

from Expression import *
from Environment import *
