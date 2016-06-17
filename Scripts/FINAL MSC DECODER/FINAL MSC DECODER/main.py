#Main Decoder
import thread
import time
import decode_msc

message="Note: Until decoding summary is not given, program is running at the background"
print "*"*len(message)
print message
print "*"*len(message)
def decodethread():
    sourcedirectory="" #full path.  Blank if in a same directory
    destination="" #Example: /home/ftpuser/reconsile/data/cdr/

    filenames=[
        'BHU2BT160606_8623.dmp',
        'BHU2BT160606_8624.dmp',
        'BHU2BT160606_8625.dmp'
        ]
    
    for sourcefile in filenames:
        destfile=destination+sourcefile[:len(sourcefile)-4]+".dat"
        print "%s" % ( time.ctime(time.time()) ),":",
        print "Decoding ",sourcefile," to ",destfile
        try:
            thread.start_new_thread(decode_msc.decode,(sourcedirectory+sourcefile,destfile,'w'))
        except Exception as e:
            print "Could not start the thread for ",sourcefile,":",e
            return "ERROR"
            raise(e)
    
decodethread()
