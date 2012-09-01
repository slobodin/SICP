/*
 * environment.cpp
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#include "environment.h"

#include "expression.h"

Environment::Environment(Environment *baseEnv)
    : m_baseEnvironment(baseEnv)
{
}

shared_ptr<Expression> Environment::lookupVariableValue(const Var var) const
{
    if (m_frame.find(var) == m_frame.end())
    {
        if (m_baseEnvironment)
            return m_baseEnvironment->lookupVariableValue(var);
    }
    else
        return m_frame.find(var)->second;

    return nullexpr;
}

void Environment::addBindingForFrame(const Var var, const Val val)
{
    m_frame[var] = val;
}

Environment *Environment::extendEnvironment(std::list<Var> vars, std::list<Val> vals)
{
    if (vars.size() != vals.size())
        throw std::runtime_error("Sizes doesn't match.");

    Environment *newEnv = new Environment(this);

    auto var = vars.begin();
    auto val = vals.begin();
    for ( ; var != vars.end(); var++, val++)
        newEnv->addBindingForFrame(*var, *val);

    return newEnv;
}

Environment *globalEnvironment()
{
    static Environment globalEnv(nullptr);

    return &globalEnv;
}
