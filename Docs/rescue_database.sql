--
--
-- CREATING DATA BASE
--
--

mysql -u root -p

use mysql;

CREATE DATABASE rescue;

--
--
-- CREATING USER ACCOUNTS
--
--

--
-- Main user(rescue) where all the DB objects are maintained
--
mysql -u root -p

use mysql;

INSERT INTO user(host, user, password, 
                 select_priv, insert_priv, update_priv, delete_priv,
                 create_priv, drop_priv, reload_priv, 
                 shutdown_priv, process_priv, file_priv,
                 grant_priv, references_priv, index_priv, alter_priv,
                 show_db_priv, super_priv, create_tmp_table_priv, lock_tables_priv,
                 execute_priv, repl_slave_priv, repl_client_priv, create_view_priv, show_view_priv,
                 create_routine_priv, alter_routine_priv, create_user_priv,
                 event_priv, trigger_priv, create_tablespace_priv
                 )
                 VALUES('localhost', 'rescue', PASSWORD('ksisak'),
                 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y',
                 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y',
                 'Y', 'Y', 'Y'
                 );
				 
FLUSH PRIVILEGES;	

--
-- User(resload) for loading parsed files into DB tables 
--

CREATE USER resload@'localhost' IDENTIFIED BY 'r35l0ad2016';

USE mysql;

SET PASSWORD FOR 'resload'@'ERPNEXT' = PASSWORD('ksisak')

FLUSH PRIVILEGES;


--
--
-- DATABASE TABLES
--
--

--
-- TRUNC GROUPS TABLE
--

CREATE TABLE rt_trunk_groups(
rf_element_id VARCHAR(10),
rf_group_type VARCHAR(10),
rf_group_id VARCHAR(10),
rf_partner VARCHAR(100),
rf_net_type CHAR(1),
rf_create_by VARCHAR(30),
rf_create_dt DATETIME,
rf_modify_by VARCHAR(30),
rf_modify_dt DATETIME,
PRIMARY KEY pk_trunk_groups(rf_element_id, rf_group_id)
);

GRANT SELECT ON rescue.rt_trunk_groups TO 'resload'@'localhost';
GRANT SELECT ON rescue.rt_trunk_groups TO 'resload'@'ERPNEXT';

INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0010','TELCO             ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0017','THM_BMOBILE       ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0065','SINGTEL_SP        ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0066','BKKB_SP           ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0077','THM_T_MOBILE      ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0088','MIRT              ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0098','Nepal_SP          ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0770','TASHICELL_INT     ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0911','BSNL_CHENNAI_SP   ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0912','BSNL_DELHI_SP     ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0913','AIRTEL_CHENNAI_SP ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0914','AIRTEL_DELHI_SP   ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0915','AIRTEL_MUMBAI_SP  ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','E1','0916','RELIANCE          ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0037','THM_CHANGJIJI01_FTTC  ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0033','THM_CHANGJIJI02_FTTC  ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0034','THM_IMTRAT01_FTTC     ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0031','Samdrup Jongkhar_WRI  ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0035','THM_HOSPITAL01_FTTC   ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0049','INOC_V5_new           ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0038','THM_BNB01_FTTC        ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0050','BAJO _FTTC            ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0039','WANGDUE_WRI           ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0030','PARO_SHABA_FTTC       ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0042','C/LINGMITHANG_FTTC    ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0044','THM_CHANGZAMTOK01_FTTC','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0043','THM_FTTC_ITPARK       ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0045','Pling Xge_FTTC_1      ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0046','Pling Xge_FTTC_2      ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0047','THM_CHANGZAMTOK02_FTTC','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','V5','0099','TRASHIGANG_V5_NEW     ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0001','PRA_DRUK AIR        ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0002','PRA_BPC             ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0003','PRA_BOB             ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0004','PRA_NRDCL           ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0005','PRA_EPBAX-BT        ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0006','PRA_RBP             ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0007','PRA_UNDP            ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0008','PRA_LAND COMMISSION ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0009','PRA_BHUTAN HOTEL    ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0011','PRA_DCCL            ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0012','PRA_NPPF    ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0013','PRA_LE MERIDIEN_PARO','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0020','PRA_BTL             ','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0014','PRA_BHUTAN-POST','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0015','PRA_G2C','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','PRA','0016','PRA_BOB-new','N',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','VOIP','0084','KDDI_VOIP           ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','VOIP','0085','KDDI_VoIP_New       ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','VOIP','1001','CAT_VOIP            ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','VOIP','0087','SIP_TG_Telco        ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','VOIP','0089','MIR_VoIP            ','I',USER(),NOW());
INSERT INTO rt_trunk_groups(rf_element_id, rf_group_type, rf_group_id, rf_partner, rf_net_type, rf_create_by, rf_create_dt) VALUES('SS','VOIP','1000','Get A Call Voip','I',USER(),NOW());


--
-- ERROR CODES TABLE
--

CREATE TABLE rt_message_codes(
rf_element_id VARCHAR(10),
rf_message_type VARCHAR(10),
rf_message_code VARCHAR(10),
rf_message_desc VARCHAR(200),
rf_create_by VARCHAR(30),
rf_create_dt DATETIME,
rf_modify_by VARCHAR(30),
rf_modify_dt DATETIME,
PRIMARY KEY pk_message_codes (rf_element_id, rf_message_type, rf_message_code)
);

GRANT SELECT,INSERT ON rescue.rt_message_codes TO 'resload'@'localhost';
GRANT SELECT,INSERT ON rescue.rt_message_codes TO 'resload'@'ERPNEXT';

