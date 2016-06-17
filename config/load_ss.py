#!/usr/bin/python
# Filename: load_ss.py

"""
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ PROGRAM: This script watches for new files that are being downloaded by ftp_ss.py and load them
+               into table rt_loaded_call_pstn real time.
+
+     Version         Date       Author              Remarks
+  ------------- --------------  ------------------- ---------------------------------------------------
+       1.00        22/05/2016   SSK                 Original Version
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"""


import os
import sys
import time
import shutil
from watchdog.observers import Observer
from watchdog.events import PatternMatchingEventHandler
from watchdog.events import FileSystemEventHandler
import MySQLdb

class MyHandler(FileSystemEventHandler):
    def on_created(self, event):
        # Initializing variables
        self.v_counter = 0
        self.v_validated = "N"
        self.v_head, self.v_tail = os.path.split(event.src_path)
        self.v_log = time.strftime('%Y/%m/%d %H:%M:%S %a').ljust(30)
        self.v_log = self.v_log+self.v_tail.ljust(35)

        # Connecting to DataBase
        db = MySQLdb.connect("192.168.2.184","resload","ksisak","rescue")
        cursor = db.cursor()

        cursor.execute("SELECT COUNT(1) FROM rt_loader_stats WHERE rf_element_id = 'SOF' AND rf_file_name = '{0}'".format(self.v_tail))
        if int(cursor.fetchone()[0]) <= 0:
            try:
                # Loading data into temporary table
                cursor.execute("SELECT * FROM rt_parameters WHERE rf_param1 = 'LOAD_SS' ORDER BY rf_numberdata")
                self.v_results = cursor.fetchall()
                for row in self.v_results:
                    if row[2] == 'LOAD':
                        cursor.execute(row[5].format(event.src_path))
                    else:
                        cursor.execute(row[5])

                self.v_results = cursor.fetchall()
                for row in self.v_results:
                    # Performing each record wise validations on temporary table and inserting into main table 
                    self.v_sql = "INSERT INTO rt_loaded_call_pstn( \
rf_record_no, rf_exchange_id, rf_net_type, rf_calling_number, rf_calling_category, \
rf_called_number, rf_called_category, rf_call_direction, rf_call_datetime, \
rf_call_duration, rf_charge_flag, rf_ict_tgn, rf_ict_cno, rf_oct_tgn, rf_oct_cno, \
rf_file_name, rf_create_by, rf_create_dt, rf_validated)\
VALUES('%d','%s','%s','%s','%s','%s','%s','%s','%s','%d','%s','%s','%s','%s','%s','%s','%s','%s','%c')" % \
(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], \
row[10], row[11], row[12], row[13], row[14], self.v_tail, row[16], row[17], self.v_validated)
                    cursor.execute(self.v_sql)
                    cursor.execute("SELECT ROW_COUNT()")
                    self.v_counter = self.v_counter + int(cursor.fetchone()[0])
            except Exception,e:
                print "SCRIPT ERROR: Error while Loading data...\n",str(e)
                db.rollback
            
            if int(self.v_tail.split('_')[1]) == self.v_counter:
                self.v_log = self.v_log + ("SUCCESS: %d" % self.v_counter).ljust(30)
                self.v_sql = "INSERT INTO rt_loader_stats(\
rf_element_id, rf_file_name, rf_cdr_count, rf_create_by, rf_create_dt)\
VALUES('SOF','%s', '%d', USER(),NOW())" % (self.v_tail, self.v_counter)
                cursor.execute(self.v_sql)
                # Moving is postponed, or else ftp_ss keeps downloading same files again and again as the files r moved to backup folder
                #shutil.move(event.src_path,event.src_path.replace('softswitch/parsedfiles','softswitch/parsedfiles/backup'))
                db.commit()
            else:
                self.v_log = self.v_log + ("***FAILED: %d" % self.v_counter).ljust(30)
                db.rollback()
        else:
            self.v_log = self.v_log + ("***REJECTED: File Already Loaded").ljust(30)
            
        print self.v_log
        db.close()

if __name__ == "__main__":
    event_handler = MyHandler()
    observer = Observer()
    observer.schedule(event_handler, path='/home/ftpuser/reconcile/data/cdrs/softswitch/parsedfiles', recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
