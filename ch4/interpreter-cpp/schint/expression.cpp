/*
 * expression.cpp
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#include "expression.h"
#include <algorithm>
#include <stdexcept>

enum ExpressionType
{
    Number,
    Variable,
    Quote,
    Assignment,
    Definition,
    If,
    Lambda,
    Begin,
    Application
};

// REDO!!!!!!!!!!!!!!!!! THIS IS XYNTA

class List
{
    std::string m_listString;

    static void makeList(std::string &rawStr)
    {
        for (size_t i = 0; i < rawStr.size(); i++)
        {
            char &ch = rawStr.at(i);
            if (i != std::string::npos && i != 0)
            {
                if (std::isspace(ch))
                {
                    const char &prevCh = rawStr.at(i - 1);
                    const char &nextCh = rawStr.at(i + 1);

                    if (prevCh == '(' || nextCh == ')' || prevCh == ' ' || nextCh == ' ')
                    {
                        rawStr.erase(i, 1); i--;
                    }
                }
            }
        }
    }

public:
    List(const std::string &str) : m_listString(str)
    {
        if (str.empty() || str[0] != '(' || str[str.size() - 1] != ')')
            throw std::runtime_error("Bad expression.");
        makeList(m_listString);
    }

    ExpressionType type() const
    {
        std::string tag = car(*this).string();

        if (tag == "\'")
            return Quote;
        if (tag == "set!")
            return Assignment;
        if (tag == "define")
            return Definition;
        if (tag == "if")
            return If;
        if (tag == "lambda")
            return Lambda;
        if (tag == "begin")
            return Begin;
//        if (tag == number);
//        if (tag == symbol);
//        if (tag == pair);

        throw std::runtime_error(std::string("Unknown expression type ") + tag + " .");
    }

    // REDO!!!!!!!!!!!!!!!!! THIS IS XYNTA

    static List car(const List &lst)
    {
        if (lst.string() == "()" || lst.string().at(0) != '(')
            throw std::runtime_error("Unable to get car.");
        return List(lst.string().substr(1, lst.string().find(' ') - 1));
    }

    static List cdr(const List &lst)
    {
        std::string res = std::string("(") + lst.string().substr(lst.string().find(' '));
        makeList(res);
        return List(res);
    }

    std::string string() const { return m_listString; }
};

Expression::Expression()
{
}

Expression *Expression::createExpression(const std::string &str)
{
    List expr(str);
    ExpressionType exprType = expr.type();

    if (exprType == Quote)
        return new QuotedExpression(List::car(List::cdr(expr)).string());
    if (exprType == Assignment)
        return new AssignmentExpression("");
    if (exprType == Definition)
        return new DefinitionExpression("");
    if (exprType == If)
        return new IfExpression("");
    if (exprType == Lambda)
        return new LambdaExpression("");
    if (exprType == Begin)
        return new BeginExpression("");

    return nullptr;
}

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
}

DefinitionExpression::DefinitionExpression(const std::string &value)
{
}

Expression *DefinitionExpression::eval(Environment *env)
{
}

std::string DefinitionExpression::toString() const
{
}

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