INSERT INTO rt_message_codes VALUES('SS', 'FILTER', 'F0001', 'Incoming Calls',USER(), NOW(), NULL, NULL);


--
-- ERROR LOG TABLE
--

DROP TABLE rt_loader_err0;

CREATE TABLE rt_loader_err0(
rf_element_id VARCHAR(10),
rf_file_name VARCHAR(100),
rf_file_loaded CHAR(1),
rf_cdr_count MEDIUMINT,
rf_valid_count MEDIUMINT,
rf_filter_count MEDIUMINT,
rf_reject_count MEDIUMINT,
rf_remarks VARCHAR(200),
rf_create_by VARCHAR(30),
rf_create_dt DATETIME,
rf_modify_by VARCHAR(30),
rf_modify_dt DATETIME,
INDEX idx1_rt_errors (rf_element_id, rf_file_name)
);

GRANT SELECT,INSERT ON rescue.rt_loader_err0 TO 'resload'@'localhost';
GRANT SELECT,INSERT ON rescue.rt_loader_err0 TO 'resload'@'ERPNEXT';

-- 
-- FILE LOGGING TABLE
-- 22/05/2016


DROP TABLE rt_loader_stats0;

CREATE TABLE rt_loader_stats0(
rf_element_id VARCHAR(10),
rf_file_name VARCHAR(100),
rf_file_loaded CHAR(1),
rf_cdr_count MEDIUMINT,
rf_valid_count MEDIUMINT,
rf_filter_count MEDIUMINT,
rf_reject_count MEDIUMINT,
rf_remarks VARCHAR(200),
rf_create_by VARCHAR(30),
rf_create_dt DATETIME,
rf_modify_by VARCHAR(30),
rf_modify_dt DATETIME,
PRIMARY KEY (rf_element_id, rf_file_name)
);

GRANT SELECT,INSERT ON rescue.rt_loader_stats0 TO 'resload'@'localhost';
GRANT SELECT,INSERT ON rescue.rt_loader_stats0 TO 'resload'@'ERPNEXT';

--
-- SS LOADING
--

CREATE TEMPORARY TABLE rt_loaded_ss_temp(
	rf_record_no INT(8) UNSIGNED,
	rf_exchange_id VARCHAR(3),
	rf_net_type VARCHAR(2),
	rf_calling_number VARCHAR(30),
	rf_calling_category VARCHAR(2),
	rf_called_number VARCHAR(30),
	rf_called_category VARCHAR(2),
	rf_call_direction VARCHAR(1),
	rf_call_datetime DATETIME,
	rf_call_duration INT UNSIGNED,
	rf_charge_flag VARCHAR(1),
	rf_ict_tgn VARCHAR(4),
	rf_ict_cno VARCHAR(4),
	rf_oct_tgn VARCHAR(4),
	rf_oct_cno VARCHAR(4)
)  ENGINE = InnoDB;

CREATE TABLE rt_filtered_ss_dump(
	rf_record_no INT(8) UNSIGNED,
	rf_exchange_id VARCHAR(3),
	rf_net_type VARCHAR(2),
	rf_calling_number VARCHAR(30),
	rf_calling_category VARCHAR(2),
	rf_called_number VARCHAR(30),
	rf_called_category VARCHAR(2),
	rf_call_direction VARCHAR(1),
	rf_call_datetime DATETIME,
	rf_call_duration INT UNSIGNED,
	rf_charge_flag VARCHAR(1),
	rf_ict_tgn VARCHAR(4),
	rf_ict_cno VARCHAR(4),
	rf_oct_tgn VARCHAR(4),
	rf_oct_cno VARCHAR(4),
	rf_message_code VARCHAR(10),	
	rf_file_name VARCHAR(100),
	rf_validated CHAR(1),	
	rf_create_by VARCHAR(30),
	rf_create_dt DATETIME,
	rf_modify_by VARCHAR(30),
	rf_modify_dt DATETIME	
)  ENGINE = InnoDB;

GRANT SELECT, INSERT ON rescue.rt_filtered_ss_dump TO 'resload'@'localhost';
GRANT SELECT, INSERT ON rescue.rt_filtered_ss_dump TO 'resload'@'ERPNEXT';

CREATE TABLE rt_loaded_ss_dump(
	rf_record_no INT(8) UNSIGNED,
	rf_exchange_id VARCHAR(3),
	rf_net_type VARCHAR(2),
	rf_calling_number VARCHAR(30),
	rf_calling_category VARCHAR(2),
	rf_called_number VARCHAR(30),
	rf_called_category VARCHAR(2),
	rf_call_direction VARCHAR(1),
	rf_call_datetime DATETIME,
	rf_call_duration INT UNSIGNED,
	rf_charge_flag VARCHAR(1),
	rf_ict_tgn VARCHAR(4),
	rf_ict_cno VARCHAR(4),
	rf_oct_tgn VARCHAR(4),
	rf_oct_cno VARCHAR(4),
	rf_file_name VARCHAR(100),
	rf_validated CHAR(1),
	rf_create_by VARCHAR(30),
	rf_create_dt DATETIME,
	rf_modify_by VARCHAR(30),
	rf_modify_dt DATETIME
)  ENGINE = InnoDB
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

