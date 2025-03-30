/*
  Education course: Oracle SQL Optimization
  Author: Kivilev Denis (https://t.me/oracle_dbd, http://backend-pro.ru,  https://www.youtube.com/c/OracleDBD)

  Lesson. Find entry/start point
  
  Description: find slow queries
  
*/

-- data in SGA
select m.sql_id
      ,m.sql_text
      ,m.username
      ,m.module
      ,m.action
      ,m.sid
      ,m.session_serial#
      ,(m.last_refresh_time - m.sql_exec_start)*24*60*60 exec_sec
      ,'---'
      ,m.*
from  v$sql_monitor m
where m.sid = 297 and m.session_serial# = 51289
order by sql_exec_start desc;


-- historical data in AWR
select m.session_id
      ,m.session_serial#
      ,(m.period_end_time - m.period_start_time)*60*60*24 exec_sec
      ,m.key1 sql_id
      ,'---'
      ,m.*
  from dba_hist_reports m
 where m.session_id = 297
   and m.session_serial# = 51289
   and m.component_name = 'sqlmonitor';


-- job + reports directly in SGA + AWR
select sysdate
       ,substr(t.session_id, 0, instr(t.session_id, ',')-1) sid
       ,substr(t.session_id, instr(t.session_id, ',')+1)  serial
       ,sm.report_id
       ,sm.sql_id
       ,sm.sql_exec_id
       ,sm.sql_exec_start
       ,'report: '
       ,rep.report_id
       ,rep.key1 sql_id_rep
       ,t.run_duration
       ,t.*
  from dba_scheduler_job_run_details t
  left join v$sql_monitor sm on sm.sid = substr(t.session_id, 0, instr(t.session_id, ',')-1) and
                                sm.session_serial# = substr(t.session_id, instr(t.session_id, ',')+1)
  left join dba_hist_reports rep on rep.session_id = substr(t.session_id, 0, instr(t.session_id, ',')-1) and
                                  rep.session_serial# = substr(t.session_id, instr(t.session_id, ',')+1)
                                 and sm.sql_id = rep.key1
 where t.job_name= 'CLIENT_WALLET_ANALYSIS_7DAYS_JOB' order by t.log_date desc;
