/*
 * expression.cpp
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#include "expression.h"
#include "schemelist.h"

#include <stdexcept>

Expression::Expression()
{
}

//Expression::ExpressionType Expression::typeBySExpression(const std::string &sexpr)
//{
//    std::string tag = sexpr.substr(1, sexpr.find(' ') - 1);



//    throw std::runtime_error(std::string("Unknown expression type ") + tag + " .");
//}

Expression *Expression::analyzeExpression(const std::string &str)
{
    SchemeList lst(str);

    std::string tag = lst.car();

    if (tag == "\'")
        return nullptr;
    if (tag == "set!")
        return nullptr;
    if (tag == "define")
        return new DefinitionExpression(0 /* analyze (rest) */, 0);
    if (tag == "if")
        return nullptr;
    if (tag == "lambda")
        return nullptr;
    if (tag == "begin")
        return nullptr;
//        if (tag == number);
//        if (tag == symbol);
//        if (tag == pair);

    throw std::runtime_error(std::string("Unknown expression type ") + tag + " .");
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

//    return nullptr;
}

Expression *Expression::car() const
{
}

Expression *Expression::cdr() const
{
}

/*
VariableExpression::VariableExpression(const std::string &value)
{
}

Expression *VariableExpression::eval(Environment *env)
{
}

std::string VariableExpression::toString() const
{
}

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

DefinitionExpression::DefinitionExpression(Expression *variable, Expression *value)
{
}

Expression *DefinitionExpression::eval(Environment *env)
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
