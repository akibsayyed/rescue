--
--
-- 09/06/2016
-- LOG BOOK
--

--
-- 06/05/2016
-- DATA STRUCTURE FOR RESCUE
-- BY SSK
--

-- Setting root password after installation

mysqladmin -u root password "new_password";

-- CONNECT

mysql -u root -p

-- Start MySQL on server boot

inside file /etc/rc.local add the following line

/etc/init.d/mysqld start

Also, you should have mysqld binary in /etc/init.d/ directory.

-- Check if MySQL server is running or not

ps -ef | grep mysqld

-- If server is not running, then you can start it by using the following command:

root@host# cd /usr/bin
./safe_mysqld &

-- if you want to shut down an already running MySQL server, then you can do it by using the following command:

root@host# cd /usr/bin
./mysqladmin -u root -p shutdown
Enter password: ******


#
# include all files from the config directory
#
!includedir /etc/my.cnf.d

-- showing system variables

SHOW VARIABLES LIKE '%max_connect%';

SET GLOBAL max_connect_errors=10000;

/* 
 --2nd
CREATE TABLE rt_loaded_call_pstn(
	rf_record_no INT(8) UNSIGNED,
	rf_exchange_id VARCHAR(3),
	rf_net_type VARCHAR(2),
	rf_calling_regioncd  VARCHAR(2),
	rf_calling_locationcd VARCHAR(2),
	rf_calling_pccd VARCHAR(30),
	rf_calling_number VARCHAR(30),
	rf_calling_category VARCHAR(2),
	rf_called_regioncd VARCHAR(2),
	rf_called_locationcd VARCHAR(2),
	rf_called_pccd VARCHAR(30),
	rf_called_countrycd VARCHAR(3),
	rf_called_countryname VARCHAR(100),
	rf_called_countryareacd VARCHAR(10),
	rf_called_number VARCHAR(30),
	rf_called_category VARCHAR(2),
	rf_call_direction VARCHAR(1),
	rf_call_datetime DATETIME,
	rf_call_duration INT UNSIGNED,
	rf_call_type VARCHAR(10),
	rf_charge_flag VARCHAR(1),
	rf_file_name VARCHAR(100),
	rf_ict_tgn VARCHAR(4),
	rf_ict_cno VARCHAR(4),
	rf_ict_partner VARCHAR(30),	
	rf_oct_tgn VARCHAR(4),
	rf_oct_cno VARCHAR(4),
	rf_oct_partner VARCHAR(30),
	rf_con_for_ic CHAR(1),
	rf_con_for_rating CHAR(1),
	rf_filter CHAR(1),
	rf_filtercd VARCHAR(10),
	rf_validated CHAR(1),
	rf_create_by VARCHAR(30),
	rf_create_dt DATETIME,
	rf_modify_by VARCHAR(30),
	rf_modify_dt DATETIME
) ENGINE = InnoDB
PARTITION BY RANGE(TO_DAYS(rf_call_datetime))
(
	PARTITION p_jan2010 VALUES LESS THAN (TO_DAYS('2010-02-01')),
	PARTITION p_feb2010 VALUES LESS THAN (TO_DAYS('2010-03-01')),
	PARTITION p_mar2010 VALUES LESS THAN (TO_DAYS('2010-04-01')),
	PARTITION p_apr2010 VALUES LESS THAN (TO_DAYS('2010-05-01')),
	PARTITION p_may2010 VALUES LESS THAN (TO_DAYS('2010-06-01')),
	PARTITION p_jun2010 VALUES LESS THAN (TO_DAYS('2010-07-01')),
	PARTITION p_jul2010 VALUES LESS THAN (TO_DAYS('2010-08-01')),
	PARTITION p_aug2010 VALUES LESS THAN (TO_DAYS('2010-09-01')),
	PARTITION p_sep2010 VALUES LESS THAN (TO_DAYS('2010-10-01')),
	PARTITION p_oct2010 VALUES LESS THAN (TO_DAYS('2010-11-01')),
	PARTITION p_nov2010 VALUES LESS THAN (TO_DAYS('2010-12-01')),
	PARTITION p_dec2010 VALUES LESS THAN (TO_DAYS('2011-01-01')),	
	PARTITION p_jan2011 VALUES LESS THAN (TO_DAYS('2011-02-01')),
	PARTITION p_feb2011 VALUES LESS THAN (TO_DAYS('2011-03-01')),
	PARTITION p_mar2011 VALUES LESS THAN (TO_DAYS('2011-04-01')),
	PARTITION p_apr2011 VALUES LESS THAN (TO_DAYS('2011-05-01')),
	PARTITION p_may2011 VALUES LESS THAN (TO_DAYS('2011-06-01')),
	PARTITION p_jun2011 VALUES LESS THAN (TO_DAYS('2011-07-01')),
	PARTITION p_jul2011 VALUES LESS THAN (TO_DAYS('2011-08-01')),
	PARTITION p_aug2011 VALUES LESS THAN (TO_DAYS('2011-09-01')),
	PARTITION p_sep2011 VALUES LESS THAN (TO_DAYS('2011-10-01')),
	PARTITION p_oct2011 VALUES LESS THAN (TO_DAYS('2011-11-01')),
	PARTITION p_nov2011 VALUES LESS THAN (TO_DAYS('2011-12-01')),
	PARTITION p_dec2011 VALUES LESS THAN (TO_DAYS('2012-01-01')),	
	PARTITION p_jan2012 VALUES LESS THAN (TO_DAYS('2012-02-01')),
	PARTITION p_feb2012 VALUES LESS THAN (TO_DAYS('2012-03-01')),
	PARTITION p_mar2012 VALUES LESS THAN (TO_DAYS('2012-04-01')),
	PARTITION p_apr2012 VALUES LESS THAN (TO_DAYS('2012-05-01')),
	PARTITION p_may2012 VALUES LESS THAN (TO_DAYS('2012-06-01')),
	PARTITION p_jun2012 VALUES LESS THAN (TO_DAYS('2012-07-01')),
	PARTITION p_jul2012 VALUES LESS THAN (TO_DAYS('2012-08-01')),
	PARTITION p_aug2012 VALUES LESS THAN (TO_DAYS('2012-09-01')),
	PARTITION p_sep2012 VALUES LESS THAN (TO_DAYS('2012-10-01')),
	PARTITION p_oct2012 VALUES LESS THAN (TO_DAYS('2012-11-01')),
	PARTITION p_nov2012 VALUES LESS THAN (TO_DAYS('2012-12-01')),
	PARTITION p_dec2012 VALUES LESS THAN (TO_DAYS('2013-01-01')),	
	PARTITION p_jan2013 VALUES LESS THAN (TO_DAYS('2013-02-01')),
	PARTITION p_feb2013 VALUES LESS THAN (TO_DAYS('2013-03-01')),
	PARTITION p_mar2013 VALUES LESS THAN (TO_DAYS('2013-04-01')),
	PARTITION p_apr2013 VALUES LESS THAN (TO_DAYS('2013-05-01')),
	PARTITION p_may2013 VALUES LESS THAN (TO_DAYS('2013-06-01')),
	PARTITION p_jun2013 VALUES LESS THAN (TO_DAYS('2013-07-01')),
	PARTITION p_jul2013 VALUES LESS THAN (TO_DAYS('2013-08-01')),
	PARTITION p_aug2013 VALUES LESS THAN (TO_DAYS('2013-09-01')),
	PARTITION p_sep2013 VALUES LESS THAN (TO_DAYS('2013-10-01')),
	PARTITION p_oct2013 VALUES LESS THAN (TO_DAYS('2013-11-01')),
	PARTITION p_nov2013 VALUES LESS THAN (TO_DAYS('2013-12-01')),
	PARTITION p_dec2013 VALUES LESS THAN (TO_DAYS('2014-01-01')),	
	PARTITION p_jan2014 VALUES LESS THAN (TO_DAYS('2014-02-01')),
	PARTITION p_feb2014 VALUES LESS THAN (TO_DAYS('2014-03-01')),
	PARTITION p_mar2014 VALUES LESS THAN (TO_DAYS('2014-04-01')),
	PARTITION p_apr2014 VALUES LESS THAN (TO_DAYS('2014-05-01')),
	PARTITION p_may2014 VALUES LESS THAN (TO_DAYS('2014-06-01')),
	PARTITION p_jun2014 VALUES LESS THAN (TO_DAYS('2014-07-01')),
	PARTITION p_jul2014 VALUES LESS THAN (TO_DAYS('2014-08-01')),
	PARTITION p_aug2014 VALUES LESS THAN (TO_DAYS('2014-09-01')),
	PARTITION p_sep2014 VALUES LESS THAN (TO_DAYS('2014-10-01')),
	PARTITION p_oct2014 VALUES LESS THAN (TO_DAYS('2014-11-01')),
	PARTITION p_nov2014 VALUES LESS THAN (TO_DAYS('2014-12-01')),
	PARTITION p_dec2014 VALUES LESS THAN (TO_DAYS('2015-01-01')),	
	PARTITION p_jan2015 VALUES LESS THAN (TO_DAYS('2015-02-01')),
	PARTITION p_feb2015 VALUES LESS THAN (TO_DAYS('2015-03-01')),
	PARTITION p_mar2015 VALUES LESS THAN (TO_DAYS('2015-04-01')),
	PARTITION p_apr2015 VALUES LESS THAN (TO_DAYS('2015-05-01')),
	PARTITION p_may2015 VALUES LESS THAN (TO_DAYS('2015-06-01')),
	PARTITION p_jun2015 VALUES LESS THAN (TO_DAYS('2015-07-01')),
	PARTITION p_jul2015 VALUES LESS THAN (TO_DAYS('2015-08-01')),
	PARTITION p_aug2015 VALUES LESS THAN (TO_DAYS('2015-09-01')),
	PARTITION p_sep2015 VALUES LESS THAN (TO_DAYS('2015-10-01')),
	PARTITION p_oct2015 VALUES LESS THAN (TO_DAYS('2015-11-01')),
	PARTITION p_nov2015 VALUES LESS THAN (TO_DAYS('2015-12-01')),
	PARTITION p_dec2015 VALUES LESS THAN (TO_DAYS('2016-01-01')),	
	PARTITION p_jan2016 VALUES LESS THAN (TO_DAYS('2016-02-01')),
	PARTITION p_feb2016 VALUES LESS THAN (TO_DAYS('2016-03-01')),
	PARTITION p_mar2016 VALUES LESS THAN (TO_DAYS('2016-04-01')),
	PARTITION p_apr2016 VALUES LESS THAN (TO_DAYS('2016-05-01')),
	PARTITION p_may2016 VALUES LESS THAN (TO_DAYS('2016-06-01')),
	PARTITION p_jun2016 VALUES LESS THAN (TO_DAYS('2016-07-01')),
	PARTITION p_jul2016 VALUES LESS THAN (TO_DAYS('2016-08-01')),
	PARTITION p_aug2016 VALUES LESS THAN (TO_DAYS('2016-09-01')),
	PARTITION p_sep2016 VALUES LESS THAN (TO_DAYS('2016-10-01')),
	PARTITION p_oct2016 VALUES LESS THAN (TO_DAYS('2016-11-01')),
	PARTITION p_nov2016 VALUES LESS THAN (TO_DAYS('2016-12-01')),
	PARTITION p_dec2016 VALUES LESS THAN (TO_DAYS('2017-01-01')),	
	PARTITION p_jan2017 VALUES LESS THAN (TO_DAYS('2017-02-01')),
	PARTITION p_feb2017 VALUES LESS THAN (TO_DAYS('2017-03-01')),
	PARTITION p_mar2017 VALUES LESS THAN (TO_DAYS('2017-04-01')),
	PARTITION p_apr2017 VALUES LESS THAN (TO_DAYS('2017-05-01')),
	PARTITION p_may2017 VALUES LESS THAN (TO_DAYS('2017-06-01')),
	PARTITION p_jun2017 VALUES LESS THAN (TO_DAYS('2017-07-01')),
	PARTITION p_jul2017 VALUES LESS THAN (TO_DAYS('2017-08-01')),
	PARTITION p_aug2017 VALUES LESS THAN (TO_DAYS('2017-09-01')),
	PARTITION p_sep2017 VALUES LESS THAN (TO_DAYS('2017-10-01')),
	PARTITION p_oct2017 VALUES LESS THAN (TO_DAYS('2017-11-01')),
	PARTITION p_nov2017 VALUES LESS THAN (TO_DAYS('2017-12-01')),
	PARTITION p_dec2017 VALUES LESS THAN (TO_DAYS('2018-01-01')),	
	PARTITION p_jan2018 VALUES LESS THAN (TO_DAYS('2018-02-01')),
	PARTITION p_feb2018 VALUES LESS THAN (TO_DAYS('2018-03-01')),
	PARTITION p_mar2018 VALUES LESS THAN (TO_DAYS('2018-04-01')),
	PARTITION p_apr2018 VALUES LESS THAN (TO_DAYS('2018-05-01')),
	PARTITION p_may2018 VALUES LESS THAN (TO_DAYS('2018-06-01')),
	PARTITION p_jun2018 VALUES LESS THAN (TO_DAYS('2018-07-01')),
	PARTITION p_jul2018 VALUES LESS THAN (TO_DAYS('2018-08-01')),
	PARTITION p_aug2018 VALUES LESS THAN (TO_DAYS('2018-09-01')),
	PARTITION p_sep2018 VALUES LESS THAN (TO_DAYS('2018-10-01')),
	PARTITION p_oct2018 VALUES LESS THAN (TO_DAYS('2018-11-01')),
	PARTITION p_nov2018 VALUES LESS THAN (TO_DAYS('2018-12-01')),
	PARTITION p_dec2018 VALUES LESS THAN (TO_DAYS('2019-01-01')),	
	PARTITION p_jan2019 VALUES LESS THAN (TO_DAYS('2019-02-01')),
	PARTITION p_feb2019 VALUES LESS THAN (TO_DAYS('2019-03-01')),
	PARTITION p_mar2019 VALUES LESS THAN (TO_DAYS('2019-04-01')),
	PARTITION p_apr2019 VALUES LESS THAN (TO_DAYS('2019-05-01')),
	PARTITION p_may2019 VALUES LESS THAN (TO_DAYS('2019-06-01')),
	PARTITION p_jun2019 VALUES LESS THAN (TO_DAYS('2019-07-01')),
	PARTITION p_jul2019 VALUES LESS THAN (TO_DAYS('2019-08-01')),
	PARTITION p_aug2019 VALUES LESS THAN (TO_DAYS('2019-09-01')),
	PARTITION p_sep2019 VALUES LESS THAN (TO_DAYS('2019-10-01')),
	PARTITION p_oct2019 VALUES LESS THAN (TO_DAYS('2019-11-01')),
	PARTITION p_nov2019 VALUES LESS THAN (TO_DAYS('2019-12-01')),
	PARTITION p_dec2019 VALUES LESS THAN (TO_DAYS('2020-01-01')),	
	PARTITION p_jan2020 VALUES LESS THAN (TO_DAYS('2020-02-01')),
	PARTITION p_feb2020 VALUES LESS THAN (TO_DAYS('2020-03-01')),
	PARTITION p_mar2020 VALUES LESS THAN (TO_DAYS('2020-04-01')),
	PARTITION p_apr2020 VALUES LESS THAN (TO_DAYS('2020-05-01')),
	PARTITION p_may2020 VALUES LESS THAN (TO_DAYS('2020-06-01')),
	PARTITION p_jun2020 VALUES LESS THAN (TO_DAYS('2020-07-01')),
	PARTITION p_jul2020 VALUES LESS THAN (TO_DAYS('2020-08-01')),
	PARTITION p_aug2020 VALUES LESS THAN (TO_DAYS('2020-09-01')),
	PARTITION p_sep2020 VALUES LESS THAN (TO_DAYS('2020-10-01')),
	PARTITION p_oct2020 VALUES LESS THAN (TO_DAYS('2020-11-01')),
	PARTITION p_nov2020 VALUES LESS THAN (TO_DAYS('2020-12-01')),
	PARTITION p_dec2020 VALUES LESS THAN (TO_DAYS('2021-01-01')),
	PARTITION p_maxval  VALUES LESS THAN (MAXVALUE)
   ); 

*/   
-- EXPLAIN PLAN
SELECT COUNT(*) FROM rt_loaded_call_pstn; --1829979
SELECT COUNT(*) FROM rt_loaded_call_pstn WHERE rf_call_datetime BETWEEN '2016-05-01' AND '2016-05-10';  --681041
SELECT COUNT(*) FROM rt_loaded_call_pstn WHERE rf_call_datetime BETWEEN '2016-05-01 00:00:00' AND '2016-05-10 23:59:59';  --791284
SELECT COUNT(*) FROM rt_loaded_call_pstn WHERE rf_call_datetime > '2016-04-30' AND rf_call_datetime <'2016-05-11'; --791284

