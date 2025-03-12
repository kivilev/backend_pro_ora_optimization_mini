/*
  Education course: Oracle SQL Optimization
  Author: Kivilev Denis (https://t.me/oracle_dbd, http://backend-pro.ru,  https://www.youtube.com/c/OracleDBD)

  Lesson. Find entry/start point
  
  Description: find slow queries
  
*/

select m.sql_text
      ,(m.last_refresh_time - m.sql_exec_start)*24*60*60 sec
      ,dbms_sqltune.report_sql_monitor(sql_id => m.sql_id, type => 'HTML', report_level => 'ALL') AS report_html
      ,dbms_sqltune.report_sql_monitor(sql_id => m.sql_id, type => 'ACTIVE', report_level => 'ALL') AS report_txt
      ,dbms_sqltune.report_sql_monitor(sql_id => m.sql_id, type => 'TEXT', report_level => 'ALL') AS report_active
from  v$sql_monitor m
where m.sid = :sid and m.session_serial# = :serial#
order by sql_exec_start desc;

