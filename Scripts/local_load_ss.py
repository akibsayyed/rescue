import MySQLdb

#db = MySQLdb.connect("192.168.2.184","rescue","ksisak","rescue")
db = MySQLdb.connect("202.144.156.184","rescue","ksisak","rescue")
cursor = db.cursor()

v_temp = "CREATE TEMPORARY TABLE IF NOT EXISTS rt_loaded_call_pstn_dump( \
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

cursor.execute(v_temp)

cursor.execute("TRUNCATE TABLE rt_loaded_call_pstn_dump")

v_query = "LOAD DATA LOCAL INFILE '"+"D:/SANKAR/SS160509_00002645_00043435.dat"+"' \
INTO TABLE rt_loaded_call_pstn_dump \
(@var1) \
SET rf_record_no = SUBSTR(@var1,1,8), \
rf_exchange_id = SUBSTR(@var1,9,3), \
rf_net_type = SUBSTR(@var1,12,2), \
rf_calling_number = SUBSTR(@var1,14,20), \
rf_calling_category = SUBSTR(@var1,34,2), \
rf_called_number = SUBSTR(@var1,36,20), \
rf_called_category = SUBSTR(@var1,56,2), \
rf_call_direction = SUBSTR(@var1,58,1), \
rf_call_datetime = str_to_date(SUBSTR(@var1,59,12),'%y%m%d%H%i%s'), \
rf_call_duration = SUBSTR(@var1,71,6), \
rf_charge_flag = SUBSTR(@var1,77,1), \
rf_ict_tgn = SUBSTR(@var1,78,4), \
rf_ict_cno = SUBSTR(@var1,82,4), \
rf_oct_tgn = SUBSTR(@var1,86,4), \
rf_oct_cno = SUBSTR(@var1,90,4), \
rf_create_by = USER(), \
rf_create_dt = NOW();"

print "First count..."
cursor.execute("SELECT COUNT(*) FROM rt_loaded_call_pstn_dump")
v_rowcount = cursor.fetchone()
print "Record count is: %s" % v_rowcount

print "Loading the file..."
cursor.execute(v_query)
print "Fetching count..."
cursor.execute("SELECT COUNT(*) FROM rt_loaded_call_pstn_dump")
print "Count is done..."
v_rowcount = cursor.fetchone()
db.commit()

db.close()

print "No.of rows inserted: %s" % v_rowcount
