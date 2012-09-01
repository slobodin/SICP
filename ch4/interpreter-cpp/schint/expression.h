/*
 * expression.h
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#ifndef EXPRESSION_H
#define EXPRESSION_H

#include "utils.h"

class Environment;

class Expression
{
protected:
    Expression();

public:
    virtual ~Expression() { }
    // maybe analyze
    static shared_ptr<Expression> analyzeExpression(const std::string &str);

    virtual shared_ptr<Expression> eval(Environment *env) = 0;
    virtual std::string toString() const = 0;

    Expression *car() const;
    Expression *cdr() const;
};

/**
  * Number.
  */
template<typename T>
class NumberExpression : public Expression
{
    T m_value;
public:
    NumberExpression(T value)
    {
        m_value = value;
    }

    virtual std::string toString() const
    {
        return std::to_string(m_value);
    }

    shared_ptr<Expression> eval(Environment *env)
    {
        return nullexpr;
    }
};

/**
  * Variable.
  */
class VariableExpression : public Expression
{
    std::string m_symbol;
public:
    VariableExpression(const std::string &varSymbol);

    virtual shared_ptr<Expression> eval(Environment *env);

    virtual std::string toString() const;

    bool operator< (const VariableExpression &other) const { return m_symbol < other.m_symbol; }
};

///**
//  * Quotation.
//  */
//class QuotedExpression : public Expression
//{
//public:
//    QuotedExpression(const std::string &value);

//    virtual Expression *eval(Environment *env);

//    virtual std::string toString() const;
//};

///**
//  * Assignment.
//  */
//class AssignmentExpression : public Expression
//{
//public:
//    AssignmentExpression(const std::string &value);

//    virtual Expression *eval(Environment *env);

//    virtual std::string toString() const;
//};

/**
  * Definition.
  */
class DefinitionExpression : public Expression
{
    shared_ptr<VariableExpression> m_var;
    shared_ptr<Expression> m_value;

public:
    DefinitionExpression(shared_ptr<VariableExpression> variable, shared_ptr<Expression> value);

    virtual shared_ptr<Expression> eval(Environment *env);

    virtual std::string toString() const;
};

///**
//  * If expression.
//  */
//class IfExpression : public Expression
//{
//public:
//    IfExpression(const std::string &value);

//    virtual Expression *eval(Environment *env);

//    virtual std::string toString() const;
//};

///**
//  * Lambda expression.
//  */
//class LambdaExpression : public Expression
//{
//public:
//    LambdaExpression(const std::string &value);

//    virtual Expression *eval(Environment *env);

//    virtual std::string toString() const;
//};

///**
//  * Begin expression.
//  */
//class BeginExpression : public Expression
//{
//public:
//    BeginExpression(const std::string &value);

//    virtual Expression *eval(Environment *env);

//    virtual std::string toString() const;
//};

///**
//  * Application expression.
//  */
//class ApplicationExpression : public Expression
//{
//public:
//    ApplicationExpression(const std::string &value);

//    virtual Expression *eval(Environment *env);

//    virtual std::string toString() const;
//};

#endif // EXPRESSION_H
