/*
  Education course: Oracle SQL Optimization
  Author: Kivilev Denis (https://t.me/oracle_dbd, http://backend-pro.ru,  https://www.youtube.com/c/OracleDBD)

  Lesson. Find entry/start point
  
  Description: find slow queries
  
*/

-- данные в SGA
select m.sql_id
      ,m.sql_text
      ,m.username
      ,m.module
      ,m.action
      ,m.sid
      ,m.session_serial#
      ,(m.last_refresh_time - m.sql_exec_start)*24*60*60 sec
      ,m.*
from  v$sql_monitor m
where m.sid = &sid and m.session_serial# = &serial#
order by sql_exec_start desc;


-- исторические данные в AWR
select m.session_id
      ,m.session_serial#
      ,(m.period_end_time - m.period_start_time)*60*60*24 sec
      ,m.key1 sql_id
      ,m.*
  from dba_hist_reports m
 where m.session_id = 44
   and m.session_serial# = 23193
   and m.component_name = 'sqlmonitor';

