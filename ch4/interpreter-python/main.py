from EvalApply import *
from Environment import *

def main():
    print("Type enter (blank line) to finish")
    
    while True:
        line = input("> ")
        if line:
            output = Eval(line, globalEnvironment)
            print(output)
        else:
            break
            
    
if __name__ == "__main__":
    main()
