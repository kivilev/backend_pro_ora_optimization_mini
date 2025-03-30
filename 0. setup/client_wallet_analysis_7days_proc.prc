/*
  Education course: Oracle SQL Optimization
  Author: Kivilev Denis (https://t.me/oracle_dbd, http://backend-pro.ru)

  Lesson: 0. setup
  
  Description: Initial client wallet analysis procedure with unoptimized queries
  
*/

create or replace procedure client_wallet_analysis_7days_proc is
  /*
  ​The procedure analyzes client and wallet data over the past seven days,
  including counts of active clients and wallets, total accounts, payment statistics, currency distribution,
  negative balances, high-value transactions, and retrieves profiles of VIP clients
  */
  v_active_client_count    number;
  v_active_wallet_count    number;
  v_total_account_count    number;
  v_successful_payments    number;
  v_failed_payments        number;
  v_high_value_us_tx_count number;
  v_client_id              client.client_id%type;
  v_wallet_id              wallet.wallet_id%type;
  v_usd_currency_id        currency.currency_id%type;
  v_start_time             timestamp;

  type currency_distribution_rec is record(
     currency_code char(3 char)
    ,account_count number);
  type currency_distribution_tab is table of currency_distribution_rec index by pls_integer;
  v_currency_distribution currency_distribution_tab;

  type risk_client_rec is record(
     client_id    number(30)
    ,block_reason varchar2(200 char));
  type risk_client_tab is table of risk_client_rec index by pls_integer;
  v_risk_clients risk_client_tab;

  type negative_balance_rec is record(
     account_id    number(38)
    ,balance       number(30, 2)
    ,currency_code char(3 char));
  type negative_balance_tab is table of negative_balance_rec index by pls_integer;
  v_negative_balances negative_balance_tab;

  type recent_transaction_rec is record(
     payment_id  number(38)
    ,amount      number(30, 2)
    ,currency    char(3 char)
    ,create_date timestamp(6));
  type recent_transaction_tab is table of recent_transaction_rec index by pls_integer;
  v_recent_transactions recent_transaction_tab;

  type suspicious_transaction_rec is record(
     payment_id  number(38)
    ,amount      number(30, 2)
    ,currency    char(3 char)
    ,create_date timestamp(6));
  type suspicious_transaction_tab is table of suspicious_transaction_rec index by pls_integer;
  v_suspicious_transactions suspicious_transaction_tab;

  type client_profile_rec is record(
     field_name  varchar2(100 char)
    ,field_value varchar2(200 char));
  type client_profile_tab is table of client_profile_rec index by pls_integer;
  v_client_profile client_profile_tab;

  type payment_client_mapping_rec is record(
     payment_id  number(38)
    ,client_name varchar2(200 char));
  type payment_client_mapping_tab is table of payment_client_mapping_rec index by pls_integer;
  v_payment_client_mapping payment_client_mapping_tab;

  v_client_ids t_numbers;
  v_active_client_ids t_numbers;

begin
  dbms_output.put_line('Procedure has started');

  v_start_time := systimestamp;

  -- Query 1: Number of active clients
  select count(*)
    into v_active_client_count
    from client
   where is_active = 1;

  -- Query 2: Number of active wallets
  select count(*)
    into v_active_wallet_count
    from wallet
   where status_id = 0;

  -- Query 3: Total number of accounts
  select count(*) into v_total_account_count from account;

  -- Query 4: Retrieving USD currency ID
  select currency_id
    into v_usd_currency_id
    from currency
   where alfa3 = 'USD';

  -- Query 5: Number of successful payments
  select count(*)
    into v_successful_payments
    from payment t
   where t.status = 1
     and t.create_dtime >= trunc(sysdate) - 7;

  -- Query 6: Number of unsuccessful payments
  select count(*)
    into v_failed_payments
    from payment t
   where status = 2
     and t.create_dtime >= trunc(sysdate) - 7;

  -- Query 7: Analysis of currency distribution across accounts
  select c.alfa3
        ,count(a.account_id)
    bulk collect
    into v_currency_distribution
    from account a
    join currency c
      on a.currency_id = c.currency_id
   group by c.alfa3
   order by count(a.account_id) desc;

  -- Query 8: Accounts with negative balance
  select a.account_id
        ,a.balance
        ,c.alfa3
    bulk collect
    into v_negative_balances
    from account a
    join currency c
      on a.currency_id = c.currency_id
   where a.balance < 0;

  -- Query 9: Determining VIP client (by highest USD balance)
  begin
    select /*+ use_hash(c w) full(a) full(w) parallel(w 2) paralel(a 2)*/
     c.client_id
      into v_client_id
      from client c
      join wallet w
        on w.client_id = c.client_id
      join account a
        on a.wallet_id = w.wallet_id
     where c.is_active = 1
       and a.currency_id = v_usd_currency_id
     order by a.balance desc
     fetch first 1 row only;
  exception
    when no_data_found then
      v_client_id := null;
  end;

  -- Query 10: Identifying clients with blocked wallets
  select c.client_id
        ,w.status_change_reason
    bulk collect
    into v_risk_clients
    from client c
    join wallet w
      on c.client_id = w.client_id
   where w.status_id = 1
     and c.is_active = 1
     and rownum <= 5;

  -- Query 11: Analysis of recent payments (over the last 7 days)
  select p.payment_id
        ,p.summa
        ,c.alfa3
        ,p.create_dtime
    bulk collect
    into v_recent_transactions
    from payment p
    join currency c
      on p.currency_id = c.currency_id
   where p.create_dtime >= trunc(sysdate) - 7
   order by p.create_dtime desc
   fetch first 5 rows only;

  -- Query 12: Get suspicious transactions
  select /*+ use_hash(p c) */
   p.payment_id
  ,p.summa
  ,c.alfa3
  ,p.create_dtime
    bulk collect
    into v_suspicious_transactions
    from payment p
    join currency c
      on p.currency_id = c.currency_id
   where p.summa > 900
     and p.create_dtime >= trunc(sysdate) - 7
   order by p.summa desc
   fetch first 5 rows only;

  -- Query 13: Retrieve the number of 300 random user with balance > 1000
  select t.client_id
    bulk collect
    into v_client_ids
    from account t
   where t.balance > 1000
     and rownum <= 300;
     
  select count(c.client_id)
    into v_active_client_count 
    from client c
        ,table(v_client_ids) t
   where c.is_active = 1;

  -- Query 14: Retrieving count of active 30 years people
  select count(*)
    into v_active_client_count
    from table(v_client_ids) c
    join client_data cd
      on cd.client_id = value(c)
   where cd.field_id = 3
     and to_date(cd.field_value, 'YYYY-MM-DD') >= add_months(sysdate, -12 * 30);

  dbms_output.put_line('Procedure has ended. Spent time: ' ||
                       to_char(systimestamp - v_start_time));
end;
/
