SQL_ID  bf5rc9by0axxx, child number 0
-------------------------------------
 
Plan hash value: 3239180514
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                        | Name                        | Starts | E-Rows | E-Time   | A-Rows |   A-Time   | Buffers | Reads  |  OMem |  1Mem | Used-Mem |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                 |                             |      1 |        |          |   3546 |00:16:30.69 |    1858K|   1260K|       |       |          |
|   1 |  HASH UNIQUE                     |                             |      1 |      9 | 00:00:43 |   3546 |00:16:30.69 |    1858K|   1260K|  1970K|  1970K| 1357K (0)|
|*  2 |   HASH JOIN                      |                             |      1 |      9 | 00:00:43 |   3744 |00:16:30.67 |    1858K|   1260K|  1368K|  1368K|   11M (0)|
|*  3 |    HASH JOIN                     |                             |      1 |    673K| 00:00:04 |   3785 |00:01:16.88 |     225K|    136K|    52M|  5547K|   55M (0)|
|   4 |     NESTED LOOPS                 |                             |      1 |    498K| 00:00:01 |    619K|00:00:01.80 |    9942 |      0 |       |       |          |
|   5 |      NESTED LOOPS                |                             |      1 |    516K| 00:00:01 |    619K|00:00:00.43 |    2195 |      0 |       |       |          |
|   6 |       TABLE ACCESS BY INDEX ROWID| OPOD_RCL                    |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       2 |      0 |       |       |          |
|*  7 |        INDEX RANGE SCAN          | OPOD_RCL_AMNDST_IDX         |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       1 |      0 |       |       |          |
|*  8 |       INDEX RANGE SCAN           | OPOD_RCL_INFO_IDX           |      1 |    516K| 00:00:01 |    619K|00:00:00.36 |    2193 |      0 |       |       |          |
|   9 |      TABLE ACCESS BY INDEX ROWID | OPOD_RCL_INFO               |    619K|    498K| 00:00:01 |    619K|00:00:01.04 |    7747 |      0 |       |       |          |
|* 10 |     TABLE ACCESS FULL            | DEC_CLIENT_DOC              |      1 |   2309K| 00:00:03 |   2820K|00:00:07.34 |     214K|    136K|       |       |          |
|  11 |    TABLE ACCESS BY INDEX ROWID   | DEC_CLIENT                  |      1 |   2065K| 00:00:40 |   2254K|00:15:11.72 |    1633K|   1124K|       |       |          |
|* 12 |     INDEX SKIP SCAN              | DEC_CLIENT_PM_DATE_FROM_IDX |      1 |   2065K| 00:00:15 |   2254K|00:00:12.47 |   13954 |   7790 |       |       |          |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$EE94F965
   6 - SEL$EE94F965 / R@SEL$1
   7 - SEL$EE94F965 / R@SEL$1
   8 - SEL$EE94F965 / RI@SEL$1
   9 - SEL$EE94F965 / RI@SEL$1
  10 - SEL$EE94F965 / DCD@SEL$2
  11 - SEL$EE94F965 / DC@SEL$3
  12 - SEL$EE94F965 / DC@SEL$3
 