-- Granting privileges on rt_loaded_ss_temp to resload
GRANT CREATE TEMPORARY TABLES ON rescue.* TO 'resload'@'localhost';
GRANT CREATE TEMPORARY TABLES ON rescue.* TO 'resload'@'ERPNEXT';
GRANT CREATE, DROP, SELECT, INSERT, UPDATE, DELETE ON rescue.rt_loaded_ss_temp TO 'resload'@'localhost';
GRANT CREATE, DROP, SELECT, INSERT, UPDATE, DELETE ON rescue.rt_loaded_ss_temp TO 'resload'@'ERPNEXT';

-- Granting privileges on rt_loaded_ss_dump to resload
GRANT SELECT, INSERT ON rescue.rt_loaded_ss_dump TO 'resload'@'localhost';
GRANT SELECT, INSERT ON rescue.rt_loaded_ss_dump TO 'resload'@'ERPNEXT';

CREATE INDEX idx1_rt_loaded_ss_dump ON rt_loaded_ss_dump(rf_ict_tgn);
CREATE INDEX idx2_rt_loaded_ss_dump ON rt_loaded_ss_dump(rf_oct_tgn);
CREATE INDEX idx3_rt_loaded_ss_dump ON rt_loaded_ss_dump(rf_file_name);
CREATE INDEX idx4_rt_loaded_ss_dump ON rt_loaded_ss_dump(rf_calling_number, rf_called_number);

--
-- MSC LOADING
--

