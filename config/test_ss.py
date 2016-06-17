#!/usr/bin/python
# Filename: test_ss.py

import os
import sys
import time
import shutil
import MySQLdb

class MyHandler():
    def on_created(self, event):
        # Initializing variables
        self.v_counter = 0
	print "CHECK: "+event
        self.v_log = time.strftime('%Y/%m/%d %H:%M:%S %a').ljust(30)
        self.v_head, self.v_tail = os.path.split(event)
        self.v_log = self.v_log+self.v_tail.ljust(30)
        self.v_validated = "N"
        print self.v_log
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

        self.v_load_qry = "LOAD DATA LOCAL INFILE '"+event+"' \
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
	print "After initializing the variables..."
        db = MySQLdb.connect("192.168.2.184","resload","ksisak","rescue")
        cursor = db.cursor()       
	print "Connected to DataBase..."
        cursor.execute(self.v_create_qry)
	print "Temporary Table is created..."
        cursor.execute("TRUNCATE TABLE rt_loaded_call_pstn_dump")
	print "Temporary Table TRUNCATED"
        try:
            cursor.execute(self.v_load_qry)
	    print "Loading is DONE..."
            cursor.execute("SELECT COUNT(*) FROM rt_loaded_call_pstn_dump")
            self.v_results = cursor.fetchone()
            self.v_log = self.v_log + ("No.of Records Loaded: %s" % self.v_results).ljust(30)
            cursor.execute("SELECT * FROM rt_loaded_call_pstn_dump")
            self.v_results = cursor.fetchall()
            print self.v_log
            for row in self.v_results:
                # Further Validations need to be done here
                self.v_sql = "INSERT INTO rt_loaded_call_pstn( \
rf_record_no, rf_exchange_id, rf_net_type, rf_calling_number, rf_calling_category, \
rf_called_number, rf_called_category, rf_call_direction, rf_call_datetime, \
rf_call_duration, rf_charge_flag, rf_ict_tgn, rf_ict_cno, rf_oct_tgn, rf_oct_cno, \
rf_file_name, rf_create_by, rf_create_dt, rf_validated) \
VALUES('%d','%s','%s','%s','%s','%s','%s','%s','%s','%d','%s','%s','%s','%s','%s','%s','%s','%s','%c')" % \
(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], \
row[10], row[11], row[12], row[13], row[14], event, row[16], row[17], self.v_validated)
		print "\n\n"+self.v_sql
		cursor.execute(self.v_sql)  
		cursor.execute("SELECT ROW_COUNT()")
		self.v_counter = self.v_counter + int(cursor.fetchone()[0])      
        except Exception,e:
            print "Error while Loading data into Temporary table",str(e)
	print self.v_counter,"Inserted"
        db.commit()
        db.close()

if __name__ == "__main__":
    event_handler = MyHandler()
    event_handler.on_created("/home/ftpuser/reconcile/data/cdrs/softswitch/parsedfiles/SS160509_00002645_00043435.dat")