EXPLAIN PARTITIONS SELECT COUNT(*) FROM rt_loaded_call_pstn WHERE rf_call_datetime BETWEEN '2016-05-01' AND '2016-05-10'\G   

*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: rt_loaded_call_pstn
   partitions: p_may2016
         type: ALL
possible_keys: NULL
          key: NULL
      key_len: NULL
          ref: NULL
         rows: 1826861
        Extra: Using where

EXPLAIN PARTITIONS SELECT COUNT(*) FROM rt_loaded_call_pstn WHERE rf_call_datetime BETWEEN '2016-05-01 00:00:00' AND '2016-05-10 23:59:59'\G   
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: rt_loaded_call_pstn
   partitions: p_may2016
         type: ALL
possible_keys: NULL
          key: NULL
      key_len: NULL
          ref: NULL
         rows: 1826861
        Extra: Using where

EXPLAIN PARTITIONS SELECT COUNT(*) FROM rt_loaded_call_pstn WHERE rf_call_datetime > '2016-04-30' AND rf_call_datetime <'2016-05-11'\G   
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: rt_loaded_call_pstn
   partitions: p_jan2010,p_apr2016,p_may2016
         type: ALL
possible_keys: NULL
          key: NULL
      key_len: NULL
          ref: NULL
         rows: 1826863
        Extra: Using where

		
