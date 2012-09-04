/*
 * schemelist.cpp
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#include "schemelist.h"

void SchemeList::eraseWhiteSpaces()
{
    for (size_t i = 0; i < m_listString.size(); i++)
    {
        char &ch = m_listString.at(i);
        if (i != std::string::npos && i != 0)
        {
            if (std::isspace(ch))
            {
                const char &prevCh = m_listString.at(i - 1);
                const char &nextCh = m_listString.at(i + 1);

                if (prevCh == '(' || nextCh == ')' || prevCh == ' ' || nextCh == ' ')
                {
                    m_listString.erase(i, 1); i--;
                }
            }
        }
    }
}

SchemeList::SchemeList(const std::string &expr)
    : m_listString(expr)
{
    eraseWhiteSpaces();

    if (m_listString.empty()/* || m_listString[0] != '(' || m_listString[m_listString.size() - 1] != ')'*/)
        m_listString = "()";
//        throw std::runtime_error("Bad expression.");
}

SchemeList SchemeList::car() const
{
    if (m_listString == "()" || m_listString.at(0) != '(')
        throw std::runtime_error("Unable to get car.");

    if (m_listString.find(' ') != std::string::npos)
        return SchemeList(m_listString.substr(1, m_listString.find(' ') - 1));
    else if (m_listString.find(')') != std::string::npos)
        return SchemeList(m_listString.substr(1, m_listString.find(')') - 1));
    else
        throw std::runtime_error("Unable to get car.");
}

SchemeList SchemeList::cdr() const
{
    std::string res = std::string("(") + m_listString.substr(m_listString.find(' '));

    return SchemeList(res);
}
