/*
 * utils.h
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#ifndef UTILS_H
#define UTILS_H

#include <iostream>
#include <string>
#include <sstream>
#include <map>
#include <stdexcept>
#include <algorithm>
#include <functional>
#include <list>

#include <boost/smart_ptr.hpp>
#include <boost/make_shared.hpp>
#include <boost/function.hpp>

#define nullexpr shared_ptr<Expression>()

using boost::shared_ptr;
using boost::make_shared;

inline bool isDouble(const std::string &str)
{
    std::istringstream inpStream(str);
    double inpValue = 0.0;
    if (inpStream >> inpValue)
        return true;
    else
        return false;
}

inline double toDouble(const std::string &str)
{
    std::istringstream inpStream(str);
    double inpValue = 0.0;
    inpStream >> inpValue;
    return inpValue;
}

inline bool isInt(const std::string &str)
{
    std::istringstream inpStream(str);
    int inpValue = 0.0;
    if (inpStream >> inpValue)
        return true;
    else
        return false;
}

inline double toInt(const std::string &str)
{
    std::istringstream inpStream(str);
    int inpValue = 0.0;
    inpStream >> inpValue;
    return inpValue;
}

// Not an a list. Thus, without parentheses
inline bool isLispString(const std::string &str)
{
    return (str.find('(') == std::string::npos) &&
            (str.find(')') == std::string::npos);
}

#endif // UTILS_H
