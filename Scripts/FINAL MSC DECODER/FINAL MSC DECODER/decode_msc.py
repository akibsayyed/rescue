from pyasn1.codec.ber import decoder
from pyasn1.codec.ber import encoder
import fields # The column segragation
from parserimp import defs as definition
import fileinfo
import time
import re

def separateComma(a): #cosolidates date or time. returns pipe separations if invalid
    separators=[m.start() for m in re.finditer(',',a)]
    s1=a[:separators[0]]
    if (len(separators)>1):
        s2=a[separators[0]+1:separators[1]]
        s3=a[separators[1]+1:]
        if (len(s1+s2+s3)<=6)and not (s1=="" or s2=="" or s3==""):
            if (int(s1)<10):
                s1="0"+s1
            if (int(s2)<10):
                s2="0"+s2
            if (int(s3)<10):
                s3="0"+s3
            return (str(s1)+str(s2)+str(s3))
        else:
            return (str(s1)+"|"+str(s2)+"|"+str(s3))
    else:
        s2=a[separators[0]+1:]
        return (str(s1)+"|"+str(s2))


def columnit(a):
    content=fields.content
    content_filter=[]
    for i in range(0,len(content)):
        pipe=0
        #content_filter.append(content[i]+"==>")
        if (content[i] in a):
            value=a[a.find(content[i])+len(content[i]):a.find(content[i])+len(content[i])+a[a.find(content[i])+len(content[i]):a.find(content[i])+len(content[i])+50].find("\n")]
            value=value.replace(")","")
            value=value.replace(" ","")
            value=value.replace("'","")
            value=value.replace("SequenceNumber=","")
            value=value.replace("SwitchIdentity=","")
            if ("datetime" in content[i]) or ("AddressString" in content[i]) or ("interruptionTime" in content[i]) or ("networkCallReference" in content[i]):
                value=separateComma(value)
            content_filter.append("|"+value)
        else:
            if ("AddressString" in content[i]):
                pipe=2
            elif ("interruptionTime" in content[i]):
                pipe=1
            elif ("networkCallReference" in content[i]):
                pipe=1
            content_filter.append('|'*pipe)
            content_filter.append('|')

    finalstring=""
    for i in range(0,len(content_filter)):
        finalstring=finalstring+content_filter[i]#+"\n";

    return finalstring+"\n"
    

def decode(fromfile,tofile,writetype):
    try:
        if (writetype=='w' or writetype=='a'):
            file = open(tofile,writetype)
        else:
            print "Invalid writetype"
        if not hasattr(fromfile, 'file'):
            data=open(fromfile,'rb')
        else:
            data=fromfile
        chunksize=2048 #optimal chunk value
        #counters for comparison purposes
        line_no=0
        block_no=0
        decoded=0
        counter=0
        failed=0
        #print"\nPlease wait. Decoding ",fromfile," and writing to ",tofile
        while True:
            line_no+=1
            block=data.read(chunksize)
            if not block:
                break
            block_no+=1
            while block and (block[0] != '\x00'):
                counter+=1
                try:
                    result, block = decoder.decode(block, asn1Spec=definition.CallDataRecord()) #decoding
                    result=result.prettyPrint()
                    result=columnit(result)
                    decoded+=1
                    file.write(result)
                except Exception as f:
                    print "\n\tDECODE FAILED AT Record: ",decoded," BLOCK: ",block_no,"\n"
                    failed+=1
                    break
        print "%s" % (time.ctime(time.time())),":",
        if (failed>0):
            print "Decoding Failed: Some error was encountered decoding ",fromfile
        else:
            print "Decoding ",fromfile," was successful"
        file.close()
    except Exception as g:
        print "Decoding Failed: Some error was encountered decoding ",fromfile
        print g
        raise(g)
