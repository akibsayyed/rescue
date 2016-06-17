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
        self.v_log = self.v_log+self.v_tail.ljust(45)
        self.v_record_no = 0
        self.v_call_datetime = '0000-00-00 00:00:00'
        self.v_call_duration = 0
        self.v_cdr_count = 0
        self.v_valid_count = 0
        self.v_filter_count = 0
        self.v_reject_count = 0
        self.v_temp = 0
        
        # Connecting to DataBase
        db = MySQLdb.connect("192.168.2.184","resload","ksisak","rescue")
        cursor = db.cursor()

        cursor.execute("SELECT COUNT(1) FROM rt_loader_stats0 WHERE rf_element_id = 'SS' AND rf_file_name = '{0}'".format(self.v_tail))

        if  int(cursor.fetchone()[0]) <= 0:
            try:
                # Loading data into temporary table
                cursor.execute("SELECT * FROM rt_parameters WHERE rf_param1 = 'LOAD_SS' ORDER BY rf_numberdata")
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
                    #
                    # CDR Validations
                    #

                    if row[0] is None or row[0] == '':
                        self.v_record_no = 0
                    else:
                        self.v_record_no = row[0]

                    if row[8] is None or row[8] =='':
                        self.v_call_datetime = '0000-00-00 00:00:00'
                    else:
                        self.v_call_datetime = row[8]
                        
                    if row[9] is None or row[9] == '':
                        self.v_call_duration = 0
                    else:
                        self.v_call_duration = row[9]
                    
                    # Filtering: Incoming calls
                    if row[11] in ('0010', '0065', '0066', '0084', '0085', '0087', '0088', '0089', \
                                    '0098', '0770', '0911', '0912', '0913', '0914', '0915', '0916', \
                                    '1000', '1001', '0017', '0077'):
                        self.v_sql = "INSERT INTO rt_filtered_ss_dump( \
rf_record_no, rf_exchange_id, rf_net_type, rf_calling_number, rf_calling_category, \
rf_called_number, rf_called_category, rf_call_direction, rf_call_datetime, \
rf_call_duration, rf_charge_flag, rf_ict_tgn, rf_ict_cno, rf_oct_tgn, rf_oct_cno, \
rf_message_code, rf_file_name, rf_validated, rf_create_by, rf_create_dt)\
VALUES('%d','%s','%s','%s','%s','%s','%s','%s','%s','%d','%s','%s','%s','%s','%s','F0001','%s','N',USER(),NOW())" \
% (self.v_record_no, row[1], row[2], row[3], row[4], row[5], row[6], row[7], self.v_call_datetime, self.v_call_duration, \
row[10], row[11], row[12], row[13], row[14], self.v_tail)
                        cursor.execute(self.v_sql)
                        cursor.execute("SELECT ROW_COUNT()")
                        self.v_counter = self.v_counter + int(cursor.fetchone()[0])                        
                        self.v_filter_count += 1
                    else:
                        # Inserting data into final table rt_loaded_ss_dump
                        self.v_sql = "INSERT INTO rt_loaded_ss_dump( \
rf_record_no, rf_exchange_id, rf_net_type, rf_calling_number, rf_calling_category, \
rf_called_number, rf_called_category, rf_call_direction, rf_call_datetime, \
rf_call_duration, rf_charge_flag, rf_ict_tgn, rf_ict_cno, rf_oct_tgn, rf_oct_cno, \
rf_file_name, rf_create_by, rf_create_dt, rf_validated)\
VALUES('%d','%s','%s','%s','%s','%s','%s','%s','%s','%d','%s','%s','%s','%s','%s','%s',USER(),NOW(),'%c')" \
% (self.v_record_no, row[1], row[2], row[3], row[4], row[5], row[6], row[7], self.v_call_datetime, self.v_call_duration, \
row[10], row[11], row[12], row[13], row[14], self.v_tail, self.v_validated)
                        cursor.execute(self.v_sql)
                        cursor.execute("SELECT ROW_COUNT()")
                        self.v_counter = self.v_counter + int(cursor.fetchone()[0])
                        self.v_valid_count += 1
            except Exception,e:
                print "SCRIPT ERROR: Error while Loading data...\n",str(e)
                db.rollback

            if self.v_cdr_count == self.v_counter:
                self.v_log = self.v_log + ("SUCCESS: %d" % self.v_counter).ljust(30)
                self.v_sql = "INSERT INTO rt_loader_stats0(\
rf_element_id, rf_file_name, rf_file_loaded, rf_cdr_count, rf_valid_count, rf_filter_count, \
rf_reject_count, rf_remarks, rf_create_by, rf_create_dt) \
VALUES('SS', '%s', '%c', '%d', '%d', '%d', '%d', '%s', USER(),NOW())" \
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
VALUES('SS', '%s', '%c', '%d', '%d', '%d', '%d', '%s', USER(),NOW())" \
% (self.v_tail, 'N', self.v_cdr_count, self.v_valid_count, self.v_filter_count, self.v_reject_count, \
('FAILED: '+str(self.v_counter)+'/'+str(self.v_cdr_count)+' Unable to proceed.'))
                cursor.execute(self.v_sql)
                db.commit()                
        else:
            self.v_log = self.v_log + ("***REJECTED: File Already Loaded").ljust(30)
            self.v_sql = "INSERT INTO rt_loader_err0(\
rf_element_id, rf_file_name, rf_file_loaded, rf_cdr_count, rf_valid_count, rf_filter_count, \
rf_reject_count, rf_remarks, rf_create_by, rf_create_dt) \
VALUES('SS', '%s', '%c', '%d', '%d', '%d', '%d', '%s', USER(),NOW())" \
% (self.v_tail, 'N', self.v_cdr_count, self.v_valid_count, self.v_filter_count, self.v_reject_count, \
'REJECTED: File Already Loaded')
            cursor.execute(self.v_sql)
            db.commit()                            
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
