/*
 * huffmantree.h
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#ifndef HUFFMANTREE_H
#define HUFFMANTREE_H

// Just for the comparsion with Lisp code

#include <string>
#include <vector>

using namespace std;

struct SymbolInfo
{
    string symbol;
    int freq;

    SymbolInfo(string s, int f)
        : symbol(s), freq(f) { }

    bool operator< (const SymbolInfo &other) const
    {
        return freq < other.freq;
    }
};

class HuffmannTree
{
    struct Node
    {
        string symbols;
        int weight;
        Node *left, *right;
        Node() : weight(0), left(0), right(0) { }
    };

    friend bool NodeCmpFunc(const HuffmannTree::Node *n1, const HuffmannTree::Node *n2);

    Node *root;
    Node *createTree(vector<Node *> orderedLeaves);

    string encodeHelper(Node *current, char letter);
    string decodeHelper(Node *current, string bits);

public:
    HuffmannTree(const vector<SymbolInfo> &symbolsInfo);

    string encode(string message);
    string decode(string codedmsg);
};

#endif // HUFFMANTREE_H
