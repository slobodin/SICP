/*
 * environment.h
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#ifndef ENVIRONMENT_H
#define ENVIRONMENT_H

#include "utils.h"
#include "expression.h"

// WHY std::less<VariableExpression> doesn't work?????
struct compare
{
    bool operator() (const shared_ptr<VariableExpression> &a, const shared_ptr<VariableExpression> &b) const
    {
        return *a < *b;
    }
};

class Environment
{
    Environment *m_baseEnvironment;

    typedef shared_ptr<VariableExpression> Var;
    typedef shared_ptr<Expression> Val;

    std::map<Var, Val, compare> m_frame;

public:
    Environment(Environment *baseEnv);

    shared_ptr<Expression> lookupVariableValue(const Var var) const;
    void addBindingForFrame(const Var var, const Val val);

    Environment *extendEnvironment(std::list<Var> vars, std::list<Val> vals);

private:
//    static boost::function
};

Environment *globalEnvironment();

#endif // ENVIRONMENT_H
