/*
This script creates the DEMO user in an Oracle database with the default password "booble12". 
It grants the necessary privileges for connecting to the database, reading tables and system dictionaries, 
and executing SQL monitoring functions. Additionally, it ensures the password does not expire and limits 
the tablespace quota to 100MB.

Optional privileges for working with Real Application Clusters (RAC), PL/SQL analysis, and AWR reports 
are included but commented out.
*/

-- 1. Create user DEMO with password "booble12"
CREATE USER DEMO IDENTIFIED BY booble12 
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP 
QUOTA 100M ON USERS;  -- Limit usage to 100MB

-- 2. Disable password expiration
ALTER USER DEMO PROFILE DEFAULT;
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

-- 3. Grant necessary privileges
GRANT CREATE SESSION TO DEMO;   -- Allow connection to the database
GRANT SELECT ANY TABLE TO DEMO; -- Allow reading all tables
GRANT SELECT ANY DICTIONARY TO DEMO; -- Allow reading system dictionaries

-- 4. Grant privileges for SQL monitoring
-- GRANT ADVISOR TO DEMO;
GRANT SELECT ON V_$SQL_MONITOR TO DEMO;
GRANT SELECT ON V_$SQL_PLAN_MONITOR TO DEMO;
GRANT SELECT ON V_$SESSION TO DEMO;
GRANT SELECT ON V_$SQL TO DEMO;
GRANT SELECT ON V_$SQLAREA TO DEMO;
GRANT SELECT ON V_$SQLSTATS TO DEMO;
GRANT SELECT ON V_$ACTIVE_SESSION_HISTORY TO DEMO;
GRANT SELECT ON V_$DATABASE TO DEMO;
GRANT SELECT ON DBA_HIST_SQLTEXT TO DEMO;
GRANT SELECT ON DBA_HIST_SQLSTAT TO DEMO;
GRANT SELECT ON DBA_HIST_ACTIVE_SESS_HISTORY TO DEMO;
GRANT SELECT ON DBA_HIST_SNAPSHOT TO DEMO;
GRANT SELECT ON DBA_HIST_SYSTEM_EVENT TO DEMO;
GRANT SELECT ON DBA_HIST_SYSMETRIC_SUMMARY TO DEMO;
GRANT SELECT ON DBA_HIST_SYSSTAT TO DEMO;

-- 5. (Optional) Grant access to GV$ views for RAC environments
/*
GRANT SELECT ON GV_$SESSION TO DEMO;
GRANT SELECT ON GV_$SQL TO DEMO;
GRANT SELECT ON GV_$SQLAREA TO DEMO;
*/

-- 6. (Optional) Grant execution privileges for PL/SQL performance analysis
GRANT EXECUTE ON DBMS_SQLTUNE TO DEMO;
GRANT EXECUTE ON DBMS_SQL_MONITOR TO DEMO;
GRANT EXECUTE ON DBMS_XPLAN TO DEMO;

-- 7. (Optional) Grant access to AWR reports (if AWR is enabled)
/*
GRANT SELECT ON DBA_HIST_SNAPSHOT TO DEMO;
GRANT SELECT ON DBA_HIST_SYSTEM_EVENT TO DEMO;
GRANT SELECT ON DBA_HIST_SYSMETRIC_SUMMARY TO DEMO;
GRANT SELECT ON DBA_HIST_SYSSTAT TO DEMO;
*/