-- Main table
CREATE TABLE rt_loaded_msc_dump(
rf_seq_no INT,
rf_cdr_type VARCHAR(10),
rf_record_no INT(8) UNSIGNED,
rf_partial_op_rec_no VARCHAR(10),
rf_last_op_rec_no VARCHAR(10),
rf_calling_imsi VARCHAR(30),
rf_calling_number VARCHAR(30),
rf_calling_imei VARCHAR(30),
rf_called_imsi VARCHAR(30),
rf_called_number VARCHAR(30),
rf_called_imei VARCHAR(30),
rf_called_num_ton VARCHAR(10),
rf_lac_id VARCHAR(10),
rf_cell_id VARCHAR(10),
rf_msc_id VARCHAR(30),
rf_out_rg VARCHAR(10),
rf_in_rg VARCHAR(10),
rf_bs_type VARCHAR(10),
rf_bs_cd VARCHAR(10),
rf_call_datetime DATETIME,
rf_call_duration INT UNSIGNED,
rf_ss_cd VARCHAR(10),
rf_ss_actcd VARCHAR(10),
rf_msrn VARCHAR(30),
rf_callid_no VARCHAR(10),
rf_field1 VARCHAR(30),
rf_field2 VARCHAR(30),
rf_field3 VARCHAR(30),
rf_field4 VARCHAR(30),
rf_file_name VARCHAR(100),
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

-- Granting privileges on rt_loaded_msc_temp to resload
GRANT CREATE, DROP, SELECT, INSERT, UPDATE, DELETE ON rescue.rt_loaded_msc_temp TO 'resload'@'localhost';
GRANT CREATE, DROP, SELECT, INSERT, UPDATE, DELETE ON rescue.rt_loaded_msc_temp TO 'resload'@'ERPNEXT';

-- Granting privileges on rt_loaded_msc_dump to resload
GRANT SELECT, INSERT ON rescue.rt_loaded_msc_dump TO 'resload'@'localhost';
GRANT SELECT, INSERT ON rescue.rt_loaded_msc_dump TO 'resload'@'ERPNEXT';
   

--
-- SGSN
--

CREATE TEMPORARY TABLE IF NOT EXISTS rt_loaded_sgsn_temp( 
rf_rec_type VARCHAR(30),
rf_rec_seq_number VARCHAR(30),
rf_local_rec_seq INT UNSIGNED,
rf_field1 VARCHAR(30),
rf_system_type VARCHAR(30),
rf_served_imsi VARCHAR(30),
rf_served_imei VARCHAR(30),
rf_served_msisdn VARCHAR(30),
rf_sgsn_addr VARCHAR(30),
rf_ms_net_capability VARCHAR(30),
rf_rounting_are_cd VARCHAR(30),
rf_lac VARCHAR(30),
rf_cell VARCHAR(30),
rf_charging_id VARCHAR(30),
rf_ggsn_addr_used VARCHAR(30),
rf_apn_net_id VARCHAR(30),
rf_apn_select_mode VARCHAR(30),
rf_pdp_type VARCHAR(30),
rf_served_pdp_addr VARCHAR(30),
rf_rec_opening_time DATETIME,
rf_duration MEDIUMINT,
rf_sgsn_change VARCHAR(30),
rf_cause_for_rec_closing VARCHAR(30),
rf_field2 VARCHAR(30),
rf_node_id VARCHAR(30),
rf_field3 VARCHAR(30),
rf_field4 VARCHAR(30),
rf_charge_character VARCHAR(30),
rf_field5 VARCHAR(30),
rf_field6 VARCHAR(30),
rf_field7 VARCHAR(30),
rf_apn_op_id VARCHAR(100),
rf_field8 VARCHAR(30),
rf_scf_address VARCHAR(30),
rf_field9 VARCHAR(30),
rf_field10 VARCHAR(30),
rf_field11 VARCHAR(30),
rf_field12 VARCHAR(30),
rf_field13 VARCHAR(30),
rf_field14 VARCHAR(30),
rf_field15 VARCHAR(30),
rf_field16 VARCHAR(30),
rf_field17 VARCHAR(30),
rf_field18 VARCHAR(30),
rf_field19 VARCHAR(30),
rf_field20 VARCHAR(30),
rf_field21 VARCHAR(30),
rf_field22 VARCHAR(30),
rf_field23 VARCHAR(30),
rf_volume_up INT,
rf_volume_down INT,
rf_field24 VARCHAR(30),
rf_change_time DATETIME,
rf_field25 VARCHAR(30),
rf_field26 VARCHAR(30)
) ENGINE = InnoDB;

-- Main table
CREATE TABLE rt_loaded_sgsn_dump(
rf_rec_type VARCHAR(30),
rf_rec_seq_number VARCHAR(30),
rf_local_rec_seq INT UNSIGNED,
rf_field1 VARCHAR(30),
rf_system_type VARCHAR(30),
rf_served_imsi VARCHAR(30),
rf_served_imei VARCHAR(30),
rf_served_msisdn VARCHAR(30),
rf_sgsn_addr VARCHAR(30),
rf_ms_net_capability VARCHAR(30),
rf_rounting_are_cd VARCHAR(30),
rf_lac VARCHAR(30),
rf_cell VARCHAR(30),
rf_charging_id VARCHAR(30),
rf_ggsn_addr_used VARCHAR(30),
rf_apn_net_id VARCHAR(30),
rf_apn_select_mode VARCHAR(30),
rf_pdp_type VARCHAR(30),
rf_served_pdp_addr VARCHAR(30),
rf_rec_opening_time DATETIME,
rf_duration MEDIUMINT,
rf_sgsn_change VARCHAR(30),
rf_cause_for_rec_closing VARCHAR(30),
rf_field2 VARCHAR(30),
rf_node_id VARCHAR(30),
rf_field3 VARCHAR(30),
rf_field4 VARCHAR(30),
rf_charge_character VARCHAR(30),
rf_field5 VARCHAR(30),
rf_field6 VARCHAR(30),
rf_field7 VARCHAR(30),
rf_apn_op_id VARCHAR(100),
rf_field8 VARCHAR(30),
rf_scf_address VARCHAR(30),
rf_field9 VARCHAR(30),
rf_field10 VARCHAR(30),
rf_field11 VARCHAR(30),
rf_field12 VARCHAR(30),
rf_field13 VARCHAR(30),
rf_field14 VARCHAR(30),
rf_field15 VARCHAR(30),
rf_field16 VARCHAR(30),
rf_field17 VARCHAR(30),
rf_field18 VARCHAR(30),
rf_field19 VARCHAR(30),
rf_field20 VARCHAR(30),
rf_field21 VARCHAR(30),
rf_field22 VARCHAR(30),
rf_field23 VARCHAR(30),
rf_volume_up INT,
rf_volume_down INT,
rf_field24 VARCHAR(30),
rf_change_time DATETIME,
rf_field25 VARCHAR(30),
rf_field26 VARCHAR(30),
rf_file_name VARCHAR(100),
rf_validated CHAR(1),
rf_create_by VARCHAR(30),
rf_create_dt DATETIME,
rf_modify_by VARCHAR(30),
rf_modify_dt DATETIME
) ENGINE = InnoDB
PARTITION BY RANGE(TO_DAYS(rf_rec_opening_time))
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

-- C:\SANKAR\Dropbox\WORKING\myprojects\rescue\Scripts\SGSN.4367_09062016.CDR
-- /home/ftpuser/reconcile/data/cdrs/sgsn/parsedfiles/SGSN.59_11062016.CDR
   
LOAD DATA LOCAL INFILE '/home/ftpuser/reconcile/data/cdrs/sgsn/parsedfiles/SGSN.59_11062016.CDR' 
INTO TABLE rt_loaded_sgsn_temp 
FIELDS TERMINATED BY '|' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
( 
@rf_rec_type, @rf_rec_seq_number, @rf_local_rec_seq, @rf_field1, @rf_system_type, 
@rf_served_imsi, @rf_served_imei, @rf_served_msisdn, @rf_sgsn_addr, @rf_ms_net_capability, 
@rf_rounting_are_cd, @rf_lac, @rf_cell, @rf_charging_id, @rf_ggsn_addr_used, 
@rf_apn_net_id, @rf_apn_select_mode, @rf_pdp_type, @rf_served_pdp_addr, @rf_rec_opening_time, 
@rf_duration, @rf_sgsn_change, @rf_cause_for_rec_closing, @rf_field2, @rf_node_id, 
@rf_field3, @rf_field4, @rf_charge_character, @rf_field5, @rf_field6, 
@rf_field7, @rf_apn_op_id, @rf_field8, @rf_scf_address, @rf_field9, 
@rf_field10, @rf_field11, @rf_field12, @rf_field13, @rf_field14, 
@rf_field15, @rf_field16, @rf_field17, @rf_field18, @rf_field19, 
@rf_field20, @rf_field21, @rf_field22, @rf_field23, @rf_volume_up, 
@rf_volume_down, @rf_field24, @rf_change_time, @rf_field25, @rf_field26) 
SET rf_rec_type = TRIM(@rf_rec_type), 
rf_rec_seq_number = TRIM(@rf_rec_seq_number), 
rf_local_rec_seq = TRIM(@rf_local_rec_seq), 
rf_field1 = TRIM(@rf_field1), 
rf_system_type = TRIM(@rf_system_type), 
rf_served_imsi = TRIM(@rf_served_imsi), 
rf_served_imei = TRIM(@rf_served_imei), 
rf_served_msisdn = TRIM(@rf_served_msisdn), 
rf_sgsn_addr = TRIM(@rf_sgsn_addr), 
rf_ms_net_capability = TRIM(@rf_ms_net_capability), 
rf_rounting_are_cd = TRIM(@rf_rounting_are_cd), 
rf_lac = TRIM(@rf_lac), 
rf_cell = TRIM(@rf_cell), 
rf_charging_id = TRIM(@rf_charging_id), 
rf_ggsn_addr_used = TRIM(@rf_ggsn_addr_used), 
rf_apn_net_id = TRIM(@rf_apn_net_id), 
rf_apn_select_mode = TRIM(@rf_apn_select_mode), 
rf_pdp_type = TRIM(@rf_pdp_type), 
rf_served_pdp_addr = TRIM(@rf_served_pdp_addr), 
rf_rec_opening_time = str_to_date(TRIM(@rf_rec_opening_time),'%d%m%y%H%i%s'), 
rf_duration = TRIM(@rf_duration), 
rf_sgsn_change = TRIM(@rf_sgsn_change), 
rf_cause_for_rec_closing = TRIM(@rf_cause_for_rec_closing), 
rf_field2 = TRIM(@rf_field2), 
rf_node_id = TRIM(@rf_node_id), 
rf_field3  = TRIM(@rf_field3), 
rf_field4  = TRIM(@rf_field4), 
rf_charge_character = TRIM(@rf_charge_character), 
rf_field5 = TRIM(@rf_field5), 
rf_field6 = TRIM(@rf_field6), 
rf_field7 = TRIM(@rf_field7), 
rf_apn_op_id = TRIM(@rf_apn_op_id), 
rf_field8 = TRIM(@rf_field8), 
rf_scf_address = TRIM(@rf_scf_address), 
rf_field9 = TRIM(@rf_field9), 
rf_field10 = TRIM(@rf_field10), 
rf_field11 = TRIM(@rf_field11), 
rf_field12 = TRIM(@rf_field12), 
rf_field13 = TRIM(@rf_field13), 
rf_field14 = TRIM(@rf_field14), 
rf_field15 = TRIM(@rf_field15), 
rf_field16 = TRIM(@rf_field16), 
rf_field17 = TRIM(@rf_field17), 
rf_field18 = TRIM(@rf_field18), 
rf_field19 = TRIM(@rf_field19), 
rf_field20 = TRIM(@rf_field20), 
rf_field21 = TRIM(@rf_field21), 
rf_field22 =TRIM(@rf_field22), 
rf_field23 = TRIM(@rf_field23), 
rf_volume_up = TRIM(@rf_volume_up), 
rf_volume_down = TRIM(@rf_volume_down), 
rf_field24 = TRIM(@rf_field24), 
rf_change_time = str_to_date(TRIM(@rf_change_time),'%d%m%y%H%i%s'),
rf_field25 = TRIM(@rf_field25), 
rf_field26 = TRIM(@rf_field26);
   
-- Granting privileges on rt_loaded_msc_temp to resload
GRANT CREATE, DROP, SELECT, INSERT, UPDATE, DELETE ON rescue.rt_loaded_sgsn_temp TO 'resload'@'localhost';
GRANT CREATE, DROP, SELECT, INSERT, UPDATE, DELETE ON rescue.rt_loaded_sgsn_temp TO 'resload'@'ERPNEXT';

-- Granting privileges on rt_loaded_msc_dump to resload
GRANT SELECT, INSERT ON rescue.rt_loaded_sgsn_dump TO 'resload'@'localhost';
GRANT SELECT, INSERT ON rescue.rt_loaded_sgsn_dump TO 'resload'@'ERPNEXT';
   
-- 
-- TABLE: RT_PARAMETERS
--		20/05/2016

CREATE TABLE rt_parameters(
	rf_param1 VARCHAR(30),
	rf_paramdesc1 VARCHAR(120),
	rf_param2 VARCHAR(30),
	rf_paramdesc2 VARCHAR(120),
	rf_numberdata DOUBLE,
	rf_chardata TEXT,
	rf_create_by VARCHAR(30),
	rf_create_dt DATETIME,
	rf_modify_by VARCHAR(30),
	rf_modify_dt DATETIME
);

-- Access rights
GRANT SELECT ON rescue.rt_parameters TO 'resload'@'localhost';
GRANT SELECT ON rescue.rt_parameters TO 'resload'@'ERPNEXT';

-- Inserting for SS

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_SS', 'CREATE', 'Creating Temporary Table rt_loaded_ss_temp', 5, "CREATE TEMPORARY TABLE IF NOT EXISTS rt_loaded_ss_temp( 
rf_record_no INT(8) UNSIGNED, 
rf_exchange_id VARCHAR(3), 
rf_net_type VARCHAR(2), 
rf_calling_number VARCHAR(30), 
rf_calling_category VARCHAR(2), 
rf_called_number VARCHAR(30), 
rf_called_category VARCHAR(2), 
rf_call_direction VARCHAR(1), 
rf_call_datetime DATETIME, 
rf_call_duration INT UNSIGNED, 
rf_charge_flag VARCHAR(1), 
rf_ict_tgn VARCHAR(4), 
rf_ict_cno VARCHAR(4), 
rf_oct_tgn VARCHAR(4), 
rf_oct_cno VARCHAR(4)) ENGINE = InnoDB;", USER(), NOW());

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_SS', 'TRUNCATE', 'Truncate table rt_loaded_ss_temp', 10, "TRUNCATE TABLE rt_loaded_ss_temp", USER(), NOW());
	
INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_SS', 'LOAD', 'Loading data into rt_loaded_ss_temp', 15, "LOAD DATA LOCAL INFILE '{0}'
 INTO TABLE rt_loaded_ss_temp 
(@var1) 
SET rf_record_no = TRIM(SUBSTR(@var1,1,8)), 
rf_exchange_id = TRIM(SUBSTR(@var1,9,3)), 
rf_net_type = TRIM(SUBSTR(@var1,12,2)), 
rf_calling_number = TRIM(SUBSTR(@var1,14,20)), 
rf_calling_category = TRIM(SUBSTR(@var1,34,2)), 
rf_called_number = TRIM(SUBSTR(@var1,36,20)), 
rf_called_category = TRIM(SUBSTR(@var1,56,2)), 
rf_call_direction = TRIM(SUBSTR(@var1,58,1)), 
rf_call_datetime = str_to_date(SUBSTR(@var1,59,12),'%y%m%d%H%i%s'), 
rf_call_duration = TRIM(SUBSTR(@var1,71,6)), 
rf_charge_flag = TRIM(SUBSTR(@var1,77,1)), 
rf_ict_tgn = TRIM(SUBSTR(@var1,78,4)), 
rf_ict_cno = TRIM(SUBSTR(@var1,82,4)), 
rf_oct_tgn = TRIM(SUBSTR(@var1,86,4)), 
rf_oct_cno = TRIM(SUBSTR(@var1,90,4));", USER(), NOW());

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_SS', 'COUNT', 'Selecting Count From rt_loaded_ss_temp', 20, "SELECT COUNT(*) FROM rt_loaded_ss_temp", USER(), NOW());

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_SS', 'SELECT', 'Selecting From rt_loaded_ss_temp', 25, "SELECT * FROM rt_loaded_ss_temp", USER(), NOW());

