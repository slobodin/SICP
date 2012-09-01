/*
 * expression.cpp
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#include "expression.h"

#include "schemelist.h"
#include "environment.h"

/*
;; lambdas
(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))
  */

/*
(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence (lambda-body exp))))
    (lambda (env) (make-procedure vars bproc env))))

(define (analyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc                                       ;; only one combination
        (loop (sequentially first-proc (car rest-procs)) ;; otherwise, loop through combinations
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
    (loop (car procs) (cdr procs))))
    */

/*
(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))

(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))
*/

shared_ptr<DefinitionExpression> analyzeDefinition(const SchemeList &str)
{
    SchemeList defVarStr = str.car();

    return make_shared<DefinitionExpression>(make_shared<VariableExpression>(defVarStr),
                                             Expression::analyzeExpression(str.cdr()));
}

Expression::Expression()
{
}

shared_ptr<Expression> Expression::analyzeExpression(const std::string &str)
{
    SchemeList lst(str);

    SchemeList tag = lst.car();

    if (tag == "\'")
        return nullexpr;
    if (tag == "set!")
        return nullexpr;
    if (tag == "define")
        return analyzeDefinition(lst.cdr());
    if (tag == "if")
        return nullexpr;
    if (tag == "lambda")
        return nullexpr;
    if (tag == "begin")
        return nullexpr;
    if (isDouble(tag))
        return make_shared<NumberExpression<double> >(toDouble(tag));
    if (isInt(tag))
        return make_shared<NumberExpression<int> >(toInt(tag));
    if (isLispString(tag))
        return nullexpr;

//    std::isxdigit
//        if (tag == number);
//        if (tag == symbol);
//        if (tag == pair);

//    throw std::runtime_error(std::string("Unknown expression type ") + tag + " .");
//    ExpressionType exprType = typeBySExpression(expr);

//    new DefinitionExpr(cadr(expr), createExpression(caddr(expr)));

//    if (exprType == Quote)
//        return new QuotedExpression(List::car(List::cdr(expr)).string());
//    if (exprType == Assignment)
//        return new AssignmentExpression("");
//    if (exprType == Definition)
//        return new DefinitionExpression("");
//    if (exprType == If)
//        return new IfExpression("");
//    if (exprType == Lambda)
//        return new LambdaExpression("");
//    if (exprType == Begin)
//        return new BeginExpression("");

    return nullexpr;
}

Expression *Expression::car() const
{
}

Expression *Expression::cdr() const
{
}


VariableExpression::VariableExpression(const std::string &varSymbol)
    : m_symbol(varSymbol)
{
}

shared_ptr<Expression> VariableExpression::eval(Environment *env)
{
//    auto var = make_shared<VariableExpression>(this);
//    return env->lookupVariableValue(var);
//    env->lookupVariableValue
}

std::string VariableExpression::toString() const
{
}
/*
QuotedExpression::QuotedExpression(const std::string &value)
{
}

Expression *QuotedExpression::eval(Environment *env)
{
}

std::string QuotedExpression::toString() const
{
}

AssignmentExpression::AssignmentExpression(const std::string &value)
{
}

Expression *AssignmentExpression::eval(Environment *env)
{
}

std::string AssignmentExpression::toString() const
{
}*/

DefinitionExpression::DefinitionExpression(shared_ptr<VariableExpression> variable, shared_ptr<Expression> value)
    : m_var(variable), m_value(value)
{
}

shared_ptr<Expression> DefinitionExpression::eval(Environment *env)
{
}

std::string DefinitionExpression::toString() const
{
}
/*
IfExpression::IfExpression(const std::string &value)
{
}

Expression *IfExpression::eval(Environment *env)
{
}

std::string IfExpression::toString() const
{
}

LambdaExpression::LambdaExpression(const std::string &value)
{
}

Expression *LambdaExpression::eval(Environment *env)
{
}

std::string LambdaExpression::toString() const
{
}

BeginExpression::BeginExpression(const std::string &value)
{
}

Expression *BeginExpression::eval(Environment *env)
{
}

std::string BeginExpression::toString() const
{
}

ApplicationExpression::ApplicationExpression(const std::string &value)
{
}

Expression *ApplicationExpression::eval(Environment *env)
{
}

std::string ApplicationExpression::toString() const
{
}
*/