-- load

mysql -u {user} -p {pass} -e "LOAD DATA {rest of command}" {db}

/*
LOAD DATA LOCAL INFILE '/home/ftpuser/reconcile/data/cdrs/softswitch/parsedfiles/SS160509_00002645_00043435.dat'
INTO TABLE rt_loaded_call_pstn_dump
(@var1)
SET rf_record_no = SUBSTR(@var1,1,8),
rf_exchange_id = SUBSTR(@var1,9,3),
rf_net_type = SUBSTR(@var1,12,2),
rf_calling_number = SUBSTR(@var1,14,20),
rf_calling_category = SUBSTR(@var1,34,2),
rf_called_number = SUBSTR(@var1,36,20),
rf_called_category = SUBSTR(@var1,56,2),
rf_call_direction = SUBSTR(@var1,58,1),
rf_call_datetime = str_to_date(SUBSTR(@var1,59,12),'%y%m%d%H%i%s'),
rf_call_duration = SUBSTR(@var1,71,6),
rf_charge_flag = SUBSTR(@var1,77,1),
rf_ict_tgn = SUBSTR(@var1,78,4),
rf_ict_cno = SUBSTR(@var1,82,4),
rf_oct_tgn = SUBSTR(@var1,86,4),
rf_oct_cno = SUBSTR(@var1,90,4),
rf_create_by = USER(),
rf_create_dt = NOW();


LOAD DATA LOCAL INFILE '/home/ftpuser/reconcile/data/cdrs/softswitch/parsedfiles/SS160509_00002645_00043435.dat'
INTO TABLE rt_loaded_call_pstn
(@var1)
SET rf_record_no = SUBSTR(@var1,1,8),
rf_exchange_id = SUBSTR(@var1,9,3),
rf_net_type = SUBSTR(@var1,12,2),
rf_calling_number = SUBSTR(@var1,14,20),
rf_calling_category = SUBSTR(@var1,34,2),
rf_called_number = SUBSTR(@var1,36,20),
rf_called_category = SUBSTR(@var1,56,2),
rf_call_direction = SUBSTR(@var1,58,1),
rf_call_datetime = str_to_date(SUBSTR(@var1,59,12),'%y%m%d%H%i%s'),
rf_call_duration = SUBSTR(@var1,71,6),
rf_charge_flag = SUBSTR(@var1,77,1),
rf_ict_tgn = SUBSTR(@var1,78,4),
rf_ict_cno = SUBSTR(@var1,82,4),
rf_oct_tgn = SUBSTR(@var1,86,4),
rf_oct_cno = SUBSTR(@var1,90,4),
rf_create_by = USER(),
rf_create_dt = NOW();
*/

-- 10/05/2016
-- Creating user for loading
--

--GRANT ALL PRIVILEGES ON *.* TO 'resload'@'localhost'
--GRANT ALL PRIVILEGES ON rescue.rt_loaded_call_pstn TO 'resload'@'localhost'
--GRANT ALL PRIVILEGES ON rescue.rt_loaded_call_pstn_dump TO 'resload'@'localhost'



-- Revoking PRIVILEGES

--REVOKE ALL ON rescue.rt_loaded_call_pstn_dump FROM 'resload'@'localhost';
REVOKE ALL ON rescue.rt_loaded_call_pstn FROM 'resload'@'localhost';

--GRANT SELECT, INSERT ON rescue.rt_loaded_call_pstn_dump TO 'resload'@'localhost';


--
--
-- Installing MySQL-python module
--
--

-- For windows download and install the file
	D:\SANKAR\Downloads\Softwares\python\MySQL-python-1.2.4b4.win32-py2.7.exe

-- For Linux (run as root)

sudo yum install MySQL-python

