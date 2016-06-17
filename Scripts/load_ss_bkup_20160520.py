#!/usr/bin/python
# Filename: load_ss.py

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
        self.v_log = time.strftime('%Y/%m/%d %H:%M:%S %a').ljust(30)
        self.v_head, self.v_tail = os.path.split(event.src_path)
        self.v_log = self.v_log+self.v_tail.ljust(35)
        self.v_validated = "N"

        #"Day old bread, 50% sale {0}".format("today")        
        self.v_create_qry = "CREATE TEMPORARY TABLE IF NOT EXISTS rt_loaded_call_pstn_dump( \
rf_record_no INT(8) UNSIGNED, \
rf_exchange_id VARCHAR(3), \
rf_net_type VARCHAR(2), \
rf_calling_number VARCHAR(30), \
rf_calling_category VARCHAR(2), \
rf_called_number VARCHAR(30), \
rf_called_category VARCHAR(2), \
rf_call_direction VARCHAR(1), \
rf_call_datetime DATETIME, \
rf_call_duration INT UNSIGNED, \
rf_charge_flag VARCHAR(1), \
rf_ict_tgn VARCHAR(4), \
rf_ict_cno VARCHAR(4), \
rf_oct_tgn VARCHAR(4), \
rf_oct_cno VARCHAR(4), \
rf_file_name VARCHAR(100), \
rf_create_by VARCHAR(30), \
rf_create_dt DATETIME \
) ENGINE = InnoDB;"

        self.v_load_qry = "LOAD DATA LOCAL INFILE '"+event.src_path+"' \
INTO TABLE rt_loaded_call_pstn_dump \
(@var1) \
SET rf_record_no = TRIM(SUBSTR(@var1,1,8)), \
rf_exchange_id = TRIM(SUBSTR(@var1,9,3)), \
rf_net_type = TRIM(SUBSTR(@var1,12,2)), \
rf_calling_number = TRIM(SUBSTR(@var1,14,20)), \
rf_calling_category = TRIM(SUBSTR(@var1,34,2)), \
rf_called_number = TRIM(SUBSTR(@var1,36,20)), \
rf_called_category = TRIM(SUBSTR(@var1,56,2)), \
rf_call_direction = TRIM(SUBSTR(@var1,58,1)), \
rf_call_datetime = str_to_date(SUBSTR(@var1,59,12),'%y%m%d%H%i%s'), \
rf_call_duration = TRIM(SUBSTR(@var1,71,6)), \
rf_charge_flag = TRIM(SUBSTR(@var1,77,1)), \
rf_ict_tgn = TRIM(SUBSTR(@var1,78,4)), \
rf_ict_cno = TRIM(SUBSTR(@var1,82,4)), \
rf_oct_tgn = TRIM(SUBSTR(@var1,86,4)), \
rf_oct_cno = TRIM(SUBSTR(@var1,90,4)), \
rf_create_by = USER(), \
rf_create_dt = NOW();"
        db = MySQLdb.connect("192.168.2.184","resload","ksisak","rescue")
        cursor = db.cursor()       
        cursor.execute(self.v_create_qry)
        cursor.execute("TRUNCATE TABLE rt_loaded_call_pstn_dump")
        try:
            cursor.execute(self.v_load_qry)
            cursor.execute("SELECT * FROM rt_loaded_call_pstn_dump")
            self.v_results = cursor.fetchall()
            for row in self.v_results:
                # Further Validations need to be done here
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
            print "Error while Loading data into Temporary table",str(e)
            db.rollback
	
        #shutil.move(event.src_path,event.src_path.replace('hlr/in','hlr/backup'))
	#print(time.asctime(time.localtime(time.time())))
        if int(self.v_tail.split('_')[1]) == self.v_counter:
            self.v_log = self.v_log + ("SUCCESS: %d" % self.v_counter).ljust(30)
            shutil.move(event.src_path,event.src_path.replace('softswitch/parsedfiles','softswitch/parsedfiles/backup'))
            db.commit()
        else:
            self.v_log = self.v_log + ("FAILED: %d" % self.v_counter).ljust(30)
            db.rollback()
            
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
