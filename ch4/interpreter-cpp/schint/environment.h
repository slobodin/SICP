/*
 * environment.h
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#ifndef ENVIRONMENT_H
#define ENVIRONMENT_H

#include <map>
#include <string>

class Evaluable;

class Environment
{
    Environment *m_baseEnvironment;

    std::map<std::string, Evaluable *> m_frame;

public:
    Environment(Environment *baseEnv);
};

Environment *globalEnvironment();

#endif // ENVIRONMENT_H
