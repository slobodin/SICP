/*
 * environment.cpp
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#include "environment.h"

Environment::Environment(Environment *baseEnv)
    : m_baseEnvironment(baseEnv)
{
}

Environment *globalEnvironment()
{
    static Environment globalEnv(nullptr);

    return &globalEnv;
}
