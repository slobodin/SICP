/*
 * eval.h
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#ifndef EVAL_H
#define EVAL_H

#include <string>

class Environment;

class Evaluable
{
public:
    Evaluable() { }
    virtual ~Evaluable() { }

    virtual Evaluable *eval(Environment *env) = 0;
};

Evaluable *eval(Evaluable *exp, Environment *env);

#endif // EVAL_H
