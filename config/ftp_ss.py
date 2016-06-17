"""
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ PROGRAM: SOFTSWITCH CDR file downloader
+
+     Version         Date       Author              Remarks
+  ------------- --------------  ------------------- ---------------------------------------------------
+       1.00        01/05/2016    Gopal Nepal         Original Version
+                                                    Script for downloading SOFTSWITCH CDRs
+       1.00        01/05/2016    SSK                 Dividing the script into multiple smaller scripts
+       1.00        01/05/2016    Phuntsho            Minor display of downloading files with date and time
+       1.00        01/05/2016    SSK,Phuntsho,Gopal  Miscalling of method extra times correct.
+       1.00        01/06/2016    Phuntsho            Correct Logs showing non-download files
+       1.00        03/05/2016    Team                Separating MSC and SMSC files, latest 24 hours files
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""

# Program to download SOFTSWITCH CDR files from Legacy system to FTP server.

import os
import time
import schedule
import ftputil
import datetime

ftp_host = "192.168.128.201"
ftp_usr  = "parallel"
ftp_pwd  = "S0ft11111100000"
ftp_node     = "Softswitch"

ftp_src  = "/IC_CDR/softswitchthimphu/ap1/second/normal/"
ftp_dest = "/home/ftpuser/reconcile/data/cdrs/softswitch/parsedfiles"

# Function to do the checking of new file and downloading it.

def ftp_cdr_downloads():
    try:
        with ftputil.FTPHost(ftp_host, ftp_usr, ftp_pwd) as node_source:
            print unicode(datetime.datetime.now())+">Download Started for "+ftp_node+"<"
            node_source.chdir(ftp_src)
            os.chdir(ftp_dest)
            file_list = node_source.listdir(node_source.curdir)

            past = time.time() - 24*60*60

            for file_name in file_list:
                if (node_source.path.isfile(file_name)) and ('ss' in file_name.lower()) and (node_source.path.getmtime(file_name)>=past):
                    if node_source.download_if_newer(file_name,file_name):
                        print unicode(datetime.datetime.now())+">Downloading :"+file_name

            print unicode(datetime.datetime.now())+">Download Complete for "+ftp_node+"<"

    except Exception,e:
        print "ERROR: ", str(e),"EOE"
        
schedule.every().hour.do(ftp_cdr_downloads)

while True:
    schedule.run_pending()
    time.sleep(1)


