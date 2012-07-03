#!/usr/bin/python

__author__="Luis Ezcurdia (3zcurdia)"
__email__="ing.ezcurdia@gmail.com"

from os import walk, remove, getcwd, sep

def thumbs_terminator(directory):
    """Erase all thumbs.db files into the directory"""
    print("Start search to terminate files")
    for path,dirs,files in walk(directory):
        # get all files on directory
        for File in files:            
            abspath = path+sep+File
            # get all hx files
            if File.lower()=="thumbs.db" or File.lower()=="zbthumbnail.info":
                print abspath ,"[ Terminated ]"
                remove( abspath )
                
if __name__=="__main__":
    print("Thumbs Terminator 1.0.1")
    thumbs_terminator( getcwd() )
    print("Hasta la vista baby...")
    
