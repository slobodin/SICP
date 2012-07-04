/*
 * huffmantree.cpp
 *
 *      Author: flamingo
 *      E-mail: epiforce57@gmail.com
 */

#include "huffmantree.h"

#include <algorithm>
#include <exception>
#include <iostream>

bool NodeCmpFunc(const HuffmannTree::Node *n1, const HuffmannTree::Node *n2)
{
    return n1->weight < n2->weight;
}

HuffmannTree::Node * HuffmannTree::createTree(vector<Node *> orderedLeaves)
{
    if (orderedLeaves.size() == 1)
        return orderedLeaves.at(0);

    Node *newNode = new Node;
    newNode->left = orderedLeaves.at(0);
    newNode->right = orderedLeaves.at(1);
    newNode->symbols = orderedLeaves.at(0)->symbols + orderedLeaves.at(1)->symbols;
    newNode->weight = orderedLeaves.at(0)->weight + orderedLeaves.at(1)->weight;

    orderedLeaves.erase(orderedLeaves.begin(), orderedLeaves.begin() + 2);
    orderedLeaves.push_back(newNode);

    std::sort(orderedLeaves.begin(), orderedLeaves.end(),
              /* boost::bind actually*/
              NodeCmpFunc);

    return createTree(orderedLeaves);
}

string HuffmannTree::encodeHelper(Node *current, char letter)
{
    if (current->left == 0 && current->right == 0)
        return "";

    if (current->left->symbols.find(letter) != string::npos)
        return string("0") + encodeHelper(current->left, letter);
    if (current->right->symbols.find(letter) != string::npos)
        return string("1") + encodeHelper(current->right, letter);
    else
    {
        std::cerr << "No such symbol";
        throw std::exception();
    }
}

string HuffmannTree::decodeHelper(Node *current, string bits)
{
    if (bits.empty())
        return "";

    if (bits.at(0) == '1')
        current = current->right;
    else if (bits.at(0) == '0')
        current = current->left;

    if (current->left == 0 && current->right == 0)  // leaf
        return current->symbols + decodeHelper(root, string(bits.begin() + 1, bits.end()));
    else
        return decodeHelper(current, string(bits.begin() + 1, bits.end()));
}

HuffmannTree::HuffmannTree(const vector<SymbolInfo> &symbolsInfo)
{
    vector<SymbolInfo> symsInfo(symbolsInfo);

    std::sort(symsInfo.begin(), symsInfo.end());

    vector<Node *> leaves(symsInfo.size());
    for (size_t i = 0; i < symsInfo.size(); i++)
    {
        leaves[i] = new Node;
        leaves[i]->symbols = symsInfo[i].symbol;
        leaves[i]->weight = symsInfo[i].freq;
    }

    root = createTree(leaves);
}

string HuffmannTree::encode(string message)
{
    if (message.empty())
        return "";

    char letter = message.at(0);
    Node *current = root;
    return encodeHelper(current, letter) + encode(string(message.begin() + 1, message.end()));
}

string HuffmannTree::decode(string codedmsg)
{
    if (codedmsg.empty())
        return "";

    return decodeHelper(root, codedmsg);
}