Outline Data
-------------
 
  /*+
      BEGIN_OUTLINE_DATA
      IGNORE_OPTIM_EMBEDDED_HINTS
      OPTIMIZER_FEATURES_ENABLE('11.2.0.4')
      DB_VERSION('11.2.0.4')
      ALL_ROWS
      OUTLINE_LEAF(@"SEL$EE94F965")
      MERGE(@"SEL$9E43CB6E")
      OUTLINE(@"SEL$4")
      OUTLINE(@"SEL$9E43CB6E")
      MERGE(@"SEL$58A6D7F6")
      OUTLINE(@"SEL$3")
      OUTLINE(@"SEL$58A6D7F6")
      MERGE(@"SEL$1")
      OUTLINE(@"SEL$2")
      OUTLINE(@"SEL$1")
      INDEX_RS_ASC(@"SEL$EE94F965" "R"@"SEL$1" ("OPOD_RCL"."AMND_STATE"))
      INDEX(@"SEL$EE94F965" "RI"@"SEL$1" ("OPOD_RCL_INFO"."ID_OPOD_RCL"))
      FULL(@"SEL$EE94F965" "DCD"@"SEL$2")
      INDEX_SS(@"SEL$EE94F965" "DC"@"SEL$3" ("DEC_CLIENT"."CLIENT_PERS_MANAGER_DATE_FROM" "DEC_CLIENT"."CLIENT_AMND_STATE"))
      LEADING(@"SEL$EE94F965" "R"@"SEL$1" "RI"@"SEL$1" "DCD"@"SEL$2" "DC"@"SEL$3")
      USE_NL(@"SEL$EE94F965" "RI"@"SEL$1")
      NLJ_BATCHING(@"SEL$EE94F965" "RI"@"SEL$1")
      USE_HASH(@"SEL$EE94F965" "DCD"@"SEL$2")
      USE_HASH(@"SEL$EE94F965" "DC"@"SEL$3")
      USE_HASH_AGGREGATION(@"SEL$EE94F965")
      END_OUTLINE_DATA
  */
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("DC"."CLIENT_ID"="DCD"."CLIENT_DOC_CLIENT_ID")
       filter((("RI"."BIRTH_DAY" IS NULL OR TO_NUMBER("RI"."BIRTH_DAY")=EXTRACT(DAY FROM INTERNAL_FUNCTION("DC"."CLIENT_BIRTH_DATE"))) AND ("RI"."BIRTH_MONTH" 
              IS NULL OR TO_NUMBER("RI"."BIRTH_MONTH")=EXTRACT(MONTH FROM INTERNAL_FUNCTION("DC"."CLIENT_BIRTH_DATE"))) AND ("RI"."BIRTH_YEAR" IS NULL OR 
              TO_NUMBER("RI"."BIRTH_YEAR")=EXTRACT(YEAR FROM INTERNAL_FUNCTION("DC"."CLIENT_BIRTH_DATE")))))
   3 - access("RI"."DOCUMENT_ISSUE_DATE"="DCD"."CLIENT_DOC_DATE" AND TRANSLATE("DEC_TERROR"."NORMALISEDOC"("RI"."DOCUMENT_ID"),'КСРЕХОТМНАУВM','KCPEXOTMHAYBM')=T
              RANSLATE("DEC_TERROR"."NORMALISEDOC"("CLIENT_DOC_SERIA","CLIENT_DOC_NUMBER"),'КСРЕХОТМНАУВM','KCPEXOTMHAYBM'))
   7 - access("R"."AMND_STATE"='A')
   8 - access("RI"."ID_OPOD_RCL"="R"."ID")
  10 - filter(("DCD"."CLIENT_DOC_DATE" IS NOT NULL AND "DCD"."CLIENT_DOC_IS_ACTUAL"='Y' AND "DCD"."CLIENT_DOC_AMND_STATE"='A' AND "DCD"."CLIENT_DOC_STATUS"='O'))
  12 - access("DC"."CLIENT_AMND_STATE"='A')
       filter("DC"."CLIENT_AMND_STATE"='A')
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
 
   1 - "DC"."CLIENT_ID"[NUMBER,22]
   2 - (#keys=1) "DC"."CLIENT_ID"[NUMBER,22]
   3 - (#keys=2) "RI"."BIRTH_DAY"[VARCHAR2,2], "RI"."BIRTH_MONTH"[VARCHAR2,2], "RI"."BIRTH_YEAR"[VARCHAR2,4], "DCD"."CLIENT_DOC_CLIENT_ID"[NUMBER,22]
   4 - "RI"."BIRTH_DAY"[VARCHAR2,2], "RI"."BIRTH_MONTH"[VARCHAR2,2], "RI"."BIRTH_YEAR"[VARCHAR2,4], "RI"."DOCUMENT_ID"[VARCHAR2,25], 
       "RI"."DOCUMENT_ISSUE_DATE"[DATE,7]
   5 - "RI".ROWID[ROWID,10]
   6 - "R"."ID"[NUMBER,22]
   7 - "R".ROWID[ROWID,10]
   8 - "RI".ROWID[ROWID,10]
   9 - "RI"."BIRTH_DAY"[VARCHAR2,2], "RI"."BIRTH_MONTH"[VARCHAR2,2], "RI"."BIRTH_YEAR"[VARCHAR2,4], "RI"."DOCUMENT_ID"[VARCHAR2,25], 
       "RI"."DOCUMENT_ISSUE_DATE"[DATE,7]
  10 - "DCD"."CLIENT_DOC_CLIENT_ID"[NUMBER,22], "CLIENT_DOC_SERIA"[VARCHAR2,255], "CLIENT_DOC_NUMBER"[VARCHAR2,255], "DCD"."CLIENT_DOC_DATE"[DATE,7]
  11 - "DC"."CLIENT_ID"[NUMBER,22], "DC"."CLIENT_BIRTH_DATE"[DATE,7]
  12 - "DC".ROWID[ROWID,10]
 
