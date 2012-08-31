/*
 * expression.h
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#ifndef EXPRESSION_H
#define EXPRESSION_H

#include "eval.h"

class Expression : public Evaluable
{
public:
    Expression();

    static Expression *createExpression(const std::string &str);

    virtual std::string toString() const = 0;
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

    Evaluable *eval(Environment *env)
    {
        return nullptr;
    }
};

/**
  * Variable.
  */
class VariableExpression : public Expression
{
public:
    VariableExpression(const std::string &value);

    virtual Expression *eval(Environment *env);

    virtual std::string toString() const;
};

/**
  * Quotation.
  */
class QuotedExpression : public Expression
{
public:
    QuotedExpression(const std::string &value);

    virtual Expression *eval(Environment *env);

    virtual std::string toString() const;
};

/**
  * Assignment.
  */
class AssignmentExpression : public Expression
{
public:
    AssignmentExpression(const std::string &value);

    virtual Expression *eval(Environment *env);

    virtual std::string toString() const;
};

/**
  * Definition.
  */
class DefinitionExpression : public Expression
{
public:
    DefinitionExpression(const std::string &value);

    virtual Expression *eval(Environment *env);

    virtual std::string toString() const;
};

/**
  * If expression.
  */
class IfExpression : public Expression
{
public:
    IfExpression(const std::string &value);

    virtual Expression *eval(Environment *env);

    virtual std::string toString() const;
};

/**
  * Lambda expression.
  */
class LambdaExpression : public Expression
{
public:
    LambdaExpression(const std::string &value);

    virtual Expression *eval(Environment *env);

    virtual std::string toString() const;
};

/**
  * Begin expression.
  */
class BeginExpression : public Expression
{
public:
    BeginExpression(const std::string &value);

    virtual Expression *eval(Environment *env);

    virtual std::string toString() const;
};

/**
  * Application expression.
  */
class ApplicationExpression : public Expression
{
public:
    ApplicationExpression(const std::string &value);

    virtual Expression *eval(Environment *env);

    virtual std::string toString() const;
};

#endif // EXPRESSION_H
