from EvalApply import schemeEval
from Environment import Environment, globalEnvironment

def printResult(exp):
    print("Xynta")

def main():
    print("Type enter (blank line) to finish")
    
    while True:
        line = input("> ")
        if line:
            output = schemeEval(line, globalEnvironment)
            printResult(output)
        else:
            break
            
    
if __name__ == "__main__":
    main()
