#!/usr/bin/python

import sys
from DictionaryServices import *


# import csv

def to_history_file(word,result):
    f_o=open("./dict_history.dit","a+")
    # tag_str=word
    # tag_str+=","
    tag_str="--------------------------------------------------\n"
    tag_str+=result

    f_o.write(tag_str)
    f_o.close()


def main():
    word = sys.argv[1].decode('utf-8')
    result = DCSCopyTextDefinition(None, word, (0, len(word)))
    if result :
        print result.encode('utf-8')
        # to_history_file(word.encode('utf-8'),result.encode('utf-8'))
    else :
        print "nothing find for < " + word +" >"
        sys.exit(1)

        
if __name__ == '__main__':
    main()
    sys.exit(0)
