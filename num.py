import sys, getopt

def main(argv):
    print(argv[1])
    print("0x", end="")
    if argv[1] == "10":
        for x in range(64):
            print("A", end="")
    elif argv[1] == "11":
        for x in range(64):
            print("B", end="")
    elif argv[1] == "12":
        for x in range(64):
            print("C", end="")
    elif argv[1] == "13":
        for x in range(64):
            print("D", end="")
    elif argv[1] == "14":
        for x in range(64):
            print("E", end="")
    elif argv[1] == "15":
        for x in range(64):
            print("F", end="")
    else:
        for x in range(64):
            print(argv[1], end="")
    print()

if __name__ == "__main__":
    main(sys.argv)