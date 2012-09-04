#include "utils.h"
#include "expression.h"
#include "environment.h"

std::string readExpression()
{
    std::string input;
    std::cin >> input;
    return input;
}

void promtOutput(const Expression *exp)
{
    exp->toString();
}

int main() try
{
    bool exit = false;

    std::string input;
    shared_ptr<Expression> exp;

//    while (!exit)
//    {
////        input = readExpression();
//        exp = Expression::analyzeExpression("( define x 3 )"/*input*/);

////        Expression *output = static_cast<Expression *>(eval(exp, globalEnvironment()));
////        promtOutput(output);

////        delete exp;
////        delete output;
//    }

//    delete exp;

    return 0;
}
catch (std::exception &ex)
{
    std::cerr << "Error: " << ex.what() << " Aborting.\n";
    return 1;
}
catch (...)
{
    std::cerr << "Unknown error\n";
    return 1;
}

