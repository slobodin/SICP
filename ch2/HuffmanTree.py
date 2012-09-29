# for the comparsion with C++ code

import operator

class Node:
    
    def __init__(self, symbols, weight):        
        self.left = None
        self.right = None
        self.symbols = symbols
        self.weight = weight


class HuffmanTree:
    
    def __createTree(self, leaves):
        if len(leaves) == 1:
            return leaves[0]
            
        newNode = Node(leaves[0].symbols + leaves[1].symbols,
                       leaves[0].weight + leaves[1].weight)
        newNode.left = leaves[0]
        newNode.right = leaves[1]

        leaves = leaves[2:]
        leaves.append(newNode)
        leaves.sort(key = lambda x: x.weight)
        return self.__createTree(leaves)

    def __init__(self, alphabet):
        sorted_alphabet = sorted(alphabet.items(), key = lambda x: x[1])
        
        leaves = []
        for k, v in sorted_alphabet:
            leaves.append(Node(k, v))

        self.root = self.__createTree(leaves)
        
    def encode(self, message):
        def helper(node, letter):
            if not node.left and not node.right:
                return ""
            
            if node.left.symbols.find(letter) != -1:
                return "0" + helper(node.left, letter)
            elif node.right.symbols.find(letter) != -1:
                return "1" + helper(node.right, letter)
            else:
                raise Exception
            
        if len(message) == 0:
            return ""
        else:
            return helper(self.root, message[0]) + self.encode(message[1:])
        
    def decode(self, codedMsg):
        def helper(node, bits):
            if len(bits) == 0:
                return ""
                
            if bits[0] == "0":
                node = node.left
            elif bits[0] == "1":
                node = node.right
            else:
                raise Exception
            
            if not node.left and not node.right:
                return node.symbols + helper(self.root, bits[1:])
            else:
                return helper(node, bits[1:])
            
        if len(codedMsg) == 0:
            return ""
            
        return helper(self.root, codedMsg)
    

if __name__ == "__main__":    
    print("Huffman tree")
    hf = HuffmanTree({ "A" : 5, "B" : 3, "C" : 16, "D" : 8, "E": 1 })
    
    msg = "ABBCCCCCCEDDDCAACCCCC"
    print("Message:", msg)
    
    encodedMsg = hf.encode(msg)
    print("Encoded message:", encodedMsg)
    
    decodedMsg = hf.decode(encodedMsg)
    print("Decoded message:", decodedMsg)

    print(decodedMsg == msg)
