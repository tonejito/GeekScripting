#!/usr/bin/python

__author__="Luis Ezcurdia (3zcurdia)"
__email__="ing.ezcurdia@gmail.com"

from os import walk, getcwd
try:
	from PIL import Image
except:
    print("To run this script you will need  get instaled PIL")
    print("Downolad from: http://www.pythonware.com/products/pil/")

def image_resizer(directory, resolution=(640,480)):
    """Resize all files on directory"""
    for path,dirs,files in walk(directory):
        # get all files on directory
        for File in files:            
            abspath = path+"\\"+File
            #if File.endswith("jpg") or File.endswith("JPG"):
            try:
                im = Image.open(abspath)
                if im.size[0] > im.size[1]:
                    im = im.resize(resolution)
                else:
                    im = im.resize(resolution)
                print File, im.size
                im.save(abspath)
            except:
                continue
                
if __name__=="__main__":
    print("Image Resizer v0.1")
    if len(sys.argv)==2:	
        image_resizer( getcwd(), (int(sys.argv[1]),int(sys.argv[2])) )
        print("Done...")
    else:
        print """Runing mode:
    imageResizer <height> <width> """

    
