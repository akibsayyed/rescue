#!/usr/bin/python
# Filename: load_sgsn.py

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
        self.v_local_rec_seq = 0
        self.v_rec_opening_time = '0000-00-00 00:00:00'
        self.v_duration = 0
        self.v_volume_up = 0
        self.v_volume_down = 0
        self.v_change_time = '0000-00-00 00:00:00'
        
        # Connecting to DataBase
        db = MySQLdb.connect("192.168.2.184","resload","ksisak","rescue")
        cursor = db.cursor()

        cursor.execute("SELECT COUNT(1) FROM rt_loader_stats0 WHERE rf_element_id = 'SGSN' AND rf_file_name = '{0}'".format(self.v_tail))

        if  int(cursor.fetchone()[0]) <= 0:
            try:
                # Loading data into temporary table
                cursor.execute("SELECT * FROM rt_parameters WHERE rf_param1 = 'LOAD_SGSN' ORDER BY rf_numberdata")
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
                    if row[2] is None:
                        self.v_local_rec_seq = 0
                    else:
                        self.v_local_rec_seq = row[2]
                        
                    if row[19] is None:    
                        self.v_rec_opening_time = '0000-00-00 00:00:00'
                    else:
                        self.v_rec_opening_time = row[19]
                        
                    if row[20] is None:
                        self.v_duration = 0
                    else:
                        self.v_duration = row[20]
                        
                    if row[49] is None:
                        self.v_volume_up = 0
                    else:
                        self.v_volume_up = row[49]
                        
                    if row[50] is None:
                        self.v_volume_down = 0
                    else:
                        self.v_volume_down = row[50]
                        
                    if row[52] is None:
                        self.v_change_time = '0000-00-00 00:00:00'
                    else:
                        self.v_change_time = row[52]
                                        
                    # Inserting data into final table rt_loaded_ss_dump
                    self.v_sql = "INSERT INTO rt_loaded_sgsn_dump( \
rf_rec_type, rf_rec_seq_number, rf_local_rec_seq, rf_field1, rf_system_type, rf_served_imsi, \
rf_served_imei, rf_served_msisdn, rf_sgsn_addr, rf_ms_net_capability, rf_rounting_are_cd, rf_lac, \
rf_cell, rf_charging_id, rf_ggsn_addr_used, rf_apn_net_id, rf_apn_select_mode, rf_pdp_type, \
rf_served_pdp_addr, rf_rec_opening_time, rf_duration, rf_sgsn_change, rf_cause_for_rec_closing, \
rf_field2, rf_node_id, rf_field3, rf_field4, rf_charge_character, rf_field5, rf_field6, rf_field7, \
rf_apn_op_id, rf_field8, rf_scf_address, rf_field9, rf_field10, rf_field11, rf_field12, \
rf_field13, rf_field14, rf_field15, rf_field16, rf_field17, rf_field18, rf_field19, rf_field20, \
rf_field21, rf_field22, rf_field23, rf_volume_up, rf_volume_down, rf_field24, rf_change_time, \
rf_field25, rf_field26, rf_file_name, rf_validated, rf_create_by, rf_create_dt) \
VALUES('%s','%s','%d','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s', \
'%s','%s','%s','%s','%d','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s', \
'%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s', \
'%s','%d','%d','%s','%s','%s','%s','%s','%c',USER(),NOW())" \
% (row[0], row[1], self.v_local_rec_seq, row[3], row[4], row[5], row[6], row[7], row[8], row[9], \
row[10], row[11], row[12], row[13], row[14], row[15], row[16], row[17], row[18], \
self.v_rec_opening_time, self.v_duration, row[21], row[22], row[23], row[24], row[25], row[26], row[27], \
row[28], row[29], row[30], row[31], row[32], row[33], row[34], row[35], row[36], \
row[37], row[38], row[39], row[40], row[41], row[42], row[43], row[44], row[45], \
row[46], row[47], row[48], self.v_volume_up, self.v_volume_down, row[51], self.v_change_time, row[53], row[54], \
self.v_tail, self.v_validated)
                    try:
                        cursor.execute(self.v_sql)
                    except Exception,e:
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
VALUES('SGSN', '%s', '%c', '%d', '%d', '%d', '%d', '%s', USER(),NOW())" \
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
VALUES('SGSN', '%s', '%c', '%d', '%d', '%d', '%d', '%s', USER(),NOW())" \
% (self.v_tail, 'N', self.v_cdr_count, self.v_valid_count, self.v_filter_count, self.v_reject_count, \
('FAILED: '+str(self.v_counter)+'/'+str(self.v_cdr_count)+' Unable to proceed.'))
                cursor.execute(self.v_sql)
                db.commit()                
        else:
            self.v_log = self.v_log + ("***REJECTED: File Already Loaded").ljust(30)
            self.v_sql = "INSERT INTO rt_loader_err0(\
rf_element_id, rf_file_name, rf_file_loaded, rf_cdr_count, rf_valid_count, rf_filter_count, \
rf_reject_count, rf_remarks, rf_create_by, rf_create_dt) \
VALUES('SGSN', '%s', '%c', '%d', '%d', '%d', '%d', '%s', USER(),NOW())" \
% (self.v_tail, 'N', self.v_cdr_count, self.v_valid_count, self.v_filter_count, self.v_reject_count, \
'REJECTED: File Already Loaded')
            cursor.execute(self.v_sql)
            db.commit()                            
        print self.v_log
        db.close()

if __name__ == "__main__":
    event_handler = MyHandler()
    observer = Observer()
    observer.schedule(event_handler, path='/home/ftpuser/reconcile/data/cdrs/sgsn/parsedfiles', recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
