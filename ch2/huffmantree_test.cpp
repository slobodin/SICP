#include <iostream>

using namespace std;
#include "huffmantree.h"

int main()
{
    vector<SymbolInfo> testSample;

    testSample.push_back(SymbolInfo("A", 8));
    testSample.push_back(SymbolInfo("B", 3));
    testSample.push_back(SymbolInfo("C", 1));
    testSample.push_back(SymbolInfo("D", 1));
    testSample.push_back(SymbolInfo("E", 1));
    testSample.push_back(SymbolInfo("F", 1));
    testSample.push_back(SymbolInfo("G", 1));
    testSample.push_back(SymbolInfo("H", 1));

    HuffmannTree tree(testSample);

    string msg = "AACCDDEFEFF";
    string encodedMsg = tree.encode(msg);
    string decodedMsg = tree.decode(encodedMsg);

    cout << "Original message:\n\n";
    cout << msg << "\n\n";
    cout << "Encoded message:\n\n";
    cout << encodedMsg << "\n\n";
    cout << "Decoded original message:\n\n";
    cout << decodedMsg << "\n\n";

    return 0;
}