-- Inserting for MSC

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_MSC', 'CREATE', 'Creating Temporary Table rt_loaded_msc_temp', 5, "CREATE TEMPORARY TABLE IF NOT EXISTS rt_loaded_msc_temp( 
rf_cdr_type VARCHAR(10), 
rf_record_no INT(8) UNSIGNED, 
rf_partial_op_rec_no VARCHAR(10), 
rf_last_op_rec_no VARCHAR(10), 
rf_calling_imsi VARCHAR(30), 
rf_calling_number VARCHAR(30), 
rf_calling_imei VARCHAR(30), 
rf_called_imsi VARCHAR(30), 
rf_called_number VARCHAR(30), 
rf_called_imei VARCHAR(30), 
rf_called_num_ton VARCHAR(10), 
rf_lac_id VARCHAR(10), 
rf_cell_id VARCHAR(10), 
rf_msc_id VARCHAR(30), 
rf_out_rg VARCHAR(10), 
rf_in_rg VARCHAR(10), 
rf_bs_type VARCHAR(10), 
rf_bs_cd VARCHAR(10), 
rf_call_datetime DATETIME, 
rf_call_duration INT UNSIGNED, 
rf_ss_cd VARCHAR(10), 
rf_ss_actcd VARCHAR(10), 
rf_msrn VARCHAR(30), 
rf_callid_no VARCHAR(10), 
rf_field1 VARCHAR(30), 
rf_field2 VARCHAR(30), 
rf_field3 VARCHAR(30), 
rf_field4 VARCHAR(30) 
) ENGINE = InnoDB;", USER(), NOW());

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_MSC', 'TRUNCATE', 'Truncate table rt_loaded_msc_temp', 10, "TRUNCATE TABLE rt_loaded_msc_temp", USER(), NOW());

  
INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_MSC', 'LOAD', 'Loading data into rt_loaded_msc_temp', 15, "LOAD DATA LOCAL INFILE '{0}' 
INTO TABLE rt_loaded_msc_temp 
FIELDS TERMINATED BY '|' 
LINES TERMINATED BY '\\r\\n' 
IGNORE 1 LINES 
( 
 @rf_cdr_type, @rf_record_no, @rf_partial_op_rec_no, @rf_last_op_rec_no, 
 @rf_calling_imsi, @rf_calling_number, @rf_calling_imei, @rf_called_imsi, 
 @rf_called_number, @rf_called_imei, @rf_called_num_ton, @rf_lac_id, 
 @rf_cell_id, @rf_msc_id, @rf_out_rg, @rf_in_rg, @rf_bs_type, 
 @rf_bs_cd, @rf_call_datetime, @rf_call_duration, @rf_ss_cd, 
 @rf_ss_actcd, @rf_msrn, @rf_callid_no, @rf_field1, 
 @rf_field2, @rf_field3, @rf_field4) 
  SET rf_cdr_type = TRIM(@rf_cdr_type), 
  rf_record_no = IF(TRIM(@rf_record_no)='',0,TRIM(@rf_record_no)),
  rf_partial_op_rec_no = TRIM(@rf_partial_op_rec_no), 
  rf_last_op_rec_no = TRIM(@rf_last_op_rec_no), 
  rf_calling_imsi = TRIM(@rf_calling_imsi), 
  rf_calling_number = TRIM(@rf_calling_number), 
  rf_calling_imei = TRIM(@rf_calling_imei), 
  rf_called_imsi = TRIM(@rf_called_imsi), 
  rf_called_number = TRIM(@rf_called_number), 
  rf_called_imei = TRIM(@rf_called_imei), 
  rf_called_num_ton = TRIM(@rf_called_num_ton), 
  rf_lac_id = TRIM(@rf_lac_id), 
  rf_cell_id = TRIM(@rf_cell_id), 
  rf_msc_id = TRIM(@rf_msc_id), 
  rf_out_rg = TRIM(@rf_out_rg), 
  rf_in_rg = TRIM(@rf_in_rg), 
  rf_bs_type = TRIM(@rf_bs_type), 
  rf_bs_cd = TRIM(@rf_bs_cd), 
  rf_call_datetime = TRIM(str_to_date(@rf_call_datetime,'%d%m%y%H%i%s')), 
  rf_call_duration = IF(TRIM(@rf_call_duration)='',0,TRIM(@rf_call_duration)),
  rf_ss_cd = TRIM(@rf_ss_cd), 
  rf_ss_actcd = TRIM(@rf_ss_actcd), 
  rf_msrn = TRIM(@rf_msrn), 
  rf_callid_no = TRIM(@rf_callid_no), 
  rf_field1 = TRIM(@rf_field1), 
  rf_field2 = TRIM(@rf_field2), 
  rf_field3 = TRIM(@rf_field3), 
  rf_field4 = TRIM(@rf_field4);", USER(), NOW());

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_MSC', 'COUNT', 'Selecting Count From rt_loaded_msc_temp', 20, "SELECT COUNT(*) FROM rt_loaded_msc_temp", USER(), NOW());  
  
INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_MSC', 'SELECT', 'Selecting From rt_loaded_msc_temp', 25, "SELECT * FROM rt_loaded_msc_temp", USER(), NOW());
   	
-- Inserting for SGSN

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_SGSN', 'CREATE', 'Creating Temporary Table rt_loaded_sgsn_temp', 5, "CREATE TEMPORARY TABLE IF NOT EXISTS rt_loaded_sgsn_temp( 
rf_rec_type VARCHAR(30),
rf_rec_seq_number VARCHAR(30),
rf_local_rec_seq INT UNSIGNED,
rf_field1 VARCHAR(30),
rf_system_type VARCHAR(30),
rf_served_imsi VARCHAR(30),
rf_served_imei VARCHAR(30),
rf_served_msisdn VARCHAR(30),
rf_sgsn_addr VARCHAR(30),
rf_ms_net_capability VARCHAR(30),
rf_rounting_are_cd VARCHAR(30),
rf_lac VARCHAR(30),
rf_cell VARCHAR(30),
rf_charging_id VARCHAR(30),
rf_ggsn_addr_used VARCHAR(30),
rf_apn_net_id VARCHAR(30),
rf_apn_select_mode VARCHAR(30),
rf_pdp_type VARCHAR(30),
rf_served_pdp_addr VARCHAR(30),
rf_rec_opening_time DATETIME,
rf_duration MEDIUMINT,
rf_sgsn_change VARCHAR(30),
rf_cause_for_rec_closing VARCHAR(30),
rf_field2 VARCHAR(30),
rf_node_id VARCHAR(30),
rf_field3 VARCHAR(30),
rf_field4 VARCHAR(30),
rf_charge_character VARCHAR(30),
rf_field5 VARCHAR(30),
rf_field6 VARCHAR(30),
rf_field7 VARCHAR(30),
rf_apn_op_id VARCHAR(100),
rf_field8 VARCHAR(30),
rf_scf_address VARCHAR(30),
rf_field9 VARCHAR(30),
rf_field10 VARCHAR(30),
rf_field11 VARCHAR(30),
rf_field12 VARCHAR(30),
rf_field13 VARCHAR(30),
rf_field14 VARCHAR(30),
rf_field15 VARCHAR(30),
rf_field16 VARCHAR(30),
rf_field17 VARCHAR(30),
rf_field18 VARCHAR(30),
rf_field19 VARCHAR(30),
rf_field20 VARCHAR(30),
rf_field21 VARCHAR(30),
rf_field22 VARCHAR(30),
rf_field23 VARCHAR(30),
rf_volume_up INT,
rf_volume_down INT,
rf_field24 VARCHAR(30),
rf_change_time DATETIME,
rf_field25 VARCHAR(30),
rf_field26 VARCHAR(30)
) ENGINE = InnoDB;", USER(), NOW());

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_SGSN', 'TRUNCATE', 'Truncate table rt_loaded_sgsn_temp', 10, "TRUNCATE TABLE rt_loaded_sgsn_temp", USER(), NOW());

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_SGSN', 'LOAD', 'Loading data into rt_loaded_sgsn_temp', 15, "LOAD DATA LOCAL INFILE '{0}' 
INTO TABLE rt_loaded_sgsn_temp 
FIELDS TERMINATED BY '|' 
LINES TERMINATED BY '\\r\\n' 
IGNORE 1 LINES 
( 
@rf_rec_type, @rf_rec_seq_number, @rf_local_rec_seq, @rf_field1, @rf_system_type, 
@rf_served_imsi, @rf_served_imei, @rf_served_msisdn, @rf_sgsn_addr, @rf_ms_net_capability, 
@rf_rounting_are_cd, @rf_lac, @rf_cell, @rf_charging_id, @rf_ggsn_addr_used, 
@rf_apn_net_id, @rf_apn_select_mode, @rf_pdp_type, @rf_served_pdp_addr, @rf_rec_opening_time, 
@rf_duration, @rf_sgsn_change, @rf_cause_for_rec_closing, @rf_field2, @rf_node_id, 
@rf_field3, @rf_field4, @rf_charge_character, @rf_field5, @rf_field6, 
@rf_field7, @rf_apn_op_id, @rf_field8, @rf_scf_address, @rf_field9, 
@rf_field10, @rf_field11, @rf_field12, @rf_field13, @rf_field14, 
@rf_field15, @rf_field16, @rf_field17, @rf_field18, @rf_field19, 
@rf_field20, @rf_field21, @rf_field22, @rf_field23, @rf_volume_up, 
@rf_volume_down, @rf_field24, @rf_change_time, @rf_field25, @rf_field26) 
SET rf_rec_type = TRIM(@rf_rec_type), 
rf_rec_seq_number = TRIM(@rf_rec_seq_number), 
rf_local_rec_seq = IF(TRIM(@rf_local_rec_seq)='',0,TRIM(@rf_local_rec_seq)), 
rf_field1 = TRIM(@rf_field1), 
rf_system_type = TRIM(@rf_system_type), 
rf_served_imsi = TRIM(@rf_served_imsi), 
rf_served_imei = TRIM(@rf_served_imei), 
rf_served_msisdn = TRIM(@rf_served_msisdn), 
rf_sgsn_addr = TRIM(@rf_sgsn_addr), 
rf_ms_net_capability = TRIM(@rf_ms_net_capability), 
rf_rounting_are_cd = TRIM(@rf_rounting_are_cd), 
rf_lac = TRIM(@rf_lac), 
rf_cell = TRIM(@rf_cell), 
rf_charging_id = TRIM(@rf_charging_id), 
rf_ggsn_addr_used = TRIM(@rf_ggsn_addr_used), 
rf_apn_net_id = TRIM(@rf_apn_net_id), 
rf_apn_select_mode = TRIM(@rf_apn_select_mode), 
rf_pdp_type = TRIM(@rf_pdp_type), 
rf_served_pdp_addr = TRIM(@rf_served_pdp_addr), 
rf_rec_opening_time = IF(str_to_date(TRIM(@rf_rec_opening_time),'%d%m%y%H%i%s')='','0000-00-00 00:00:00',str_to_date(TRIM(@rf_rec_opening_time),'%d%m%y%H%i%s')), 
rf_duration = IF(TRIM(@rf_duration)='',0,TRIM(@rf_duration)), 
rf_sgsn_change = TRIM(@rf_sgsn_change), 
rf_cause_for_rec_closing = TRIM(@rf_cause_for_rec_closing), 
rf_field2 = TRIM(@rf_field2), 
rf_node_id = TRIM(@rf_node_id), 
rf_field3  = TRIM(@rf_field3), 
rf_field4  = TRIM(@rf_field4), 
rf_charge_character = TRIM(@rf_charge_character), 
rf_field5 = TRIM(@rf_field5), 
rf_field6 = TRIM(@rf_field6), 
rf_field7 = TRIM(@rf_field7), 
rf_apn_op_id = TRIM(@rf_apn_op_id), 
rf_field8 = TRIM(@rf_field8), 
rf_scf_address = TRIM(@rf_scf_address), 
rf_field9 = TRIM(@rf_field9), 
rf_field10 = TRIM(@rf_field10), 
rf_field11 = TRIM(@rf_field11), 
rf_field12 = TRIM(@rf_field12), 
rf_field13 = TRIM(@rf_field13), 
rf_field14 = TRIM(@rf_field14), 
rf_field15 = TRIM(@rf_field15), 
rf_field16 = TRIM(@rf_field16), 
rf_field17 = TRIM(@rf_field17), 
rf_field18 = TRIM(@rf_field18), 
rf_field19 = TRIM(@rf_field19), 
rf_field20 = TRIM(@rf_field20), 
rf_field21 = TRIM(@rf_field21), 
rf_field22 = TRIM(@rf_field22), 
rf_field23 = TRIM(@rf_field23), 
rf_volume_up = IF(TRIM(@rf_volume_up)='',0,TRIM(@rf_volume_up)), 
rf_volume_down = IF(TRIM(@rf_volume_down)='',0,TRIM(@rf_volume_down)), 
rf_field24 = TRIM(@rf_field24), 
rf_change_time = IF(str_to_date(TRIM(@rf_change_time),'%d%m%y%H%i%s')='','0000-00-00 00:00:00',str_to_date(TRIM(@rf_change_time),'%d%m%y%H%i%s')),
rf_field25 = TRIM(@rf_field25), 
rf_field26 = TRIM(@rf_field26);", USER(), NOW());

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_SGSN', 'COUNT', 'Selecting Count From rt_loaded_sgsn_temp', 20, "SELECT COUNT(*) FROM rt_loaded_sgsn_temp", USER(), NOW());

INSERT INTO rt_parameters(rf_param1, rf_param2, rf_paramdesc1, rf_numberdata, rf_chardata, rf_create_by, rf_create_dt) 
	VALUES('LOAD_SGSN', 'SELECT', 'Selecting From rt_loaded_sgsn_temp', 25, "SELECT * FROM rt_loaded_sgsn_temp", USER(), NOW());
   		