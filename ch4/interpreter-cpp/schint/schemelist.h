/*
 * schemelist.h
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#ifndef SCHEMELIST_H
#define SCHEMELIST_H

#include "utils.h"

/**
  * Lisp list string representation.
  */

class SchemeList
{
    std::string m_listString;

    void eraseWhiteSpaces();
public:
    SchemeList(const std::string &expr);

    SchemeList car() const;
    SchemeList cdr() const;

    operator std::string() { return m_listString; }
    bool operator== (const std::string &str) const { return m_listString == str; }
};

#endif // SCHEMELIST_H
