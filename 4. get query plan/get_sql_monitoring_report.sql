/*
  Education course: Oracle SQL Optimization
  Author: Kivilev Denis (https://t.me/oracle_dbd, http://backend-pro.ru,  https://www.youtube.com/c/OracleDBD)

  Lesson. Query plan
  
  Description: get query plans
  
*/

-- v$ data
select m.sql_id
      ,m.sql_text
      ,m.username
      ,m.module
      ,m.action
      ,m.sid
      ,m.session_serial#
      ,(m.last_refresh_time - m.sql_exec_start)*24*60*60 sec
      ,dbms_sqltune.report_sql_monitor(sql_id => m.sql_id, sql_exec_id => m.sql_exec_id, type => 'HTML', report_level => 'ALL') AS report_html
      ,dbms_sqltune.report_sql_monitor(sql_id => m.sql_id, sql_exec_id => m.sql_exec_id, type => 'ACTIVE', report_level => 'ALL') as report_active
      ,dbms_sqltune.report_sql_monitor(sql_id => m.sql_id, sql_exec_id => m.sql_exec_id, type => 'TEXT', report_level => 'ALL') AS report_txt
from  v$sql_monitor m
where m.sid = 297 and m.session_serial# = 51289
order by sql_exec_start desc;

-- historical data
select t.session_id
      ,t.session_serial#
      ,(t.period_end_time - t.period_start_time)*60*60*24 sec
      ,t.key1 sql_id
      ,dbms_auto_report.report_repository_detail(rid => t.report_id, type => 'HTML') report_html
      ,dbms_auto_report.report_repository_detail(rid => t.report_id, type => 'ACTIVE') report_active
      ,dbms_auto_report.report_repository_detail(rid => t.report_id, type => 'TEXT') report_txt
  from dba_hist_reports t
 where t.session_id = 297
   and t.session_serial# = 51289
   and t.component_name = 'sqlmonitor';


