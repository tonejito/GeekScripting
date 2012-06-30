#!/usr/bin/python

__author__="Luis Ezcurdia (3zcurdia)"
__email__="ing.ezcurdia@gmail.com"

import os,sys
import hashlib
try:
	import magic
except:
    print("To run this scritp you will need pymagic")

def search(path):
    print("Searching on route : %s ..." % path)
    hash_dic = {}
    duplicates = {}

    print("This will take awhile.. so go and get a coffee.")
    for path,dirs,files in os.walk(path):
        for File in files:
            shafile = None
            shafile = hashlib.sha1()
            shafile.update( open( path+"/"+File, "rb" ).read() )
            key  = str( shafile.hexdigest() )
            if hash_dic.has_key( key ):

                if duplicates.has_key( key ):
                    duplicates[ key ].append( path+"/"+File )
                else:
                    duplicates[ key ] =  [  hash_dic[ key ] , path+"/"+File ]
            else:
                hash_dic[ key ] = path+"/"+File

    print("%d Files found" % len(duplicates))
    return duplicates, len(duplicates)

if __name__=="__main__":
    print("Duplicatrix v0.1")
    magic_square = magic.open(magic.MAGIC_NONE)
    magic_square.load()
    if len(sys.argv)>1:
        os.chdir(sys.argv[1])

    duplex, duplex_count =  search( os.getcwd() )
	
    if duplex_count>0:
        print("Generating Report: duplicated.txt")
        report = open( "duplicated.txt", "w")
        report.write( "Files duplicated: " + str(duplex_count)+ "\n" )
        for key in duplex:
            report.write( ("="*40)+ "\n"  )
            report.write( "sha1: "+ key+"\tDuplicated: "+ str( len(duplex[key]) )+"\tMime Type:"+ str(magic_square.file( duplex[key][0] )) + "\n"  )
            for item in duplex[key]:
                report.write( item+"\n" )
        report.close()

