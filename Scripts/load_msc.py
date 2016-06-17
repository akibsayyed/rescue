#!/usr/bin/python
# Filename: load_msc.py

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
        self.v_cdr_count = 0
        self.v_valid_count = 0
        self.v_filter_count = 0
        self.v_reject_count = 0
        self.v_record_no = 0
        self.v_call_duration = 0
        self.v_call_datetime = '0000-00-00 00:00:00'
        
        # Connecting to DataBase
        db = MySQLdb.connect("192.168.2.184","resload","ksisak","rescue")
        cursor = db.cursor()

        cursor.execute("SELECT COUNT(1) FROM rt_loader_stats0 WHERE rf_element_id = 'MSC' AND rf_file_name = '{0}'".format(self.v_tail))

        if  int(cursor.fetchone()[0]) <= 0:
            try:
                # Loading data into temporary table
                cursor.execute("SELECT * FROM rt_parameters WHERE rf_param1 = 'LOAD_MSC' ORDER BY rf_numberdata")
                self.v_results = cursor.fetchall()
                for row in self.v_results:
                    if row[2] == 'LOAD':
                        cursor.execute(row[5].format(event.src_path))
                    elif row[2] == 'COUNT':
                        cursor.execute(row[5])
                        self.v_cdr_count = int(cursor.fetchone()[0])
                    else:
                        cursor.execute(row[5])

                self.v_results = cursor.fetchall()
                for row in self.v_results:
                    # CDR Validations
                    if row[1] is None:
                        v_record_no = 0
                    else:
                        v_record_no = row[1]

                    if row[18] is None:
                        v_call_datetime = '0000-00-00 00:00:00'
                    else:
                        v_call_datetime = row[18]
                        
                    if row[19] is None:
                        v_call_duration = 0
                    else:
                        v_call_duration = row[19]
                        
                    # Inserting data into final table rt_loaded_ss_dump
                    self.v_sql = "INSERT INTO rt_loaded_msc_dump( \
rf_cdr_type, rf_record_no, rf_partial_op_rec_no, rf_last_op_rec_no, rf_calling_imsi, \
rf_calling_number, rf_calling_imei, rf_called_imsi, rf_called_number, rf_called_imei, \
rf_called_num_ton, rf_lac_id, rf_cell_id, rf_msc_id, rf_out_rg, rf_in_rg, rf_bs_type, \
rf_bs_cd, rf_call_datetime, rf_call_duration, rf_ss_cd, rf_ss_actcd, rf_msrn, \
rf_callid_no, rf_field1, rf_field2, rf_field3, rf_field4, \
rf_file_name, rf_validated, rf_create_by, rf_create_dt) \
VALUES('%s','%d','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s', \
'%s','%s','%s','%d','%s','%s','%s','%s','%s','%s','%s','%s','%s','%c',USER(),NOW())" % \
(row[0], v_record_no, row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], \
row[10], row[11], row[12], row[13], row[14], row[15], row[16], row[17], v_call_datetime, \
v_call_duration, row[20], row[21], row[22], row[23], row[24], row[25], row[26], row[27], \
self.v_tail, self.v_validated)
                    try:
                        cursor.execute(self.v_sql)
                    except Exceptio,e:
                        print 'Error while inserting into main table: \n'+str(e)
                    cursor.execute("SELECT ROW_COUNT()")
                    self.v_counter = self.v_counter + int(cursor.fetchone()[0])
            except Exception,e:
                print "SCRIPT ERROR: Error while Loading data...\n",str(e)
                db.rollback

            if self.v_cdr_count == self.v_counter:
                self.v_log = self.v_log + ("SUCCESS: %d" % self.v_counter).ljust(30)
                self.v_sql = "INSERT INTO rt_loader_stats0(\
rf_element_id, rf_file_name, rf_file_loaded, rf_cdr_count, rf_valid_count, rf_filter_count, \
rf_reject_count, rf_remarks, rf_create_by, rf_create_dt) \
VALUES('MSC', '%s', '%c', '%d', '%d', '%d', '%d', '%s', USER(),NOW())" \
% (self.v_tail, 'Y', self.v_cdr_count, self.v_valid_count, self.v_filter_count, self.v_reject_count, 'SUCCESS')
                cursor.execute(self.v_sql)
                # Moving is postponed, or else ftp_ss keeps downloading same files again and again as the files r moved to backup folder
                #shutil.move(event.src_path,event.src_path.replace('softswitch/parsedfiles','softswitch/parsedfiles/backup'))
                db.commit()
            else:
                self.v_log = self.v_log + ("***FAILED: %d" % self.v_counter).ljust(30)
                db.rollback()
                self.v_sql = "INSERT INTO rt_loader_err0(\
rf_element_id, rf_file_name, rf_file_loaded, rf_cdr_count, rf_valid_count, rf_filter_count, \
rf_reject_count, rf_remarks, rf_create_by, rf_create_dt) \
VALUES('MSC', '%s', '%c', '%d', '%d', '%d', '%d', '%s', USER(),NOW())" \
% (self.v_tail, 'N', self.v_cdr_count, self.v_valid_count, self.v_filter_count, self.v_reject_count, \
('FAILED: '+str(self.v_counter)+'/'+str(self.v_cdr_count)+' Unable to proceed.'))
                cursor.execute(self.v_sql)
                db.commit()                
        else:
            self.v_log = self.v_log + ("***REJECTED: File Already Loaded").ljust(30)
            self.v_sql = "INSERT INTO rt_loader_err0(\
rf_element_id, rf_file_name, rf_file_loaded, rf_cdr_count, rf_valid_count, rf_filter_count, \
rf_reject_count, rf_remarks, rf_create_by, rf_create_dt) \
VALUES('MSC', '%s', '%c', '%d', '%d', '%d', '%d', '%s', USER(),NOW())" \
% (self.v_tail, 'N', self.v_cdr_count, self.v_valid_count, self.v_filter_count, self.v_reject_count, \
'REJECTED: File Already Loaded')
            cursor.execute(self.v_sql)
            db.commit()                            
        print self.v_log
        db.close()

if __name__ == "__main__":
    event_handler = MyHandler()
    observer = Observer()
    observer.schedule(event_handler, path='/home/ftpuser/reconcile/data/cdrs/msc/parsedfiles', recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
