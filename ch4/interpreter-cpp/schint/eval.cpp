/*
 * eval.cpp
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#include "eval.h"

Evaluable *eval(Evaluable *exp, Environment *env)
{
    return exp->eval(env);
}
