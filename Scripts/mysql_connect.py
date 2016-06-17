import MySQLdb

db = MySQLdb.connect("192.168.2.184","rescue","ksisak","rescue")
cursor = db.cursor()

# try1
cursor.execute("SELECT COUNT(*) FROM rt_loaded_call_pstn")
data = cursor.fetchone()
print "No.of records %s" % data

# try2
cursor.execute("SELECT VERSION()")
data = cursor.fetchone()
print "No.of records %s" % data

# try3
try:
    cursor.execute("INSERT INTO names_tbl(name) VALUES('SivaSankar K')")
    cursor.execute("INSERT INTO names_tbl(name) VALUES('SivaSankar K')")
    cursor.execute("SELECT ROW_COUNT()")
    data = cursor.fetchone()
    print "After insert %s" % data
    
    db.commit()
except:
    db.rollback()

# try4 (session keeps track just like in oracle)
try:
    cursor.execute("SELECT COUNT(*) FROM names_tbl WHERE name = 'DEEPA'")
    data = cursor.fetchone()
    print "First: %s" % data
    
    cursor.execute("INSERT INTO names_tbl(name) VALUES('DEEPA')")

    cursor.execute("SELECT COUNT(*) FROM names_tbl WHERE name = 'DEEPA'")
    data = cursor.fetchone()
    print "Second: %s" % data
    
    db.commit()
except Exception,e:
    print "### Exception: ",str(e)," ###"
    db.rollback()

db.close()
