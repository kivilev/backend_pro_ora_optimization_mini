SQL_ID  3rr36bmpsd0d8, child number 1
-------------------------------------
SELECT * FROM ( SELECT V.PID, V.IS_NAZNACH, V.DS_HID, V.ID, V.ARMS, V.GAI, V.SSERVICE_TYPE, V.SERVICE, V.SERVICE_NAME, V.SSERV_STATUS, V.OUT_DIR_STATUS, V.SOPEN_VISIT, V.LABMED_IS_REPEAT, COALESCE(V.LABMED_VAL_RESULT, (SELECT CASE WHEN COALESCE(PC.NORM, -1) = 1 THEN 0 ELSE 1 END FROM D_V_PROF_CARD_CONCLUSIONS_BASE PCC LEFT JOIN D_V_PC_CONCLUSIONS PC ON PC.ID = PCC.CONCLUSION WHERE PCC.VISIT = V.VISIT_ID AND PCC.PID = V.PID AND ROWNUM = 1), (SELECT CASE WHEN PCSOR.IS_TRUE_DISEASE IS NULL THEN NULL ELSE 1 - PC.NORM END FROM D_V_PC_SERV_OTHER_RESULTS PCSOR LEFT JOIN D_V_PC_CONCLUSIONS PC ON PC.ID = PCSOR.IS_TRUE_DISEASE WHERE PCSOR.PID = V.ID)) LABMED_VAL_RESULT, V.VAL_RESULT_STR, V.VISIT_EMPLOYER, V.NSERVICE_TYPE, V.VISIT_MKB, (CASE WHEN V.NSERVICE_TYPE = 8 THEN D_F_GET_LABMED_EHRS(V.DIRECTION_SERVICE, 0, V.LPU) ELSE (SELECT COUNT(1) FROM D_V_EHRS_BASE E JOIN D_V_EHR_STATES_BASE E2 ON E2.PID = E.ID WHERE E.UNIT_ID = V.VISIT_ID AND E2.SGN_HASH IS NOT NULL ) END) IS_SIGNED, (CASE WHEN V.NSERVICE_TYPE = 8 THEN D_F_GET_LABMED_EHRS(V.DIRECTION_SERVICE, 1, V.LPU) ELSE (SELECT SUM(CASE WHEN (SELECT COUNT(1) FROM D_V_INT_HL7V3_MSGS REQ LEFT JOIN D_V_INT_HL7V3_MSGS RESP ON RESP.HID = REQ.ID WHERE REQ.UNIT = 'EHR_STATES' AND REQ.UNIT_ID = E2.ID AND REQ.ERROR_MSG IS NULL AND RESP.ERROR_MSG IS NULL) > 0 THEN 1 ELSE 0 END) FROM D_V_EHRS_BASE E JOIN D_V_EHR_STATES_BASE E2 ON E2.PID = E.ID WHERE E.UNIT_ID = V.VISIT_ID AND E2.SGN_HASH IS NOT NULL ) END) IS_IN_IEMK, (SELECT SUM(CASE WHEN (SELECT COUNT(1) FROM D_V_INT_HL7V3_MSGS REQ LEFT JOIN D_V_INT_HL7V3_MSGS RESP ON RESP.HID = REQ.ID WHERE REQ.UNIT = 'EHR_STATES' AND REQ.UNIT_ID = E2.ID AND REQ.ERROR_MSG IS NULL AND RESP.ERROR_MSG IS NULL) > 0 THEN 1 ELSE 0 END) FROM D_V_EHRS_BASE E JOIN D_V_EHR_STATES_BASE E2 ON E2.PID = E.ID WHERE E.UNIT_ID = V.DISEASECASE AND E2.SGN_HASH IS NOT NULL ) IS_IN_IEMK_DC, (CASE WHEN V.NSERVICE_TYPE = 8 THEN D_F_GET_LABMED_EHRS(V.DIRECTION_SERVICE, 2, V.LPU) ELSE (SELECT COUNT(1) FROM D_V_EHRS_BASE E JOIN D_V_EHR_STATES_BASE E2 ON E2.PID = E.ID WHERE E.UNIT_ID = V.VISIT_ID AND E2.SGN_HASH IS NOT NULL AND (SELECT D_PKG_EX_SYSTEM_VALUES.GET_VAL(NULL, 'remd/mis', 'EMDR_ID', 'EHR_STATES', E2.ID) FROM DUAL) IS NOT NULL ) END) IS_IN_REMD, (SELECT COUNT(1) FROM D_V_EHRS_BASE E JOIN D_V_EHR_STATES_BASE E2 ON E2.PID = E.ID WHERE E.UNIT_ID = V.DISEASECASE AND E2.SGN_HASH IS NOT NULL AND (SELECT D_PKG_EX_SYSTEM_VALUES.GET_VAL(NULL, 'remd/mis', 'EMDR_ID', 'EHR_STATES', E2.ID) FROM DUAL) IS NOT NULL ) IS_IN_REMD_DC, D_F_GET_DIR_SERV_LABMED(V.DIRECTION_SERVICE,V.LPU) LABMED_PATJOUR_ID, CASE WHEN V.VISIT_DATE IS NOT NULL THEN V.VISIT_DATE ELSE (SELECT MAX(ATOV.VIS_DATE) FROM D_V_PC_SERV_OTHER_RESULTS_ATOV ATOV WHERE ATOV.PID = V.ID) END VISIT_DATE, V.VISIT_ID, V.STATE, V.REC_DATE, V.NSERV_STATUS, V.DIRECTION_SERVICE, V.DISEASECASE, V.SERVICE_ID, V.SERVICES_STR_COUNT, SIGN(V.SERVICES_STR_COUNT) HAS_CHILD_SERVICE, V.DIR_ID, V.LABMED_VAL_RESULT_STR, CASE WHEN V.STATE IS NULL AND (V.NSERV_STATUS IS NULL OR V.NSERV_STATUS = 0) THEN 1 ELSE 0 END IS_USED, V.DS_ID, V.IS_COMMENT, V.IS_MSEK, V.NSAMPLE_IN_WORK, COALESCE((SELECT TO_CLOB(PC.C_NAME) FROM D_V_PC_SERV_OTHER_RESULTS PCSOR JOIN D_V_PROF_CARD_SERVICES_BASE PCS ON PCS.ID = PCSOR.PID LEFT JOIN D_V_PC_CONCLUSIONS PC ON PC.ID = PCSOR.IS_TRUE_DISEASE WHERE PCSOR.PID = V.ID AND PCS.STATE IN (1, 2, 5, 7)), V.ZAKL, (SELECT TO_CLOB(PCSOR.ZAKL) FROM D_V_PC_SERV_OTHER_RESULTS PCSOR WHERE PCSOR.PID = V.ID)) ZAKL, (SELECT COUNT(1) FROM D_V_MEDICAL_COMMISSIONS MC WHERE MC.PROT_SERV_ID = V.SERVICE_ID AND (MC.DATE_END > SYSDATE OR MC.DATE_END IS NULL) AND MC.IS_CONCORD IN(1,2)) CHECK_MED, V.NURSE_USER_TEMPLATES, CASE WHEN V.SOPEN_VISIT = 'Принять' THEN (SELECT COUNT(1) FROM D_V_DISPS_SERVICES DIS WHERE DIS.SERVICE = V.SERVICE AND DIS.DISP_SERVICE IN ('PMVN1.13', 'PMVN1.05', 'D1.07.1', 'D1.07') AND TO_NUMBER(COALESCE((SELECT D_PKG_OPTIONS.GET('UpdateSSR', V.LPU, 0) FROM DUAL), '0')) = 1 AND PCT_ID = DIS.PC_TYPE_ID AND PCT_CODE IN (2, 6)) END DISABLE_CREATE_VISIT, CASE WHEN V.PROF_CARD_MODEL IS NOT NULL THEN (SELECT MS.S_ORDER FROM D_V_PROF_CARD_MODELS_SR MS WHERE MS.SERVICE_ID = V.SERVICE_ID AND MS.PID = V.PROF_CARD_MODEL AND ROWNUM = 1) END S_ORDER, CASE WHEN V.DS_ID IS NOT NULL AND V.NSERV_STATUS <> 1 AND V.NSERVICE_TYPE = 8 THEN CASE WHEN (SELECT COUNT(1) FROM D_V_PROF_CARD_BASE PC WHERE PC.ID = V.PID AND PC.DATE_E IS NOT NULL) + (SELECT COUNT(1) FROM D_V_DISEASECASES_BASE DSC WHERE DSC.ID = V.DISEASECASE AND DSC.IS_CLOSE <> 0) + (SELECT COUNT(1) FROM D_V_AMB_TALONS_BASE AT JOIN D_V_AMB_TALON_VISITS_BASE ATV ON AT.ID = ATV.PID JOIN D_V_VISITS_BASE VIS ON ATV.VISIT = VIS.ID JOIN D_V_DIRECTION_SERVICES_BASE DS ON DS.ID = VIS.PID OR DS.HID = VIS.PID WHERE DS.ID = V.DS_ID AND ROWNUM = 1) > 0 THEN 0 ELSE 1 END ELSE 0 END CAN_EXCLUDE FROM (SELECT S.ID, S.LPU, S.CID, S.PID, S.SERVICE_ID, S.SERVICE, S.SERVICE_NAME, S.SERVICE_NAME_SHORT, S.SSERVICE_TYPE, S.NSERVICE_TYPE, S.DIRECTION_SERVICE, S.NSERV_STATUS, S.REC_DATE, S.SSERV_STATUS, S.SOPEN_VISIT, S.VISIT_ID, S.VISIT_EMPLOYER, S.VISIT_DATE, S.VISIT_MKB, S.LABMED_IS_REPEAT, S.LABMED_VAL_RESULT, S.LABMED_VAL_RESULT_STR, S.STATE, S.IS_NAZNACH, S.REG_DATE, S.REG_EMPLOYER_ID, S.REG_EMPLOYER_FIO, S.NOTE, S.CABLAB_DEF, S.DEP_DEF, S.CABLAB_DEF_CODE, S.DEP_DEF_CODE, S.CABLAB_DEF_NAME, S.DEP_DEF_NAME, S.DS_HID, S.NSAMPLE_IN_WORK, S.HAS_CHILDRENS, S.S_ORDER, S.DIR_ID, S.VAL_RESULT, S.VAL_RESULT_STR, S.DISEASECASE, S.DS_ID, S.IS_COMMENT, S.IS_MSEK, S.NURSE_USER_TEMPLATES, S.SERVICE DS_SERVICE_ID, S.OUT_DIR_STATUS, EX.FILTER_SERVICE, ROW_NUMBER() OVER(PARTITION BY S.ID ORDER BY S.VISIT_DATE) RN, PCC.ZAKL, PC.PROF_CARD_MODEL, PCT.ID PCT_ID, PCT.PCT_CODE, PCT.ARMS, PCT.GAI, (SELECT COUNT(1) FROM D_V_SERVICES_STR SS WHERE SS.PID = S.SERVICE_ID) SERVICES_STR_COUNT FROM D_V_PROF_CARD_SERVICES_DS S JOIN D_V_PROF_CARD_BASE PC ON PC.ID = S.PID JOIN D_V_PROF_CARD_TYPES_BASE PCT ON PCT.ID = PC.PROF_CARD_TYPE LEFT JOIN (SELECT CASE WHEN ESV.STR_VALUE < 2 THEN 0 ELSE 1 END FILTER_SERVICE, PS.PID, RANK() OVER (PARTITION BY PS.PID ORDER BY ESV.ID DESC) OBR_RANK FROM D_V_EX_SYSTEM_VALUES ESV JOIN D_V_PROF_CARD_DIR_SERVS_BASE PSD ON PSD.DIR_SERV = ESV.UNIT_ID JOIN D_V_PROF_CARD_SERVICES_BASE PS ON PSD.PID = PS.ID WHERE ESV.VAL_CODE IN ('MSE_COMPLETE', 'MSE_PDO') AND ESV.UNIT = 'DIRECTION_SERVICES' AND ESV.PID = TO_NUMBER(:B1 ) ) EX ON EX.PID = S.PID AND EX.OBR_RANK = 1 LEFT JOIN D_V_PROF_CARD_CONCLUSIONS PCC ON PCC.PID = S.PID AND PCC.SERVICE_CODE = S.SERVICE WHERE S.PID = TO_NUMBER(:B2) ) V WHERE V.RN = 1 AND V.IS_NAZNACH = 0 AND V.DS_HID IS NULL AND (V.FILTER_SERVICE IS NULL OR V.FILTER_SERVICE = 0 OR (V.FILTER_SERVICE = 1 AND V.SERVICE <> :B3 ) ) ) WHERE NSERVICE_TYPE LIKE :B4 
 
Plan hash value: 79056167
 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                                        | Name                           | Starts | E-Rows | E-Time   | A-Rows |   A-Time   | Buffers | Reads  |  OMem |  1Mem | Used-Mem |
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                                 |                                |      1 |        |          |      1 |00:10:54.32 |     380K|    318K|       |       |          |
|   1 |  SORT AGGREGATE                                  |                                |      1 |      1 |          |      1 |00:00:00.01 |       0 |      0 |       |       |          |
|   2 |   NESTED LOOPS                                   |                                |      1 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|   3 |    NESTED LOOPS                                  |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|   4 |     NESTED LOOPS                                 |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|   5 |      TABLE ACCESS BY INDEX ROWID                 | D_VISITS                       |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*  6 |       INDEX UNIQUE SCAN                          | PK_D_VISITS                    |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*  7 |      INDEX RANGE SCAN                            | I_D_PROF_CARD_DIR_SERVS_DS_PID |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*  8 |     INDEX UNIQUE SCAN                            | PK_D_PROF_CARD_SERVICES        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*  9 |    TABLE ACCESS BY INDEX ROWID                   | D_PROF_CARD_SERVICES           |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  10 |  TABLE ACCESS BY INDEX ROWID                     | D_SERVTYPES                    |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       2 |      0 |       |       |          |
|* 11 |   INDEX UNIQUE SCAN                              | PK_D_SERVTYPES                 |      1 |      1 |          |      1 |00:00:00.01 |       1 |      0 |       |       |          |
|  12 |  SORT AGGREGATE                                  |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 13 |   HASH JOIN                                      |                                |      0 |      4 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |  1298K|  1298K|          |
|  14 |    NESTED LOOPS                                  |                                |      0 |      4 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  15 |     TABLE ACCESS BY INDEX ROWID                  | D_DIRECTION_SERVICES           |      0 |      4 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 16 |      INDEX RANGE SCAN                            | I_D_DIRECTION_SERVICES_HID     |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 17 |     INDEX RANGE SCAN                             | I_D_LABMED_DIRECTION_LINE_DRST |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  18 |    VIEW                                          | index$_join$_142               |      0 |     10 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 19 |     HASH JOIN                                    |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |  2078K|  2078K|          |
|* 20 |      INDEX FAST FULL SCAN                        | PK_D_LBM_DIRLINE_STATUSES      |      0 |     10 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  21 |      INDEX FAST FULL SCAN                        | UK_D_LBM_DIRLINE_STATUSES      |      0 |     10 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  22 |    SORT AGGREGATE                                |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  23 |     NESTED LOOPS                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  24 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 25 |       INDEX RANGE SCAN                           | I_D_LABMED_DIRECTION_LINE_DRST |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 26 |       INDEX UNIQUE SCAN                          | PK_D_LBM_DIRLINE_STATUSES      |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  27 |      TABLE ACCESS BY INDEX ROWID                 | D_LBM_DIRLINE_STATUSES         |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  28 |       TABLE ACCESS BY INDEX ROWID                | D_CABLAB                       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 29 |        INDEX UNIQUE SCAN                         | PK_D_CABLAB                    |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  30 |        TABLE ACCESS BY INDEX ROWID               | D_CABLAB                       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 31 |         INDEX UNIQUE SCAN                        | PK_D_CABLAB                    |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  32 |         NESTED LOOPS                             |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      3 |       |       |          |
|  33 |          NESTED LOOPS                            |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      3 |       |       |          |
|  34 |           NESTED LOOPS                           |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      3 |       |       |          |
|* 35 |            INDEX RANGE SCAN                      | UK_D_VISIT_FIELDS              |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      3 |       |       |          |
|* 36 |            INDEX RANGE SCAN                      | I_D_VISIT_TAB_FIELDS_IC        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 37 |           INDEX UNIQUE SCAN                      | PK_D_ADD_DIR_VALUES            |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  38 |          TABLE ACCESS BY INDEX ROWID             | D_ADD_DIR_VALUES               |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 39 |           COUNT STOPKEY                          |                                |      1 |        |          |      1 |00:00:00.01 |       8 |      2 |       |       |          |
|  40 |            NESTED LOOPS                          |                                |      1 |        |          |      1 |00:00:00.01 |       8 |      2 |       |       |          |
|  41 |             NESTED LOOPS                         |                                |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       7 |      2 |       |       |          |
|* 42 |              TABLE ACCESS BY INDEX ROWID         | D_VIS_DIAGNOSISES              |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       5 |      2 |       |       |          |
|* 43 |               INDEX RANGE SCAN                   | I_D_VIS_DIAGNOSISES_PM         |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      1 |       |       |          |
|* 44 |              INDEX UNIQUE SCAN                   | PK_D_MKB10                     |      1 |      1 |          |      1 |00:00:00.01 |       2 |      0 |       |       |          |
|  45 |             TABLE ACCESS BY INDEX ROWID          | D_MKB10                        |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       1 |      0 |       |       |          |
|* 46 |            INDEX RANGE SCAN                      | I_D_LABMED_DIRECTION_LINE_DIR_ |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  47 |             TABLE ACCESS BY INDEX ROWID          | D_CABLAB                       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 48 |              INDEX UNIQUE SCAN                   | PK_D_CABLAB                    |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 49 |              COUNT STOPKEY                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  50 |               NESTED LOOPS                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  51 |                NESTED LOOPS                      |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  52 |                 TABLE ACCESS BY INDEX ROWID      | D_PC_SERV_OTHER_RESULTS        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 53 |                  INDEX RANGE SCAN                | I_D_PC_SERV_OTHER_RESULTS_PID  |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 54 |                 INDEX UNIQUE SCAN                | PK_D_AMB_TALON_OTHER_VISITS    |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  55 |                TABLE ACCESS BY INDEX ROWID       | D_AMB_TALON_OTHER_VISITS       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 56 |               FILTER                             |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  57 |                NESTED LOOPS                      |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  58 |                 NESTED LOOPS                     |                                |      0 |      2 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  59 |                  NESTED LOOPS                    |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  60 |                   MERGE JOIN CARTESIAN           |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  61 |                    TABLE ACCESS BY INDEX ROWID   | D_OUT_DIR_SERVS                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 62 |                     INDEX RANGE SCAN             | I_D_OUT_DIR_SERVS_PID          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  63 |                    BUFFER SORT                   |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 | 73728 | 73728 |          |
|  64 |                     TABLE ACCESS BY INDEX ROWID  | D_OUTER_DIRECTIONS             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 65 |                      INDEX RANGE SCAN            | I_D_OUTER_DIRECTIONS_RPD       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  66 |                   TABLE ACCESS BY INDEX ROWID    | D_DIRECTIONS                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 67 |                    INDEX RANGE SCAN              | I_D_DIRECTIONS_OD              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  68 |                  TABLE ACCESS BY INDEX ROWID     | D_DIRECTION_SERVICES           |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 69 |                   INDEX RANGE SCAN               | I_D_DIRECTION_SERVICES_SS      |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 70 |                 INDEX RANGE SCAN                 | I_D_SERVICES_SEC_SET_ID        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 71 |                COUNT STOPKEY                     |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 72 |                 FILTER                           |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 73 |                  INDEX RANGE SCAN                | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  74 |                  NESTED LOOPS                    |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 75 |                   INDEX RANGE SCAN               | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 76 |                   INDEX UNIQUE SCAN              | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  77 |                NESTED LOOPS                      |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  78 |                 TABLE ACCESS BY INDEX ROWID      | D_LPU                          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 79 |                  INDEX UNIQUE SCAN               | PK_D_LPU                       |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  80 |                 TABLE ACCESS BY INDEX ROWID      | D_LPUDICT                      |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 81 |                  INDEX UNIQUE SCAN               | PK_D_LPUDICT                   |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 82 |                  FILTER                          |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  83 |                   NESTED LOOPS                   |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  84 |                    NESTED LOOPS                  |                                |      0 |     31 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  85 |                     NESTED LOOPS                 |                                |      0 |     25 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  86 |                      NESTED LOOPS                |                                |      0 |     25 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  87 |                       TABLE ACCESS BY INDEX ROWID| D_DIRECTIONS                   |      0 |     17 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 88 |                        INDEX RANGE SCAN          | I_D_DIRECTIONS_OD              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  89 |                       TABLE ACCESS BY INDEX ROWID| D_DIRECTION_SERVICES           |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 90 |                        INDEX RANGE SCAN          | I_D_DIRECTION_SERVICES_SS      |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  91 |                      TABLE ACCESS BY INDEX ROWID | D_VISITS                       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 92 |                       INDEX RANGE SCAN           | I_D_VISITS_PARK                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 93 |                     INDEX UNIQUE SCAN            | PK_D_SERVICES                  |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|  94 |                    TABLE ACCESS BY INDEX ROWID   | D_SERVICES                     |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 95 |                   FILTER                         |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 96 |                    TABLE ACCESS BY INDEX ROWID   | D_OUT_DIR_SERVS                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 97 |                     INDEX RANGE SCAN             | I_D_OUT_DIR_SERVS_PID          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 98 |                    COUNT STOPKEY                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|* 99 |                     FILTER                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*100 |                      INDEX RANGE SCAN            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 101 |                      NESTED LOOPS                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*102 |                       INDEX RANGE SCAN           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*103 |                       INDEX UNIQUE SCAN          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 104 |                TABLE ACCESS BY INDEX ROWID       | D_OUTER_DIRECTIONS             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*105 |                 INDEX RANGE SCAN                 | I_D_OUTER_DIRECTIONS_RPD       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 106 |                 NESTED LOOPS OUTER               |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 107 |                  TABLE ACCESS BY INDEX ROWID     | D_DIRECTIONS                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*108 |                   INDEX UNIQUE SCAN              | PK_D_DIRECTIONS                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 109 |                  TABLE ACCESS BY INDEX ROWID     | D_LPUDICT                      |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*110 |                   INDEX UNIQUE SCAN              | PK_D_LPUDICT                   |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*111 |                   COUNT STOPKEY                  |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 112 |                    NESTED LOOPS                  |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 113 |                     NESTED LOOPS                 |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 114 |                      TABLE ACCESS BY INDEX ROWID | D_PC_SERV_OTHER_RESULTS        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*115 |                       INDEX RANGE SCAN           | I_D_PC_SERV_OTHER_RESULTS_PID  |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*116 |                      INDEX UNIQUE SCAN           | PK_D_AMB_TALON_OTHER_VISITS    |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 117 |                     TABLE ACCESS BY INDEX ROWID  | D_AMB_TALON_OTHER_VISITS       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*118 |  FILTER                                          |                                |      1 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 119 |   NESTED LOOPS                                   |                                |      1 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 120 |    NESTED LOOPS                                  |                                |      1 |      3 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 121 |     NESTED LOOPS                                 |                                |      1 |      2 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 122 |      NESTED LOOPS                                |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 123 |       TABLE ACCESS BY INDEX ROWID                | D_OUTER_DIRECTIONS             |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*124 |        INDEX RANGE SCAN                          | I_D_OUTER_DIRECTIONS_RPD       |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 125 |       TABLE ACCESS BY INDEX ROWID                | D_DIRECTIONS                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*126 |        INDEX RANGE SCAN                          | I_D_DIRECTIONS_OD              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 127 |      TABLE ACCESS BY INDEX ROWID                 | D_DIRECTION_SERVICES           |      0 |      2 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*128 |       INDEX RANGE SCAN                           | I_D_DIRECTION_SERVICES_ISP     |      0 |      2 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*129 |     INDEX UNIQUE SCAN                            | PK_D_SERVICES                  |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 130 |    TABLE ACCESS BY INDEX ROWID                   | D_SERVICES                     |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*131 |   FILTER                                         |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*132 |    TABLE ACCESS BY INDEX ROWID                   | D_OUT_DIR_SERVS                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*133 |     INDEX RANGE SCAN                             | I_D_OUT_DIR_SERVS_PID          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*134 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*135 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*136 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 137 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*138 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*139 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 140 |  SORT AGGREGATE                                  |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 141 |   NESTED LOOPS                                   |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 142 |    NESTED LOOPS                                  |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 143 |     TABLE ACCESS BY INDEX ROWID                  | D_LABMED_PATJOUR               |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*144 |      INDEX RANGE SCAN                            | I_D_LABMED_PATJOUR_DS          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*145 |     INDEX RANGE SCAN                             | I_D_LABMED_RSRCH_JOUR_PTJ      |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 146 |    TABLE ACCESS BY INDEX ROWID                   | D_LABMED_RSRCH_JOUR            |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 147 |  SORT AGGREGATE                                  |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*148 |   FILTER                                         |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 149 |    NESTED LOOPS OUTER                            |                                |      0 |      5 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 150 |     NESTED LOOPS                                 |                                |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 151 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 152 |       TABLE ACCESS BY INDEX ROWID                | D_LABMED_PATJOUR               |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*153 |        INDEX RANGE SCAN                          | I_D_LABMED_PATJOUR_DS          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 154 |       TABLE ACCESS BY INDEX ROWID                | D_LABMED_RSRCH_JOUR            |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*155 |        INDEX RANGE SCAN                          | I_D_LABMED_RSRCH_JOUR_PTJ      |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*156 |      TABLE ACCESS BY INDEX ROWID                 | D_LABMED_RSRCH_JOURSP          |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*157 |       INDEX RANGE SCAN                           | I_D_LABMED_RSRCH_JOURSP_PID    |      0 |      9 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 158 |     TABLE ACCESS BY INDEX ROWID                  | D_LABMED_DIRECTION_LINE        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*159 |      INDEX UNIQUE SCAN                           | PK_D_LABMED_DIRECTION_LINE     |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*160 |    COUNT STOPKEY                                 |                                |      1 |        |          |      0 |00:00:00.01 |       3 |      0 |       |       |          |
| 161 |     NESTED LOOPS OUTER                           |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      0 |       |       |          |
| 162 |      NESTED LOOPS SEMI                           |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      0 |       |       |          |
|*163 |       TABLE ACCESS BY INDEX ROWID                | D_PROF_CARD_CONCLUSIONS        |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      0 |       |       |          |
|*164 |        INDEX RANGE SCAN                          | I_D_PROF_CARD_CONCLUSIONS_VIS  |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      0 |       |       |          |
| 165 |       VIEW PUSHED PREDICATE                      | VW_SQ_2                        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*166 |        FILTER                                    |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*167 |         INDEX RANGE SCAN                         | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 168 |         NESTED LOOPS                             |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*169 |          INDEX RANGE SCAN                        | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*170 |          INDEX UNIQUE SCAN                       | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 171 |      VIEW PUSHED PREDICATE                       | D_V_PC_CONCLUSIONS             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*172 |       FILTER                                     |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 173 |        TABLE ACCESS BY INDEX ROWID               | D_PC_CONCLUSIONS               |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*174 |         INDEX UNIQUE SCAN                        | PK_D_PC_CONCLUSIONS            |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*175 |        COUNT STOPKEY                             |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*176 |         FILTER                                   |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*177 |          INDEX RANGE SCAN                        | UK_D_URPRIVS                   |      0 |     20 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 178 |          NESTED LOOPS                            |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*179 |           INDEX RANGE SCAN                       | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*180 |           INDEX UNIQUE SCAN                      | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*181 |     FILTER                                       |                                |      1 |        |          |      0 |00:00:00.01 |       2 |      1 |       |       |          |
| 182 |      NESTED LOOPS OUTER                          |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       2 |      1 |       |       |          |
| 183 |       TABLE ACCESS BY INDEX ROWID                | D_PC_SERV_OTHER_RESULTS        |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       2 |      1 |       |       |          |
|*184 |        INDEX RANGE SCAN                          | I_D_PC_SERV_OTHER_RESULTS_PID  |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       2 |      1 |       |       |          |
| 185 |       VIEW PUSHED PREDICATE                      | D_V_PC_CONCLUSIONS             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*186 |        FILTER                                    |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 187 |         TABLE ACCESS BY INDEX ROWID              | D_PC_CONCLUSIONS               |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*188 |          INDEX UNIQUE SCAN                       | PK_D_PC_CONCLUSIONS            |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*189 |         COUNT STOPKEY                            |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*190 |          FILTER                                  |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*191 |           INDEX RANGE SCAN                       | UK_D_URPRIVS                   |      0 |     20 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 192 |           NESTED LOOPS                           |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*193 |            INDEX RANGE SCAN                      | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*194 |            INDEX UNIQUE SCAN                     | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*195 |      COUNT STOPKEY                               |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*196 |       FILTER                                     |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*197 |        INDEX RANGE SCAN                          | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 198 |        NESTED LOOPS                              |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*199 |         INDEX RANGE SCAN                         | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*200 |         INDEX UNIQUE SCAN                        | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 201 |  SORT GROUP BY                                   |                                |      1 |      1 |          |      1 |00:00:00.01 |       9 |      1 |  1024 |  1024 |          |
| 202 |   NESTED LOOPS                                   |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       9 |      1 |       |       |          |
| 203 |    NESTED LOOPS OUTER                            |                                |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       6 |      0 |       |       |          |
| 204 |     TABLE ACCESS BY INDEX ROWID                  | D_PROF_CARD                    |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      0 |       |       |          |
|*205 |      INDEX UNIQUE SCAN                           | PK_D_PROF_CARD                 |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       3 |      0 |       |       |          |
| 206 |     TABLE ACCESS BY INDEX ROWID                  | D_PROF_CARD_TYPES              |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       2 |      0 |       |       |          |
|*207 |      INDEX UNIQUE SCAN                           | PK_D_PROF_CARD_TYPES           |      1 |      1 |          |      1 |00:00:00.01 |       1 |      0 |       |       |          |
|*208 |    TABLE ACCESS BY INDEX ROWID                   | D_PROF_CARD_CONCLUSIONS        |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      1 |       |       |          |
|*209 |     INDEX RANGE SCAN                             | I_D_PROF_CARD_CONCLUSIONS_VIS  |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      1 |       |       |          |
|*210 |  COUNT STOPKEY                                   |                                |      1 |        |          |      1 |00:00:00.01 |       8 |      0 |       |       |          |
| 211 |   NESTED LOOPS                                   |                                |      1 |        |          |      1 |00:00:00.01 |       8 |      0 |       |       |          |
| 212 |    NESTED LOOPS                                  |                                |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       7 |      0 |       |       |          |
|*213 |     TABLE ACCESS BY INDEX ROWID                  | D_VIS_DIAGNOSISES              |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       5 |      0 |       |       |          |
|*214 |      INDEX RANGE SCAN                            | I_D_VIS_DIAGNOSISES_PM         |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      0 |       |       |          |
|*215 |     INDEX UNIQUE SCAN                            | PK_D_MKB10                     |      1 |      1 |          |      1 |00:00:00.01 |       2 |      0 |       |       |          |
| 216 |    TABLE ACCESS BY INDEX ROWID                   | D_MKB10                        |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       1 |      0 |       |       |          |
| 217 |  SORT AGGREGATE                                  |                                |      1 |      1 |          |      1 |00:00:00.01 |       4 |      2 |       |       |          |
|*218 |   FILTER                                         |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      2 |       |       |          |
| 219 |    NESTED LOOPS                                  |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      2 |       |       |          |
| 220 |     NESTED LOOPS                                 |                                |      1 |      2 | 00:00:01 |      0 |00:00:00.01 |       4 |      2 |       |       |          |
| 221 |      TABLE ACCESS BY INDEX ROWID                 | D_EHRS                         |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      2 |       |       |          |
|*222 |       INDEX RANGE SCAN                           | I_D_EHRS_UID                   |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      2 |       |       |          |
|*223 |      INDEX RANGE SCAN                            | I_D_EHR_STATES_PID             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*224 |     TABLE ACCESS BY INDEX ROWID                  | D_EHR_STATES                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*225 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*226 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*227 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 228 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*229 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*230 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*231 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*232 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*233 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 234 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*235 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*236 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 237 |  SORT AGGREGATE                                  |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*238 |   FILTER                                         |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 239 |    NESTED LOOPS OUTER                            |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*240 |     TABLE ACCESS BY INDEX ROWID                  | INT_HL7V3_MSGS                 |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*241 |      INDEX RANGE SCAN                            | INT_HL7V3_MSGS_ITEM            |      0 |      2 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 242 |     TABLE ACCESS BY INDEX ROWID                  | INT_HL7V3_MSGS                 |      0 |     39M| 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*243 |      INDEX RANGE SCAN                            | I_INT_HL7V3_MSGS_HID           |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 244 |  SORT AGGREGATE                                  |                                |      1 |      1 |          |      1 |00:00:00.01 |       4 |      0 |       |       |          |
|*245 |   FILTER                                         |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      0 |       |       |          |
| 246 |    NESTED LOOPS                                  |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      0 |       |       |          |
| 247 |     NESTED LOOPS                                 |                                |      1 |      2 | 00:00:01 |      0 |00:00:00.01 |       4 |      0 |       |       |          |
| 248 |      TABLE ACCESS BY INDEX ROWID                 | D_EHRS                         |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      0 |       |       |          |
|*249 |       INDEX RANGE SCAN                           | I_D_EHRS_UID                   |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      0 |       |       |          |
|*250 |      INDEX RANGE SCAN                            | I_D_EHR_STATES_PID             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*251 |     TABLE ACCESS BY INDEX ROWID                  | D_EHR_STATES                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*252 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*253 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*254 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 255 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*256 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*257 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*258 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*259 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*260 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 261 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*262 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*263 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 264 |  SORT AGGREGATE                                  |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*265 |   FILTER                                         |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 266 |    NESTED LOOPS OUTER                            |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*267 |     TABLE ACCESS BY INDEX ROWID                  | INT_HL7V3_MSGS                 |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*268 |      INDEX RANGE SCAN                            | INT_HL7V3_MSGS_ITEM            |      0 |      2 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 269 |     TABLE ACCESS BY INDEX ROWID                  | INT_HL7V3_MSGS                 |      0 |     39M| 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*270 |      INDEX RANGE SCAN                            | I_INT_HL7V3_MSGS_HID           |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 271 |  SORT AGGREGATE                                  |                                |      1 |      1 |          |      1 |00:00:00.01 |       4 |      2 |       |       |          |
|*272 |   FILTER                                         |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      2 |       |       |          |
| 273 |    NESTED LOOPS                                  |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      2 |       |       |          |
| 274 |     NESTED LOOPS                                 |                                |      1 |      2 | 00:00:01 |      0 |00:00:00.01 |       4 |      2 |       |       |          |
| 275 |      TABLE ACCESS BY INDEX ROWID                 | D_EHRS                         |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      2 |       |       |          |
|*276 |       INDEX RANGE SCAN                           | I_D_EHRS_UID                   |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      2 |       |       |          |
|*277 |      INDEX RANGE SCAN                            | I_D_EHR_STATES_PID             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*278 |     TABLE ACCESS BY INDEX ROWID                  | D_EHR_STATES                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*279 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*280 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*281 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 282 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*283 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*284 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*285 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*286 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*287 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 288 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*289 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*290 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 291 |  SORT AGGREGATE                                  |                                |      1 |      1 |          |      1 |00:00:00.01 |       4 |      0 |       |       |          |
|*292 |   FILTER                                         |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      0 |       |       |          |
| 293 |    NESTED LOOPS                                  |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      0 |       |       |          |
| 294 |     NESTED LOOPS                                 |                                |      1 |      2 | 00:00:01 |      0 |00:00:00.01 |       4 |      0 |       |       |          |
| 295 |      TABLE ACCESS BY INDEX ROWID                 | D_EHRS                         |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      0 |       |       |          |
|*296 |       INDEX RANGE SCAN                           | I_D_EHRS_UID                   |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      0 |       |       |          |
|*297 |      INDEX RANGE SCAN                            | I_D_EHR_STATES_PID             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*298 |     TABLE ACCESS BY INDEX ROWID                  | D_EHR_STATES                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 299 |    FAST DUAL                                     |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*300 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*301 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*302 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 303 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*304 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*305 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*306 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*307 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*308 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 309 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*310 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*311 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 312 |  SORT AGGREGATE                                  |                                |      1 |      1 |          |      1 |00:00:00.01 |       4 |      0 |       |       |          |
|*313 |   FILTER                                         |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      0 |       |       |          |
| 314 |    NESTED LOOPS                                  |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      0 |       |       |          |
| 315 |     NESTED LOOPS                                 |                                |      1 |      2 | 00:00:01 |      0 |00:00:00.01 |       4 |      0 |       |       |          |
| 316 |      TABLE ACCESS BY INDEX ROWID                 | D_EHRS                         |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      0 |       |       |          |
|*317 |       INDEX RANGE SCAN                           | I_D_EHRS_UID                   |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      0 |       |       |          |
|*318 |      INDEX RANGE SCAN                            | I_D_EHR_STATES_PID             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*319 |     TABLE ACCESS BY INDEX ROWID                  | D_EHR_STATES                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 320 |    FAST DUAL                                     |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*321 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*322 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*323 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 324 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*325 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*326 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*327 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*328 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*329 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 330 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*331 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*332 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 333 |  SORT AGGREGATE                                  |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*334 |   FILTER                                         |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 335 |    NESTED LOOPS                                  |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 336 |     NESTED LOOPS                                 |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 337 |      TABLE ACCESS BY INDEX ROWID                 | D_PC_SERV_OTHER_RESULTS        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*338 |       INDEX RANGE SCAN                           | I_D_PC_SERV_OTHER_RESULTS_PID  |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 339 |      TABLE ACCESS BY INDEX ROWID                 | D_AMB_TALON_OTHER_VISITS       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*340 |       INDEX UNIQUE SCAN                          | PK_D_AMB_TALON_OTHER_VISITS    |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*341 |     INDEX RANGE SCAN                             | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*342 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*343 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*344 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 345 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*346 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*347 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 348 |    NESTED LOOPS                                  |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*349 |     INDEX RANGE SCAN                             | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*350 |     INDEX UNIQUE SCAN                            | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 351 |  SORT AGGREGATE                                  |                                |      1 |      1 |          |      1 |00:00:00.01 |       2 |      0 |       |       |          |
| 352 |   NESTED LOOPS SEMI                              |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       2 |      0 |       |       |          |
| 353 |    TABLE ACCESS BY INDEX ROWID                   | D_SERVICES_STR                 |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       2 |      0 |       |       |          |
|*354 |     INDEX RANGE SCAN                             | UK_D_SERVICES_STR              |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       2 |      0 |       |       |          |
| 355 |    VIEW PUSHED PREDICATE                         | VW_SQ_1                        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*356 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*357 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST1             |      0 |      4 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 358 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*359 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*360 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*361 |  COUNT STOPKEY                                   |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 362 |   NESTED LOOPS                                   |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 363 |    NESTED LOOPS                                  |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*364 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 365 |      NESTED LOOPS OUTER                          |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 366 |       NESTED LOOPS                               |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 367 |        NESTED LOOPS                              |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 368 |         NESTED LOOPS                             |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 369 |          TABLE ACCESS BY INDEX ROWID             | D_LABMED_PATJOUR               |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*370 |           INDEX RANGE SCAN                       | I_D_LABMED_PATJOUR_DS          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 371 |          TABLE ACCESS BY INDEX ROWID             | D_LABMED_RSRCH_JOUR            |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*372 |           INDEX RANGE SCAN                       | I_D_LABMED_RSRCH_JOUR_PTJ      |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*373 |         TABLE ACCESS BY INDEX ROWID              | D_LABMED_RSRCH_JOURSP          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*374 |          INDEX RANGE SCAN                        | I_D_LABMED_RSRCH_JOURSP_PID    |      0 |      9 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*375 |        TABLE ACCESS BY INDEX ROWID               | D_LABMED_RESEARCH_RES          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*376 |         INDEX UNIQUE SCAN                        | PK_D_LABMED_RESEARCH_RES       |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 377 |       TABLE ACCESS BY INDEX ROWID                | D_LABMED_DIRECTION_LINE        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*378 |        INDEX UNIQUE SCAN                         | PK_D_LABMED_DIRECTION_LINE     |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*379 |     INDEX UNIQUE SCAN                            | PK_D_MEASURES                  |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 380 |    TABLE ACCESS BY INDEX ROWID                   | D_MEASURES                     |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*381 |  COUNT STOPKEY                                   |                                |      1 |        |          |      1 |00:00:00.01 |       6 |      0 |       |       |          |
| 382 |   NESTED LOOPS                                   |                                |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       6 |      0 |       |       |          |
| 383 |    TABLE ACCESS BY INDEX ROWID                   | D_PROF_CARD                    |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      0 |       |       |          |
|*384 |     INDEX UNIQUE SCAN                            | PK_D_PROF_CARD                 |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       3 |      0 |       |       |          |
| 385 |    TABLE ACCESS BY INDEX ROWID                   | D_PROF_CARD_TYPES              |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       2 |      0 |       |       |          |
|*386 |     INDEX UNIQUE SCAN                            | PK_D_PROF_CARD_TYPES           |      1 |      1 |          |      1 |00:00:00.01 |       1 |      0 |       |       |          |
| 387 |  SORT AGGREGATE                                  |                                |      1 |      1 |          |      1 |00:00:00.01 |       4 |      1 |       |       |          |
| 388 |   NESTED LOOPS                                   |                                |      1 |        |          |      0 |00:00:00.01 |       4 |      1 |       |       |          |
| 389 |    NESTED LOOPS                                  |                                |      1 |      3 | 00:00:01 |      0 |00:00:00.01 |       4 |      1 |       |       |          |
| 390 |     NESTED LOOPS                                 |                                |      1 |      4 | 00:00:01 |      0 |00:00:00.01 |       4 |      1 |       |       |          |
| 391 |      NESTED LOOPS                                |                                |      1 |      4 | 00:00:01 |      0 |00:00:00.01 |       4 |      1 |       |       |          |
| 392 |       TABLE ACCESS BY INDEX ROWID                | D_DIRECTION_SERVICES           |      1 |      4 | 00:00:01 |      0 |00:00:00.01 |       4 |      1 |       |       |          |
|*393 |        INDEX RANGE SCAN                          | I_D_DIRECTION_SERVICES_HID     |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       4 |      1 |       |       |          |
| 394 |       TABLE ACCESS BY INDEX ROWID                | D_LABMED_DIRECTION_LINE        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*395 |        INDEX RANGE SCAN                          | I_D_LABMED_DIRECTION_LINE_DRST |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 396 |      TABLE ACCESS BY INDEX ROWID                 | D_LBM_SAMPLE_DIRLINE           |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*397 |       INDEX RANGE SCAN                           | I_D_LBM_SAMPLE_DIRLINE_DIRLINE |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*398 |     INDEX UNIQUE SCAN                            | PK_D_LABMED_SAMPLES            |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*399 |    TABLE ACCESS BY INDEX ROWID                   | D_LABMED_SAMPLES               |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*400 |  FILTER                                          |                                |      1 |        |          |      0 |00:00:00.02 |       4 |      2 |       |       |          |
| 401 |   NESTED LOOPS OUTER                             |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.02 |       4 |      2 |       |       |          |
| 402 |    NESTED LOOPS                                  |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.02 |       4 |      2 |       |       |          |
|*403 |     TABLE ACCESS BY INDEX ROWID                  | D_PROF_CARD_SERVICES           |      1 |      1 | 00:00:01 |      0 |00:00:00.02 |       4 |      2 |       |       |          |
|*404 |      INDEX UNIQUE SCAN                           | PK_D_PROF_CARD_SERVICES        |      1 |      1 | 00:00:01 |      1 |00:00:00.02 |       3 |      1 |       |       |          |
| 405 |     TABLE ACCESS BY INDEX ROWID                  | D_PC_SERV_OTHER_RESULTS        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*406 |      INDEX RANGE SCAN                            | I_D_PC_SERV_OTHER_RESULTS_PID  |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 407 |    VIEW PUSHED PREDICATE                         | D_V_PC_CONCLUSIONS             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*408 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 409 |      TABLE ACCESS BY INDEX ROWID                 | D_PC_CONCLUSIONS               |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*410 |       INDEX UNIQUE SCAN                          | PK_D_PC_CONCLUSIONS            |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*411 |      COUNT STOPKEY                               |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*412 |       FILTER                                     |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*413 |        INDEX RANGE SCAN                          | UK_D_URPRIVS                   |      0 |     20 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 414 |        NESTED LOOPS                              |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*415 |         INDEX RANGE SCAN                         | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*416 |         INDEX UNIQUE SCAN                        | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*417 |   COUNT STOPKEY                                  |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*418 |    FILTER                                        |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*419 |     INDEX RANGE SCAN                             | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 420 |     NESTED LOOPS                                 |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*421 |      INDEX RANGE SCAN                            | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*422 |      INDEX UNIQUE SCAN                           | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*423 |   COUNT STOPKEY                                  |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*424 |    FILTER                                        |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*425 |     INDEX RANGE SCAN                             | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 426 |     NESTED LOOPS                                 |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*427 |      INDEX RANGE SCAN                            | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*428 |      INDEX UNIQUE SCAN                           | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*429 |   FILTER                                         |                                |      1 |        |          |      0 |00:00:00.01 |       2 |      0 |       |       |          |
| 430 |    TABLE ACCESS BY INDEX ROWID                   | D_PC_SERV_OTHER_RESULTS        |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       2 |      0 |       |       |          |
|*431 |     INDEX RANGE SCAN                             | I_D_PC_SERV_OTHER_RESULTS_PID  |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       2 |      0 |       |       |          |
|*432 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*433 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*434 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 435 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*436 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*437 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 438 |  SORT AGGREGATE                                  |                                |      1 |      1 |          |      1 |00:00:00.01 |       3 |      0 |       |       |          |
| 439 |   NESTED LOOPS SEMI                              |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      0 |       |       |          |
|*440 |    TABLE ACCESS BY INDEX ROWID                   | D_MEDICAL_COMMISSIONS          |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      0 |       |       |          |
|*441 |     INDEX RANGE SCAN                             | I_D_MEDICAL_COMMISSIONS_PS     |      1 |      2 | 00:00:01 |      2 |00:00:00.01 |       1 |      0 |       |       |          |
| 442 |    VIEW PUSHED PREDICATE                         | VW_SQ_3                        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*443 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*444 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 445 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*446 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*447 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 448 |  SORT AGGREGATE                                  |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*449 |   FILTER                                         |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*450 |    FILTER                                        |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 451 |     NESTED LOOPS                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 452 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 453 |       NESTED LOOPS                               |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*454 |        INDEX RANGE SCAN                          | I_D_SERVICES_SEC_SET_ID        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 455 |        TABLE ACCESS BY INDEX ROWID               | D_DISPS_SERVICES               |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*456 |         INDEX RANGE SCAN                         | I_D_DISPS_SERVICES_SERVICE     |      0 |      2 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*457 |       INDEX UNIQUE SCAN                          | PK_D_DISP_SERVICES             |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*458 |      TABLE ACCESS BY INDEX ROWID                 | D_DISP_SERVICES                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 459 |     FAST DUAL                                    |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*460 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*461 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*462 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST3             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 463 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*464 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*465 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*466 |  COUNT STOPKEY                                   |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 467 |   NESTED LOOPS SEMI                              |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 468 |    TABLE ACCESS BY INDEX ROWID                   | D_PROF_CARD_MODELS_SR          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 469 |     BITMAP CONVERSION TO ROWIDS                  |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 470 |      BITMAP AND                                  |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 471 |       BITMAP CONVERSION FROM ROWIDS              |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*472 |        INDEX RANGE SCAN                          | I_D_PROF_CARD_MODELS_SR_PID    |      0 |     15 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 473 |       BITMAP CONVERSION FROM ROWIDS              |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*474 |        INDEX RANGE SCAN                          | I_D_PROF_CARD_MODELS_SR_SV     |      0 |     15 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 475 |    VIEW PUSHED PREDICATE                         | VW_SQ_4                        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*476 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*477 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 478 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*479 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*480 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 481 |  SORT AGGREGATE                                  |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*482 |   FILTER                                         |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*483 |    TABLE ACCESS BY INDEX ROWID                   | D_PROF_CARD                    |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*484 |     INDEX UNIQUE SCAN                            | PK_D_PROF_CARD                 |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*485 |    COUNT STOPKEY                                 |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*486 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*487 |      INDEX RANGE SCAN                            | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 488 |      NESTED LOOPS                                |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*489 |       INDEX RANGE SCAN                           | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*490 |       INDEX UNIQUE SCAN                          | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 491 |    SORT AGGREGATE                                |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*492 |     FILTER                                       |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*493 |      TABLE ACCESS BY INDEX ROWID                 | D_DISEASECASES                 |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*494 |       INDEX UNIQUE SCAN                          | PK_D_DISEASECASES              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*495 |      COUNT STOPKEY                               |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*496 |       FILTER                                     |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*497 |        INDEX RANGE SCAN                          | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 498 |        NESTED LOOPS                              |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*499 |         INDEX RANGE SCAN                         | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*500 |         INDEX UNIQUE SCAN                        | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 501 |      SORT AGGREGATE                              |                                |      0 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*502 |       COUNT STOPKEY                              |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*503 |        FILTER                                    |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 504 |         NESTED LOOPS                             |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 505 |          NESTED LOOPS                            |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 506 |           NESTED LOOPS                           |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 507 |            TABLE ACCESS BY INDEX ROWID           | D_DIRECTION_SERVICES           |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*508 |             INDEX UNIQUE SCAN                    | PK_D_DIRECTION_SERVICES        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*509 |            TABLE ACCESS BY INDEX ROWID           | D_VISITS                       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 510 |             BITMAP CONVERSION TO ROWIDS          |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 511 |              BITMAP OR                           |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 512 |               BITMAP CONVERSION FROM ROWIDS      |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*513 |                INDEX RANGE SCAN                  | I_D_VISITS_PARK                |      0 |    178M| 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 514 |               BITMAP CONVERSION FROM ROWIDS      |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*515 |                INDEX RANGE SCAN                  | I_D_VISITS_PARK                |      0 |    178M| 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 516 |           TABLE ACCESS BY INDEX ROWID            | D_AMB_TALON_VISITS             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*517 |            INDEX RANGE SCAN                      | I_D_AMB_TALON_VISITS_V         |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*518 |          INDEX RANGE SCAN                        | I_D_AMB_TALONS_ID_CID          |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*519 |           COUNT STOPKEY                          |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*520 |            FILTER                                |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*521 |             INDEX RANGE SCAN                     | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 522 |             NESTED LOOPS                         |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*523 |              INDEX RANGE SCAN                    | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*524 |              INDEX UNIQUE SCAN                   | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*525 |         COUNT STOPKEY                            |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*526 |          FILTER                                  |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*527 |           INDEX RANGE SCAN                       | IX_D_URPRIVS_TEST2             |      0 |     48 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 528 |           NESTED LOOPS                           |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*529 |            INDEX RANGE SCAN                      | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*530 |            INDEX UNIQUE SCAN                     | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*531 |         COUNT STOPKEY                            |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*532 |          FILTER                                  |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*533 |           INDEX RANGE SCAN                       | IX_D_URPRIVS_TEST2             |      0 |      7 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 534 |           NESTED LOOPS                           |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*535 |            INDEX RANGE SCAN                      | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*536 |            INDEX UNIQUE SCAN                     | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*537 |         COUNT STOPKEY                            |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*538 |          FILTER                                  |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*539 |           INDEX RANGE SCAN                       | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 540 |           NESTED LOOPS                           |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*541 |            INDEX RANGE SCAN                      | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*542 |            INDEX UNIQUE SCAN                     | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*543 |  VIEW                                            |                                |      1 |      1 | 00:00:01 |      1 |00:10:54.32 |     380K|    318K|       |       |          |
|*544 |   WINDOW SORT PUSHED RANK                        |                                |      1 |      1 | 00:00:01 |      1 |00:10:54.32 |     380K|    318K|  2048 |  2048 | 2048  (0)|
| 545 |    NESTED LOOPS OUTER                            |                                |      1 |      1 | 00:00:01 |      1 |00:10:54.32 |     380K|    318K|       |       |          |
| 546 |     VIEW                                         |                                |      1 |      1 | 00:00:01 |      1 |00:10:54.32 |     380K|    318K|       |       |          |
|*547 |      FILTER                                      |                                |      1 |        |          |      1 |00:10:54.29 |     380K|    318K|       |       |          |
|*548 |       HASH JOIN OUTER                            |                                |      1 |     10 | 00:00:01 |      1 |00:10:54.29 |     380K|    318K|   751K|   751K|  468K (0)|
| 549 |        NESTED LOOPS OUTER                        |                                |      1 |     10 | 00:00:01 |      1 |00:00:00.02 |      33 |      7 |       |       |          |
| 550 |         NESTED LOOPS OUTER                       |                                |      1 |     10 | 00:00:01 |      1 |00:00:00.02 |      33 |      7 |       |       |          |
| 551 |          NESTED LOOPS OUTER                      |                                |      1 |     10 | 00:00:01 |      1 |00:00:00.01 |      28 |      5 |       |       |          |
| 552 |           NESTED LOOPS OUTER                     |                                |      1 |     10 | 00:00:01 |      1 |00:00:00.01 |      23 |      3 |       |       |          |
| 553 |            NESTED LOOPS OUTER                    |                                |      1 |     10 | 00:00:01 |      1 |00:00:00.01 |      23 |      3 |       |       |          |
| 554 |             NESTED LOOPS OUTER                   |                                |      1 |     10 | 00:00:01 |      1 |00:00:00.01 |      18 |      3 |       |       |          |
| 555 |              NESTED LOOPS                        |                                |      1 |     10 | 00:00:01 |      1 |00:00:00.01 |      14 |      1 |       |       |          |
| 556 |               NESTED LOOPS                       |                                |      1 |     10 | 00:00:01 |      1 |00:00:00.01 |      11 |      1 |       |       |          |
| 557 |                NESTED LOOPS                      |                                |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       6 |      0 |       |       |          |
| 558 |                 TABLE ACCESS BY INDEX ROWID      | D_PROF_CARD                    |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      0 |       |       |          |
|*559 |                  INDEX UNIQUE SCAN               | PK_D_PROF_CARD                 |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       3 |      0 |       |       |          |
| 560 |                 TABLE ACCESS BY INDEX ROWID      | D_PROF_CARD_TYPES              |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       2 |      0 |       |       |          |
|*561 |                  INDEX UNIQUE SCAN               | PK_D_PROF_CARD_TYPES           |      1 |      1 |          |      1 |00:00:00.01 |       1 |      0 |       |       |          |
| 562 |                TABLE ACCESS BY INDEX ROWID       | D_PROF_CARD_SERVICES           |      1 |     10 | 00:00:01 |      1 |00:00:00.01 |       5 |      1 |       |       |          |
|*563 |                 INDEX RANGE SCAN                 | I_D_PROF_CARD_SERVICES_PID     |      1 |     10 | 00:00:01 |      1 |00:00:00.01 |       4 |      1 |       |       |          |
| 564 |               TABLE ACCESS BY INDEX ROWID        | D_SERVICES                     |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       3 |      0 |       |       |          |
|*565 |                INDEX UNIQUE SCAN                 | PK_D_SERVICES                  |      1 |      1 |          |      1 |00:00:00.01 |       2 |      0 |       |       |          |
| 566 |              TABLE ACCESS BY INDEX ROWID         | D_PROF_CARD_DIR_SERVS          |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      2 |       |       |          |
|*567 |               INDEX RANGE SCAN                   | I_D_PROF_CARD_DIR_SERVS_PID    |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       3 |      1 |       |       |          |
| 568 |             TABLE ACCESS BY INDEX ROWID          | D_DIRECTION_SERVICES           |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       5 |      0 |       |       |          |
|*569 |              INDEX UNIQUE SCAN                   | PK_D_DIRECTION_SERVICES        |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      0 |       |       |          |
| 570 |            TABLE ACCESS BY INDEX ROWID           | D_EMPLOYERS                    |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*571 |             INDEX UNIQUE SCAN                    | PK_D_EMPLOYERS                 |      1 |      1 |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 572 |           TABLE ACCESS BY INDEX ROWID            | D_VISITS                       |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       5 |      2 |       |       |          |
|*573 |            INDEX RANGE SCAN                      | I_D_VISITS_PARK                |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      1 |       |       |          |
| 574 |          TABLE ACCESS BY INDEX ROWID             | D_DIRECTIONS                   |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       5 |      2 |       |       |          |
|*575 |           INDEX UNIQUE SCAN                      | PK_D_DIRECTIONS                |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      1 |       |       |          |
| 576 |         TABLE ACCESS BY INDEX ROWID              | D_AGENTS                       |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*577 |          INDEX UNIQUE SCAN                       | PK_D_AGENTS                    |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*578 |        VIEW                                      |                                |      1 |      1 | 00:00:01 |      0 |00:10:54.26 |     380K|    318K|       |       |          |
|*579 |         WINDOW SORT PUSHED RANK                  |                                |      1 |      1 | 00:00:01 |      0 |00:10:54.26 |     380K|    318K|  1024 |  1024 |          |
|*580 |          FILTER                                  |                                |      1 |        |          |      0 |00:10:54.26 |     380K|    318K|       |       |          |
| 581 |           NESTED LOOPS                           |                                |      1 |        |          |      0 |00:10:54.26 |     380K|    318K|       |       |          |
| 582 |            NESTED LOOPS                          |                                |      1 |      1 | 00:00:01 |   9487 |00:10:54.23 |     371K|    318K|       |       |          |
| 583 |             NESTED LOOPS                         |                                |      1 |      1 | 00:00:01 |   9487 |00:10:54.18 |     352K|    318K|       |       |          |
|*584 |              TABLE ACCESS BY INDEX ROWID         | D_EX_SYSTEM_VALUES             |      1 |      1 | 00:00:01 |   9487 |00:10:24.54 |     324K|    304K|       |       |          |
|*585 |               INDEX RANGE SCAN                   | I_D_EX_SYSTEM_VALUES_UNITN     |      1 |      1 | 00:00:01 |   9487 |00:10:24.52 |     315K|    304K|       |       |          |
| 586 |              TABLE ACCESS BY INDEX ROWID         | D_PROF_CARD_DIR_SERVS          |   9487 |      1 | 00:00:01 |   9487 |00:00:29.63 |   28191 |  14207 |       |       |          |
|*587 |               INDEX RANGE SCAN                   | I_D_PROF_CARD_DIR_SERVS_DIR_SE |   9487 |      1 | 00:00:01 |   9487 |00:00:13.42 |   18966 |   6555 |       |       |          |
|*588 |             INDEX UNIQUE SCAN                    | PK_D_PROF_CARD_SERVICES        |   9487 |      1 | 00:00:01 |   9487 |00:00:00.05 |   18812 |      0 |       |       |          |
|*589 |            TABLE ACCESS BY INDEX ROWID           | D_PROF_CARD_SERVICES           |   9487 |      1 | 00:00:01 |      0 |00:00:00.03 |    9487 |      0 |       |       |          |
|*590 |           COUNT STOPKEY                          |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*591 |            FILTER                                |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*592 |             INDEX RANGE SCAN                     | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 593 |             NESTED LOOPS                         |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*594 |              INDEX RANGE SCAN                    | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*595 |              INDEX UNIQUE SCAN                   | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*596 |           COUNT STOPKEY                          |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*597 |            FILTER                                |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*598 |             INDEX RANGE SCAN                     | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 599 |             NESTED LOOPS                         |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*600 |              INDEX RANGE SCAN                    | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*601 |              INDEX UNIQUE SCAN                   | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*602 |       COUNT STOPKEY                              |                                |      1 |        |          |      1 |00:00:00.01 |      12 |      1 |       |       |          |
|*603 |        FILTER                                    |                                |      1 |        |          |      1 |00:00:00.01 |      12 |      1 |       |       |          |
|*604 |         INDEX RANGE SCAN                         | IX_D_URPRIVS_TEST3             |      1 |      1 | 00:00:01 |    111 |00:00:00.01 |       5 |      0 |       |       |          |
| 605 |         NESTED LOOPS                             |                                |      2 |      1 | 00:00:01 |      1 |00:00:00.01 |       7 |      1 |       |       |          |
|*606 |          INDEX RANGE SCAN                        | I_D_USERS_UI                   |      2 |      1 | 00:00:01 |      2 |00:00:00.01 |       4 |      0 |       |       |          |
|*607 |          INDEX UNIQUE SCAN                       | UK_D_USERROLES_UR              |      2 |      1 | 00:00:01 |      1 |00:00:00.01 |       3 |      1 |       |       |          |
|*608 |       COUNT STOPKEY                              |                                |      1 |        |          |      1 |00:00:00.01 |       9 |      0 |       |       |          |
|*609 |        FILTER                                    |                                |      1 |        |          |      1 |00:00:00.01 |       9 |      0 |       |       |          |
|*610 |         INDEX RANGE SCAN                         | IX_D_URPRIVS_TEST1             |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      0 |       |       |          |
| 611 |         NESTED LOOPS                             |                                |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       5 |      0 |       |       |          |
|*612 |          INDEX RANGE SCAN                        | I_D_USERS_UI                   |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       2 |      0 |       |       |          |
|*613 |          INDEX UNIQUE SCAN                       | UK_D_USERROLES_UR              |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       3 |      0 |       |       |          |
|*614 |       COUNT STOPKEY                              |                                |      1 |        |          |      1 |00:00:00.01 |       9 |      0 |       |       |          |
|*615 |        FILTER                                    |                                |      1 |        |          |      1 |00:00:00.01 |       9 |      0 |       |       |          |
|*616 |         INDEX RANGE SCAN                         | IX_D_URPRIVS_TEST1             |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       4 |      0 |       |       |          |
| 617 |         NESTED LOOPS                             |                                |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       5 |      0 |       |       |          |
|*618 |          INDEX RANGE SCAN                        | I_D_USERS_UI                   |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       2 |      0 |       |       |          |
|*619 |          INDEX UNIQUE SCAN                       | UK_D_USERROLES_UR              |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       3 |      0 |       |       |          |
| 620 |     VIEW PUSHED PREDICATE                        | D_V_PROF_CARD_CONCLUSIONS      |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       5 |      1 |       |       |          |
|*621 |      FILTER                                      |                                |      1 |        |          |      0 |00:00:00.01 |       5 |      1 |       |       |          |
|*622 |       FILTER                                     |                                |      1 |        |          |      0 |00:00:00.01 |       5 |      1 |       |       |          |
| 623 |        NESTED LOOPS                              |                                |      1 |        |          |      0 |00:00:00.01 |       5 |      1 |       |       |          |
| 624 |         NESTED LOOPS                             |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       5 |      1 |       |       |          |
| 625 |          NESTED LOOPS                            |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       5 |      1 |       |       |          |
| 626 |           MERGE JOIN CARTESIAN                   |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       5 |      1 |       |       |          |
|*627 |            INDEX RANGE SCAN                      | I_D_SERVICES_SEC_SET_ID        |      1 |      1 | 00:00:01 |      1 |00:00:00.01 |       2 |      0 |       |       |          |
| 628 |            BUFFER SORT                           |                                |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      1 |  1024 |  1024 |          |
| 629 |             TABLE ACCESS BY INDEX ROWID          | D_PROF_CARD_CONCLUSIONS        |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      1 |       |       |          |
|*630 |              INDEX RANGE SCAN                    | I_D_PROF_CARD_CONCLUSIONS_PID  |      1 |      1 | 00:00:01 |      0 |00:00:00.01 |       3 |      1 |       |       |          |
| 631 |           TABLE ACCESS BY INDEX ROWID            | D_VISITS                       |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*632 |            INDEX UNIQUE SCAN                     | PK_D_VISITS                    |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*633 |          INDEX UNIQUE SCAN                       | PK_D_DIRECTION_SERVICES        |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*634 |         TABLE ACCESS BY INDEX ROWID              | D_DIRECTION_SERVICES           |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*635 |       COUNT STOPKEY                              |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*636 |        FILTER                                    |                                |      0 |        |          |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*637 |         INDEX RANGE SCAN                         | IX_D_URPRIVS_TEST1             |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
| 638 |         NESTED LOOPS                             |                                |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*639 |          INDEX RANGE SCAN                        | I_D_USERS_UI                   |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
|*640 |          INDEX UNIQUE SCAN                       | UK_D_USERROLES_UR              |      0 |      1 | 00:00:01 |      0 |00:00:00.01 |       0 |      0 |       |       |          |
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
 
   1 - SEL$15D00A3E
   5 - SEL$15D00A3E / V@SEL$253
   6 - SEL$15D00A3E / V@SEL$253
   7 - SEL$15D00A3E / PCDS@SEL$251
   8 - SEL$15D00A3E / TT@SEL$251
   9 - SEL$15D00A3E / TT@SEL$251
  10 - SEL$301      / T2@SEL$301
  11 - SEL$301      / T2@SEL$301
  12 - SEL$5D7B7D17
  15 - SEL$5D7B7D17 / DS@SEL$207
  16 - SEL$5D7B7D17 / DS@SEL$207
  17 - SEL$5D7B7D17 / LDL@SEL$206
  18 - SEL$421D897B / LDS@SEL$206
  19 - SEL$421D897B
  20 - SEL$421D897B / indexjoin$_alias$_001@SEL$421D897B
  21 - SEL$421D897B / indexjoin$_alias$_002@SEL$421D897B
  22 - SEL$00D15238
  25 - SEL$00D15238 / LDL@SEL$208
  26 - SEL$00D15238 / LDS@SEL$208
  27 - SEL$00D15238 / LDS@SEL$208
  28 - SEL$304      / CL@SEL$304
  29 - SEL$304      / CL@SEL$304
  30 - SEL$305      / CL@SEL$305
  31 - SEL$305      / CL@SEL$305
  32 - SEL$CE5A1A76
  35 - SEL$CE5A1A76 / VF@SEL$209
  36 - SEL$CE5A1A76 / VTF@SEL$209
  37 - SEL$CE5A1A76 / ADV@SEL$210
  38 - SEL$CE5A1A76 / ADV@SEL$210
  39 - SEL$B03545E5
  42 - SEL$B03545E5 / VD@SEL$211
  43 - SEL$B03545E5 / VD@SEL$211
  44 - SEL$B03545E5 / MVD@SEL$211
  45 - SEL$B03545E5 / MVD@SEL$211
  46 - SEL$308      / LDL@SEL$308
  47 - SEL$309      / CL@SEL$309
  48 - SEL$309      / CL@SEL$309
  49 - SEL$F7E4EAE9
  52 - SEL$F7E4EAE9 / ORES@SEL$212
  53 - SEL$F7E4EAE9 / ORES@SEL$212
  54 - SEL$F7E4EAE9 / OV@SEL$212
  55 - SEL$F7E4EAE9 / OV@SEL$212
  56 - SEL$306633FD
  61 - SEL$306633FD / T@SEL$214
  62 - SEL$306633FD / T@SEL$214
  64 - SEL$306633FD / ODIR@SEL$220
  65 - SEL$306633FD / ODIR@SEL$220
  66 - SEL$306633FD / OD@SEL$221
  67 - SEL$306633FD / OD@SEL$221
  68 - SEL$306633FD / ODS@SEL$222
  69 - SEL$306633FD / ODS@SEL$222
  70 - SEL$306633FD / S@SEL$223
  71 - SEL$1952D768
  73 - SEL$1952D768 / UP@SEL$218
  74 - SEL$A426E5F1
  75 - SEL$A426E5F1 / US@SEL$217
  76 - SEL$A426E5F1 / UR@SEL$217
  77 - SEL$7FF20CC2
  78 - SEL$7FF20CC2 / L@SEL$224
  79 - SEL$7FF20CC2 / L@SEL$224
  80 - SEL$7FF20CC2 / LD@SEL$224
  81 - SEL$7FF20CC2 / LD@SEL$224
  82 - SEL$7799FE8A
  87 - SEL$7799FE8A / OD@SEL$232
  88 - SEL$7799FE8A / OD@SEL$232
  89 - SEL$7799FE8A / ODS@SEL$232
  90 - SEL$7799FE8A / ODS@SEL$232
  91 - SEL$7799FE8A / V@SEL$233
  92 - SEL$7799FE8A / V@SEL$233
  93 - SEL$7799FE8A / S@SEL$234
  94 - SEL$7799FE8A / S@SEL$234
  95 - SEL$72C161FC
  96 - SEL$72C161FC / T@SEL$226
  97 - SEL$72C161FC / T@SEL$226
  98 - SEL$46A3E3EC
 100 - SEL$46A3E3EC / UP@SEL$230
 101 - SEL$7B3F1794
 102 - SEL$7B3F1794 / US@SEL$229
 103 - SEL$7B3F1794 / UR@SEL$229
 104 - SEL$838BDF1F / ODIR@SEL$235
 105 - SEL$838BDF1F / ODIR@SEL$235
 106 - SEL$F2A4B3EE
 107 - SEL$F2A4B3EE / DD@SEL$237
 108 - SEL$F2A4B3EE / DD@SEL$237
 109 - SEL$F2A4B3EE / L@SEL$236
 110 - SEL$F2A4B3EE / L@SEL$236
 111 - SEL$0D40BBC1
 114 - SEL$0D40BBC1 / ORES@SEL$238
 115 - SEL$0D40BBC1 / ORES@SEL$238
 116 - SEL$0D40BBC1 / OV@SEL$238
 117 - SEL$0D40BBC1 / OV@SEL$238
 118 - SEL$B0D01609
 123 - SEL$B0D01609 / ODIR@SEL$283
 124 - SEL$B0D01609 / ODIR@SEL$283
 125 - SEL$B0D01609 / OD@SEL$284
 126 - SEL$B0D01609 / OD@SEL$284
 127 - SEL$B0D01609 / ODS@SEL$285
 128 - SEL$B0D01609 / ODS@SEL$285
 129 - SEL$B0D01609 / S@SEL$286
 130 - SEL$B0D01609 / S@SEL$286
 131 - SEL$8CEE2984
 132 - SEL$8CEE2984 / T@SEL$277
 133 - SEL$8CEE2984 / T@SEL$277
 134 - SEL$BA42F60A
 136 - SEL$BA42F60A / UP@SEL$281
 137 - SEL$1797E9EC
 138 - SEL$1797E9EC / US@SEL$280
 139 - SEL$1797E9EC / UR@SEL$280
 140 - SEL$3E0B8B1B
 143 - SEL$3E0B8B1B / K1@SEL$240
 144 - SEL$3E0B8B1B / K1@SEL$240
 145 - SEL$3E0B8B1B / K2@SEL$240
 146 - SEL$3E0B8B1B / K2@SEL$240
 147 - SEL$AEAAFD30
 152 - SEL$AEAAFD30 / J1@SEL$241
 153 - SEL$AEAAFD30 / J1@SEL$241
 154 - SEL$AEAAFD30 / J2@SEL$241
 155 - SEL$AEAAFD30 / J2@SEL$241
 156 - SEL$AEAAFD30 / J3@SEL$242
 157 - SEL$AEAAFD30 / J3@SEL$242
 158 - SEL$AEAAFD30 / DL@SEL$243
 159 - SEL$AEAAFD30 / DL@SEL$243
 160 - SEL$FF54AA42
 163 - SEL$FF54AA42 / C@SEL$9
 164 - SEL$FF54AA42 / C@SEL$9
 165 - SEL$C6D4F03D / VW_SQ_2@SEL$A884B7E2
 166 - SEL$C6D4F03D
 167 - SEL$C6D4F03D / UP@SEL$12
 168 - SEL$5D238E44
 169 - SEL$5D238E44 / US@SEL$11
 170 - SEL$5D238E44 / UR@SEL$11
 171 - SEL$B01C6807 / PC@SEL$2
 172 - SEL$B01C6807
 173 - SEL$B01C6807 / PCC@SEL$3
 174 - SEL$B01C6807 / PCC@SEL$3
 175 - SEL$0DAFA1FC
 177 - SEL$0DAFA1FC / UP@SEL$6
 178 - SEL$F23444D6
 179 - SEL$F23444D6 / US@SEL$5
 180 - SEL$F23444D6 / UR@SEL$5
 181 - SEL$1861DA60
 183 - SEL$1861DA60 / PCSOR@SEL$21
 184 - SEL$1861DA60 / PCSOR@SEL$21
 185 - SEL$F5405A97 / PC@SEL$14
 186 - SEL$F5405A97
 187 - SEL$F5405A97 / PCC@SEL$15
 188 - SEL$F5405A97 / PCC@SEL$15
 189 - SEL$FA8321DB
 191 - SEL$FA8321DB / UP@SEL$18
 192 - SEL$32561052
 193 - SEL$32561052 / US@SEL$17
 194 - SEL$32561052 / UR@SEL$17
 195 - SEL$30E1352B
 197 - SEL$30E1352B / UP@SEL$25
 198 - SEL$4D82D6A1
 199 - SEL$4D82D6A1 / US@SEL$24
 200 - SEL$4D82D6A1 / UR@SEL$24
 201 - SEL$09C8BA82
 204 - SEL$09C8BA82 / PC@SEL$270
 205 - SEL$09C8BA82 / PC@SEL$270
 206 - SEL$09C8BA82 / PCT@SEL$269
 207 - SEL$09C8BA82 / PCT@SEL$269
 208 - SEL$09C8BA82 / PCC@SEL$271
 209 - SEL$09C8BA82 / PCC@SEL$271
 210 - SEL$7C70D976
 213 - SEL$7C70D976 / VD@SEL$239
 214 - SEL$7C70D976 / VD@SEL$239
 215 - SEL$7C70D976 / MVD@SEL$239
 216 - SEL$7C70D976 / MVD@SEL$239
 217 - SEL$7D0723C2
 221 - SEL$7D0723C2 / T@SEL$28
 222 - SEL$7D0723C2 / T@SEL$28
 223 - SEL$7D0723C2 / T@SEL$33
 224 - SEL$7D0723C2 / T@SEL$33
 225 - SEL$C6517114
 227 - SEL$C6517114 / UP@SEL$36
 228 - SEL$032A48B3
 229 - SEL$032A48B3 / US@SEL$35
 230 - SEL$032A48B3 / UR@SEL$35
 231 - SEL$88C6B492
 233 - SEL$88C6B492 / UP@SEL$31
 234 - SEL$7C84398F
 235 - SEL$7C84398F / US@SEL$30
 236 - SEL$7C84398F / UR@SEL$30
 237 - SEL$FC7715CF
 240 - SEL$FC7715CF / INT_HL7V3_MSGS@SEL$41
 241 - SEL$FC7715CF / INT_HL7V3_MSGS@SEL$41
 242 - SEL$FC7715CF / INT_HL7V3_MSGS@SEL$39
 243 - SEL$FC7715CF / INT_HL7V3_MSGS@SEL$39
 244 - SEL$1F8A2BDC
 248 - SEL$1F8A2BDC / T@SEL$43
 249 - SEL$1F8A2BDC / T@SEL$43
 250 - SEL$1F8A2BDC / T@SEL$48
 251 - SEL$1F8A2BDC / T@SEL$48
 252 - SEL$C68B223C
 254 - SEL$C68B223C / UP@SEL$51
 255 - SEL$8A9147A6
 256 - SEL$8A9147A6 / US@SEL$50
 257 - SEL$8A9147A6 / UR@SEL$50
 258 - SEL$C2C6E2EA
 260 - SEL$C2C6E2EA / UP@SEL$46
 261 - SEL$68F5C6F7
 262 - SEL$68F5C6F7 / US@SEL$45
 263 - SEL$68F5C6F7 / UR@SEL$45
 264 - SEL$F2E67D0D
 267 - SEL$F2E67D0D / INT_HL7V3_MSGS@SEL$56
 268 - SEL$F2E67D0D / INT_HL7V3_MSGS@SEL$56
 269 - SEL$F2E67D0D / INT_HL7V3_MSGS@SEL$54
 270 - SEL$F2E67D0D / INT_HL7V3_MSGS@SEL$54
 271 - SEL$28F00AFB
 275 - SEL$28F00AFB / T@SEL$58
 276 - SEL$28F00AFB / T@SEL$58
 277 - SEL$28F00AFB / T@SEL$63
 278 - SEL$28F00AFB / T@SEL$63
 279 - SEL$C9F0CD94
 281 - SEL$C9F0CD94 / UP@SEL$66
 282 - SEL$25AB1310
 283 - SEL$25AB1310 / US@SEL$65
 284 - SEL$25AB1310 / UR@SEL$65
 285 - SEL$6BA534D9
 287 - SEL$6BA534D9 / UP@SEL$61
 288 - SEL$7A8D133E
 289 - SEL$7A8D133E / US@SEL$60
 290 - SEL$7A8D133E / UR@SEL$60
 291 - SEL$623FEB7C
 295 - SEL$623FEB7C / T@SEL$69
 296 - SEL$623FEB7C / T@SEL$69
 297 - SEL$623FEB7C / T@SEL$74
 298 - SEL$623FEB7C / T@SEL$74
 299 - SEL$145      / DUAL@SEL$145
 300 - SEL$3D1041AC
 302 - SEL$3D1041AC / UP@SEL$77
 303 - SEL$4B944954
 304 - SEL$4B944954 / US@SEL$76
 305 - SEL$4B944954 / UR@SEL$76
 306 - SEL$7C3F09F1
 308 - SEL$7C3F09F1 / UP@SEL$72
 309 - SEL$EA442AA0
 310 - SEL$EA442AA0 / US@SEL$71
 311 - SEL$EA442AA0 / UR@SEL$71
 312 - SEL$770E79DD
 316 - SEL$770E79DD / T@SEL$80
 317 - SEL$770E79DD / T@SEL$80
 318 - SEL$770E79DD / T@SEL$85
 319 - SEL$770E79DD / T@SEL$85
 320 - SEL$147      / DUAL@SEL$147
 321 - SEL$3A30E29F
 323 - SEL$3A30E29F / UP@SEL$88
 324 - SEL$21CF4C06
 325 - SEL$21CF4C06 / US@SEL$87
 326 - SEL$21CF4C06 / UR@SEL$87
 327 - SEL$2977D0E0
 329 - SEL$2977D0E0 / UP@SEL$83
 330 - SEL$474C6891
 331 - SEL$474C6891 / US@SEL$82
 332 - SEL$474C6891 / UR@SEL$82
 333 - SEL$058EA8D5
 337 - SEL$058EA8D5 / PCSOR@SEL$155
 338 - SEL$058EA8D5 / PCSOR@SEL$155
 339 - SEL$058EA8D5 / T1@SEL$149
 340 - SEL$058EA8D5 / T1@SEL$149
 341 - SEL$058EA8D5 / UP@SEL$152
 342 - SEL$64D77254
 344 - SEL$64D77254 / UP@SEL$159
 345 - SEL$F9DD4CB9
 346 - SEL$F9DD4CB9 / US@SEL$158
 347 - SEL$F9DD4CB9 / UR@SEL$158
 348 - SEL$B9991707
 349 - SEL$B9991707 / US@SEL$151
 350 - SEL$B9991707 / UR@SEL$151
 351 - SEL$CD5BF647
 353 - SEL$CD5BF647 / T@SEL$407
 354 - SEL$CD5BF647 / T@SEL$407
 355 - SEL$BC875581 / VW_SQ_1@SEL$659B72BF
 356 - SEL$BC875581
 357 - SEL$BC875581 / UP@SEL$414
 358 - SEL$B75A2FFF
 359 - SEL$B75A2FFF / US@SEL$413
 360 - SEL$B75A2FFF / UR@SEL$413
 361 - SEL$4E5B4514
 369 - SEL$4E5B4514 / J1@SEL$245
 370 - SEL$4E5B4514 / J1@SEL$245
 371 - SEL$4E5B4514 / J2@SEL$245
 372 - SEL$4E5B4514 / J2@SEL$245
 373 - SEL$4E5B4514 / J3@SEL$246
 374 - SEL$4E5B4514 / J3@SEL$246
 375 - SEL$4E5B4514 / J4@SEL$247
 376 - SEL$4E5B4514 / J4@SEL$247
 377 - SEL$4E5B4514 / DL@SEL$249
 378 - SEL$4E5B4514 / DL@SEL$249
 379 - SEL$4E5B4514 / J5@SEL$248
 380 - SEL$4E5B4514 / J5@SEL$248
 381 - SEL$4A8506B4
 383 - SEL$4A8506B4 / PC@SEL$275
 384 - SEL$4A8506B4 / PC@SEL$275
 385 - SEL$4A8506B4 / PCT@SEL$275
 386 - SEL$4A8506B4 / PCT@SEL$275
 387 - SEL$0B0BE1F3
 392 - SEL$0B0BE1F3 / DS@SEL$257
 393 - SEL$0B0BE1F3 / DS@SEL$257
 394 - SEL$0B0BE1F3 / DL@SEL$257
 395 - SEL$0B0BE1F3 / DL@SEL$257
 396 - SEL$0B0BE1F3 / SD@SEL$258
 397 - SEL$0B0BE1F3 / SD@SEL$258
 398 - SEL$0B0BE1F3 / S@SEL$259
 399 - SEL$0B0BE1F3 / S@SEL$259
 400 - SEL$0A8A44CF
 403 - SEL$0A8A44CF / PCS@SEL$97
 404 - SEL$0A8A44CF / PCS@SEL$97
 405 - SEL$0A8A44CF / PCSOR@SEL$91
 406 - SEL$0A8A44CF / PCSOR@SEL$91
 407 - SEL$C482CF97 / PC@SEL$106
 408 - SEL$C482CF97
 409 - SEL$C482CF97 / PCC@SEL$107
 410 - SEL$C482CF97 / PCC@SEL$107
 411 - SEL$9100DC0B
 413 - SEL$9100DC0B / UP@SEL$110
 414 - SEL$EEB295B0
 415 - SEL$EEB295B0 / US@SEL$109
 416 - SEL$EEB295B0 / UR@SEL$109
 417 - SEL$F9DE4AF1
 419 - SEL$F9DE4AF1 / UP@SEL$104
 420 - SEL$0CBCACBD
 421 - SEL$0CBCACBD / US@SEL$103
 422 - SEL$0CBCACBD / UR@SEL$103
 423 - SEL$0929CC96
 425 - SEL$0929CC96 / UP@SEL$95
 426 - SEL$44D94F01
 427 - SEL$44D94F01 / US@SEL$94
 428 - SEL$44D94F01 / UR@SEL$94
 429 - SEL$FF307D9F
 430 - SEL$FF307D9F / PCSOR@SEL$164
 431 - SEL$FF307D9F / PCSOR@SEL$164
 432 - SEL$C44BA534
 434 - SEL$C44BA534 / UP@SEL$168
 435 - SEL$F37F9FD3
 436 - SEL$F37F9FD3 / US@SEL$167
 437 - SEL$F37F9FD3 / UR@SEL$167
 438 - SEL$8D1A81FE
 440 - SEL$8D1A81FE / T@SEL$171
 441 - SEL$8D1A81FE / T@SEL$171
 442 - SEL$2634090D / VW_SQ_3@SEL$80B75D33
 443 - SEL$2634090D
 444 - SEL$2634090D / UP@SEL$174
 445 - SEL$D2A93C17
 446 - SEL$D2A93C17 / US@SEL$173
 447 - SEL$D2A93C17 / UR@SEL$173
 448 - SEL$8DEB7E6D
 454 - SEL$8DEB7E6D / S@SEL$179
 455 - SEL$8DEB7E6D / DSS@SEL$177
 456 - SEL$8DEB7E6D / DSS@SEL$177
 457 - SEL$8DEB7E6D / DS@SEL$177
 458 - SEL$8DEB7E6D / DS@SEL$177
 459 - SEL$185      / DUAL@SEL$185
 460 - SEL$89359AEE
 462 - SEL$89359AEE / UP@SEL$183
 463 - SEL$88C79FCA
 464 - SEL$88C79FCA / US@SEL$182
 465 - SEL$88C79FCA / UR@SEL$182
 466 - SEL$AD8C7765
 468 - SEL$AD8C7765 / T@SEL$187
 475 - SEL$CD4C9210 / VW_SQ_4@SEL$0FFCFA0B
 476 - SEL$CD4C9210
 477 - SEL$CD4C9210 / UP@SEL$190
 478 - SEL$6D9A86AF
 479 - SEL$6D9A86AF / US@SEL$189
 480 - SEL$6D9A86AF / UR@SEL$189
 481 - SEL$4B7AE55C
 483 - SEL$4B7AE55C / PC@SEL$193
 484 - SEL$4B7AE55C / PC@SEL$193
 485 - SEL$72EEAF55
 487 - SEL$72EEAF55 / UP@SEL$196
 488 - SEL$2002CBB4
 489 - SEL$2002CBB4 / US@SEL$195
 490 - SEL$2002CBB4 / UR@SEL$195
 491 - SEL$E12F393B
 493 - SEL$E12F393B / T@SEL$199
 494 - SEL$E12F393B / T@SEL$199
 495 - SEL$75546432
 497 - SEL$75546432 / UP@SEL$202
 498 - SEL$0A384FF1
 499 - SEL$0A384FF1 / US@SEL$201
 500 - SEL$0A384FF1 / UR@SEL$201
 501 - SEL$CBB9BA06
 507 - SEL$CBB9BA06 / T@SEL$131
 508 - SEL$CBB9BA06 / T@SEL$131
 509 - SEL$CBB9BA06 / T@SEL$125
 516 - SEL$CBB9BA06 / T@SEL$119
 517 - SEL$CBB9BA06 / T@SEL$119
 518 - SEL$CBB9BA06 / AT@SEL$114
 519 - SEL$0CAA258E
 521 - SEL$0CAA258E / UP@SEL$117
 522 - SEL$1ADC8C15
 523 - SEL$1ADC8C15 / US@SEL$116
 524 - SEL$1ADC8C15 / UR@SEL$116
 525 - SEL$CFD2D090
 527 - SEL$CFD2D090 / UP@SEL$134
 528 - SEL$BA458DC4
 529 - SEL$BA458DC4 / US@SEL$133
 530 - SEL$BA458DC4 / UR@SEL$133
 531 - SEL$51F828FA
 533 - SEL$51F828FA / UP@SEL$128
 534 - SEL$CC1EF0E8
 535 - SEL$CC1EF0E8 / US@SEL$127
 536 - SEL$CC1EF0E8 / UR@SEL$127
 537 - SEL$A5BAA20F
 539 - SEL$A5BAA20F / UP@SEL$122
 540 - SEL$FA386CED
 541 - SEL$FA386CED / US@SEL$121
 542 - SEL$FA386CED / UR@SEL$121
 543 - SEL$51F04F9E / V@SEL$136
 544 - SEL$51F04F9E
 546 - SEL$6B41E1E4 / from$_subquery$_064@SEL$404
 547 - SEL$6B41E1E4
 558 - SEL$6B41E1E4 / PC@SEL$343
 559 - SEL$6B41E1E4 / PC@SEL$343
 560 - SEL$6B41E1E4 / PCT@SEL$349
 561 - SEL$6B41E1E4 / PCT@SEL$349
 562 - SEL$6B41E1E4 / PCS@SEL$287
 563 - SEL$6B41E1E4 / PCS@SEL$287
 564 - SEL$6B41E1E4 / SERV@SEL$287
 565 - SEL$6B41E1E4 / SERV@SEL$287
 566 - SEL$6B41E1E4 / PCDIRS@SEL$288
 567 - SEL$6B41E1E4 / PCDIRS@SEL$288
 568 - SEL$6B41E1E4 / DIRS@SEL$290
 569 - SEL$6B41E1E4 / DIRS@SEL$290
 570 - SEL$6B41E1E4 / EMP@SEL$292
 571 - SEL$6B41E1E4 / EMP@SEL$292
 572 - SEL$6B41E1E4 / V@SEL$296
 573 - SEL$6B41E1E4 / V@SEL$296
 574 - SEL$6B41E1E4 / DIR@SEL$298
 575 - SEL$6B41E1E4 / DIR@SEL$298
 576 - SEL$6B41E1E4 / EMPA@SEL$294
 577 - SEL$6B41E1E4 / EMPA@SEL$294
 578 - SEL$169CD701 / EX@SEL$354
 579 - SEL$169CD701
 584 - SEL$169CD701 / D_EX_SYSTEM_VALUES@SEL$356
 585 - SEL$169CD701 / D_EX_SYSTEM_VALUES@SEL$356
 586 - SEL$169CD701 / T@SEL$357
 587 - SEL$169CD701 / T@SEL$357
 588 - SEL$169CD701 / PCS@SEL$363
 589 - SEL$169CD701 / PCS@SEL$363
 590 - SEL$23FC1809
 592 - SEL$23FC1809 / UP@SEL$370
 593 - SEL$9CC480F5
 594 - SEL$9CC480F5 / US@SEL$369
 595 - SEL$9CC480F5 / UR@SEL$369
 596 - SEL$BFD74306
 598 - SEL$BFD74306 / UP@SEL$360
 599 - SEL$C2C6B5C4
 600 - SEL$C2C6B5C4 / US@SEL$359
 601 - SEL$C2C6B5C4 / UR@SEL$359
 602 - SEL$906D331B
 604 - SEL$906D331B / UP@SEL$352
 605 - SEL$97238E9E
 606 - SEL$97238E9E / US@SEL$351
 607 - SEL$97238E9E / UR@SEL$351
 608 - SEL$827DFB84
 610 - SEL$827DFB84 / UP@SEL$346
 611 - SEL$518ABD35
 612 - SEL$518ABD35 / US@SEL$345
 613 - SEL$518ABD35 / UR@SEL$345
 614 - SEL$29A4ECCD
 616 - SEL$29A4ECCD / UP@SEL$341
 617 - SEL$F9CD0431
 618 - SEL$F9CD0431 / US@SEL$340
 619 - SEL$F9CD0431 / UR@SEL$340
 620 - SEL$F306E5BC / PCC@SEL$374
 621 - SEL$F306E5BC
 627 - SEL$F306E5BC / SRV@SEL$395
 629 - SEL$F306E5BC / PCC@SEL$376
 630 - SEL$F306E5BC / PCC@SEL$376
 631 - SEL$F306E5BC / V@SEL$391
 632 - SEL$F306E5BC / V@SEL$391
 633 - SEL$F306E5BC / DRS@SEL$393
 634 - SEL$F306E5BC / DRS@SEL$393
 635 - SEL$27147FD9
 637 - SEL$27147FD9 / UP@SEL$402
 638 - SEL$102B9171
 639 - SEL$102B9171 / US@SEL$401
 640 - SEL$102B9171 / UR@SEL$401
 
Outline Data
-------------
 
  /*+
      BEGIN_OUTLINE_DATA
      IGNORE_OPTIM_EMBEDDED_HINTS
      OPTIMIZER_FEATURES_ENABLE('11.2.0.4')
      DB_VERSION('19.1.0')
      ALL_ROWS
      OUTLINE_LEAF(@"SEL$5D238E44")
      MERGE(@"SEL$11" >"SEL$13")
      OUTLINE_LEAF(@"SEL$C6D4F03D")
      PUSH_PRED(@"SEL$FF54AA42" "VW_SQ_2"@"SEL$A884B7E2" 5)
      OUTLINE_LEAF(@"SEL$F23444D6")
      MERGE(@"SEL$5" >"SEL$7")
      OUTLINE_LEAF(@"SEL$0DAFA1FC")
      MERGE(@"SEL$6" >"SEL$4")
      OUTLINE_LEAF(@"SEL$B01C6807")
      PUSH_PRED(@"SEL$FF54AA42" "PC"@"SEL$2" 4)
      OUTLINE_LEAF(@"SEL$FF54AA42")
      UNNEST(@"SEL$18BE6699")
      OUTLINE_LEAF(@"SEL$4D82D6A1")
      MERGE(@"SEL$24" >"SEL$26")
      OUTLINE_LEAF(@"SEL$30E1352B")
      MERGE(@"SEL$25" >"SEL$23")
      OUTLINE_LEAF(@"SEL$32561052")
      MERGE(@"SEL$17" >"SEL$19")
      OUTLINE_LEAF(@"SEL$FA8321DB")
      MERGE(@"SEL$18" >"SEL$16")
      OUTLINE_LEAF(@"SEL$F5405A97")
      PUSH_PRED(@"SEL$1861DA60" "PC"@"SEL$14" 2)
      OUTLINE_LEAF(@"SEL$1861DA60")
      MERGE(@"SEL$096670FF" >"SEL$138")
      OUTLINE_LEAF(@"SEL$032A48B3")
      MERGE(@"SEL$35" >"SEL$37")
      OUTLINE_LEAF(@"SEL$C6517114")
      MERGE(@"SEL$36" >"SEL$34")
      OUTLINE_LEAF(@"SEL$7C84398F")
      MERGE(@"SEL$30" >"SEL$32")
      OUTLINE_LEAF(@"SEL$88C6B492")
      MERGE(@"SEL$31" >"SEL$29")
      OUTLINE_LEAF(@"SEL$7D0723C2")
      MERGE(@"SEL$F87F4B43" >"SEL$139")
      OUTLINE_LEAF(@"SEL$FC7715CF")
      MERGE(@"SEL$39" >"SEL$28551BD7")
      OUTLINE_LEAF(@"SEL$8A9147A6")
      MERGE(@"SEL$50" >"SEL$52")
      OUTLINE_LEAF(@"SEL$C68B223C")
      MERGE(@"SEL$51" >"SEL$49")
      OUTLINE_LEAF(@"SEL$68F5C6F7")
      MERGE(@"SEL$45" >"SEL$47")
      OUTLINE_LEAF(@"SEL$C2C6E2EA")
      MERGE(@"SEL$46" >"SEL$44")
      OUTLINE_LEAF(@"SEL$1F8A2BDC")
      MERGE(@"SEL$8E26BC93" >"SEL$140")
      OUTLINE_LEAF(@"SEL$F2E67D0D")
      MERGE(@"SEL$54" >"SEL$404F1C3B")
      OUTLINE_LEAF(@"SEL$25AB1310")
      MERGE(@"SEL$65" >"SEL$67")
      OUTLINE_LEAF(@"SEL$C9F0CD94")
      MERGE(@"SEL$66" >"SEL$64")
      OUTLINE_LEAF(@"SEL$7A8D133E")
      MERGE(@"SEL$60" >"SEL$62")
      OUTLINE_LEAF(@"SEL$6BA534D9")
      MERGE(@"SEL$61" >"SEL$59")
      OUTLINE_LEAF(@"SEL$28F00AFB")
      MERGE(@"SEL$C5D9AD8A" >"SEL$142")
      OUTLINE_LEAF(@"SEL$145")
      OUTLINE_LEAF(@"SEL$4B944954")
      MERGE(@"SEL$76" >"SEL$78")
      OUTLINE_LEAF(@"SEL$3D1041AC")
      MERGE(@"SEL$77" >"SEL$75")
      OUTLINE_LEAF(@"SEL$EA442AA0")
      MERGE(@"SEL$71" >"SEL$73")
      OUTLINE_LEAF(@"SEL$7C3F09F1")
      MERGE(@"SEL$72" >"SEL$70")
      OUTLINE_LEAF(@"SEL$623FEB7C")
      MERGE(@"SEL$BE10A7DB" >"SEL$144")
      OUTLINE_LEAF(@"SEL$147")
      OUTLINE_LEAF(@"SEL$21CF4C06")
      MERGE(@"SEL$87" >"SEL$89")
      OUTLINE_LEAF(@"SEL$3A30E29F")
      MERGE(@"SEL$88" >"SEL$86")
      OUTLINE_LEAF(@"SEL$474C6891")
      MERGE(@"SEL$82" >"SEL$84")
      OUTLINE_LEAF(@"SEL$2977D0E0")
      MERGE(@"SEL$83" >"SEL$81")
      OUTLINE_LEAF(@"SEL$770E79DD")
      MERGE(@"SEL$419D8FE3" >"SEL$146")
      OUTLINE_LEAF(@"SEL$F9DD4CB9")
      MERGE(@"SEL$158" >"SEL$160")
      OUTLINE_LEAF(@"SEL$64D77254")
      MERGE(@"SEL$159" >"SEL$157")
      OUTLINE_LEAF(@"SEL$B9991707")
      MERGE(@"SEL$151" >"SEL$153")
      OUTLINE_LEAF(@"SEL$058EA8D5")
      UNNEST(@"SEL$3856FDC7")
      OUTLINE_LEAF(@"SEL$0CBCACBD")
      MERGE(@"SEL$103" >"SEL$105")
      OUTLINE_LEAF(@"SEL$F9DE4AF1")
      MERGE(@"SEL$104" >"SEL$102")
      OUTLINE_LEAF(@"SEL$44D94F01")
      MERGE(@"SEL$94" >"SEL$96")
      OUTLINE_LEAF(@"SEL$0929CC96")
      MERGE(@"SEL$95" >"SEL$93")
      OUTLINE_LEAF(@"SEL$EEB295B0")
      MERGE(@"SEL$109" >"SEL$111")
      OUTLINE_LEAF(@"SEL$9100DC0B")
      MERGE(@"SEL$110" >"SEL$108")
      OUTLINE_LEAF(@"SEL$C482CF97")
      PUSH_PRED(@"SEL$0A8A44CF" "PC"@"SEL$106" 3)
      OUTLINE_LEAF(@"SEL$0A8A44CF")
      ELIMINATE_JOIN(@"SEL$F576CF67" "S"@"SEL$97")
      OUTLINE_LEAF(@"SEL$F37F9FD3")
      MERGE(@"SEL$167" >"SEL$169")
      OUTLINE_LEAF(@"SEL$C44BA534")
      MERGE(@"SEL$168" >"SEL$166")
      OUTLINE_LEAF(@"SEL$FF307D9F")
      MERGE(@"SEL$164" >"SEL$163")
      OUTLINE_LEAF(@"SEL$D2A93C17")
      MERGE(@"SEL$173" >"SEL$175")
      OUTLINE_LEAF(@"SEL$2634090D")
      PUSH_PRED(@"SEL$8D1A81FE" "VW_SQ_3"@"SEL$80B75D33" 4)
      OUTLINE_LEAF(@"SEL$8D1A81FE")
      UNNEST(@"SEL$8D164D70")
      OUTLINE_LEAF(@"SEL$185")
      OUTLINE_LEAF(@"SEL$88C79FCA")
      MERGE(@"SEL$182" >"SEL$184")
      OUTLINE_LEAF(@"SEL$89359AEE")
      MERGE(@"SEL$183" >"SEL$181")
      OUTLINE_LEAF(@"SEL$8DEB7E6D")
      ELIMINATE_JOIN(@"SEL$7DF6143C" "PCT"@"SEL$178")
      OUTLINE_LEAF(@"SEL$6D9A86AF")
      MERGE(@"SEL$189" >"SEL$191")
      OUTLINE_LEAF(@"SEL$CD4C9210")
      PUSH_PRED(@"SEL$AD8C7765" "VW_SQ_4"@"SEL$0FFCFA0B" 4)
      OUTLINE_LEAF(@"SEL$AD8C7765")
      UNNEST(@"SEL$5B5117AB")
      OUTLINE_LEAF(@"SEL$2002CBB4")
      MERGE(@"SEL$195" >"SEL$197")
      OUTLINE_LEAF(@"SEL$72EEAF55")
      MERGE(@"SEL$196" >"SEL$194")
      OUTLINE_LEAF(@"SEL$4B7AE55C")
      MERGE(@"SEL$193" >"SEL$192")
      OUTLINE_LEAF(@"SEL$0A384FF1")
      MERGE(@"SEL$201" >"SEL$203")
      OUTLINE_LEAF(@"SEL$75546432")
      MERGE(@"SEL$202" >"SEL$200")
      OUTLINE_LEAF(@"SEL$E12F393B")
      MERGE(@"SEL$199" >"SEL$198")
      OUTLINE_LEAF(@"SEL$BA458DC4")
      MERGE(@"SEL$133" >"SEL$135")
      OUTLINE_LEAF(@"SEL$CFD2D090")
      MERGE(@"SEL$134" >"SEL$132")
      OUTLINE_LEAF(@"SEL$CC1EF0E8")
      MERGE(@"SEL$127" >"SEL$129")
      OUTLINE_LEAF(@"SEL$51F828FA")
      MERGE(@"SEL$128" >"SEL$126")
      OUTLINE_LEAF(@"SEL$FA386CED")
      MERGE(@"SEL$121" >"SEL$123")
      OUTLINE_LEAF(@"SEL$A5BAA20F")
      MERGE(@"SEL$122" >"SEL$120")
      OUTLINE_LEAF(@"SEL$1ADC8C15")
      MERGE(@"SEL$116" >"SEL$118")
      OUTLINE_LEAF(@"SEL$0CAA258E")
      MERGE(@"SEL$117" >"SEL$115")
      OUTLINE_LEAF(@"SEL$CBB9BA06")
      MERGE(@"SEL$6A4B05D8" >"SEL$204")
      OUTLINE_LEAF(@"SEL$B75A2FFF")
      MERGE(@"SEL$413" >"SEL$415")
      OUTLINE_LEAF(@"SEL$BC875581")
      PUSH_PRED(@"SEL$CD5BF647" "VW_SQ_1"@"SEL$659B72BF" 2)
      OUTLINE_LEAF(@"SEL$CD5BF647")
      ELIMINATE_JOIN(@"SEL$4C987CF0" "T1"@"SEL$407")
      OUTLINE_LEAF(@"SEL$97238E9E")
      MERGE(@"SEL$351" >"SEL$353")
      OUTLINE_LEAF(@"SEL$906D331B")
      MERGE(@"SEL$352" >"SEL$350")
      OUTLINE_LEAF(@"SEL$518ABD35")
      MERGE(@"SEL$345" >"SEL$347")
      OUTLINE_LEAF(@"SEL$827DFB84")
      MERGE(@"SEL$346" >"SEL$344")
      OUTLINE_LEAF(@"SEL$301")
      OUTLINE_LEAF(@"SEL$421D897B")
      OUTLINE_LEAF(@"SEL$5D7B7D17")
      MERGE(@"SEL$6A269FB7" >"SEL$302")
      OUTLINE_LEAF(@"SEL$00D15238")
      MERGE(@"SEL$208" >"SEL$303")
      OUTLINE_LEAF(@"SEL$304")
      OUTLINE_LEAF(@"SEL$305")
      OUTLINE_LEAF(@"SEL$CE5A1A76")
      MERGE(@"SEL$DC51C721" >"SEL$306")
      OUTLINE_LEAF(@"SEL$B03545E5")
      MERGE(@"SEL$211" >"SEL$307")
      OUTLINE_LEAF(@"SEL$308")
      OUTLINE_LEAF(@"SEL$309")
      OUTLINE_LEAF(@"SEL$F7E4EAE9")
      MERGE(@"SEL$212" >"SEL$310")
      OUTLINE_LEAF(@"SEL$A426E5F1")
      MERGE(@"SEL$217" >"SEL$219")
      OUTLINE_LEAF(@"SEL$1952D768")
      MERGE(@"SEL$218" >"SEL$216")
      OUTLINE_LEAF(@"SEL$306633FD")
      UNNEST(@"SEL$68774E43")
      OUTLINE_LEAF(@"SEL$7FF20CC2")
      MERGE(@"SEL$224" >"SEL$314")
      OUTLINE_LEAF(@"SEL$7B3F1794")
      MERGE(@"SEL$229" >"SEL$231")
      OUTLINE_LEAF(@"SEL$46A3E3EC")
      MERGE(@"SEL$230" >"SEL$228")
      OUTLINE_LEAF(@"SEL$72C161FC")
      ELIMINATE_JOIN(@"SEL$2A4F3908" "D1"@"SEL$225")
      ELIMINATE_JOIN(@"SEL$2A4F3908" "T9"@"SEL$226")
      OUTLINE_LEAF(@"SEL$7799FE8A")
      MERGE(@"SEL$6E00D23F" >"SEL$315")
      OUTLINE_LEAF(@"SEL$838BDF1F")
      ELIMINATE_JOIN(@"SEL$61DEC2DE" "D"@"SEL$235")
      OUTLINE_LEAF(@"SEL$F2A4B3EE")
      MERGE(@"SEL$22CC368D" >"SEL$317")
      OUTLINE_LEAF(@"SEL$0D40BBC1")
      MERGE(@"SEL$238" >"SEL$318")
      OUTLINE_LEAF(@"SEL$7C70D976")
      MERGE(@"SEL$239" >"SEL$319")
      OUTLINE_LEAF(@"SEL$3E0B8B1B")
      MERGE(@"SEL$240" >"SEL$320")
      OUTLINE_LEAF(@"SEL$AEAAFD30")
      MERGE(@"SEL$CCCF656D" >"SEL$321")
      OUTLINE_LEAF(@"SEL$4E5B4514")
      MERGE(@"SEL$AB0185AF" >"SEL$322")
      OUTLINE_LEAF(@"SEL$15D00A3E")
      ELIMINATE_JOIN(@"SEL$D2574228" "DS"@"SEL$252")
      OUTLINE_LEAF(@"SEL$2AEBFB23")
      MERGE(@"SEL$254" >"SEL$324")
      OUTLINE_LEAF(@"SEL$885A6771")
      MERGE(@"SEL$E10926EF" >"SEL$325")
      OUTLINE_LEAF(@"SEL$326")
      OUTLINE_LEAF(@"SEL$327")
      OUTLINE_LEAF(@"SEL$328")
      OUTLINE_LEAF(@"SEL$329")
      OUTLINE_LEAF(@"SEL$0B0BE1F3")
      MERGE(@"SEL$7D443A45" >"SEL$330")
      OUTLINE_LEAF(@"SEL$7057249E")
      MERGE(@"SEL$2BF2BB32" >"SEL$331")
      OUTLINE_LEAF(@"SEL$DF1510EF")
      MERGE(@"SEL$262" >"SEL$332")
      OUTLINE_LEAF(@"SEL$B560D28C")
      OUTER_JOIN_TO_INNER(@"SEL$457DE630" "PCC"@"SEL$265")
      OUTLINE_LEAF(@"SEL$334")
      OUTLINE_LEAF(@"SEL$09C8BA82")
      ELIMINATE_JOIN(@"SEL$609DDCFC" "PCL"@"SEL$273")
      OUTLINE_LEAF(@"SEL$4A8506B4")
      MERGE(@"SEL$275" >"SEL$336")
      OUTLINE_LEAF(@"SEL$1797E9EC")
      MERGE(@"SEL$280" >"SEL$282")
      OUTLINE_LEAF(@"SEL$BA42F60A")
      MERGE(@"SEL$281" >"SEL$279")
      OUTLINE_LEAF(@"SEL$8CEE2984")
      ELIMINATE_JOIN(@"SEL$AE143F5E" "D1"@"SEL$276")
      ELIMINATE_JOIN(@"SEL$AE143F5E" "T9"@"SEL$277")
      OUTLINE_LEAF(@"SEL$B0D01609")
      ELIMINATE_JOIN(@"SEL$ADE031A8" "D"@"SEL$283")
      OUTLINE_LEAF(@"SEL$F9CD0431")
      MERGE(@"SEL$340" >"SEL$342")
      OUTLINE_LEAF(@"SEL$29A4ECCD")
      MERGE(@"SEL$341" >"SEL$339")
      OUTLINE_LEAF(@"SEL$9CC480F5")
      MERGE(@"SEL$369" >"SEL$371")
      OUTLINE_LEAF(@"SEL$23FC1809")
      MERGE(@"SEL$370" >"SEL$368")
      OUTLINE_LEAF(@"SEL$C2C6B5C4")
      MERGE(@"SEL$359" >"SEL$361")
      OUTLINE_LEAF(@"SEL$BFD74306")
      MERGE(@"SEL$360" >"SEL$358")
      OUTLINE_LEAF(@"SEL$169CD701")
      ELIMINATE_JOIN(@"SEL$1880377E" "S"@"SEL$363")
      OUTLINE_LEAF(@"SEL$6B41E1E4")
      MERGE(@"SEL$354" >"SEL$373")
      MERGE(@"SEL$53FEB0C4" >"SEL$373")
      OUTLINE_LEAF(@"SEL$102B9171")
      MERGE(@"SEL$401" >"SEL$403")
      OUTLINE_LEAF(@"SEL$27147FD9")
      MERGE(@"SEL$402" >"SEL$400")
      OUTLINE_LEAF(@"SEL$F306E5BC")
      OUTER_JOIN_TO_INNER(@"SEL$F7F100ED" "V"@"SEL$391")
      OUTER_JOIN_TO_INNER(@"SEL$F7F100ED" "DRS"@"SEL$393")
      OUTER_JOIN_TO_INNER(@"SEL$F7F100ED" "SRV"@"SEL$395")
      OUTLINE_LEAF(@"SEL$51F04F9E")
      MERGE(@"SEL$67A83AA1" >"SEL$405")
      OUTLINE_LEAF(@"SEL$0FD46156")
      MERGE(@"SEL$136" >"SEL$1")
      OUTLINE(@"SEL$13")
      OUTLINE(@"SEL$11")
      OUTLINE(@"SEL$68E06B2D")
      OUTLINE(@"SEL$7")
      OUTLINE(@"SEL$5")
      OUTLINE(@"SEL$4")
      OUTLINE(@"SEL$6")
      OUTLINE(@"SEL$3")
      OUTLINE(@"SEL$A884B7E2")
      OUTLINE(@"SEL$18BE6699")
      MERGE(@"SEL$12" >"SEL$10")
      OUTLINE(@"SEL$26")
      OUTLINE(@"SEL$24")
      OUTLINE(@"SEL$23")
      OUTLINE(@"SEL$25")
      OUTLINE(@"SEL$19")
      OUTLINE(@"SEL$17")
      OUTLINE(@"SEL$16")
      OUTLINE(@"SEL$18")
      OUTLINE(@"SEL$15")
      OUTLINE(@"SEL$138")
      OUTLINE(@"SEL$096670FF")
      MERGE(@"SEL$14" >"SEL$20")
      MERGE(@"SEL$21" >"SEL$20")
      OUTLINE(@"SEL$37")
      OUTLINE(@"SEL$35")
      OUTLINE(@"SEL$34")
      OUTLINE(@"SEL$36")
      OUTLINE(@"SEL$32")
      OUTLINE(@"SEL$30")
      OUTLINE(@"SEL$29")
      OUTLINE(@"SEL$31")
      OUTLINE(@"SEL$139")
      OUTLINE(@"SEL$F87F4B43")
      MERGE(@"SEL$28" >"SEL$27")
      MERGE(@"SEL$33" >"SEL$27")
      OUTLINE(@"SEL$28551BD7")
      MERGE(@"SEL$B9383990" >"SEL$141")
      OUTLINE(@"SEL$39")
      OUTLINE(@"SEL$52")
      OUTLINE(@"SEL$50")
      OUTLINE(@"SEL$49")
      OUTLINE(@"SEL$51")
      OUTLINE(@"SEL$47")
      OUTLINE(@"SEL$45")
      OUTLINE(@"SEL$44")
      OUTLINE(@"SEL$46")
      OUTLINE(@"SEL$140")
      OUTLINE(@"SEL$8E26BC93")
      MERGE(@"SEL$43" >"SEL$42")
      MERGE(@"SEL$48" >"SEL$42")
      OUTLINE(@"SEL$404F1C3B")
      MERGE(@"SEL$FD582BC8" >"SEL$143")
      OUTLINE(@"SEL$54")
      OUTLINE(@"SEL$67")
      OUTLINE(@"SEL$65")
      OUTLINE(@"SEL$64")
      OUTLINE(@"SEL$66")
      OUTLINE(@"SEL$62")
      OUTLINE(@"SEL$60")
      OUTLINE(@"SEL$59")
      OUTLINE(@"SEL$61")
      OUTLINE(@"SEL$142")
      OUTLINE(@"SEL$C5D9AD8A")
      MERGE(@"SEL$58" >"SEL$57")
      MERGE(@"SEL$63" >"SEL$57")
      OUTLINE(@"SEL$78")
      OUTLINE(@"SEL$76")
      OUTLINE(@"SEL$75")
      OUTLINE(@"SEL$77")
      OUTLINE(@"SEL$73")
      OUTLINE(@"SEL$71")
      OUTLINE(@"SEL$70")
      OUTLINE(@"SEL$72")
      OUTLINE(@"SEL$144")
      OUTLINE(@"SEL$BE10A7DB")
      MERGE(@"SEL$69" >"SEL$68")
      MERGE(@"SEL$74" >"SEL$68")
      OUTLINE(@"SEL$89")
      OUTLINE(@"SEL$87")
      OUTLINE(@"SEL$86")
      OUTLINE(@"SEL$88")
      OUTLINE(@"SEL$84")
      OUTLINE(@"SEL$82")
      OUTLINE(@"SEL$81")
      OUTLINE(@"SEL$83")
      OUTLINE(@"SEL$146")
      OUTLINE(@"SEL$419D8FE3")
      MERGE(@"SEL$80" >"SEL$79")
      MERGE(@"SEL$85" >"SEL$79")
      OUTLINE(@"SEL$160")
      OUTLINE(@"SEL$158")
      OUTLINE(@"SEL$157")
      OUTLINE(@"SEL$159")
      OUTLINE(@"SEL$153")
      OUTLINE(@"SEL$151")
      OUTLINE(@"SEL$25F6C0FA")
      MERGE(@"SEL$149" >"SEL$6DF0CB6D")
      OUTLINE(@"SEL$3856FDC7")
      MERGE(@"SEL$152" >"SEL$150")
      OUTLINE(@"SEL$105")
      OUTLINE(@"SEL$103")
      OUTLINE(@"SEL$102")
      OUTLINE(@"SEL$104")
      OUTLINE(@"SEL$96")
      OUTLINE(@"SEL$94")
      OUTLINE(@"SEL$93")
      OUTLINE(@"SEL$95")
      OUTLINE(@"SEL$111")
      OUTLINE(@"SEL$109")
      OUTLINE(@"SEL$108")
      OUTLINE(@"SEL$110")
      OUTLINE(@"SEL$107")
      OUTLINE(@"SEL$F576CF67")
      ELIMINATE_JOIN(@"SEL$2D5B589B" "ST"@"SEL$98")
      OUTLINE(@"SEL$169")
      OUTLINE(@"SEL$167")
      OUTLINE(@"SEL$166")
      OUTLINE(@"SEL$168")
      OUTLINE(@"SEL$163")
      OUTLINE(@"SEL$164")
      OUTLINE(@"SEL$175")
      OUTLINE(@"SEL$173")
      OUTLINE(@"SEL$D857C0AC")
      OUTLINE(@"SEL$80B75D33")
      OUTLINE(@"SEL$8D164D70")
      MERGE(@"SEL$174" >"SEL$172")
      OUTLINE(@"SEL$184")
      OUTLINE(@"SEL$182")
      OUTLINE(@"SEL$181")
      OUTLINE(@"SEL$183")
      OUTLINE(@"SEL$7DF6143C")
      MERGE(@"SEL$F490752B" >"SEL$176")
      OUTLINE(@"SEL$191")
      OUTLINE(@"SEL$189")
      OUTLINE(@"SEL$8993CE0A")
      OUTLINE(@"SEL$0FFCFA0B")
      OUTLINE(@"SEL$5B5117AB")
      MERGE(@"SEL$190" >"SEL$188")
      OUTLINE(@"SEL$197")
      OUTLINE(@"SEL$195")
      OUTLINE(@"SEL$194")
      OUTLINE(@"SEL$196")
      OUTLINE(@"SEL$192")
      OUTLINE(@"SEL$193")
      OUTLINE(@"SEL$203")
      OUTLINE(@"SEL$201")
      OUTLINE(@"SEL$200")
      OUTLINE(@"SEL$202")
      OUTLINE(@"SEL$198")
      OUTLINE(@"SEL$199")
      OUTLINE(@"SEL$135")
      OUTLINE(@"SEL$133")
      OUTLINE(@"SEL$132")
      OUTLINE(@"SEL$134")
      OUTLINE(@"SEL$129")
      OUTLINE(@"SEL$127")
      OUTLINE(@"SEL$126")
      OUTLINE(@"SEL$128")
      OUTLINE(@"SEL$123")
      OUTLINE(@"SEL$121")
      OUTLINE(@"SEL$120")
      OUTLINE(@"SEL$122")
      OUTLINE(@"SEL$118")
      OUTLINE(@"SEL$116")
      OUTLINE(@"SEL$115")
      OUTLINE(@"SEL$117")
      OUTLINE(@"SEL$204")
      OUTLINE(@"SEL$6A4B05D8")
      MERGE(@"SEL$131" >"SEL$130")
      MERGE(@"SEL$CA8CE374" >"SEL$130")
      OUTLINE(@"SEL$415")
      OUTLINE(@"SEL$413")
      OUTLINE(@"SEL$FDD0F22A")
      OUTLINE(@"SEL$4C987CF0")
      UNNEST(@"SEL$EAC689DF")
      OUTLINE(@"SEL$353")
      OUTLINE(@"SEL$351")
      OUTLINE(@"SEL$350")
      OUTLINE(@"SEL$352")
      OUTLINE(@"SEL$347")
      OUTLINE(@"SEL$345")
      OUTLINE(@"SEL$344")
      OUTLINE(@"SEL$346")
      OUTLINE(@"SEL$302")
      OUTLINE(@"SEL$6A269FB7")
      MERGE(@"SEL$206" >"SEL$207")
      OUTLINE(@"SEL$303")
      OUTLINE(@"SEL$208")
      OUTLINE(@"SEL$306")
      OUTLINE(@"SEL$DC51C721")
      MERGE(@"SEL$209" >"SEL$210")
      OUTLINE(@"SEL$307")
      OUTLINE(@"SEL$211")
      OUTLINE(@"SEL$310")
      OUTLINE(@"SEL$212")
      OUTLINE(@"SEL$219")
      OUTLINE(@"SEL$217")
      OUTLINE(@"SEL$216")
      OUTLINE(@"SEL$218")
      OUTLINE(@"SEL$6137B0AF")
      ELIMINATE_JOIN(@"SEL$16DAEBA1" "D"@"SEL$220")
      OUTLINE(@"SEL$68774E43")
      ELIMINATE_JOIN(@"SEL$2021A073" "D1"@"SEL$213")
      ELIMINATE_JOIN(@"SEL$2021A073" "T9"@"SEL$214")
      OUTLINE(@"SEL$314")
      OUTLINE(@"SEL$224")
      OUTLINE(@"SEL$231")
      OUTLINE(@"SEL$229")
      OUTLINE(@"SEL$228")
      OUTLINE(@"SEL$230")
      OUTLINE(@"SEL$2A4F3908")
      MERGE(@"SEL$2FDF64D0" >"SEL$316")
      OUTLINE(@"SEL$315")
      OUTLINE(@"SEL$6E00D23F")
      MERGE(@"SEL$2C920A48" >"SEL$234")
      OUTLINE(@"SEL$61DEC2DE")
      MERGE(@"SEL$235" >"SEL$313")
      OUTLINE(@"SEL$317")
      OUTLINE(@"SEL$22CC368D")
      MERGE(@"SEL$236" >"SEL$237")
      OUTLINE(@"SEL$318")
      OUTLINE(@"SEL$238")
      OUTLINE(@"SEL$319")
      OUTLINE(@"SEL$239")
      OUTLINE(@"SEL$320")
      OUTLINE(@"SEL$240")
      OUTLINE(@"SEL$321")
      OUTLINE(@"SEL$CCCF656D")
      MERGE(@"SEL$243" >"SEL$244")
      MERGE(@"SEL$A29A9A6B" >"SEL$244")
      OUTLINE(@"SEL$322")
      OUTLINE(@"SEL$AB0185AF")
      MERGE(@"SEL$249" >"SEL$250")
      MERGE(@"SEL$BE7172B4" >"SEL$250")
      OUTLINE(@"SEL$D2574228")
      MERGE(@"SEL$02EC525C" >"SEL$323")
      OUTLINE(@"SEL$324")
      OUTLINE(@"SEL$254")
      OUTLINE(@"SEL$325")
      OUTLINE(@"SEL$E10926EF")
      MERGE(@"SEL$255" >"SEL$256")
      OUTLINE(@"SEL$330")
      OUTLINE(@"SEL$7D443A45")
      MERGE(@"SEL$684DCB1D" >"SEL$259")
      OUTLINE(@"SEL$331")
      OUTLINE(@"SEL$2BF2BB32")
      MERGE(@"SEL$260" >"SEL$261")
      OUTLINE(@"SEL$332")
      OUTLINE(@"SEL$262")
      OUTLINE(@"SEL$457DE630")
      MERGE(@"SEL$5027E41D" >"SEL$333")
      OUTLINE(@"SEL$609DDCFC")
      OUTER_JOIN_TO_INNER(@"SEL$71D841EC" "PCC"@"SEL$271")
      OUTLINE(@"SEL$336")
      OUTLINE(@"SEL$275")
      OUTLINE(@"SEL$282")
      OUTLINE(@"SEL$280")
      OUTLINE(@"SEL$279")
      OUTLINE(@"SEL$281")
      OUTLINE(@"SEL$AE143F5E")
      MERGE(@"SEL$C6BD8978" >"SEL$338")
      OUTLINE(@"SEL$ADE031A8")
      MERGE(@"SEL$B7ED7A58" >"SEL$337")
      OUTLINE(@"SEL$342")
      OUTLINE(@"SEL$340")
      OUTLINE(@"SEL$339")
      OUTLINE(@"SEL$341")
      OUTLINE(@"SEL$371")
      OUTLINE(@"SEL$369")
      OUTLINE(@"SEL$368")
      OUTLINE(@"SEL$370")
      OUTLINE(@"SEL$361")
      OUTLINE(@"SEL$359")
      OUTLINE(@"SEL$358")
      OUTLINE(@"SEL$360")
      OUTLINE(@"SEL$1880377E")
      ELIMINATE_JOIN(@"SEL$D2F95C08" "ST"@"SEL$364")
      OUTLINE(@"SEL$373")
      OUTLINE(@"SEL$354")
      OUTLINE(@"SEL$53FEB0C4")
      MERGE(@"SEL$349" >"SEL$348")
      MERGE(@"SEL$B9A6188B" >"SEL$348")
      OUTLINE(@"SEL$403")
      OUTLINE(@"SEL$401")
      OUTLINE(@"SEL$400")
      OUTLINE(@"SEL$402")
      OUTLINE(@"SEL$F7F100ED")
      PUSH_PRED(@"SEL$51F04F9E" "PCC"@"SEL$374" 2 1)
      OUTLINE(@"SEL$405")
      OUTLINE(@"SEL$67A83AA1")
      MERGE(@"SEL$374" >"SEL$404")
      OUTLINE(@"SEL$1")
      OUTLINE(@"SEL$136")
      OUTLINE(@"SEL$F4290F7D")
      MERGE(@"SEL$96C8B4DB" >"SEL$137")
      OUTLINE(@"SEL$10")
      OUTLINE(@"SEL$12")
      OUTLINE(@"SEL$20")
      OUTLINE(@"SEL$14")
      OUTLINE(@"SEL$21")
      OUTLINE(@"SEL$27")
      OUTLINE(@"SEL$28")
      OUTLINE(@"SEL$33")
      OUTLINE(@"SEL$141")
      OUTLINE(@"SEL$B9383990")
      MERGE(@"SEL$38" >"SEL$40")
      MERGE(@"SEL$41" >"SEL$40")
      OUTLINE(@"SEL$42")
      OUTLINE(@"SEL$43")
      OUTLINE(@"SEL$48")
      OUTLINE(@"SEL$143")
      OUTLINE(@"SEL$FD582BC8")
      MERGE(@"SEL$53" >"SEL$55")
      MERGE(@"SEL$56" >"SEL$55")
      OUTLINE(@"SEL$57")
      OUTLINE(@"SEL$58")
      OUTLINE(@"SEL$63")
      OUTLINE(@"SEL$68")
      OUTLINE(@"SEL$69")
      OUTLINE(@"SEL$74")
      OUTLINE(@"SEL$79")
      OUTLINE(@"SEL$80")
      OUTLINE(@"SEL$85")
      OUTLINE(@"SEL$6DF0CB6D")
      OUTER_JOIN_TO_INNER(@"SEL$BD5F85D1" "from$_subquery$_464"@"SEL$154")
      OUTLINE(@"SEL$149")
      OUTLINE(@"SEL$150")
      OUTLINE(@"SEL$152")
      OUTLINE(@"SEL$2D5B589B")
      MERGE(@"SEL$9FCE29B2" >"SEL$162")
      OUTLINE(@"SEL$A23C6FA4")
      ELIMINATE_JOIN(@"SEL$3C0ECB29" "T3"@"SEL$171")
      OUTLINE(@"SEL$172")
      OUTLINE(@"SEL$174")
      OUTLINE(@"SEL$176")
      OUTLINE(@"SEL$F490752B")
      MERGE(@"SEL$20D1D2E8" >"SEL$180")
      OUTLINE(@"SEL$241484AA")
      ELIMINATE_JOIN(@"SEL$0B74ABC2" "T2"@"SEL$187")
      OUTLINE(@"SEL$188")
      OUTLINE(@"SEL$190")
      OUTLINE(@"SEL$130")
      OUTLINE(@"SEL$131")
      OUTLINE(@"SEL$CA8CE374")
      MERGE(@"SEL$125" >"SEL$124")
      MERGE(@"SEL$1FCC0E3C" >"SEL$124")
      OUTLINE(@"SEL$EAC689DF")
      MERGE(@"SEL$414" >"SEL$412")
      OUTLINE(@"SEL$659B72BF")
      OUTLINE(@"SEL$207")
      OUTLINE(@"SEL$206")
      OUTLINE(@"SEL$210")
      OUTLINE(@"SEL$209")
      OUTLINE(@"SEL$16DAEBA1")
      MERGE(@"SEL$43111103" >"SEL$311")
      OUTLINE(@"SEL$2021A073")
      MERGE(@"SEL$A855AFED" >"SEL$312")
      OUTLINE(@"SEL$316")
      OUTLINE(@"SEL$2FDF64D0")
      MERGE(@"SEL$C9A6D0E0" >"SEL$225")
      OUTLINE(@"SEL$234")
      OUTLINE(@"SEL$2C920A48")
      MERGE(@"SEL$232" >"SEL$233")
      OUTLINE(@"SEL$313")
      OUTLINE(@"SEL$235")
      OUTLINE(@"SEL$237")
      OUTLINE(@"SEL$236")
      OUTLINE(@"SEL$244")
      OUTLINE(@"SEL$243")
      OUTLINE(@"SEL$A29A9A6B")
      MERGE(@"SEL$241" >"SEL$242")
      OUTLINE(@"SEL$250")
      OUTLINE(@"SEL$249")
      OUTLINE(@"SEL$BE7172B4")
      MERGE(@"SEL$1D01BD5E" >"SEL$248")
      OUTLINE(@"SEL$323")
      OUTLINE(@"SEL$02EC525C")
      MERGE(@"SEL$44B82241" >"SEL$253")
      OUTLINE(@"SEL$256")
      OUTLINE(@"SEL$255")
      OUTLINE(@"SEL$259")
      OUTLINE(@"SEL$684DCB1D")
      MERGE(@"SEL$257" >"SEL$258")
      OUTLINE(@"SEL$261")
      OUTLINE(@"SEL$260")
      OUTLINE(@"SEL$333")
      OUTLINE(@"SEL$5027E41D")
      MERGE(@"SEL$267" >"SEL$268")
      MERGE(@"SEL$9FCC41F1" >"SEL$268")
      OUTLINE(@"SEL$71D841EC")
      MERGE(@"SEL$52874634" >"SEL$335")
      OUTLINE(@"SEL$338")
      OUTLINE(@"SEL$C6BD8978")
      MERGE(@"SEL$79EC03D4" >"SEL$276")
      OUTLINE(@"SEL$337")
      OUTLINE(@"SEL$B7ED7A58")
      MERGE(@"SEL$FCF0E762" >"SEL$286")
      OUTLINE(@"SEL$D2F95C08")
      MERGE(@"SEL$288B3780" >"SEL$372")
      OUTLINE(@"SEL$348")
      OUTLINE(@"SEL$349")
      OUTLINE(@"SEL$B9A6188B")
      MERGE(@"SEL$343" >"SEL$205")
      MERGE(@"SEL$52D6E3A9" >"SEL$205")
      OUTLINE(@"SEL$4DF7A7FF")
      ELIMINATE_JOIN(@"SEL$01090876" "EM"@"SEL$383")
      OUTLINE(@"SEL$51F04F9E")
      MERGE(@"SEL$67A83AA1" >"SEL$405")
      OUTLINE(@"SEL$404")
      OUTLINE(@"SEL$374")
      OUTLINE(@"SEL$137")
      OUTLINE(@"SEL$96C8B4DB")
      MERGE(@"SEL$2" >"SEL$8")
      MERGE(@"SEL$9" >"SEL$8")
      OUTLINE(@"SEL$40")
      OUTLINE(@"SEL$38")
      OUTLINE(@"SEL$41")
      OUTLINE(@"SEL$55")
      OUTLINE(@"SEL$53")
      OUTLINE(@"SEL$56")
      OUTLINE(@"SEL$BD5F85D1")
      MERGE(@"SEL$1E0AAD4F" >"SEL$148")
      OUTLINE(@"SEL$162")
      OUTLINE(@"SEL$9FCE29B2")
      MERGE(@"SEL$106" >"SEL$112")
      MERGE(@"SEL$6AE10BBD" >"SEL$112")
      OUTLINE(@"SEL$3C0ECB29")
      MERGE(@"SEL$E208A177" >"SEL$170")
      OUTLINE(@"SEL$180")
      OUTLINE(@"SEL$20D1D2E8")
      MERGE(@"SEL$D603CBAF" >"SEL$179")
      OUTLINE(@"SEL$0B74ABC2")
      MERGE(@"SEL$1F3EA0DC" >"SEL$186")
      OUTLINE(@"SEL$124")
      OUTLINE(@"SEL$125")
      OUTLINE(@"SEL$1FCC0E3C")
      MERGE(@"SEL$114" >"SEL$113")
      MERGE(@"SEL$119" >"SEL$113")
      OUTLINE(@"SEL$412")
      OUTLINE(@"SEL$414")
      OUTLINE(@"SEL$F09BF2C7")
      ELIMINATE_JOIN(@"SEL$35BFE6AB" "T3"@"SEL$408")
      ELIMINATE_JOIN(@"SEL$35BFE6AB" "T2"@"SEL$409")
      OUTLINE(@"SEL$311")
      OUTLINE(@"SEL$43111103")
      MERGE(@"SEL$102F8B08" >"SEL$223")
      OUTLINE(@"SEL$312")
      OUTLINE(@"SEL$A855AFED")
      MERGE(@"SEL$95CEFA00" >"SEL$213")
      OUTLINE(@"SEL$225")
      OUTLINE(@"SEL$C9A6D0E0")
      MERGE(@"SEL$226" >"SEL$227")
      OUTLINE(@"SEL$233")
      OUTLINE(@"SEL$232")
      OUTLINE(@"SEL$242")
      OUTLINE(@"SEL$241")
      OUTLINE(@"SEL$248")
      OUTLINE(@"SEL$1D01BD5E")
      MERGE(@"SEL$B987E809" >"SEL$247")
      OUTLINE(@"SEL$253")
      OUTLINE(@"SEL$44B82241")
      MERGE(@"SEL$251" >"SEL$252")
      OUTLINE(@"SEL$258")
      OUTLINE(@"SEL$257")
      OUTLINE(@"SEL$268")
      OUTLINE(@"SEL$267")
      OUTLINE(@"SEL$9FCC41F1")
      MERGE(@"SEL$265" >"SEL$266")
      MERGE(@"SEL$55F6C155" >"SEL$266")
      OUTLINE(@"SEL$335")
      OUTLINE(@"SEL$52874634")
      MERGE(@"SEL$273" >"SEL$274")
      MERGE(@"SEL$510E2E97" >"SEL$274")
      OUTLINE(@"SEL$276")
      OUTLINE(@"SEL$79EC03D4")
      MERGE(@"SEL$277" >"SEL$278")
      OUTLINE(@"SEL$286")
      OUTLINE(@"SEL$FCF0E762")
      MERGE(@"SEL$BF7C3312" >"SEL$285")
      OUTLINE(@"SEL$372")
      OUTLINE(@"SEL$288B3780")
      MERGE(@"SEL$4766B431" >"SEL$362")
      MERGE(@"SEL$D9097786" >"SEL$362")
      OUTLINE(@"SEL$205")
      OUTLINE(@"SEL$343")
      OUTLINE(@"SEL$52D6E3A9")
      MERGE(@"SEL$CBF62EE2" >"SEL$300")
      OUTLINE(@"SEL$01090876")
      ELIMINATE_JOIN(@"SEL$AFCA664F" "PC"@"SEL$375")
      ELIMINATE_JOIN(@"SEL$AFCA664F" "PG"@"SEL$377")
      ELIMINATE_JOIN(@"SEL$AFCA664F" "MKB"@"SEL$379")
      ELIMINATE_JOIN(@"SEL$AFCA664F" "VR"@"SEL$381")
      ELIMINATE_JOIN(@"SEL$AFCA664F" "A"@"SEL$385")
      ELIMINATE_JOIN(@"SEL$AFCA664F" "S"@"SEL$387")
      ELIMINATE_JOIN(@"SEL$AFCA664F" "DS"@"SEL$389")
      ELIMINATE_JOIN(@"SEL$AFCA664F" "DUG"@"SEL$397")
      OUTLINE(@"SEL$8")
      OUTLINE(@"SEL$2")
      OUTLINE(@"SEL$9")
      OUTLINE(@"SEL$148")
      OUTLINE(@"SEL$1E0AAD4F")
      MERGE(@"SEL$F0FAD245" >"SEL$161")
      OUTLINE(@"SEL$112")
      OUTLINE(@"SEL$106")
      OUTLINE(@"SEL$6AE10BBD")
      MERGE(@"SEL$65F26A31" >"SEL$90")
      MERGE(@"SEL$91" >"SEL$90")
      OUTLINE(@"SEL$170")
      OUTLINE(@"SEL$E208A177")
      ELIMINATE_JOIN(@"SEL$171" "T1"@"SEL$171")
      ELIMINATE_JOIN(@"SEL$171" "T2"@"SEL$171")
      ELIMINATE_JOIN(@"SEL$171" "T4"@"SEL$171")
      OUTLINE(@"SEL$179")
      OUTLINE(@"SEL$D603CBAF")
      MERGE(@"SEL$177" >"SEL$178")
      OUTLINE(@"SEL$186")
      OUTLINE(@"SEL$1F3EA0DC")
      ELIMINATE_JOIN(@"SEL$187" "T4"@"SEL$187")
      ELIMINATE_JOIN(@"SEL$187" "T5"@"SEL$187")
      ELIMINATE_JOIN(@"SEL$187" "T6"@"SEL$187")
      ELIMINATE_JOIN(@"SEL$187" "T7"@"SEL$187")
      OUTLINE(@"SEL$113")
      OUTLINE(@"SEL$114")
      OUTLINE(@"SEL$119")
      OUTLINE(@"SEL$35BFE6AB")
      MERGE(@"SEL$0633BE9E" >"SEL$406")
      OUTLINE(@"SEL$223")
      OUTLINE(@"SEL$102F8B08")
      MERGE(@"SEL$6ED195B1" >"SEL$222")
      OUTLINE(@"SEL$213")
      OUTLINE(@"SEL$95CEFA00")
      MERGE(@"SEL$214" >"SEL$215")
      OUTLINE(@"SEL$227")
      OUTLINE(@"SEL$226")
      OUTLINE(@"SEL$247")
      OUTLINE(@"SEL$B987E809")
      MERGE(@"SEL$245" >"SEL$246")
      OUTLINE(@"SEL$252")
      OUTLINE(@"SEL$251")
      OUTLINE(@"SEL$266")
      OUTLINE(@"SEL$265")
      OUTLINE(@"SEL$55F6C155")
      MERGE(@"SEL$263" >"SEL$264")
      OUTLINE(@"SEL$274")
      OUTLINE(@"SEL$273")
      OUTLINE(@"SEL$510E2E97")
      MERGE(@"SEL$271" >"SEL$272")
      MERGE(@"SEL$28D2B949" >"SEL$272")
      OUTLINE(@"SEL$278")
      OUTLINE(@"SEL$277")
      OUTLINE(@"SEL$285")
      OUTLINE(@"SEL$BF7C3312")
      MERGE(@"SEL$283" >"SEL$284")
      OUTLINE(@"SEL$362")
      OUTLINE(@"SEL$4766B431")
      MERGE(@"SEL$01CE0F83" >"SEL$365")
      OUTLINE(@"SEL$D9097786")
      MERGE(@"SEL$356" >"SEL$355")
      MERGE(@"SEL$357" >"SEL$355")
      OUTLINE(@"SEL$300")
      OUTLINE(@"SEL$CBF62EE2")
      MERGE(@"SEL$298" >"SEL$299")
      MERGE(@"SEL$3A98FED6" >"SEL$299")
      OUTLINE(@"SEL$AFCA664F")
      MERGE(@"SEL$624FDCF8" >"SEL$399")
      OUTLINE(@"SEL$161")
      OUTLINE(@"SEL$F0FAD245")
      MERGE(@"SEL$155" >"SEL$154")
      OUTLINE(@"SEL$90")
      OUTLINE(@"SEL$65F26A31")
      MERGE(@"SEL$BCB735A9" >"SEL$99")
      OUTLINE(@"SEL$91")
      OUTLINE(@"SEL$171")
      OUTLINE(@"SEL$178")
      OUTLINE(@"SEL$177")
      OUTLINE(@"SEL$187")
      OUTLINE(@"SEL$406")
      OUTLINE(@"SEL$0633BE9E")
      MERGE(@"SEL$C7322B17" >"SEL$411")
      OUTLINE(@"SEL$222")
      OUTLINE(@"SEL$6ED195B1")
      MERGE(@"SEL$220" >"SEL$221")
      OUTLINE(@"SEL$215")
      OUTLINE(@"SEL$214")
      OUTLINE(@"SEL$246")
      OUTLINE(@"SEL$245")
      OUTLINE(@"SEL$264")
      OUTLINE(@"SEL$263")
      OUTLINE(@"SEL$272")
      OUTLINE(@"SEL$271")
      OUTLINE(@"SEL$28D2B949")
      MERGE(@"SEL$269" >"SEL$270")
      OUTLINE(@"SEL$284")
      OUTLINE(@"SEL$283")
      OUTLINE(@"SEL$365")
      OUTLINE(@"SEL$01CE0F83")
      MERGE(@"SEL$363" >"SEL$364")
      OUTLINE(@"SEL$355")
      OUTLINE(@"SEL$356")
      OUTLINE(@"SEL$357")
      OUTLINE(@"SEL$299")
      OUTLINE(@"SEL$298")
      OUTLINE(@"SEL$3A98FED6")
      MERGE(@"SEL$296" >"SEL$297")
      MERGE(@"SEL$EA954C6E" >"SEL$297")
      OUTLINE(@"SEL$399")
      OUTLINE(@"SEL$624FDCF8")
      MERGE(@"SEL$266DEF5D" >"SEL$B32B9E55")
      OUTLINE(@"SEL$154")
      OUTLINE(@"SEL$155")
      OUTLINE(@"SEL$99")
      OUTLINE(@"SEL$BCB735A9")
      MERGE(@"SEL$97" >"SEL$98")
      OUTLINE(@"SEL$411")
      OUTLINE(@"SEL$C7322B17")
      MERGE(@"SEL$409" >"SEL$410")
      MERGE(@"SEL$D1D519EA" >"SEL$410")
      OUTLINE(@"SEL$221")
      OUTLINE(@"SEL$220")
      OUTLINE(@"SEL$270")
      OUTLINE(@"SEL$269")
      OUTLINE(@"SEL$364")
      OUTLINE(@"SEL$363")
      OUTLINE(@"SEL$297")
      OUTLINE(@"SEL$296")
      OUTLINE(@"SEL$EA954C6E")
      MERGE(@"SEL$294" >"SEL$295")
      MERGE(@"SEL$8D19839F" >"SEL$295")
      OUTLINE(@"SEL$B32B9E55")
      MERGE(@"SEL$397" >"SEL$398")
      OUTLINE(@"SEL$266DEF5D")
      MERGE(@"SEL$B6D482DA" >"SEL$73281751")
      OUTLINE(@"SEL$98")
      OUTLINE(@"SEL$97")
      OUTLINE(@"SEL$410")
      OUTLINE(@"SEL$409")
      OUTLINE(@"SEL$D1D519EA")
      MERGE(@"SEL$407" >"SEL$408")
      OUTLINE(@"SEL$295")
      OUTLINE(@"SEL$294")
      OUTLINE(@"SEL$8D19839F")
      MERGE(@"SEL$292" >"SEL$293")
      MERGE(@"SEL$45167930" >"SEL$293")
      OUTLINE(@"SEL$398")
      OUTLINE(@"SEL$397")
      OUTLINE(@"SEL$73281751")
      MERGE(@"SEL$395" >"SEL$396")
      OUTLINE(@"SEL$B6D482DA")
      MERGE(@"SEL$43ECFA2E" >"SEL$FBD07C95")
      OUTLINE(@"SEL$408")
      OUTLINE(@"SEL$407")
      OUTLINE(@"SEL$293")
      OUTLINE(@"SEL$292")
      OUTLINE(@"SEL$45167930")
      MERGE(@"SEL$290" >"SEL$291")
      MERGE(@"SEL$58628C10" >"SEL$291")
      OUTLINE(@"SEL$396")
      OUTLINE(@"SEL$395")
      OUTLINE(@"SEL$FBD07C95")
      MERGE(@"SEL$393" >"SEL$394")
      OUTLINE(@"SEL$43ECFA2E")
      MERGE(@"SEL$6A01E28F" >"SEL$FEC32A10")
      OUTLINE(@"SEL$291")
      OUTLINE(@"SEL$290")
      OUTLINE(@"SEL$58628C10")
      MERGE(@"SEL$287" >"SEL$289")
      MERGE(@"SEL$288" >"SEL$289")
      OUTLINE(@"SEL$394")
      OUTLINE(@"SEL$393")
      OUTLINE(@"SEL$FEC32A10")
      MERGE(@"SEL$391" >"SEL$392")
      OUTLINE(@"SEL$6A01E28F")
      MERGE(@"SEL$DF7D0533" >"SEL$5239749C")
      OUTLINE(@"SEL$289")
      OUTLINE(@"SEL$287")
      OUTLINE(@"SEL$288")
      OUTLINE(@"SEL$392")
      OUTLINE(@"SEL$391")
      OUTLINE(@"SEL$5239749C")
      MERGE(@"SEL$389" >"SEL$390")
      OUTLINE(@"SEL$DF7D0533")
      MERGE(@"SEL$57018A77" >"SEL$BB55E40B")
      OUTLINE(@"SEL$390")
      OUTLINE(@"SEL$389")
      OUTLINE(@"SEL$BB55E40B")
      MERGE(@"SEL$387" >"SEL$388")
      OUTLINE(@"SEL$57018A77")
      MERGE(@"SEL$2C4774CE" >"SEL$B9A95C06")
      OUTLINE(@"SEL$388")
      OUTLINE(@"SEL$387")
      OUTLINE(@"SEL$B9A95C06")
      MERGE(@"SEL$385" >"SEL$386")
      OUTLINE(@"SEL$2C4774CE")
      MERGE(@"SEL$1CF2BDA4" >"SEL$244A394E")
      OUTLINE(@"SEL$386")
      OUTLINE(@"SEL$385")
      OUTLINE(@"SEL$244A394E")
      MERGE(@"SEL$383" >"SEL$384")
      OUTLINE(@"SEL$1CF2BDA4")
      MERGE(@"SEL$C90D5F44" >"SEL$6823446A")
      OUTLINE(@"SEL$384")
      OUTLINE(@"SEL$383")
      OUTLINE(@"SEL$6823446A")
      MERGE(@"SEL$381" >"SEL$382")
      OUTLINE(@"SEL$C90D5F44")
      MERGE(@"SEL$F590F9F1" >"SEL$C28125FF")
      OUTLINE(@"SEL$382")
      OUTLINE(@"SEL$381")
      OUTLINE(@"SEL$C28125FF")
      MERGE(@"SEL$379" >"SEL$380")
      OUTLINE(@"SEL$F590F9F1")
      MERGE(@"SEL$510A50D5" >"SEL$55E97992")
      OUTLINE(@"SEL$380")
      OUTLINE(@"SEL$379")
      OUTLINE(@"SEL$55E97992")
      MERGE(@"SEL$377" >"SEL$378")
      OUTLINE(@"SEL$510A50D5")
      MERGE(@"SEL$375" >"SEL$376")
      OUTLINE(@"SEL$378")
      OUTLINE(@"SEL$377")
      OUTLINE(@"SEL$376")
      OUTLINE(@"SEL$375")
      NO_ACCESS(@"SEL$0FD46156" "V"@"SEL$136")
      NO_ACCESS(@"SEL$51F04F9E" "from$_subquery$_064"@"SEL$404")
      NO_ACCESS(@"SEL$51F04F9E" "PCC"@"SEL$374")
      LEADING(@"SEL$51F04F9E" "from$_subquery$_064"@"SEL$404" "PCC"@"SEL$374")
      USE_NL(@"SEL$51F04F9E" "PCC"@"SEL$374")
      INDEX_RS_ASC(@"SEL$6B41E1E4" "PC"@"SEL$343" ("D_PROF_CARD"."ID"))
      INDEX_RS_ASC(@"SEL$6B41E1E4" "PCT"@"SEL$349" ("D_PROF_CARD_TYPES"."ID"))
      INDEX_RS_ASC(@"SEL$6B41E1E4" "PCS"@"SEL$287" ("D_PROF_CARD_SERVICES"."PID"))
      INDEX_RS_ASC(@"SEL$6B41E1E4" "SERV"@"SEL$287" ("D_SERVICES"."ID"))
      INDEX_RS_ASC(@"SEL$6B41E1E4" "PCDIRS"@"SEL$288" ("D_PROF_CARD_DIR_SERVS"."PID"))
      INDEX_RS_ASC(@"SEL$6B41E1E4" "DIRS"@"SEL$290" ("D_DIRECTION_SERVICES"."ID"))
      INDEX_RS_ASC(@"SEL$6B41E1E4" "EMP"@"SEL$292" ("D_EMPLOYERS"."ID"))
      INDEX_RS_ASC(@"SEL$6B41E1E4" "V"@"SEL$296" ("D_VISITS"."PID"))
      INDEX_RS_ASC(@"SEL$6B41E1E4" "DIR"@"SEL$298" ("D_DIRECTIONS"."ID"))
      INDEX_RS_ASC(@"SEL$6B41E1E4" "EMPA"@"SEL$294" ("D_AGENTS"."ID"))
      NO_ACCESS(@"SEL$6B41E1E4" "EX"@"SEL$354")
      LEADING(@"SEL$6B41E1E4" "PC"@"SEL$343" "PCT"@"SEL$349" "PCS"@"SEL$287" "SERV"@"SEL$287" "PCDIRS"@"SEL$288" "DIRS"@"SEL$290" "EMP"@"SEL$292" "V"@"SEL$296" "DIR"@"SEL$298" 
              "EMPA"@"SEL$294" "EX"@"SEL$354")
      USE_NL(@"SEL$6B41E1E4" "PCT"@"SEL$349")
      USE_NL(@"SEL$6B41E1E4" "PCS"@"SEL$287")
      USE_NL(@"SEL$6B41E1E4" "SERV"@"SEL$287")
      USE_NL(@"SEL$6B41E1E4" "PCDIRS"@"SEL$288")
      USE_NL(@"SEL$6B41E1E4" "DIRS"@"SEL$290")
      USE_NL(@"SEL$6B41E1E4" "EMP"@"SEL$292")
      USE_NL(@"SEL$6B41E1E4" "V"@"SEL$296")
      USE_NL(@"SEL$6B41E1E4" "DIR"@"SEL$298")
      USE_NL(@"SEL$6B41E1E4" "EMPA"@"SEL$294")
      USE_HASH(@"SEL$6B41E1E4" "EX"@"SEL$354")
      ORDER_SUBQ(@"SEL$6B41E1E4" "SEL$906D331B" "SEL$827DFB84" "SEL$29A4ECCD")
      PQ_FILTER(@"SEL$6B41E1E4" SERIAL)
      INDEX(@"SEL$F306E5BC" "SRV"@"SEL$395" ("D_SERVICES"."SE_CODE" "D_SERVICES"."SE_TYPE" "D_SERVICES"."ID"))
      INDEX_RS_ASC(@"SEL$F306E5BC" "PCC"@"SEL$376" ("D_PROF_CARD_CONCLUSIONS"."PID"))
      INDEX_RS_ASC(@"SEL$F306E5BC" "V"@"SEL$391" ("D_VISITS"."ID"))
      INDEX(@"SEL$F306E5BC" "DRS"@"SEL$393" ("D_DIRECTION_SERVICES"."ID"))
      LEADING(@"SEL$F306E5BC" "SRV"@"SEL$395" "PCC"@"SEL$376" "V"@"SEL$391" "DRS"@"SEL$393")
      USE_MERGE_CARTESIAN(@"SEL$F306E5BC" "PCC"@"SEL$376")
      USE_NL(@"SEL$F306E5BC" "V"@"SEL$391")
      USE_NL(@"SEL$F306E5BC" "DRS"@"SEL$393")
      NLJ_BATCHING(@"SEL$F306E5BC" "DRS"@"SEL$393")
      PQ_FILTER(@"SEL$F306E5BC" SERIAL)
      INDEX(@"SEL$27147FD9" "UP"@"SEL$402" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$27147FD9" SERIAL)
      INDEX(@"SEL$102B9171" "US"@"SEL$401" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$102B9171" "UR"@"SEL$401" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$102B9171" "US"@"SEL$401" "UR"@"SEL$401")
      USE_NL(@"SEL$102B9171" "UR"@"SEL$401")
      INDEX_RS_ASC(@"SEL$169CD701" "D_EX_SYSTEM_VALUES"@"SEL$356" ("D_EX_SYSTEM_VALUES"."UNIT" "D_EX_SYSTEM_VALUES"."VAL_CODE" "D_EX_SYSTEM_VALUES"."NUM_VALUE"))
      NUM_INDEX_KEYS(@"SEL$169CD701" "D_EX_SYSTEM_VALUES"@"SEL$356" "I_D_EX_SYSTEM_VALUES_UNITN" 1)
      INDEX_RS_ASC(@"SEL$169CD701" "T"@"SEL$357" ("D_PROF_CARD_DIR_SERVS"."DIR_SERV"))
      INDEX(@"SEL$169CD701" "PCS"@"SEL$363" ("D_PROF_CARD_SERVICES"."ID"))
      LEADING(@"SEL$169CD701" "D_EX_SYSTEM_VALUES"@"SEL$356" "T"@"SEL$357" "PCS"@"SEL$363")
      USE_NL(@"SEL$169CD701" "T"@"SEL$357")
      USE_NL(@"SEL$169CD701" "PCS"@"SEL$363")
      NLJ_BATCHING(@"SEL$169CD701" "PCS"@"SEL$363")
      ORDER_SUBQ(@"SEL$169CD701" "SEL$23FC1809" "SEL$BFD74306")
      PQ_FILTER(@"SEL$169CD701" SERIAL)
      INDEX(@"SEL$BFD74306" "UP"@"SEL$360" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$BFD74306" SERIAL)
      INDEX(@"SEL$23FC1809" "UP"@"SEL$370" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$23FC1809" SERIAL)
      INDEX(@"SEL$9CC480F5" "US"@"SEL$369" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$9CC480F5" "UR"@"SEL$369" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$9CC480F5" "US"@"SEL$369" "UR"@"SEL$369")
      USE_NL(@"SEL$9CC480F5" "UR"@"SEL$369")
      INDEX(@"SEL$C2C6B5C4" "US"@"SEL$359" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$C2C6B5C4" "UR"@"SEL$359" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$C2C6B5C4" "US"@"SEL$359" "UR"@"SEL$359")
      USE_NL(@"SEL$C2C6B5C4" "UR"@"SEL$359")
      INDEX(@"SEL$29A4ECCD" "UP"@"SEL$341" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$29A4ECCD" SERIAL)
      INDEX_RS_ASC(@"SEL$B0D01609" "ODIR"@"SEL$283" ("D_OUTER_DIRECTIONS"."REPRESENT_DIRECTION"))
      INDEX_RS_ASC(@"SEL$B0D01609" "OD"@"SEL$284" ("D_DIRECTIONS"."OUTER_DIRECTION"))
      INDEX_RS_ASC(@"SEL$B0D01609" "ODS"@"SEL$285" ("D_DIRECTION_SERVICES"."PID" "D_DIRECTION_SERVICES"."ID" "D_DIRECTION_SERVICES"."SERVICE"))
      INDEX(@"SEL$B0D01609" "S"@"SEL$286" ("D_SERVICES"."ID"))
      LEADING(@"SEL$B0D01609" "ODIR"@"SEL$283" "OD"@"SEL$284" "ODS"@"SEL$285" "S"@"SEL$286")
      USE_NL(@"SEL$B0D01609" "OD"@"SEL$284")
      USE_NL(@"SEL$B0D01609" "ODS"@"SEL$285")
      USE_NL(@"SEL$B0D01609" "S"@"SEL$286")
      NLJ_BATCHING(@"SEL$B0D01609" "S"@"SEL$286")
      PQ_FILTER(@"SEL$B0D01609" SERIAL)
      INDEX_RS_ASC(@"SEL$4A8506B4" "PC"@"SEL$275" ("D_PROF_CARD"."ID"))
      INDEX_RS_ASC(@"SEL$4A8506B4" "PCT"@"SEL$275" ("D_PROF_CARD_TYPES"."ID"))
      LEADING(@"SEL$4A8506B4" "PC"@"SEL$275" "PCT"@"SEL$275")
      USE_NL(@"SEL$4A8506B4" "PCT"@"SEL$275")
      INDEX_RS_ASC(@"SEL$09C8BA82" "PC"@"SEL$270" ("D_PROF_CARD"."ID"))
      INDEX_RS_ASC(@"SEL$09C8BA82" "PCT"@"SEL$269" ("D_PROF_CARD_TYPES"."ID"))
      INDEX_RS_ASC(@"SEL$09C8BA82" "PCC"@"SEL$271" ("D_PROF_CARD_CONCLUSIONS"."VISIT"))
      LEADING(@"SEL$09C8BA82" "PC"@"SEL$270" "PCT"@"SEL$269" "PCC"@"SEL$271")
      USE_NL(@"SEL$09C8BA82" "PCT"@"SEL$269")
      USE_NL(@"SEL$09C8BA82" "PCC"@"SEL$271")
      INDEX_RS_ASC(@"SEL$334" "OTR"@"SEL$334" ("D_PC_SERV_OTHER_RESULTS"."PID"))
      INDEX_RS_ASC(@"SEL$B560D28C" "PC"@"SEL$264" ("D_PROF_CARD"."ID"))
      INDEX_RS_ASC(@"SEL$B560D28C" "PCT"@"SEL$263" ("D_PROF_CARD_TYPES"."ID"))
      INDEX_RS_ASC(@"SEL$B560D28C" "PCC"@"SEL$265" ("D_PROF_CARD_CONCLUSIONS"."VISIT"))
      INDEX_RS_ASC(@"SEL$B560D28C" "PCL"@"SEL$267" ("D_PC_CONCLUSIONS"."ID"))
      LEADING(@"SEL$B560D28C" "PC"@"SEL$264" "PCT"@"SEL$263" "PCC"@"SEL$265" "PCL"@"SEL$267")
      USE_NL(@"SEL$B560D28C" "PCT"@"SEL$263")
      USE_NL(@"SEL$B560D28C" "PCC"@"SEL$265")
      USE_NL(@"SEL$B560D28C" "PCL"@"SEL$267")
      INDEX_RS_ASC(@"SEL$DF1510EF" "MS"@"SEL$262" ("D_PROF_CARD_MODELS_SR"."SERVICE"))
      INDEX(@"SEL$DF1510EF" "PC"@"SEL$262" ("D_PROF_CARD"."PROF_CARD_MODEL"))
      LEADING(@"SEL$DF1510EF" "MS"@"SEL$262" "PC"@"SEL$262")
      USE_NL(@"SEL$DF1510EF" "PC"@"SEL$262")
      INDEX_RS_ASC(@"SEL$7057249E" "DS1"@"SEL$261" ("D_DIRECTION_SERVICES"."HID"))
      INDEX(@"SEL$7057249E" "PDS1"@"SEL$260" ("D_PROF_CARD_DIR_SERVS"."DIR_SERV"))
      INDEX_RS_ASC(@"SEL$7057249E" "PS1"@"SEL$260" ("D_PROF_CARD_SERVICES"."PID"))
      LEADING(@"SEL$7057249E" "DS1"@"SEL$261" "PDS1"@"SEL$260" "PS1"@"SEL$260")
      USE_NL(@"SEL$7057249E" "PDS1"@"SEL$260")
      NLJ_BATCHING(@"SEL$7057249E" "PDS1"@"SEL$260")
      USE_HASH(@"SEL$7057249E" "PS1"@"SEL$260")
      INDEX_RS_ASC(@"SEL$0B0BE1F3" "DS"@"SEL$257" ("D_DIRECTION_SERVICES"."HID"))
      INDEX_RS_ASC(@"SEL$0B0BE1F3" "DL"@"SEL$257" ("D_LABMED_DIRECTION_LINE"."DIR_SERV" "D_LABMED_DIRECTION_LINE"."STATUS"))
      INDEX_RS_ASC(@"SEL$0B0BE1F3" "SD"@"SEL$258" ("D_LBM_SAMPLE_DIRLINE"."DIRLINE"))
      INDEX(@"SEL$0B0BE1F3" "S"@"SEL$259" ("D_LABMED_SAMPLES"."ID"))
      LEADING(@"SEL$0B0BE1F3" "DS"@"SEL$257" "DL"@"SEL$257" "SD"@"SEL$258" "S"@"SEL$259")
      USE_NL(@"SEL$0B0BE1F3" "DL"@"SEL$257")
      USE_NL(@"SEL$0B0BE1F3" "SD"@"SEL$258")
      USE_NL(@"SEL$0B0BE1F3" "S"@"SEL$259")
      NLJ_BATCHING(@"SEL$0B0BE1F3" "S"@"SEL$259")
      INDEX_RS_ASC(@"SEL$329" "DEP"@"SEL$329" ("D_DEPS"."ID"))
      INDEX_RS_ASC(@"SEL$328" "CAB"@"SEL$328" ("D_CABLAB"."ID"))
      INDEX_RS_ASC(@"SEL$327" "DEP"@"SEL$327" ("D_DEPS"."ID"))
      INDEX_RS_ASC(@"SEL$326" "CAB"@"SEL$326" ("D_CABLAB"."ID"))
      INDEX_RS_ASC(@"SEL$885A6771" "PC"@"SEL$255" ("D_PROF_CARD"."ID"))
      INDEX_SS(@"SEL$885A6771" "DSDS"@"SEL$256" ("D_DISPS_SERVICES"."VERSION" "D_DISPS_SERVICES"."SERVICE" "D_DISPS_SERVICES"."DISP_SERVICE"))
      INDEX(@"SEL$885A6771" "DDS"@"SEL$255" ("D_DISP_SERVICES"."ID"))
      LEADING(@"SEL$885A6771" "PC"@"SEL$255" "DSDS"@"SEL$256" "DDS"@"SEL$255")
      USE_NL(@"SEL$885A6771" "DSDS"@"SEL$256")
      USE_NL(@"SEL$885A6771" "DDS"@"SEL$255")
      NLJ_BATCHING(@"SEL$885A6771" "DDS"@"SEL$255")
      INDEX_RS_ASC(@"SEL$2AEBFB23" "RE"@"SEL$254" ("D_EMPLOYERS"."ID"))
      INDEX_RS_ASC(@"SEL$2AEBFB23" "RA"@"SEL$254" ("D_AGENTS"."ID"))
      LEADING(@"SEL$2AEBFB23" "RE"@"SEL$254" "RA"@"SEL$254")
      USE_NL(@"SEL$2AEBFB23" "RA"@"SEL$254")
      INDEX_RS_ASC(@"SEL$15D00A3E" "V"@"SEL$253" ("D_VISITS"."ID"))
      INDEX(@"SEL$15D00A3E" "PCDS"@"SEL$251" ("D_PROF_CARD_DIR_SERVS"."DIR_SERV" "D_PROF_CARD_DIR_SERVS"."PID"))
      INDEX(@"SEL$15D00A3E" "TT"@"SEL$251" ("D_PROF_CARD_SERVICES"."ID"))
      LEADING(@"SEL$15D00A3E" "V"@"SEL$253" "PCDS"@"SEL$251" "TT"@"SEL$251")
      USE_NL(@"SEL$15D00A3E" "PCDS"@"SEL$251")
      USE_NL(@"SEL$15D00A3E" "TT"@"SEL$251")
      NLJ_BATCHING(@"SEL$15D00A3E" "TT"@"SEL$251")
      INDEX_RS_ASC(@"SEL$4E5B4514" "J1"@"SEL$245" ("D_LABMED_PATJOUR"."DIRECTION_SERVICE"))
      INDEX_RS_ASC(@"SEL$4E5B4514" "J2"@"SEL$245" ("D_LABMED_RSRCH_JOUR"."PATJOUR"))
      INDEX_RS_ASC(@"SEL$4E5B4514" "J3"@"SEL$246" ("D_LABMED_RSRCH_JOURSP"."PID"))
      INDEX_RS_ASC(@"SEL$4E5B4514" "J4"@"SEL$247" ("D_LABMED_RESEARCH_RES"."ID"))
      INDEX_RS_ASC(@"SEL$4E5B4514" "DL"@"SEL$249" ("D_LABMED_DIRECTION_LINE"."ID"))
      INDEX(@"SEL$4E5B4514" "J5"@"SEL$248" ("D_MEASURES"."ID"))
      LEADING(@"SEL$4E5B4514" "J1"@"SEL$245" "J2"@"SEL$245" "J3"@"SEL$246" "J4"@"SEL$247" "DL"@"SEL$249" "J5"@"SEL$248")
      USE_NL(@"SEL$4E5B4514" "J2"@"SEL$245")
      USE_NL(@"SEL$4E5B4514" "J3"@"SEL$246")
      USE_NL(@"SEL$4E5B4514" "J4"@"SEL$247")
      USE_NL(@"SEL$4E5B4514" "DL"@"SEL$249")
      USE_NL(@"SEL$4E5B4514" "J5"@"SEL$248")
      NLJ_BATCHING(@"SEL$4E5B4514" "J5"@"SEL$248")
      INDEX_RS_ASC(@"SEL$AEAAFD30" "J1"@"SEL$241" ("D_LABMED_PATJOUR"."DIRECTION_SERVICE"))
      INDEX_RS_ASC(@"SEL$AEAAFD30" "J2"@"SEL$241" ("D_LABMED_RSRCH_JOUR"."PATJOUR"))
      INDEX_RS_ASC(@"SEL$AEAAFD30" "J3"@"SEL$242" ("D_LABMED_RSRCH_JOURSP"."PID"))
      INDEX_RS_ASC(@"SEL$AEAAFD30" "DL"@"SEL$243" ("D_LABMED_DIRECTION_LINE"."ID"))
      LEADING(@"SEL$AEAAFD30" "J1"@"SEL$241" "J2"@"SEL$241" "J3"@"SEL$242" "DL"@"SEL$243")
      USE_NL(@"SEL$AEAAFD30" "J2"@"SEL$241")
      USE_NL(@"SEL$AEAAFD30" "J3"@"SEL$242")
      USE_NL(@"SEL$AEAAFD30" "DL"@"SEL$243")
      INDEX_RS_ASC(@"SEL$3E0B8B1B" "K1"@"SEL$240" ("D_LABMED_PATJOUR"."DIRECTION_SERVICE"))
      INDEX(@"SEL$3E0B8B1B" "K2"@"SEL$240" ("D_LABMED_RSRCH_JOUR"."PATJOUR"))
      LEADING(@"SEL$3E0B8B1B" "K1"@"SEL$240" "K2"@"SEL$240")
      USE_NL(@"SEL$3E0B8B1B" "K2"@"SEL$240")
      NLJ_BATCHING(@"SEL$3E0B8B1B" "K2"@"SEL$240")
      INDEX_RS_ASC(@"SEL$7C70D976" "VD"@"SEL$239" ("D_VIS_DIAGNOSISES"."PID" "D_VIS_DIAGNOSISES"."MKB"))
      INDEX(@"SEL$7C70D976" "MVD"@"SEL$239" ("D_MKB10"."ID"))
      LEADING(@"SEL$7C70D976" "VD"@"SEL$239" "MVD"@"SEL$239")
      USE_NL(@"SEL$7C70D976" "MVD"@"SEL$239")
      NLJ_BATCHING(@"SEL$7C70D976" "MVD"@"SEL$239")
      INDEX_RS_ASC(@"SEL$0D40BBC1" "ORES"@"SEL$238" ("D_PC_SERV_OTHER_RESULTS"."PID"))
      INDEX(@"SEL$0D40BBC1" "OV"@"SEL$238" ("D_AMB_TALON_OTHER_VISITS"."ID"))
      LEADING(@"SEL$0D40BBC1" "ORES"@"SEL$238" "OV"@"SEL$238")
      USE_NL(@"SEL$0D40BBC1" "OV"@"SEL$238")
      NLJ_BATCHING(@"SEL$0D40BBC1" "OV"@"SEL$238")
      INDEX_RS_ASC(@"SEL$F2A4B3EE" "DD"@"SEL$237" ("D_DIRECTIONS"."ID"))
      INDEX_RS_ASC(@"SEL$F2A4B3EE" "L"@"SEL$236" ("D_LPUDICT"."ID"))
      LEADING(@"SEL$F2A4B3EE" "DD"@"SEL$237" "L"@"SEL$236")
      USE_NL(@"SEL$F2A4B3EE" "L"@"SEL$236")
      INDEX_RS_ASC(@"SEL$838BDF1F" "ODIR"@"SEL$235" ("D_OUTER_DIRECTIONS"."REPRESENT_DIRECTION"))
      INDEX_RS_ASC(@"SEL$306633FD" "T"@"SEL$214" ("D_OUT_DIR_SERVS"."PID"))
      INDEX_RS_ASC(@"SEL$306633FD" "ODIR"@"SEL$220" ("D_OUTER_DIRECTIONS"."REPRESENT_DIRECTION"))
      INDEX_RS_ASC(@"SEL$306633FD" "OD"@"SEL$221" ("D_DIRECTIONS"."OUTER_DIRECTION"))
      INDEX_RS_ASC(@"SEL$306633FD" "ODS"@"SEL$222" ("D_DIRECTION_SERVICES"."SERV_STATUS" "D_DIRECTION_SERVICES"."PID"))
      INDEX(@"SEL$306633FD" "S"@"SEL$223" ("D_SERVICES"."SE_CODE" "D_SERVICES"."SE_TYPE" "D_SERVICES"."ID"))
      LEADING(@"SEL$306633FD" "T"@"SEL$214" "ODIR"@"SEL$220" "OD"@"SEL$221" "ODS"@"SEL$222" "S"@"SEL$223")
      USE_MERGE_CARTESIAN(@"SEL$306633FD" "ODIR"@"SEL$220")
      USE_NL(@"SEL$306633FD" "OD"@"SEL$221")
      USE_NL(@"SEL$306633FD" "ODS"@"SEL$222")
      USE_NL(@"SEL$306633FD" "S"@"SEL$223")
      PQ_FILTER(@"SEL$306633FD" SERIAL)
      INDEX_RS_ASC(@"SEL$F7E4EAE9" "ORES"@"SEL$212" ("D_PC_SERV_OTHER_RESULTS"."PID"))
      INDEX(@"SEL$F7E4EAE9" "OV"@"SEL$212" ("D_AMB_TALON_OTHER_VISITS"."ID"))
      LEADING(@"SEL$F7E4EAE9" "ORES"@"SEL$212" "OV"@"SEL$212")
      USE_NL(@"SEL$F7E4EAE9" "OV"@"SEL$212")
      NLJ_BATCHING(@"SEL$F7E4EAE9" "OV"@"SEL$212")
      INDEX_RS_ASC(@"SEL$309" "CL"@"SEL$309" ("D_CABLAB"."ID"))
      INDEX(@"SEL$308" "LDL"@"SEL$308" ("D_LABMED_DIRECTION_LINE"."DIR_SERV"))
      INDEX_RS_ASC(@"SEL$B03545E5" "VD"@"SEL$211" ("D_VIS_DIAGNOSISES"."PID" "D_VIS_DIAGNOSISES"."MKB"))
      INDEX(@"SEL$B03545E5" "MVD"@"SEL$211" ("D_MKB10"."ID"))
      LEADING(@"SEL$B03545E5" "VD"@"SEL$211" "MVD"@"SEL$211")
      USE_NL(@"SEL$B03545E5" "MVD"@"SEL$211")
      NLJ_BATCHING(@"SEL$B03545E5" "MVD"@"SEL$211")
      INDEX(@"SEL$CE5A1A76" "VF"@"SEL$209" ("D_VISIT_FIELDS"."PID" "D_VISIT_FIELDS"."TEMPLATE_FIELD" "D_VISIT_FIELDS"."ADD_DIR_VALUE" "D_VISIT_FIELDS"."EXTRA_DICT_VALUE"))
      INDEX(@"SEL$CE5A1A76" "VTF"@"SEL$209" ("D_VISIT_TAB_FIELDS"."ID" "D_VISIT_TAB_FIELDS"."F_CODE"))
      INDEX(@"SEL$CE5A1A76" "ADV"@"SEL$210" ("D_ADD_DIR_VALUES"."ID"))
      LEADING(@"SEL$CE5A1A76" "VF"@"SEL$209" "VTF"@"SEL$209" "ADV"@"SEL$210")
      USE_NL(@"SEL$CE5A1A76" "VTF"@"SEL$209")
      USE_NL(@"SEL$CE5A1A76" "ADV"@"SEL$210")
      NLJ_BATCHING(@"SEL$CE5A1A76" "ADV"@"SEL$210")
      INDEX_RS_ASC(@"SEL$305" "CL"@"SEL$305" ("D_CABLAB"."ID"))
      INDEX_RS_ASC(@"SEL$304" "CL"@"SEL$304" ("D_CABLAB"."ID"))
      INDEX(@"SEL$00D15238" "LDL"@"SEL$208" ("D_LABMED_DIRECTION_LINE"."DIR_SERV" "D_LABMED_DIRECTION_LINE"."STATUS"))
      INDEX(@"SEL$00D15238" "LDS"@"SEL$208" ("D_LBM_DIRLINE_STATUSES"."ID"))
      LEADING(@"SEL$00D15238" "LDL"@"SEL$208" "LDS"@"SEL$208")
      USE_NL(@"SEL$00D15238" "LDS"@"SEL$208")
      NLJ_BATCHING(@"SEL$00D15238" "LDS"@"SEL$208")
      INDEX_RS_ASC(@"SEL$5D7B7D17" "DS"@"SEL$207" ("D_DIRECTION_SERVICES"."HID"))
      INDEX(@"SEL$5D7B7D17" "LDL"@"SEL$206" ("D_LABMED_DIRECTION_LINE"."DIR_SERV" "D_LABMED_DIRECTION_LINE"."STATUS"))
      INDEX_JOIN(@"SEL$5D7B7D17" "LDS"@"SEL$206" ("D_LBM_DIRLINE_STATUSES"."ID") ("D_LBM_DIRLINE_STATUSES"."ST_NAME"))
      LEADING(@"SEL$5D7B7D17" "DS"@"SEL$207" "LDL"@"SEL$206" "LDS"@"SEL$206")
      USE_NL(@"SEL$5D7B7D17" "LDL"@"SEL$206")
      USE_HASH(@"SEL$5D7B7D17" "LDS"@"SEL$206")
      INDEX_RS_ASC(@"SEL$301" "T2"@"SEL$301" ("D_SERVTYPES"."ID"))
      INDEX(@"SEL$827DFB84" "UP"@"SEL$346" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$827DFB84" SERIAL)
      INDEX(@"SEL$906D331B" "UP"@"SEL$352" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."VERSION" "D_URPRIVS"."USERNAME" "D_URPRIVS"."ROLEID"))
      PQ_FILTER(@"SEL$906D331B" SERIAL)
      INDEX(@"SEL$97238E9E" "US"@"SEL$351" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$97238E9E" "UR"@"SEL$351" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$97238E9E" "US"@"SEL$351" "UR"@"SEL$351")
      USE_NL(@"SEL$97238E9E" "UR"@"SEL$351")
      INDEX(@"SEL$518ABD35" "US"@"SEL$345" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$518ABD35" "UR"@"SEL$345" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$518ABD35" "US"@"SEL$345" "UR"@"SEL$345")
      USE_NL(@"SEL$518ABD35" "UR"@"SEL$345")
      INDEX(@"SEL$1952D768" "UP"@"SEL$218" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$1952D768" SERIAL)
      INDEX(@"SEL$A426E5F1" "US"@"SEL$217" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$A426E5F1" "UR"@"SEL$217" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$A426E5F1" "US"@"SEL$217" "UR"@"SEL$217")
      USE_NL(@"SEL$A426E5F1" "UR"@"SEL$217")
      INDEX_RS_ASC(@"SEL$7799FE8A" "OD"@"SEL$232" ("D_DIRECTIONS"."OUTER_DIRECTION"))
      INDEX_RS_ASC(@"SEL$7799FE8A" "ODS"@"SEL$232" ("D_DIRECTION_SERVICES"."SERV_STATUS" "D_DIRECTION_SERVICES"."PID"))
      INDEX_RS_ASC(@"SEL$7799FE8A" "V"@"SEL$233" ("D_VISITS"."PID"))
      INDEX(@"SEL$7799FE8A" "S"@"SEL$234" ("D_SERVICES"."ID"))
      LEADING(@"SEL$7799FE8A" "OD"@"SEL$232" "ODS"@"SEL$232" "V"@"SEL$233" "S"@"SEL$234")
      USE_NL(@"SEL$7799FE8A" "ODS"@"SEL$232")
      USE_NL(@"SEL$7799FE8A" "V"@"SEL$233")
      USE_NL(@"SEL$7799FE8A" "S"@"SEL$234")
      NLJ_BATCHING(@"SEL$7799FE8A" "S"@"SEL$234")
      PQ_FILTER(@"SEL$7799FE8A" SERIAL)
      INDEX_RS_ASC(@"SEL$7FF20CC2" "L"@"SEL$224" ("D_LPU"."ID"))
      INDEX_RS_ASC(@"SEL$7FF20CC2" "LD"@"SEL$224" ("D_LPUDICT"."ID"))
      LEADING(@"SEL$7FF20CC2" "L"@"SEL$224" "LD"@"SEL$224")
      USE_NL(@"SEL$7FF20CC2" "LD"@"SEL$224")
      INDEX_RS_ASC(@"SEL$72C161FC" "T"@"SEL$226" ("D_OUT_DIR_SERVS"."PID"))
      PQ_FILTER(@"SEL$72C161FC" SERIAL)
      INDEX(@"SEL$46A3E3EC" "UP"@"SEL$230" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$46A3E3EC" SERIAL)
      INDEX(@"SEL$7B3F1794" "US"@"SEL$229" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$7B3F1794" "UR"@"SEL$229" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$7B3F1794" "US"@"SEL$229" "UR"@"SEL$229")
      USE_NL(@"SEL$7B3F1794" "UR"@"SEL$229")
      INDEX_RS_ASC(@"SEL$8CEE2984" "T"@"SEL$277" ("D_OUT_DIR_SERVS"."PID"))
      PQ_FILTER(@"SEL$8CEE2984" SERIAL)
      INDEX(@"SEL$BA42F60A" "UP"@"SEL$281" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$BA42F60A" SERIAL)
      INDEX(@"SEL$1797E9EC" "US"@"SEL$280" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$1797E9EC" "UR"@"SEL$280" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$1797E9EC" "US"@"SEL$280" "UR"@"SEL$280")
      USE_NL(@"SEL$1797E9EC" "UR"@"SEL$280")
      INDEX(@"SEL$F9CD0431" "US"@"SEL$340" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$F9CD0431" "UR"@"SEL$340" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$F9CD0431" "US"@"SEL$340" "UR"@"SEL$340")
      USE_NL(@"SEL$F9CD0431" "UR"@"SEL$340")
      INDEX_RS_ASC(@"SEL$CD5BF647" "T"@"SEL$407" ("D_SERVICES_STR"."PID" "D_SERVICES_STR"."SERVICE"))
      NO_ACCESS(@"SEL$CD5BF647" "VW_SQ_1"@"SEL$659B72BF")
      LEADING(@"SEL$CD5BF647" "T"@"SEL$407" "VW_SQ_1"@"SEL$659B72BF")
      USE_NL(@"SEL$CD5BF647" "VW_SQ_1"@"SEL$659B72BF")
      INDEX(@"SEL$BC875581" "UP"@"SEL$414" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$BC875581" SERIAL)
      INDEX(@"SEL$B75A2FFF" "US"@"SEL$413" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$B75A2FFF" "UR"@"SEL$413" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$B75A2FFF" "US"@"SEL$413" "UR"@"SEL$413")
      USE_NL(@"SEL$B75A2FFF" "UR"@"SEL$413")
      INDEX_RS_ASC(@"SEL$CBB9BA06" "T"@"SEL$131" ("D_DIRECTION_SERVICES"."ID"))
      BITMAP_TREE(@"SEL$CBB9BA06" "T"@"SEL$125" OR(1 1 ("D_VISITS"."PID") 2 ("D_VISITS"."PID")))
      INDEX_RS_ASC(@"SEL$CBB9BA06" "T"@"SEL$119" ("D_AMB_TALON_VISITS"."VISIT"))
      INDEX(@"SEL$CBB9BA06" "AT"@"SEL$114" ("D_AMB_TALONS"."ID" "D_AMB_TALONS"."CID"))
      LEADING(@"SEL$CBB9BA06" "T"@"SEL$131" "T"@"SEL$125" "T"@"SEL$119" "AT"@"SEL$114")
      USE_NL(@"SEL$CBB9BA06" "T"@"SEL$125")
      USE_NL(@"SEL$CBB9BA06" "T"@"SEL$119")
      USE_NL(@"SEL$CBB9BA06" "AT"@"SEL$114")
      PUSH_SUBQ(@"SEL$0CAA258E")
      ORDER_SUBQ(@"SEL$CBB9BA06" "SEL$CFD2D090" "SEL$51F828FA" "SEL$A5BAA20F")
      PQ_FILTER(@"SEL$CBB9BA06" SERIAL)
      INDEX_RS_ASC(@"SEL$E12F393B" "T"@"SEL$199" ("D_DISEASECASES"."ID"))
      PQ_FILTER(@"SEL$E12F393B" SERIAL)
      INDEX_RS_ASC(@"SEL$4B7AE55C" "PC"@"SEL$193" ("D_PROF_CARD"."ID"))
      PQ_FILTER(@"SEL$4B7AE55C" SERIAL)
      BITMAP_TREE(@"SEL$AD8C7765" "T"@"SEL$187" AND(("D_PROF_CARD_MODELS_SR"."PID") ("D_PROF_CARD_MODELS_SR"."SERVICE")))
      NO_ACCESS(@"SEL$AD8C7765" "VW_SQ_4"@"SEL$0FFCFA0B")
      LEADING(@"SEL$AD8C7765" "T"@"SEL$187" "VW_SQ_4"@"SEL$0FFCFA0B")
      USE_NL(@"SEL$AD8C7765" "VW_SQ_4"@"SEL$0FFCFA0B")
      INDEX(@"SEL$8DEB7E6D" "S"@"SEL$179" ("D_SERVICES"."SE_CODE" "D_SERVICES"."SE_TYPE" "D_SERVICES"."ID"))
      INDEX_RS_ASC(@"SEL$8DEB7E6D" "DSS"@"SEL$177" ("D_DISPS_SERVICES"."SERVICE"))
      INDEX(@"SEL$8DEB7E6D" "DS"@"SEL$177" ("D_DISP_SERVICES"."ID"))
      LEADING(@"SEL$8DEB7E6D" "S"@"SEL$179" "DSS"@"SEL$177" "DS"@"SEL$177")
      USE_NL(@"SEL$8DEB7E6D" "DSS"@"SEL$177")
      USE_NL(@"SEL$8DEB7E6D" "DS"@"SEL$177")
      NLJ_BATCHING(@"SEL$8DEB7E6D" "DS"@"SEL$177")
      PQ_FILTER(@"SEL$8DEB7E6D" SERIAL)
      INDEX_RS_ASC(@"SEL$8D1A81FE" "T"@"SEL$171" ("D_MEDICAL_COMMISSIONS"."PROT_SERV"))
      NO_ACCESS(@"SEL$8D1A81FE" "VW_SQ_3"@"SEL$80B75D33")
      LEADING(@"SEL$8D1A81FE" "T"@"SEL$171" "VW_SQ_3"@"SEL$80B75D33")
      USE_NL(@"SEL$8D1A81FE" "VW_SQ_3"@"SEL$80B75D33")
      INDEX_RS_ASC(@"SEL$FF307D9F" "PCSOR"@"SEL$164" ("D_PC_SERV_OTHER_RESULTS"."PID"))
      PQ_FILTER(@"SEL$FF307D9F" SERIAL)
      INDEX_RS_ASC(@"SEL$0A8A44CF" "PCS"@"SEL$97" ("D_PROF_CARD_SERVICES"."ID"))
      INDEX_RS_ASC(@"SEL$0A8A44CF" "PCSOR"@"SEL$91" ("D_PC_SERV_OTHER_RESULTS"."PID"))
      NO_ACCESS(@"SEL$0A8A44CF" "PC"@"SEL$106")
      LEADING(@"SEL$0A8A44CF" "PCS"@"SEL$97" "PCSOR"@"SEL$91" "PC"@"SEL$106")
      USE_NL(@"SEL$0A8A44CF" "PCSOR"@"SEL$91")
      USE_NL(@"SEL$0A8A44CF" "PC"@"SEL$106")
      ORDER_SUBQ(@"SEL$0A8A44CF" "SEL$F9DE4AF1" "SEL$0929CC96")
      PQ_FILTER(@"SEL$0A8A44CF" SERIAL)
      INDEX_RS_ASC(@"SEL$058EA8D5" "PCSOR"@"SEL$155" ("D_PC_SERV_OTHER_RESULTS"."PID"))
      INDEX_RS_ASC(@"SEL$058EA8D5" "T1"@"SEL$149" ("D_AMB_TALON_OTHER_VISITS"."ID"))
      INDEX(@"SEL$058EA8D5" "UP"@"SEL$152" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      LEADING(@"SEL$058EA8D5" "PCSOR"@"SEL$155" "T1"@"SEL$149" "UP"@"SEL$152")
      USE_NL(@"SEL$058EA8D5" "T1"@"SEL$149")
      USE_NL(@"SEL$058EA8D5" "UP"@"SEL$152")
      ORDER_SUBQ(@"SEL$058EA8D5" "SEL$64D77254" "SEL$B9991707")
      PQ_FILTER(@"SEL$058EA8D5" SERIAL)
      INDEX_RS_ASC(@"SEL$770E79DD" "T"@"SEL$80" ("D_EHRS"."UNIT_ID"))
      INDEX(@"SEL$770E79DD" "T"@"SEL$85" ("D_EHR_STATES"."PID"))
      LEADING(@"SEL$770E79DD" "T"@"SEL$80" "T"@"SEL$85")
      USE_NL(@"SEL$770E79DD" "T"@"SEL$85")
      NLJ_BATCHING(@"SEL$770E79DD" "T"@"SEL$85")
      ORDER_SUBQ(@"SEL$770E79DD" "SEL$147" "SEL$3A30E29F" "SEL$2977D0E0")
      PQ_FILTER(@"SEL$770E79DD" SERIAL)
      INDEX_RS_ASC(@"SEL$623FEB7C" "T"@"SEL$69" ("D_EHRS"."UNIT_ID"))
      INDEX(@"SEL$623FEB7C" "T"@"SEL$74" ("D_EHR_STATES"."PID"))
      LEADING(@"SEL$623FEB7C" "T"@"SEL$69" "T"@"SEL$74")
      USE_NL(@"SEL$623FEB7C" "T"@"SEL$74")
      NLJ_BATCHING(@"SEL$623FEB7C" "T"@"SEL$74")
      ORDER_SUBQ(@"SEL$623FEB7C" "SEL$145" "SEL$3D1041AC" "SEL$7C3F09F1")
      PQ_FILTER(@"SEL$623FEB7C" SERIAL)
      INDEX_RS_ASC(@"SEL$28F00AFB" "T"@"SEL$58" ("D_EHRS"."UNIT_ID"))
      INDEX(@"SEL$28F00AFB" "T"@"SEL$63" ("D_EHR_STATES"."PID"))
      LEADING(@"SEL$28F00AFB" "T"@"SEL$58" "T"@"SEL$63")
      USE_NL(@"SEL$28F00AFB" "T"@"SEL$63")
      NLJ_BATCHING(@"SEL$28F00AFB" "T"@"SEL$63")
      ORDER_SUBQ(@"SEL$28F00AFB" "SEL$C9F0CD94" "SEL$6BA534D9")
      PQ_FILTER(@"SEL$28F00AFB" SERIAL)
      INDEX_RS_ASC(@"SEL$1F8A2BDC" "T"@"SEL$43" ("D_EHRS"."UNIT_ID"))
      INDEX(@"SEL$1F8A2BDC" "T"@"SEL$48" ("D_EHR_STATES"."PID"))
      LEADING(@"SEL$1F8A2BDC" "T"@"SEL$43" "T"@"SEL$48")
      USE_NL(@"SEL$1F8A2BDC" "T"@"SEL$48")
      NLJ_BATCHING(@"SEL$1F8A2BDC" "T"@"SEL$48")
      ORDER_SUBQ(@"SEL$1F8A2BDC" "SEL$C68B223C" "SEL$C2C6E2EA")
      PQ_FILTER(@"SEL$1F8A2BDC" SERIAL)
      INDEX_RS_ASC(@"SEL$7D0723C2" "T"@"SEL$28" ("D_EHRS"."UNIT_ID"))
      INDEX(@"SEL$7D0723C2" "T"@"SEL$33" ("D_EHR_STATES"."PID"))
      LEADING(@"SEL$7D0723C2" "T"@"SEL$28" "T"@"SEL$33")
      USE_NL(@"SEL$7D0723C2" "T"@"SEL$33")
      NLJ_BATCHING(@"SEL$7D0723C2" "T"@"SEL$33")
      ORDER_SUBQ(@"SEL$7D0723C2" "SEL$C6517114" "SEL$88C6B492")
      PQ_FILTER(@"SEL$7D0723C2" SERIAL)
      INDEX_RS_ASC(@"SEL$1861DA60" "PCSOR"@"SEL$21" ("D_PC_SERV_OTHER_RESULTS"."PID"))
      NO_ACCESS(@"SEL$1861DA60" "PC"@"SEL$14")
      LEADING(@"SEL$1861DA60" "PCSOR"@"SEL$21" "PC"@"SEL$14")
      USE_NL(@"SEL$1861DA60" "PC"@"SEL$14")
      PQ_FILTER(@"SEL$1861DA60" SERIAL)
      INDEX_RS_ASC(@"SEL$FF54AA42" "C"@"SEL$9" ("D_PROF_CARD_CONCLUSIONS"."VISIT"))
      NO_ACCESS(@"SEL$FF54AA42" "VW_SQ_2"@"SEL$A884B7E2")
      NO_ACCESS(@"SEL$FF54AA42" "PC"@"SEL$2")
      LEADING(@"SEL$FF54AA42" "C"@"SEL$9" "VW_SQ_2"@"SEL$A884B7E2" "PC"@"SEL$2")
      USE_NL(@"SEL$FF54AA42" "VW_SQ_2"@"SEL$A884B7E2")
      USE_NL(@"SEL$FF54AA42" "PC"@"SEL$2")
      INDEX(@"SEL$C6D4F03D" "UP"@"SEL$12" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$C6D4F03D" SERIAL)
      INDEX_RS_ASC(@"SEL$B01C6807" "PCC"@"SEL$3" ("D_PC_CONCLUSIONS"."ID"))
      INDEX(@"SEL$0DAFA1FC" "UP"@"SEL$6" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."LPU" "D_URPRIVS"."VERSION" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$0DAFA1FC" SERIAL)
      INDEX(@"SEL$F23444D6" "US"@"SEL$5" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$F23444D6" "UR"@"SEL$5" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$F23444D6" "US"@"SEL$5" "UR"@"SEL$5")
      USE_NL(@"SEL$F23444D6" "UR"@"SEL$5")
      INDEX(@"SEL$5D238E44" "US"@"SEL$11" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$5D238E44" "UR"@"SEL$11" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$5D238E44" "US"@"SEL$11" "UR"@"SEL$11")
      USE_NL(@"SEL$5D238E44" "UR"@"SEL$11")
      INDEX_RS_ASC(@"SEL$F5405A97" "PCC"@"SEL$15" ("D_PC_CONCLUSIONS"."ID"))
      INDEX(@"SEL$FA8321DB" "UP"@"SEL$18" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."LPU" "D_URPRIVS"."VERSION" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$FA8321DB" SERIAL)
      INDEX(@"SEL$32561052" "US"@"SEL$17" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$32561052" "UR"@"SEL$17" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$32561052" "US"@"SEL$17" "UR"@"SEL$17")
      USE_NL(@"SEL$32561052" "UR"@"SEL$17")
      INDEX(@"SEL$30E1352B" "UP"@"SEL$25" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$30E1352B" SERIAL)
      INDEX(@"SEL$4D82D6A1" "US"@"SEL$24" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$4D82D6A1" "UR"@"SEL$24" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$4D82D6A1" "US"@"SEL$24" "UR"@"SEL$24")
      USE_NL(@"SEL$4D82D6A1" "UR"@"SEL$24")
      INDEX(@"SEL$88C6B492" "UP"@"SEL$31" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$88C6B492" SERIAL)
      INDEX(@"SEL$C6517114" "UP"@"SEL$36" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$C6517114" SERIAL)
      INDEX(@"SEL$032A48B3" "US"@"SEL$35" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$032A48B3" "UR"@"SEL$35" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$032A48B3" "US"@"SEL$35" "UR"@"SEL$35")
      USE_NL(@"SEL$032A48B3" "UR"@"SEL$35")
      INDEX(@"SEL$7C84398F" "US"@"SEL$30" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$7C84398F" "UR"@"SEL$30" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$7C84398F" "US"@"SEL$30" "UR"@"SEL$30")
      USE_NL(@"SEL$7C84398F" "UR"@"SEL$30")
      INDEX(@"SEL$C2C6E2EA" "UP"@"SEL$46" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$C2C6E2EA" SERIAL)
      INDEX(@"SEL$C68B223C" "UP"@"SEL$51" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$C68B223C" SERIAL)
      INDEX_RS_ASC(@"SEL$FC7715CF" "INT_HL7V3_MSGS"@"SEL$41" ("INT_HL7V3_MSGS"."UNIT" "INT_HL7V3_MSGS"."UNIT_ID"))
      INDEX_RS_ASC(@"SEL$FC7715CF" "INT_HL7V3_MSGS"@"SEL$39" ("INT_HL7V3_MSGS"."HID"))
      LEADING(@"SEL$FC7715CF" "INT_HL7V3_MSGS"@"SEL$41" "INT_HL7V3_MSGS"@"SEL$39")
      USE_NL(@"SEL$FC7715CF" "INT_HL7V3_MSGS"@"SEL$39")
      INDEX(@"SEL$8A9147A6" "US"@"SEL$50" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$8A9147A6" "UR"@"SEL$50" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$8A9147A6" "US"@"SEL$50" "UR"@"SEL$50")
      USE_NL(@"SEL$8A9147A6" "UR"@"SEL$50")
      INDEX(@"SEL$68F5C6F7" "US"@"SEL$45" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$68F5C6F7" "UR"@"SEL$45" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$68F5C6F7" "US"@"SEL$45" "UR"@"SEL$45")
      USE_NL(@"SEL$68F5C6F7" "UR"@"SEL$45")
      INDEX(@"SEL$6BA534D9" "UP"@"SEL$61" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$6BA534D9" SERIAL)
      INDEX(@"SEL$C9F0CD94" "UP"@"SEL$66" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$C9F0CD94" SERIAL)
      INDEX_RS_ASC(@"SEL$F2E67D0D" "INT_HL7V3_MSGS"@"SEL$56" ("INT_HL7V3_MSGS"."UNIT" "INT_HL7V3_MSGS"."UNIT_ID"))
      INDEX_RS_ASC(@"SEL$F2E67D0D" "INT_HL7V3_MSGS"@"SEL$54" ("INT_HL7V3_MSGS"."HID"))
      LEADING(@"SEL$F2E67D0D" "INT_HL7V3_MSGS"@"SEL$56" "INT_HL7V3_MSGS"@"SEL$54")
      USE_NL(@"SEL$F2E67D0D" "INT_HL7V3_MSGS"@"SEL$54")
      INDEX(@"SEL$25AB1310" "US"@"SEL$65" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$25AB1310" "UR"@"SEL$65" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$25AB1310" "US"@"SEL$65" "UR"@"SEL$65")
      USE_NL(@"SEL$25AB1310" "UR"@"SEL$65")
      INDEX(@"SEL$7A8D133E" "US"@"SEL$60" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$7A8D133E" "UR"@"SEL$60" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$7A8D133E" "US"@"SEL$60" "UR"@"SEL$60")
      USE_NL(@"SEL$7A8D133E" "UR"@"SEL$60")
      INDEX(@"SEL$7C3F09F1" "UP"@"SEL$72" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$7C3F09F1" SERIAL)
      INDEX(@"SEL$3D1041AC" "UP"@"SEL$77" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$3D1041AC" SERIAL)
      INDEX(@"SEL$4B944954" "US"@"SEL$76" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$4B944954" "UR"@"SEL$76" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$4B944954" "US"@"SEL$76" "UR"@"SEL$76")
      USE_NL(@"SEL$4B944954" "UR"@"SEL$76")
      INDEX(@"SEL$EA442AA0" "US"@"SEL$71" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$EA442AA0" "UR"@"SEL$71" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$EA442AA0" "US"@"SEL$71" "UR"@"SEL$71")
      USE_NL(@"SEL$EA442AA0" "UR"@"SEL$71")
      INDEX(@"SEL$2977D0E0" "UP"@"SEL$83" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$2977D0E0" SERIAL)
      INDEX(@"SEL$3A30E29F" "UP"@"SEL$88" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$3A30E29F" SERIAL)
      INDEX(@"SEL$21CF4C06" "US"@"SEL$87" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$21CF4C06" "UR"@"SEL$87" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$21CF4C06" "US"@"SEL$87" "UR"@"SEL$87")
      USE_NL(@"SEL$21CF4C06" "UR"@"SEL$87")
      INDEX(@"SEL$474C6891" "US"@"SEL$82" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$474C6891" "UR"@"SEL$82" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$474C6891" "US"@"SEL$82" "UR"@"SEL$82")
      USE_NL(@"SEL$474C6891" "UR"@"SEL$82")
      INDEX(@"SEL$B9991707" "US"@"SEL$151" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$B9991707" "UR"@"SEL$151" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$B9991707" "US"@"SEL$151" "UR"@"SEL$151")
      USE_NL(@"SEL$B9991707" "UR"@"SEL$151")
      INDEX(@"SEL$64D77254" "UP"@"SEL$159" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$64D77254" SERIAL)
      INDEX(@"SEL$F9DD4CB9" "US"@"SEL$158" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$F9DD4CB9" "UR"@"SEL$158" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$F9DD4CB9" "US"@"SEL$158" "UR"@"SEL$158")
      USE_NL(@"SEL$F9DD4CB9" "UR"@"SEL$158")
      INDEX_RS_ASC(@"SEL$C482CF97" "PCC"@"SEL$107" ("D_PC_CONCLUSIONS"."ID"))
      INDEX(@"SEL$9100DC0B" "UP"@"SEL$110" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."LPU" "D_URPRIVS"."VERSION" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$9100DC0B" SERIAL)
      INDEX(@"SEL$EEB295B0" "US"@"SEL$109" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$EEB295B0" "UR"@"SEL$109" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$EEB295B0" "US"@"SEL$109" "UR"@"SEL$109")
      USE_NL(@"SEL$EEB295B0" "UR"@"SEL$109")
      INDEX(@"SEL$0929CC96" "UP"@"SEL$95" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$0929CC96" SERIAL)
      INDEX(@"SEL$F9DE4AF1" "UP"@"SEL$104" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$F9DE4AF1" SERIAL)
      INDEX(@"SEL$0CBCACBD" "US"@"SEL$103" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$0CBCACBD" "UR"@"SEL$103" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$0CBCACBD" "US"@"SEL$103" "UR"@"SEL$103")
      USE_NL(@"SEL$0CBCACBD" "UR"@"SEL$103")
      INDEX(@"SEL$44D94F01" "US"@"SEL$94" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$44D94F01" "UR"@"SEL$94" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$44D94F01" "US"@"SEL$94" "UR"@"SEL$94")
      USE_NL(@"SEL$44D94F01" "UR"@"SEL$94")
      INDEX(@"SEL$C44BA534" "UP"@"SEL$168" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$C44BA534" SERIAL)
      INDEX(@"SEL$F37F9FD3" "US"@"SEL$167" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$F37F9FD3" "UR"@"SEL$167" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$F37F9FD3" "US"@"SEL$167" "UR"@"SEL$167")
      USE_NL(@"SEL$F37F9FD3" "UR"@"SEL$167")
      INDEX(@"SEL$2634090D" "UP"@"SEL$174" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$2634090D" SERIAL)
      INDEX(@"SEL$D2A93C17" "US"@"SEL$173" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$D2A93C17" "UR"@"SEL$173" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$D2A93C17" "US"@"SEL$173" "UR"@"SEL$173")
      USE_NL(@"SEL$D2A93C17" "UR"@"SEL$173")
      INDEX(@"SEL$89359AEE" "UP"@"SEL$183" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."VERSION" "D_URPRIVS"."USERNAME" "D_URPRIVS"."ROLEID"))
      PQ_FILTER(@"SEL$89359AEE" SERIAL)
      INDEX(@"SEL$88C79FCA" "US"@"SEL$182" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$88C79FCA" "UR"@"SEL$182" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$88C79FCA" "US"@"SEL$182" "UR"@"SEL$182")
      USE_NL(@"SEL$88C79FCA" "UR"@"SEL$182")
      INDEX(@"SEL$CD4C9210" "UP"@"SEL$190" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$CD4C9210" SERIAL)
      INDEX(@"SEL$6D9A86AF" "US"@"SEL$189" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$6D9A86AF" "UR"@"SEL$189" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$6D9A86AF" "US"@"SEL$189" "UR"@"SEL$189")
      USE_NL(@"SEL$6D9A86AF" "UR"@"SEL$189")
      INDEX(@"SEL$72EEAF55" "UP"@"SEL$196" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$72EEAF55" SERIAL)
      INDEX(@"SEL$2002CBB4" "US"@"SEL$195" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$2002CBB4" "UR"@"SEL$195" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$2002CBB4" "US"@"SEL$195" "UR"@"SEL$195")
      USE_NL(@"SEL$2002CBB4" "UR"@"SEL$195")
      INDEX(@"SEL$75546432" "UP"@"SEL$202" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$75546432" SERIAL)
      INDEX(@"SEL$0A384FF1" "US"@"SEL$201" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$0A384FF1" "UR"@"SEL$201" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$0A384FF1" "US"@"SEL$201" "UR"@"SEL$201")
      USE_NL(@"SEL$0A384FF1" "UR"@"SEL$201")
      INDEX(@"SEL$0CAA258E" "UP"@"SEL$117" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$0CAA258E" SERIAL)
      INDEX(@"SEL$A5BAA20F" "UP"@"SEL$122" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."CATALOG" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$A5BAA20F" SERIAL)
      INDEX(@"SEL$51F828FA" "UP"@"SEL$128" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$51F828FA" SERIAL)
      INDEX(@"SEL$CFD2D090" "UP"@"SEL$134" ("D_URPRIVS"."UNITCODE" "D_URPRIVS"."LPU" "D_URPRIVS"."ROLEID" "D_URPRIVS"."USERNAME"))
      PQ_FILTER(@"SEL$CFD2D090" SERIAL)
      INDEX(@"SEL$BA458DC4" "US"@"SEL$133" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$BA458DC4" "UR"@"SEL$133" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$BA458DC4" "US"@"SEL$133" "UR"@"SEL$133")
      USE_NL(@"SEL$BA458DC4" "UR"@"SEL$133")
      INDEX(@"SEL$CC1EF0E8" "US"@"SEL$127" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$CC1EF0E8" "UR"@"SEL$127" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$CC1EF0E8" "US"@"SEL$127" "UR"@"SEL$127")
      USE_NL(@"SEL$CC1EF0E8" "UR"@"SEL$127")
      INDEX(@"SEL$FA386CED" "US"@"SEL$121" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$FA386CED" "UR"@"SEL$121" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$FA386CED" "US"@"SEL$121" "UR"@"SEL$121")
      USE_NL(@"SEL$FA386CED" "UR"@"SEL$121")
      INDEX(@"SEL$1ADC8C15" "US"@"SEL$116" ("D_USERS"."USERNAME" "D_USERS"."ID"))
      INDEX(@"SEL$1ADC8C15" "UR"@"SEL$116" ("D_USERROLES"."SYSUSER" "D_USERROLES"."ROLEID"))
      LEADING(@"SEL$1ADC8C15" "US"@"SEL$116" "UR"@"SEL$116")
      USE_NL(@"SEL$1ADC8C15" "UR"@"SEL$116")
      END_OUTLINE_DATA
  */
 
Peeked Binds (identified by position):
--------------------------------------
 
   1 - :1 (VARCHAR2(30), CSID=171): '108570861'
   2 - :2 (VARCHAR2(30), CSID=171): '17657401309'
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   6 - access("V"."ID"=:B1)
   7 - access("PCDS"."DIR_SERV"="V"."PID")
   8 - access("PCDS"."PID"="TT"."ID")
   9 - filter("TT"."PID"=:B1)
  11 - access("T2"."ID"=:B1)
  13 - access("LDS"."ID"="LDL"."STATUS")
  16 - access("DS"."HID"=:B1)
  17 - access("DS"."ID"="LDL"."DIR_SERV")
       filter(("LDL"."STATUS"<>1 AND "LDL"."STATUS"<>2))
  19 - access(ROWID=ROWID)
  20 - filter(("LDS"."ID"<>2 AND "LDS"."ID"<>1))
  25 - access("LDL"."DIR_SERV"=:B1)
       filter(("LDL"."STATUS"<>1 AND "LDL"."STATUS"<>2))
  26 - access("LDS"."ID"="LDL"."STATUS")
       filter(("LDS"."ID"<>1 AND "LDS"."ID"<>2))
  29 - access("CL"."ID"=:B1)
  31 - access("CL"."ID"=:B1)
  35 - access("VF"."PID"=:B1)
       filter("VF"."ADD_DIR_VALUE" IS NOT NULL)
  36 - access("VTF"."ID"="VF"."TEMPLATE_FIELD" AND "VTF"."F_CODE"='C_VIEW_RESULT_MO')
       filter(UPPER("F_CODE")='C_VIEW_RESULT_MO')
  37 - access("ADV"."ID"="VF"."ADD_DIR_VALUE")
  39 - filter(ROWNUM=1)
  42 - filter("VD"."IS_MAIN"=0)
  43 - access("VD"."PID"=:B1)
  44 - access("MVD"."ID"="VD"."MKB")
  46 - access("LDL"."DIR_SERV"=:B1)
  48 - access("CL"."ID"=:B1)
  49 - filter(ROWNUM=1)
  53 - access("ORES"."PID"=:B1)
  54 - access("ORES"."AT_OTHER_VISIT"="OV"."ID")
  56 - filter( IS NOT NULL)
  62 - access("T"."PID"=:B1)
  65 - access("ODIR"."REPRESENT_DIRECTION"=:B1)
       filter("ODIR"."REPRESENT_DIRECTION" IS NOT NULL)
  67 - access("OD"."OUTER_DIRECTION"="ODIR"."ID")
       filter("OD"."OUTER_DIRECTION" IS NOT NULL)
  69 - access("ODS"."SERV_STATUS"=1 AND "ODS"."PID"="OD"."ID")
  70 - access("T"."SERVICE_CODE"="S"."SE_CODE" AND "S"."ID"="ODS"."SERVICE")
       filter("S"."ID"="ODS"."SERVICE")
  71 - filter(ROWNUM=1)
  72 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
  73 - access("UP"."UNITCODE"='OUT_DIR_SERVS' AND "UP"."LPU"=:B1)
  75 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
  76 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
  79 - access("L"."ID"=:B1)
  81 - access("LD"."ID"="L"."LPUDICT")
  82 - filter( IS NOT NULL)
  88 - access("OD"."OUTER_DIRECTION"=:B1)
  90 - access("ODS"."SERV_STATUS"=1 AND "ODS"."PID"="OD"."ID")
  92 - access("V"."PID"="ODS"."ID")
  93 - access("S"."ID"="ODS"."SERVICE")
  95 - filter( IS NOT NULL)
  96 - filter("T"."SERVICE_CODE"=:B1)
  97 - access("T"."PID"=:B1)
  98 - filter(ROWNUM=1)
  99 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 100 - access("UP"."UNITCODE"='OUT_DIR_SERVS' AND "UP"."LPU"=:B1)
 102 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 103 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 105 - access("ODIR"."REPRESENT_DIRECTION"=:B1)
       filter("ODIR"."REPRESENT_DIRECTION" IS NOT NULL)
 108 - access("DD"."ID"=:B1)
 110 - access("L"."ID"="DD"."LPU_TO")
 111 - filter(ROWNUM=1)
 115 - access("ORES"."PID"=:B1)
 116 - access("ORES"."AT_OTHER_VISIT"="OV"."ID")
 118 - filter( IS NOT NULL)
 124 - access("ODIR"."REPRESENT_DIRECTION"=:B1)
       filter("ODIR"."REPRESENT_DIRECTION" IS NOT NULL)
 126 - access("OD"."OUTER_DIRECTION"="ODIR"."ID")
       filter("OD"."OUTER_DIRECTION" IS NOT NULL)
 128 - access("ODS"."PID"="OD"."ID")
 129 - access("S"."ID"="ODS"."SERVICE")
 131 - filter( IS NOT NULL)
 132 - filter("T"."SERVICE_CODE"=:B1)
 133 - access("T"."PID"=:B1)
 134 - filter(ROWNUM=1)
 135 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 136 - access("UP"."UNITCODE"='OUT_DIR_SERVS' AND "UP"."LPU"=:B1)
 138 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 139 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 144 - access("K1"."DIRECTION_SERVICE"=:B1)
 145 - access("K2"."PATJOUR"="K1"."ID")
 148 - filter(("DL"."STATUS"=5 OR "DL"."STATUS" IS NULL))
 153 - access("J1"."DIRECTION_SERVICE"=:B1)
 155 - access("J2"."PATJOUR"="J1"."ID")
 156 - filter(("J3"."IS_ACTUAL"=1 AND "J3"."CONFIRM_STATUS"<>1))
 157 - access("J3"."PID"="J2"."ID")
 159 - access("DL"."ID"="J3"."DIR_LINE")
 160 - filter(ROWNUM=1)
 163 - filter("C"."PID"=:B1)
 164 - access("C"."VISIT"=:B1)
 166 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 167 - access("UP"."UNITCODE"='PROF_CARD_CONCLUSIONS' AND "UP"."CATALOG"="C"."CID")
 169 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 170 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 172 - filter( IS NOT NULL)
 174 - access("PCC"."ID"="C"."CONCLUSION")
 175 - filter(ROWNUM=1)
 176 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 177 - access("UP"."UNITCODE"='PC_CONCLUSIONS' AND "UP"."LPU" IS NULL AND "UP"."VERSION" IS NULL)
       filter(("UP"."VERSION" IS NULL AND "UP"."LPU" IS NULL))
 179 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 180 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 181 - filter( IS NOT NULL)
 184 - access("PCSOR"."PID"=:B1)
 186 - filter( IS NOT NULL)
 188 - access("PCC"."ID"="PCSOR"."IS_TRUE_DISEASE")
 189 - filter(ROWNUM=1)
 190 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 191 - access("UP"."UNITCODE"='PC_CONCLUSIONS' AND "UP"."LPU" IS NULL AND "UP"."VERSION" IS NULL)
       filter(("UP"."VERSION" IS NULL AND "UP"."LPU" IS NULL))
 193 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 194 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 195 - filter(ROWNUM=1)
 196 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 197 - access("UP"."UNITCODE"='PC_SERV_OTHER_RESULTS' AND "UP"."CATALOG"=:B1)
 199 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 200 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 205 - access("PC"."ID"=:B1)
 207 - access("PCT"."ID"="PC"."PROF_CARD_TYPE")
 208 - filter("PCC"."PID"=:B1)
 209 - access("PCC"."VISIT"=:B1)
 210 - filter(ROWNUM=1)
 213 - filter("VD"."IS_MAIN"=0)
 214 - access("VD"."PID"=:B1)
 215 - access("MVD"."ID"="VD"."MKB")
 218 - filter(( IS NOT NULL AND  IS NOT NULL))
 222 - access("T"."UNIT_ID"=:B1)
 223 - access("T"."PID"="T"."ID")
 224 - filter("T"."SGN_HASH" IS NOT NULL)
 225 - filter(ROWNUM=1)
 226 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 227 - access("UP"."UNITCODE"='EHR_STATES' AND "UP"."LPU"=:B1)
 229 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 230 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 231 - filter(ROWNUM=1)
 232 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 233 - access("UP"."UNITCODE"='EHRS' AND "UP"."LPU"=:B1)
 235 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 236 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 238 - filter("ERROR_MSG" IS NULL)
 240 - filter("ERROR_MSG" IS NULL)
 241 - access("UNIT"='EHR_STATES' AND "UNIT_ID"=:B1)
 243 - access("HID"="ID")
       filter("HID" IS NOT NULL)
 245 - filter(( IS NOT NULL AND  IS NOT NULL))
 249 - access("T"."UNIT_ID"=:B1)
 250 - access("T"."PID"="T"."ID")
 251 - filter("T"."SGN_HASH" IS NOT NULL)
 252 - filter(ROWNUM=1)
 253 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 254 - access("UP"."UNITCODE"='EHR_STATES' AND "UP"."LPU"=:B1)
 256 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 257 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 258 - filter(ROWNUM=1)
 259 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 260 - access("UP"."UNITCODE"='EHRS' AND "UP"."LPU"=:B1)
 262 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 263 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 265 - filter("ERROR_MSG" IS NULL)
 267 - filter("ERROR_MSG" IS NULL)
 268 - access("UNIT"='EHR_STATES' AND "UNIT_ID"=:B1)
 270 - access("HID"="ID")
       filter("HID" IS NOT NULL)
 272 - filter(( IS NOT NULL AND  IS NOT NULL))
 276 - access("T"."UNIT_ID"=:B1)
 277 - access("T"."PID"="T"."ID")
 278 - filter("T"."SGN_HASH" IS NOT NULL)
 279 - filter(ROWNUM=1)
 280 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 281 - access("UP"."UNITCODE"='EHR_STATES' AND "UP"."LPU"=:B1)
 283 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 284 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 285 - filter(ROWNUM=1)
 286 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 287 - access("UP"."UNITCODE"='EHRS' AND "UP"."LPU"=:B1)
 289 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 290 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 292 - filter(( IS NOT NULL AND  IS NOT NULL AND  IS NOT NULL))
 296 - access("T"."UNIT_ID"=:B1)
 297 - access("T"."PID"="T"."ID")
 298 - filter("T"."SGN_HASH" IS NOT NULL)
 300 - filter(ROWNUM=1)
 301 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 302 - access("UP"."UNITCODE"='EHR_STATES' AND "UP"."LPU"=:B1)
 304 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 305 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 306 - filter(ROWNUM=1)
 307 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 308 - access("UP"."UNITCODE"='EHRS' AND "UP"."LPU"=:B1)
 310 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 311 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 313 - filter(( IS NOT NULL AND  IS NOT NULL AND  IS NOT NULL))
 317 - access("T"."UNIT_ID"=:B1)
 318 - access("T"."PID"="T"."ID")
 319 - filter("T"."SGN_HASH" IS NOT NULL)
 321 - filter(ROWNUM=1)
 322 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 323 - access("UP"."UNITCODE"='EHR_STATES' AND "UP"."LPU"=:B1)
 325 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 326 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 327 - filter(ROWNUM=1)
 328 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 329 - access("UP"."UNITCODE"='EHRS' AND "UP"."LPU"=:B1)
 331 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 332 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 334 - filter(( IS NOT NULL AND ("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL)))
 338 - access("PCSOR"."PID"=:B1)
 340 - access("T1"."ID"="PCSOR"."AT_OTHER_VISIT")
 341 - access("UP"."UNITCODE"='PC_SERV_OTHER_RESULTS' AND "UP"."CATALOG"="PCSOR"."CID")
       filter("UP"."CATALOG" IS NOT NULL)
 342 - filter(ROWNUM=1)
 343 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 344 - access("UP"."UNITCODE"='PC_SERV_OTHER_RESULTS' AND "UP"."CATALOG"=:B1)
 346 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 347 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 349 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 350 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 354 - access("T"."PID"=:B1)
 356 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 357 - access("UP"."UNITCODE"='SERVICES_STR' AND "UP"."CATALOG"="T"."CID")
 359 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 360 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 361 - filter(ROWNUM=1)
 364 - filter(("DL"."STATUS"=5 OR "DL"."STATUS" IS NULL))
 370 - access("J1"."DIRECTION_SERVICE"=:B1)
 372 - access("J2"."PATJOUR"="J1"."ID")
 373 - filter(("J3"."VAL_RESULT"=1 AND "J3"."IS_ACTUAL"=1 AND "J3"."CONFIRM_STATUS"<>1))
 374 - access("J3"."PID"="J2"."ID")
 375 - filter("J4"."MEASURE" IS NOT NULL)
 376 - access("J4"."ID"="J3"."RESULT")
 378 - access("DL"."ID"="J3"."DIR_LINE")
 379 - access("J5"."ID"="J4"."MEASURE")
 381 - filter(ROWNUM=1)
 384 - access("PC"."ID"=:B1)
 386 - access("PC"."PROF_CARD_TYPE"="PCT"."ID")
 393 - access("DS"."HID"=:B1)
 395 - access("DL"."DIR_SERV"="DS"."ID")
       filter("DL"."STATUS"<>6)
 397 - access("SD"."DIRLINE"="DL"."ID")
 398 - access("S"."ID"="SD"."PID")
 399 - filter("S"."SAMPLE_CODE" IS NOT NULL)
 400 - filter(( IS NOT NULL AND  IS NOT NULL))
 403 - filter(("PCS"."STATE"=1 OR "PCS"."STATE"=2 OR "PCS"."STATE"=5 OR "PCS"."STATE"=7))
 404 - access("PCS"."ID"=:B1)
 406 - access("PCSOR"."PID"=:B1)
 408 - filter( IS NOT NULL)
 410 - access("PCC"."ID"="PCSOR"."IS_TRUE_DISEASE")
 411 - filter(ROWNUM=1)
 412 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 413 - access("UP"."UNITCODE"='PC_CONCLUSIONS' AND "UP"."LPU" IS NULL AND "UP"."VERSION" IS NULL)
       filter(("UP"."VERSION" IS NULL AND "UP"."LPU" IS NULL))
 415 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 416 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 417 - filter(ROWNUM=1)
 418 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 419 - access("UP"."UNITCODE"='PROF_CARD_SERVICES' AND "UP"."CATALOG"=:B1)
 421 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 422 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 423 - filter(ROWNUM=1)
 424 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 425 - access("UP"."UNITCODE"='PC_SERV_OTHER_RESULTS' AND "UP"."CATALOG"=:B1)
 427 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 428 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 429 - filter( IS NOT NULL)
 431 - access("PCSOR"."PID"=:B1)
 432 - filter(ROWNUM=1)
 433 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 434 - access("UP"."UNITCODE"='PC_SERV_OTHER_RESULTS' AND "UP"."CATALOG"=:B1)
 436 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 437 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 440 - filter((INTERNAL_FUNCTION("T"."IS_CONCORD") AND ("T"."DATE_END" IS NULL OR "T"."DATE_END">SYSDATE@!)))
 441 - access("T"."PROT_SERV"=:B1)
 443 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 444 - access("UP"."UNITCODE"='MEDICAL_COMMISSIONS' AND "UP"."CATALOG"="T"."CID")
 446 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 447 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 449 - filter( IS NOT NULL)
 450 - filter(((:B1=2 OR :B2=6) AND TO_NUMBER(COALESCE(,'0'))=1))
 454 - access("S"."SE_CODE"=:B1)
 456 - access("S"."ID"="DSS"."SERVICE")
 457 - access("DS"."ID"="DSS"."DISP_SERVICE")
 458 - filter(("DS"."PC_TYPE"=:B1 AND INTERNAL_FUNCTION("DS"."DS_CODE")))
 460 - filter(ROWNUM=1)
 461 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 462 - access("UP"."UNITCODE"='DISPS_SERVICES' AND "UP"."VERSION"=:B1)
 464 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 465 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 466 - filter(ROWNUM=1)
 472 - access("T"."PID"=:B1)
 474 - access("T"."SERVICE"=:B1)
 476 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 477 - access("UP"."UNITCODE"='PROF_CARD_MODELS_SR' AND "UP"."CATALOG"="T"."CID")
 479 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 480 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 482 - filter( IS NOT NULL)
 483 - filter("PC"."DATE_E" IS NOT NULL)
 484 - access("PC"."ID"=:B1)
 485 - filter(ROWNUM=1)
 486 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 487 - access("UP"."UNITCODE"='PROF_CARD' AND "UP"."CATALOG"=:B1)
 489 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 490 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 492 - filter( IS NOT NULL)
 493 - filter("T"."IS_CLOSE"<>0)
 494 - access("T"."ID"=:B1)
 495 - filter(ROWNUM=1)
 496 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 497 - access("UP"."UNITCODE"='DISEASECASES' AND "UP"."LPU"=:B1)
 499 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 500 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 502 - filter(ROWNUM=1)
 503 - filter(( IS NOT NULL AND  IS NOT NULL AND  IS NOT NULL))
 508 - access("T"."ID"=:B1)
 509 - filter(("T"."ID"="T"."PID" OR ("T"."HID"="T"."PID" AND "T"."HID" IS NOT NULL)))
 513 - access("T"."ID"="T"."PID")
 515 - access("T"."HID"="T"."PID")
 517 - access("T"."VISIT"="T"."ID")
       filter("T"."VISIT" IS NOT NULL)
 518 - access("AT"."ID"="T"."PID")
       filter( IS NOT NULL)
 519 - filter(ROWNUM=1)
 520 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 521 - access("UP"."UNITCODE"='AMB_TALONS' AND "UP"."CATALOG"=:B1)
 523 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 524 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 525 - filter(ROWNUM=1)
 526 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 527 - access("UP"."UNITCODE"='DIRECTION_SERVICES' AND "UP"."LPU"=:B1)
 529 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 530 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 531 - filter(ROWNUM=1)
 532 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 533 - access("UP"."UNITCODE"='VISITS' AND "UP"."LPU"=:B1)
 535 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 536 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 537 - filter(ROWNUM=1)
 538 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 539 - access("UP"."UNITCODE"='AMB_TALON_VISITS' AND "UP"."CATALOG"=:B1)
 541 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 542 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 543 - filter((TO_CHAR("V"."NSERVICE_TYPE") LIKE :B4 AND "V"."RN"=1 AND "V"."IS_NAZNACH"=0 AND "V"."DS_HID" IS NULL AND ("V"."FILTER_SERVICE" IS NULL OR "V"."FILTER_SERVICE"=0 OR 
              ("V"."FILTER_SERVICE"=1 AND "V"."SERVICE"<>:B3))))
 544 - filter(ROW_NUMBER() OVER ( PARTITION BY "from$_subquery$_064"."QCSJ_C000000005500000" ORDER BY "from$_subquery$_064"."VISIT_DATE")<=1)
 547 - filter(( IS NOT NULL AND  IS NOT NULL AND  IS NOT NULL))
 548 - access("EX"."PID"="PCS"."PID")
 559 - access("PC"."ID"=TO_NUMBER(:B2))
 561 - access("PCT"."ID"="PC"."PROF_CARD_TYPE")
 563 - access("PCS"."PID"=TO_NUMBER(:B2))
 565 - access("SERV"."ID"="PCS"."SERVICE")
 567 - access("PCDIRS"."PID"="PCS"."ID")
 569 - access("DIRS"."ID"="PCDIRS"."DIR_SERV")
 571 - access("EMP"."ID"="DIRS"."EMPLOYER_TO")
 573 - access("V"."PID"="DIRS"."ID")
 575 - access("DIR"."ID"="DIRS"."PID")
 577 - access("EMPA"."ID"="EMP"."AGENT")
 578 - filter("EX"."OBR_RANK"=1)
 579 - filter(RANK() OVER ( PARTITION BY "PCS"."PID" ORDER BY INTERNAL_FUNCTION("ID") DESC )<=1)
 580 - filter(( IS NOT NULL AND  IS NOT NULL))
 584 - filter("PID"=TO_NUMBER(:B1))
 585 - access("UNIT"='DIRECTION_SERVICES')
       filter(("VAL_CODE"='MSE_COMPLETE' OR "VAL_CODE"='MSE_PDO'))
 587 - access("T"."DIR_SERV"="UNIT_ID")
 588 - access("T"."PID"="PCS"."ID")
 589 - filter("PCS"."PID"=TO_NUMBER(:B2))
 590 - filter(ROWNUM=1)
 591 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 592 - access("UP"."UNITCODE"='PROF_CARD_SERVICES' AND "UP"."CATALOG"=:B1)
 594 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 595 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 596 - filter(ROWNUM=1)
 597 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 598 - access("UP"."UNITCODE"='PROF_CARD_DIR_SERVS' AND "UP"."CATALOG"=:B1)
 600 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 601 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 602 - filter(ROWNUM=1)
 603 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 604 - access("UP"."UNITCODE"='PROF_CARD_TYPES' AND "UP"."VERSION"=:B1)
 606 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 607 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 608 - filter(ROWNUM=1)
 609 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 610 - access("UP"."UNITCODE"='PROF_CARD' AND "UP"."CATALOG"=:B1)
 612 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 613 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 614 - filter(ROWNUM=1)
 615 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 616 - access("UP"."UNITCODE"='PROF_CARD_SERVICES' AND "UP"."CATALOG"=:B1)
 618 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 619 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 621 - filter( IS NOT NULL)
 622 - filter("S"."PID"=TO_NUMBER(:B2))
 627 - access("SRV"."SE_CODE"="S"."SERVICE")
 630 - access("PCC"."PID"=TO_NUMBER(:B2))
 632 - access("V"."ID"="PCC"."VISIT")
 633 - access("DRS"."ID"="V"."PID")
 634 - filter("SRV"."ID"="DRS"."SERVICE")
 635 - filter(ROWNUM=1)
 636 - filter(("UP"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')) OR  IS NOT NULL))
 637 - access("UP"."UNITCODE"='PROF_CARD_CONCLUSIONS' AND "UP"."CATALOG"=:B1)
 639 - access("US"."USERNAME"=COALESCE(SYS_CONTEXT('MED','USER'),SYS_CONTEXT('USERENV','SESSION_USER')))
 640 - access("UR"."SYSUSER"="US"."ID" AND "UR"."ROLEID"=:B1)
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
 
   1 - (#keys=0) COUNT(*)[22]
   3 - "TT".ROWID[ROWID,10]
   4 - "PCDS"."PID"[NUMBER,22]
   5 - "V"."PID"[NUMBER,22]
   6 - "V".ROWID[ROWID,10]
   7 - "PCDS"."PID"[NUMBER,22]
   8 - "TT".ROWID[ROWID,10]
  10 - "T2"."ST_NAME"[VARCHAR2,60]
  11 - "T2".ROWID[ROWID,10]
  12 - (#keys=0) MAX("LDS"."ST_NAME") KEEP (DENSE_RANK FIRST  ORDER BY INTERNAL_FUNCTION("LDS"."ID") DESC )[50]
  13 - (#keys=1) "LDS"."ID"[NUMBER,22], "LDS"."ST_NAME"[VARCHAR2,50]
  14 - "LDL"."STATUS"[NUMBER,22]
  15 - "DS"."ID"[NUMBER,22]
  16 - "DS".ROWID[ROWID,10]
  17 - "LDL"."STATUS"[NUMBER,22]
  18 - "LDS"."ST_NAME"[VARCHAR2,50], "LDS"."ID"[NUMBER,22]
  19 - (#keys=1) "LDS"."ID"[NUMBER,22], "LDS"."ST_NAME"[VARCHAR2,50]
  20 - ROWID[ROWID,10], "LDS"."ID"[NUMBER,22]
  21 - ROWID[ROWID,10], "LDS"."ST_NAME"[VARCHAR2,50]
  22 - (#keys=0) MAX("LDS"."ST_NAME") KEEP (DENSE_RANK FIRST  ORDER BY INTERNAL_FUNCTION("LDS"."ID") DESC )[50]
  23 - "LDS"."ID"[NUMBER,22], "LDS"."ST_NAME"[VARCHAR2,50]
  24 - "LDS".ROWID[ROWID,10], "LDS"."ID"[NUMBER,22]
  25 - "LDL"."STATUS"[NUMBER,22]
  26 - "LDS".ROWID[ROWID,10], "LDS"."ID"[NUMBER,22]
  27 - "LDS"."ST_NAME"[VARCHAR2,50]
  28 - "CL"."CL_NAME"[VARCHAR2,160]
  29 - "CL".ROWID[ROWID,10]
  30 - "CL"."CL_NAME"[VARCHAR2,160]
  31 - "CL".ROWID[ROWID,10]
  32 - "ADV"."STR_VALUE"[VARCHAR2,4000]
  33 - "ADV".ROWID[ROWID,10]
  34 - "VF"."ADD_DIR_VALUE"[NUMBER,22]
  35 - "VF"."TEMPLATE_FIELD"[NUMBER,22], "VF"."ADD_DIR_VALUE"[NUMBER,22]
  37 - "ADV".ROWID[ROWID,10]
  38 - "ADV"."STR_VALUE"[VARCHAR2,4000]
  39 - "MVD"."MKB_CODE"[VARCHAR2,10]
  40 - "MVD"."MKB_CODE"[VARCHAR2,10]
  41 - "MVD".ROWID[ROWID,10]
  42 - "VD"."MKB"[NUMBER,22]
  43 - "VD".ROWID[ROWID,10], "VD"."MKB"[NUMBER,22]
  44 - "MVD".ROWID[ROWID,10]
  45 - "MVD"."MKB_CODE"[VARCHAR2,10]
  47 - "CL"."CL_NAME"[VARCHAR2,160]
  48 - "CL".ROWID[ROWID,10]
  49 - "OV"."OTHER_LPU_NAME"[VARCHAR2,250]
  50 - "OV"."OTHER_LPU_NAME"[VARCHAR2,250]
  51 - "OV".ROWID[ROWID,10]
  52 - "ORES"."AT_OTHER_VISIT"[NUMBER,22]
  53 - "ORES".ROWID[ROWID,10]
  54 - "OV".ROWID[ROWID,10]
  55 - "OV"."OTHER_LPU_NAME"[VARCHAR2,250]
  57 - "T"."LPU"[NUMBER,22]
  58 - "T"."LPU"[NUMBER,22], "T"."SERVICE_CODE"[VARCHAR2,20], "ODS"."SERVICE"[NUMBER,22]
  59 - "T"."LPU"[NUMBER,22], "T"."SERVICE_CODE"[VARCHAR2,20], "OD"."ID"[NUMBER,22]
  60 - "T"."LPU"[NUMBER,22], "T"."SERVICE_CODE"[VARCHAR2,20], "ODIR"."ID"[NUMBER,22]
  61 - "T"."LPU"[NUMBER,22], "T"."SERVICE_CODE"[VARCHAR2,20]
  62 - "T".ROWID[ROWID,10]
  63 - (#keys=0) "ODIR"."ID"[NUMBER,22]
  64 - "ODIR"."ID"[NUMBER,22]
  65 - "ODIR".ROWID[ROWID,10]
  66 - "OD"."ID"[NUMBER,22]
  67 - "OD".ROWID[ROWID,10]
  68 - "ODS"."SERVICE"[NUMBER,22]
  69 - "ODS".ROWID[ROWID,10]
  73 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
  75 - "US"."ID"[NUMBER,22]
  77 - "LD"."LPU_NAME"[VARCHAR2,100]
  78 - "L"."LPUDICT"[NUMBER,22]
  79 - "L".ROWID[ROWID,10]
  80 - "LD"."LPU_NAME"[VARCHAR2,100]
  81 - "LD".ROWID[ROWID,10]
  82 - "V"."VISIT_DATE"[DATE,7]
  83 - "V"."VISIT_DATE"[DATE,7], "S"."SE_CODE"[VARCHAR2,30]
  84 - "V"."VISIT_DATE"[DATE,7], "S".ROWID[ROWID,10]
  85 - "ODS"."SERVICE"[NUMBER,22], "V"."VISIT_DATE"[DATE,7]
  86 - "ODS"."ID"[NUMBER,22], "ODS"."SERVICE"[NUMBER,22]
  87 - "OD"."ID"[NUMBER,22]
  88 - "OD".ROWID[ROWID,10]
  89 - "ODS"."ID"[NUMBER,22], "ODS"."SERVICE"[NUMBER,22]
  90 - "ODS".ROWID[ROWID,10]
  91 - "V"."VISIT_DATE"[DATE,7]
  92 - "V".ROWID[ROWID,10]
  93 - "S".ROWID[ROWID,10]
  94 - "S"."SE_CODE"[VARCHAR2,30]
  96 - "T"."LPU"[NUMBER,22]
  97 - "T".ROWID[ROWID,10]
 100 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 102 - "US"."ID"[NUMBER,22]
 104 - "ODIR"."ID"[NUMBER,22], "ODIR"."LPU"[NUMBER,22]
 105 - "ODIR".ROWID[ROWID,10]
 106 - "DD"."LPU_TO_HANDLE"[VARCHAR2,250], "L"."LPU_NAME"[VARCHAR2,100]
 107 - "DD"."LPU_TO"[NUMBER,22], "DD"."LPU_TO_HANDLE"[VARCHAR2,250]
 108 - "DD".ROWID[ROWID,10]
 109 - "L"."LPU_NAME"[VARCHAR2,100]
 110 - "L".ROWID[ROWID,10]
 111 - "OV"."VIS_DATE"[DATE,7], "OV"."OTHER_LPU_NAME"[VARCHAR2,250]
 112 - "OV"."VIS_DATE"[DATE,7], "OV"."OTHER_LPU_NAME"[VARCHAR2,250]
 113 - "OV".ROWID[ROWID,10]
 114 - "ORES"."AT_OTHER_VISIT"[NUMBER,22]
 115 - "ORES".ROWID[ROWID,10]
 116 - "OV".ROWID[ROWID,10]
 117 - "OV"."VIS_DATE"[DATE,7], "OV"."OTHER_LPU_NAME"[VARCHAR2,250]
 118 - "ODS"."SERV_STATUS"[NUMBER,22]
 119 - "ODS"."SERV_STATUS"[NUMBER,22], "S"."SE_CODE"[VARCHAR2,30]
 120 - "ODS"."SERV_STATUS"[NUMBER,22], "S".ROWID[ROWID,10]
 121 - "ODS"."SERVICE"[NUMBER,22], "ODS"."SERV_STATUS"[NUMBER,22]
 122 - "OD"."ID"[NUMBER,22]
 123 - "ODIR"."ID"[NUMBER,22]
 124 - "ODIR".ROWID[ROWID,10]
 125 - "OD"."ID"[NUMBER,22]
 126 - "OD".ROWID[ROWID,10]
 127 - "ODS"."SERVICE"[NUMBER,22], "ODS"."SERV_STATUS"[NUMBER,22]
 128 - "ODS".ROWID[ROWID,10], "ODS"."SERVICE"[NUMBER,22]
 129 - "S".ROWID[ROWID,10]
 130 - "S"."SE_CODE"[VARCHAR2,30]
 132 - "T"."LPU"[NUMBER,22]
 133 - "T".ROWID[ROWID,10]
 136 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 138 - "US"."ID"[NUMBER,22]
 140 - (#keys=0) MAX("K2"."IS_REPEAT")[22]
 141 - "K2"."IS_REPEAT"[NUMBER,22]
 142 - "K2".ROWID[ROWID,10]
 143 - "K1"."ID"[NUMBER,22]
 144 - "K1".ROWID[ROWID,10]
 145 - "K2".ROWID[ROWID,10]
 146 - "K2"."IS_REPEAT"[NUMBER,22]
 147 - (#keys=0) MAX("J3"."VAL_RESULT")[22]
 148 - "J3"."VAL_RESULT"[NUMBER,22]
 149 - "J3"."VAL_RESULT"[NUMBER,22], "DL"."STATUS"[NUMBER,22]
 150 - "J3"."VAL_RESULT"[NUMBER,22], "J3"."DIR_LINE"[NUMBER,22]
 151 - "J2"."ID"[NUMBER,22]
 152 - "J1"."ID"[NUMBER,22]
 153 - "J1".ROWID[ROWID,10]
 154 - "J2"."ID"[NUMBER,22]
 155 - "J2".ROWID[ROWID,10]
 156 - "J3"."VAL_RESULT"[NUMBER,22], "J3"."DIR_LINE"[NUMBER,22]
 157 - "J3".ROWID[ROWID,10]
 158 - "DL"."STATUS"[NUMBER,22]
 159 - "DL".ROWID[ROWID,10]
 160 - "PC"."NORM"[NUMBER,22]
 161 - "PC"."NORM"[NUMBER,22]
 162 - "C"."CONCLUSION"[NUMBER,22]
 163 - "C"."CID"[NUMBER,22], "C"."CONCLUSION"[NUMBER,22]
 164 - "C".ROWID[ROWID,10]
 167 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 169 - "US"."ID"[NUMBER,22]
 171 - "PC"."NORM"[NUMBER,22]
 172 - "PCC"."NORM"[NUMBER,22]
 173 - "PCC"."NORM"[NUMBER,22]
 174 - "PCC".ROWID[ROWID,10]
 177 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 179 - "US"."ID"[NUMBER,22]
 181 - "PCSOR"."IS_TRUE_DISEASE"[NUMBER,22], "PC"."NORM"[NUMBER,22]
 182 - "PCSOR"."CID"[NUMBER,22], "PCSOR"."IS_TRUE_DISEASE"[NUMBER,22], "PC"."NORM"[NUMBER,22]
 183 - "PCSOR"."CID"[NUMBER,22], "PCSOR"."IS_TRUE_DISEASE"[NUMBER,22]
 184 - "PCSOR".ROWID[ROWID,10]
 185 - "PC"."NORM"[NUMBER,22]
 186 - "PCC"."NORM"[NUMBER,22]
 187 - "PCC"."NORM"[NUMBER,22]
 188 - "PCC".ROWID[ROWID,10]
 191 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 193 - "US"."ID"[NUMBER,22]
 197 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 199 - "US"."ID"[NUMBER,22]
 201 - (#keys=0) LISTAGG(SYS_OP_CL2C(CASE COALESCE("PCT"."PCT_CODE",0) WHEN 1 THEN "PCC"."ZAKL" /*+ LOB_BY_VALUE */  WHEN 9 THEN "PCC"."ZAKL" /*+ LOB_BY_VALUE */  WHEN 10 THEN 
       "PCC"."ZAKL" /*+ LOB_BY_VALUE */  ELSE NULL END ),NULL) WITHIN GROUP ( ORDER BY "PC"."ID")[4000]
 202 - "PC"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCC"."ZAKL" /*+ LOB_BY_VALUE */ [LOB,4000]
 203 - "PC"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22]
 204 - "PC"."ID"[NUMBER,22], "PC"."PROF_CARD_TYPE"[NUMBER,22]
 205 - "PC".ROWID[ROWID,10], "PC"."ID"[NUMBER,22]
 206 - "PCT"."PCT_CODE"[NUMBER,22]
 207 - "PCT".ROWID[ROWID,10]
 208 - "PCC"."ZAKL" /*+ LOB_BY_VALUE */ [LOB,4000]
 209 - "PCC".ROWID[ROWID,10]
 210 - "MVD"."MKB_NAME"[VARCHAR2,500]
 211 - "MVD"."MKB_NAME"[VARCHAR2,500]
 212 - "MVD".ROWID[ROWID,10]
 213 - "VD"."MKB"[NUMBER,22]
 214 - "VD".ROWID[ROWID,10], "VD"."MKB"[NUMBER,22]
 215 - "MVD".ROWID[ROWID,10]
 216 - "MVD"."MKB_NAME"[VARCHAR2,500]
 217 - (#keys=0) COUNT(*)[22]
 219 - "T"."LPU"[NUMBER,22], "T"."LPU"[NUMBER,22]
 220 - "T"."LPU"[NUMBER,22], "T".ROWID[ROWID,10]
 221 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 222 - "T".ROWID[ROWID,10]
 223 - "T".ROWID[ROWID,10]
 224 - "T"."LPU"[NUMBER,22]
 227 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 229 - "US"."ID"[NUMBER,22]
 233 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 235 - "US"."ID"[NUMBER,22]
 237 - (#keys=0) COUNT(*)[22]
 239 - "ERROR_MSG"[VARCHAR2,4000]
 240 - "ID"[NUMBER,22]
 241 - "INT_HL7V3_MSGS".ROWID[ROWID,10]
 242 - "ERROR_MSG"[VARCHAR2,4000]
 243 - "INT_HL7V3_MSGS".ROWID[ROWID,10]
 244 - (#keys=0) SUM(CASE  WHEN >0 THEN 1 ELSE 0 END )[22]
 245 - "T"."ID"[NUMBER,22]
 246 - "T"."LPU"[NUMBER,22], "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 247 - "T"."LPU"[NUMBER,22], "T".ROWID[ROWID,10]
 248 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 249 - "T".ROWID[ROWID,10]
 250 - "T".ROWID[ROWID,10]
 251 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 254 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 256 - "US"."ID"[NUMBER,22]
 260 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 262 - "US"."ID"[NUMBER,22]
 264 - (#keys=0) COUNT(*)[22]
 266 - "ERROR_MSG"[VARCHAR2,4000]
 267 - "ID"[NUMBER,22]
 268 - "INT_HL7V3_MSGS".ROWID[ROWID,10]
 269 - "ERROR_MSG"[VARCHAR2,4000]
 270 - "INT_HL7V3_MSGS".ROWID[ROWID,10]
 271 - (#keys=0) SUM(CASE  WHEN >0 THEN 1 ELSE 0 END )[22]
 272 - "T"."ID"[NUMBER,22]
 273 - "T"."LPU"[NUMBER,22], "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 274 - "T"."LPU"[NUMBER,22], "T".ROWID[ROWID,10]
 275 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 276 - "T".ROWID[ROWID,10]
 277 - "T".ROWID[ROWID,10]
 278 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 281 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 283 - "US"."ID"[NUMBER,22]
 287 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 289 - "US"."ID"[NUMBER,22]
 291 - (#keys=0) COUNT(*)[22]
 293 - "T"."LPU"[NUMBER,22], "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 294 - "T"."LPU"[NUMBER,22], "T".ROWID[ROWID,10]
 295 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 296 - "T".ROWID[ROWID,10]
 297 - "T".ROWID[ROWID,10]
 298 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 302 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 304 - "US"."ID"[NUMBER,22]
 308 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 310 - "US"."ID"[NUMBER,22]
 312 - (#keys=0) COUNT(*)[22]
 314 - "T"."LPU"[NUMBER,22], "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 315 - "T"."LPU"[NUMBER,22], "T".ROWID[ROWID,10]
 316 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 317 - "T".ROWID[ROWID,10]
 318 - "T".ROWID[ROWID,10]
 319 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 323 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 325 - "US"."ID"[NUMBER,22]
 329 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 331 - "US"."ID"[NUMBER,22]
 333 - (#keys=0) MAX("T1"."VIS_DATE")[7]
 334 - "T1"."VIS_DATE"[DATE,7]
 335 - "PCSOR"."CID"[NUMBER,22], "T1"."VIS_DATE"[DATE,7], "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 336 - "PCSOR"."CID"[NUMBER,22], "T1"."VIS_DATE"[DATE,7]
 337 - "PCSOR"."CID"[NUMBER,22], "PCSOR"."AT_OTHER_VISIT"[NUMBER,22]
 338 - "PCSOR".ROWID[ROWID,10]
 339 - "T1"."VIS_DATE"[DATE,7]
 340 - "T1".ROWID[ROWID,10]
 341 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 344 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 346 - "US"."ID"[NUMBER,22]
 349 - "US"."ID"[NUMBER,22]
 351 - (#keys=0) COUNT(*)[22]
 353 - "T"."CID"[NUMBER,22]
 354 - "T".ROWID[ROWID,10]
 357 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 359 - "US"."ID"[NUMBER,22]
 361 - "J3"."STR_VALUE"[VARCHAR2,2000], "J3"."NUM_VALUE"[NUMBER,22], "J4"."NAME"[VARCHAR2,200], "J5"."MNEMOCODE"[VARCHAR2,60]
 362 - "J3"."STR_VALUE"[VARCHAR2,2000], "J3"."NUM_VALUE"[NUMBER,22], "J4"."NAME"[VARCHAR2,200], "J5"."MNEMOCODE"[VARCHAR2,60]
 363 - "J3"."STR_VALUE"[VARCHAR2,2000], "J3"."NUM_VALUE"[NUMBER,22], "J4"."NAME"[VARCHAR2,200], "J5".ROWID[ROWID,10]
 364 - "J3"."STR_VALUE"[VARCHAR2,2000], "J3"."NUM_VALUE"[NUMBER,22], "J4"."NAME"[VARCHAR2,200], "J4"."MEASURE"[NUMBER,22]
 365 - "J3"."STR_VALUE"[VARCHAR2,2000], "J3"."NUM_VALUE"[NUMBER,22], "J4"."NAME"[VARCHAR2,200], "J4"."MEASURE"[NUMBER,22], "DL"."STATUS"[NUMBER,22]
 366 - "J3"."STR_VALUE"[VARCHAR2,2000], "J3"."NUM_VALUE"[NUMBER,22], "J3"."DIR_LINE"[NUMBER,22], "J4"."NAME"[VARCHAR2,200], "J4"."MEASURE"[NUMBER,22]
 367 - "J3"."RESULT"[NUMBER,22], "J3"."STR_VALUE"[VARCHAR2,2000], "J3"."NUM_VALUE"[NUMBER,22], "J3"."DIR_LINE"[NUMBER,22]
 368 - "J2"."ID"[NUMBER,22]
 369 - "J1"."ID"[NUMBER,22]
 370 - "J1".ROWID[ROWID,10]
 371 - "J2"."ID"[NUMBER,22]
 372 - "J2".ROWID[ROWID,10]
 373 - "J3"."RESULT"[NUMBER,22], "J3"."STR_VALUE"[VARCHAR2,2000], "J3"."NUM_VALUE"[NUMBER,22], "J3"."DIR_LINE"[NUMBER,22]
 374 - "J3".ROWID[ROWID,10]
 375 - "J4"."NAME"[VARCHAR2,200], "J4"."MEASURE"[NUMBER,22]
 376 - "J4".ROWID[ROWID,10]
 377 - "DL"."STATUS"[NUMBER,22]
 378 - "DL".ROWID[ROWID,10]
 379 - "J5".ROWID[ROWID,10]
 380 - "J5"."MNEMOCODE"[VARCHAR2,60]
 381 - "PCT"."MSEK"[NUMBER,22]
 382 - "PCT"."MSEK"[NUMBER,22]
 383 - "PC"."PROF_CARD_TYPE"[NUMBER,22]
 384 - "PC".ROWID[ROWID,10]
 385 - "PCT"."MSEK"[NUMBER,22]
 386 - "PCT".ROWID[ROWID,10]
 387 - (#keys=0) COUNT(*)[22]
 389 - "S".ROWID[ROWID,10]
 390 - "SD"."PID"[NUMBER,22]
 391 - "DL"."ID"[NUMBER,22]
 392 - "DS"."ID"[NUMBER,22]
 393 - "DS".ROWID[ROWID,10]
 394 - "DL"."ID"[NUMBER,22]
 395 - "DL".ROWID[ROWID,10]
 396 - "SD"."PID"[NUMBER,22]
 397 - "SD".ROWID[ROWID,10]
 398 - "S".ROWID[ROWID,10]
 400 - "PC"."C_NAME"[VARCHAR2,250]
 401 - "PCS"."CID"[NUMBER,22], "PCSOR"."CID"[NUMBER,22], "PC"."C_NAME"[VARCHAR2,250]
 402 - "PCS"."CID"[NUMBER,22], "PCSOR"."CID"[NUMBER,22], "PCSOR"."IS_TRUE_DISEASE"[NUMBER,22]
 403 - "PCS"."CID"[NUMBER,22]
 404 - "PCS".ROWID[ROWID,10]
 405 - "PCSOR"."CID"[NUMBER,22], "PCSOR"."IS_TRUE_DISEASE"[NUMBER,22]
 406 - "PCSOR".ROWID[ROWID,10]
 407 - "PC"."C_NAME"[VARCHAR2,250]
 408 - "PCC"."C_NAME"[VARCHAR2,250]
 409 - "PCC"."C_NAME"[VARCHAR2,250]
 410 - "PCC".ROWID[ROWID,10]
 413 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 415 - "US"."ID"[NUMBER,22]
 419 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 421 - "US"."ID"[NUMBER,22]
 425 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 427 - "US"."ID"[NUMBER,22]
 429 - "PCSOR"."ZAKL"[VARCHAR2,4000]
 430 - "PCSOR"."CID"[NUMBER,22], "PCSOR"."ZAKL"[VARCHAR2,4000]
 431 - "PCSOR".ROWID[ROWID,10]
 434 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 436 - "US"."ID"[NUMBER,22]
 438 - (#keys=0) COUNT(*)[22]
 440 - "T"."CID"[NUMBER,22]
 441 - "T".ROWID[ROWID,10]
 444 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 446 - "US"."ID"[NUMBER,22]
 448 - (#keys=0) COUNT(*)[22]
 450 - "DSS"."VERSION"[NUMBER,22]
 451 - "DSS"."VERSION"[NUMBER,22]
 452 - "DSS"."VERSION"[NUMBER,22], "DS".ROWID[ROWID,10]
 453 - "DSS"."VERSION"[NUMBER,22], "DSS"."DISP_SERVICE"[NUMBER,22]
 454 - "S"."ID"[NUMBER,22]
 455 - "DSS"."VERSION"[NUMBER,22], "DSS"."DISP_SERVICE"[NUMBER,22]
 456 - "DSS".ROWID[ROWID,10]
 457 - "DS".ROWID[ROWID,10]
 462 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 464 - "US"."ID"[NUMBER,22]
 466 - "T"."S_ORDER"[NUMBER,22]
 467 - "T"."S_ORDER"[NUMBER,22]
 468 - "T"."CID"[NUMBER,22], "T"."S_ORDER"[NUMBER,22]
 469 - "T".ROWID[ROWID,10]
 470 - STRDEF[BM VAR, 10], STRDEF[BM VAR, 10], STRDEF[BM VAR, 32496]
 471 - STRDEF[BM VAR, 10], STRDEF[BM VAR, 10], STRDEF[BM VAR, 32496]
 472 - "T".ROWID[ROWID,10]
 473 - STRDEF[BM VAR, 10], STRDEF[BM VAR, 10], STRDEF[BM VAR, 32496]
 474 - "T".ROWID[ROWID,10]
 477 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 479 - "US"."ID"[NUMBER,22]
 481 - (#keys=0) COUNT(*)[22]
 483 - "PC"."CID"[NUMBER,22]
 484 - "PC".ROWID[ROWID,10]
 487 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 489 - "US"."ID"[NUMBER,22]
 491 - (#keys=0) COUNT(*)[22]
 493 - "T"."LPU"[NUMBER,22]
 494 - "T".ROWID[ROWID,10]
 497 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 499 - "US"."ID"[NUMBER,22]
 501 - (#keys=0) COUNT(*)[22]
 504 - "T"."LPU"[NUMBER,22], "T"."LPU"[NUMBER,22], "T"."CID"[NUMBER,22]
 505 - "T"."LPU"[NUMBER,22], "T"."LPU"[NUMBER,22], "T"."PID"[NUMBER,22], "T"."CID"[NUMBER,22]
 506 - "T"."LPU"[NUMBER,22], "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 507 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22], "T"."HID"[NUMBER,22]
 508 - "T".ROWID[ROWID,10], "T"."ID"[NUMBER,22]
 509 - "T"."ID"[NUMBER,22], "T"."LPU"[NUMBER,22]
 510 - "T".ROWID[ROWID,10]
 511 - STRDEF[BM VAR, 10], STRDEF[BM VAR, 10], STRDEF[BM VAR, 32496]
 512 - STRDEF[BM VAR, 10], STRDEF[BM VAR, 10], STRDEF[BM VAR, 32496]
 513 - "T".ROWID[ROWID,10]
 514 - STRDEF[BM VAR, 10], STRDEF[BM VAR, 10], STRDEF[BM VAR, 32496]
 515 - "T".ROWID[ROWID,10]
 516 - "T"."PID"[NUMBER,22], "T"."CID"[NUMBER,22]
 517 - "T".ROWID[ROWID,10]
 521 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 523 - "US"."ID"[NUMBER,22]
 527 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 529 - "US"."ID"[NUMBER,22]
 533 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 535 - "US"."ID"[NUMBER,22]
 539 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 541 - "US"."ID"[NUMBER,22]
 543 - "V"."ID"[NUMBER,22], "V"."LPU"[NUMBER,22], "V"."PID"[NUMBER,22], "V"."SERVICE_ID"[NUMBER,22], "V"."SERVICE"[VARCHAR2,30], "V"."SERVICE_NAME"[VARCHAR2,1000], 
       "V"."SSERVICE_TYPE"[VARCHAR2,60], "V"."NSERVICE_TYPE"[NUMBER,22], "V"."DIRECTION_SERVICE"[NUMBER,22], "V"."NSERV_STATUS"[NUMBER,22], "V"."REC_DATE"[DATE,7], 
       "V"."SSERV_STATUS"[VARCHAR2,4000], "V"."SOPEN_VISIT"[VARCHAR2,8], "V"."VISIT_ID"[NUMBER,22], "V"."VISIT_EMPLOYER"[NUMBER,22], "V"."VISIT_DATE"[DATE,7], 
       "V"."VISIT_MKB"[VARCHAR2,500], "V"."LABMED_IS_REPEAT"[NUMBER,22], "V"."LABMED_VAL_RESULT"[NUMBER,22], "V"."LABMED_VAL_RESULT_STR"[VARCHAR2,2263], "V"."STATE"[NUMBER,22], 
       "V"."IS_NAZNACH"[NUMBER,22], "V"."DS_HID"[NUMBER,22], "V"."NSAMPLE_IN_WORK"[NUMBER,2], "V"."DIR_ID"[NUMBER,22], "V"."VAL_RESULT_STR"[VARCHAR2,4000], "V"."DISEASECASE"[NUMBER,22], 
       "V"."DS_ID"[NUMBER,22], "V"."IS_COMMENT"[NUMBER,2], "V"."IS_MSEK"[NUMBER,22], "V"."NURSE_USER_TEMPLATES"[NUMBER,22], "V"."OUT_DIR_STATUS"[NUMBER,22], 
       "V"."FILTER_SERVICE"[NUMBER,2], "V"."RN"[NUMBER,22], "V"."ZAKL"[LOB,4000], "V"."PROF_CARD_MODEL"[NUMBER,22], "PCT_ID"[NUMBER,22], "PCT_CODE"[NUMBER,22], "V"."ARMS"[NUMBER,22], 
       "V"."GAI"[NUMBER,22], "V"."SERVICES_STR_COUNT"[NUMBER,22]
 544 - (#keys=2) "from$_subquery$_064"."QCSJ_C000000005500000"[NUMBER,22], "from$_subquery$_064"."VISIT_DATE"[DATE,7], "PCC"."ZAKL"[LOB,4000], 
       "from$_subquery$_064"."QCSJ_C000000005500002"[NUMBER,22], "S"."PID"[NUMBER,22], "from$_subquery$_064"."SERVICE_ID"[NUMBER,22], "S"."SERVICE"[VARCHAR2,30], 
       "from$_subquery$_064"."SERVICE_NAME"[VARCHAR2,1000], "from$_subquery$_064"."SSERVICE_TYPE"[VARCHAR2,60], "from$_subquery$_064"."NSERVICE_TYPE"[NUMBER,22], 
       "from$_subquery$_064"."DIRECTION_SERVICE"[NUMBER,22], "from$_subquery$_064"."NSERV_STATUS"[NUMBER,22], "from$_subquery$_064"."REC_DATE"[DATE,7], 
       "from$_subquery$_064"."SSERV_STATUS"[VARCHAR2,4000], "from$_subquery$_064"."SOPEN_VISIT"[VARCHAR2,8], "from$_subquery$_064"."VISIT_ID"[NUMBER,22], 
       "from$_subquery$_064"."VISIT_EMPLOYER"[NUMBER,22], "from$_subquery$_064"."FILTER_SERVICE"[NUMBER,2], "from$_subquery$_064"."VISIT_MKB"[VARCHAR2,500], 
       "from$_subquery$_064"."LABMED_IS_REPEAT"[NUMBER,22], "from$_subquery$_064"."LABMED_VAL_RESULT"[NUMBER,22], "from$_subquery$_064"."LABMED_VAL_RESULT_STR"[VARCHAR2,2263], 
       "from$_subquery$_064"."STATE"[NUMBER,22], "from$_subquery$_064"."IS_NAZNACH"[NUMBER,22], "from$_subquery$_064"."DS_HID"[NUMBER,22], 
       "from$_subquery$_064"."NSAMPLE_IN_WORK"[NUMBER,2], "from$_subquery$_064"."DIR_ID"[NUMBER,22], "from$_subquery$_064"."VAL_RESULT_STR"[VARCHAR2,4000], 
       "from$_subquery$_064"."QCSJ_C000000005500006"[NUMBER,22], "from$_subquery$_064"."DS_ID"[NUMBER,22], "from$_subquery$_064"."IS_COMMENT"[NUMBER,2], 
       "from$_subquery$_064"."IS_MSEK"[NUMBER,22], "from$_subquery$_064"."NURSE_USER_TEMPLATES"[NUMBER,22], "from$_subquery$_064"."OUT_DIR_STATUS"[NUMBER,22], 
       "from$_subquery$_064"."PROF_CARD_MODEL"[NUMBER,22], "from$_subquery$_064"."ID"[NUMBER,22], "from$_subquery$_064"."PCT_CODE"[NUMBER,22], "from$_subquery$_064"."ARMS"[NUMBER,22], 
       "from$_subquery$_064"."GAI"[NUMBER,22], ROW_NUMBER() OVER ( PARTITION BY "from$_subquery$_064"."QCSJ_C000000005500000" ORDER BY "from$_subquery$_064"."VISIT_DATE")[22]
 545 - "from$_subquery$_064"."QCSJ_C000000005500000"[NUMBER,22], "from$_subquery$_064"."QCSJ_C000000005500002"[NUMBER,22], "S"."PID"[NUMBER,22], 
       "from$_subquery$_064"."SERVICE_ID"[NUMBER,22], "S"."SERVICE"[VARCHAR2,30], "from$_subquery$_064"."SERVICE_NAME"[VARCHAR2,1000], "from$_subquery$_064"."SSERVICE_TYPE"[VARCHAR2,60], 
       "from$_subquery$_064"."NSERVICE_TYPE"[NUMBER,22], "from$_subquery$_064"."DIRECTION_SERVICE"[NUMBER,22], "from$_subquery$_064"."NSERV_STATUS"[NUMBER,22], 
       "from$_subquery$_064"."REC_DATE"[DATE,7], "from$_subquery$_064"."SSERV_STATUS"[VARCHAR2,4000], "from$_subquery$_064"."SOPEN_VISIT"[VARCHAR2,8], 
       "from$_subquery$_064"."VISIT_ID"[NUMBER,22], "from$_subquery$_064"."VISIT_EMPLOYER"[NUMBER,22], "from$_subquery$_064"."VISIT_DATE"[DATE,7], 
       "from$_subquery$_064"."VISIT_MKB"[VARCHAR2,500], "from$_subquery$_064"."LABMED_IS_REPEAT"[NUMBER,22], "from$_subquery$_064"."LABMED_VAL_RESULT"[NUMBER,22], 
       "from$_subquery$_064"."LABMED_VAL_RESULT_STR"[VARCHAR2,2263], "from$_subquery$_064"."STATE"[NUMBER,22], "from$_subquery$_064"."IS_NAZNACH"[NUMBER,22], 
       "from$_subquery$_064"."DS_HID"[NUMBER,22], "from$_subquery$_064"."NSAMPLE_IN_WORK"[NUMBER,2], "from$_subquery$_064"."DIR_ID"[NUMBER,22], 
       "from$_subquery$_064"."VAL_RESULT_STR"[VARCHAR2,4000], "from$_subquery$_064"."QCSJ_C000000005500006"[NUMBER,22], "from$_subquery$_064"."DS_ID"[NUMBER,22], 
       "from$_subquery$_064"."IS_COMMENT"[NUMBER,2], "from$_subquery$_064"."IS_MSEK"[NUMBER,22], "from$_subquery$_064"."NURSE_USER_TEMPLATES"[NUMBER,22], 
       "from$_subquery$_064"."OUT_DIR_STATUS"[NUMBER,22], "from$_subquery$_064"."PROF_CARD_MODEL"[NUMBER,22], "from$_subquery$_064"."ID"[NUMBER,22], 
       "from$_subquery$_064"."PCT_CODE"[NUMBER,22], "from$_subquery$_064"."ARMS"[NUMBER,22], "from$_subquery$_064"."GAI"[NUMBER,22], "from$_subquery$_064"."FILTER_SERVICE"[NUMBER,2], 
       "PCC"."ZAKL"[LOB,4000]
 546 - "from$_subquery$_064"."QCSJ_C000000005500000"[NUMBER,22], "from$_subquery$_064"."QCSJ_C000000005500002"[NUMBER,22], "S"."PID"[NUMBER,22], 
       "from$_subquery$_064"."SERVICE_ID"[NUMBER,22], "S"."SERVICE"[VARCHAR2,30], "from$_subquery$_064"."SERVICE_NAME"[VARCHAR2,1000], "from$_subquery$_064"."SSERVICE_TYPE"[VARCHAR2,60], 
       "from$_subquery$_064"."NSERVICE_TYPE"[NUMBER,22], "from$_subquery$_064"."DIRECTION_SERVICE"[NUMBER,22], "from$_subquery$_064"."NSERV_STATUS"[NUMBER,22], 
       "from$_subquery$_064"."REC_DATE"[DATE,7], "from$_subquery$_064"."SSERV_STATUS"[VARCHAR2,4000], "from$_subquery$_064"."SOPEN_VISIT"[VARCHAR2,8], 
       "from$_subquery$_064"."VISIT_ID"[NUMBER,22], "from$_subquery$_064"."VISIT_EMPLOYER"[NUMBER,22], "from$_subquery$_064"."VISIT_DATE"[DATE,7], 
       "from$_subquery$_064"."VISIT_MKB"[VARCHAR2,500], "from$_subquery$_064"."LABMED_IS_REPEAT"[NUMBER,22], "from$_subquery$_064"."LABMED_VAL_RESULT"[NUMBER,22], 
       "from$_subquery$_064"."LABMED_VAL_RESULT_STR"[VARCHAR2,2263], "from$_subquery$_064"."STATE"[NUMBER,22], "from$_subquery$_064"."IS_NAZNACH"[NUMBER,22], 
       "from$_subquery$_064"."DS_HID"[NUMBER,22], "from$_subquery$_064"."NSAMPLE_IN_WORK"[NUMBER,2], "from$_subquery$_064"."DIR_ID"[NUMBER,22], 
       "from$_subquery$_064"."VAL_RESULT_STR"[VARCHAR2,4000], "from$_subquery$_064"."QCSJ_C000000005500006"[NUMBER,22], "from$_subquery$_064"."DS_ID"[NUMBER,22], 
       "from$_subquery$_064"."IS_COMMENT"[NUMBER,2], "from$_subquery$_064"."IS_MSEK"[NUMBER,22], "from$_subquery$_064"."NURSE_USER_TEMPLATES"[NUMBER,22], 
       "from$_subquery$_064"."OUT_DIR_STATUS"[NUMBER,22], "from$_subquery$_064"."PROF_CARD_MODEL"[NUMBER,22], "from$_subquery$_064"."ID"[NUMBER,22], 
       "from$_subquery$_064"."PCT_CODE"[NUMBER,22], "from$_subquery$_064"."ARMS"[NUMBER,22], "from$_subquery$_064"."GAI"[NUMBER,22], "from$_subquery$_064"."FILTER_SERVICE"[NUMBER,2]
 547 - "PCS"."PID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], "PCT"."GAI"[NUMBER,22], 
       "PCS"."ID"[NUMBER,22], "EMPA"."LASTNAME"[VARCHAR2,40], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."STATE"[NUMBER,22], "PCS"."STATE_DATE"[DATE,7], 
       "PCS"."DIRECTION"[NUMBER,22], "SERV"."SE_CODE"[VARCHAR2,30], "SERV"."SE_NAME"[VARCHAR2,1000], "SERV"."SE_TYPE"[NUMBER,22], "PCDIRS"."DIR_SERV"[NUMBER,22], "DIRS"."ID"[NUMBER,22], 
       "DIRS"."HID"[NUMBER,22], "DIRS"."EMPLOYER_TO"[NUMBER,22], "DIRS"."CABLAB_TO"[NUMBER,22], "DIRS"."REC_DATE"[DATE,7], "DIRS"."DISEASECASE"[NUMBER,22], 
       "DIRS"."SERV_STATUS"[NUMBER,22], "DIRS"."S_COMMNET"[VARCHAR2,1200], "DIRS"."SERV_STATUS_REASON"[VARCHAR2,250], "DIRS"."NURSE_USER_TEMPLATES"[NUMBER,22], 
       "EMP"."KOD_VRACHA"[VARCHAR2,11], "V"."ID"[NUMBER,22], "V"."EMPLOYER"[NUMBER,22], "V"."VISIT_DATE"[DATE,7], "DIR"."ID"[NUMBER,22], "DIR"."REG_VISIT"[NUMBER,22], 
       "DIR"."DOC_COMMENT"[VARCHAR2,4000], "EMPA"."FIRSTNAME"[VARCHAR2,40], "EMPA"."SURNAME"[VARCHAR2,40], "EX"."FILTER_SERVICE"[NUMBER,2]
 548 - (#keys=1) "PCS"."PID"[NUMBER,22], "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], 
       "PCT"."ARMS"[NUMBER,22], "PCT"."GAI"[NUMBER,22], "PCS"."ID"[NUMBER,22], "EMPA"."LASTNAME"[VARCHAR2,40], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."CID"[NUMBER,22], 
       "PCS"."STATE"[NUMBER,22], "PCS"."STATE_DATE"[DATE,7], "PCS"."DIRECTION"[NUMBER,22], "SERV"."SE_CODE"[VARCHAR2,30], "SERV"."SE_NAME"[VARCHAR2,1000], "SERV"."SE_TYPE"[NUMBER,22], 
       "PCDIRS"."DIR_SERV"[NUMBER,22], "DIRS"."ID"[NUMBER,22], "DIRS"."HID"[NUMBER,22], "DIRS"."EMPLOYER_TO"[NUMBER,22], "DIRS"."CABLAB_TO"[NUMBER,22], "DIRS"."REC_DATE"[DATE,7], 
       "DIRS"."DISEASECASE"[NUMBER,22], "DIRS"."SERV_STATUS"[NUMBER,22], "DIRS"."S_COMMNET"[VARCHAR2,1200], "DIRS"."SERV_STATUS_REASON"[VARCHAR2,250], 
       "DIRS"."NURSE_USER_TEMPLATES"[NUMBER,22], "EMP"."KOD_VRACHA"[VARCHAR2,11], "V"."ID"[NUMBER,22], "V"."EMPLOYER"[NUMBER,22], "V"."VISIT_DATE"[DATE,7], "DIR"."ID"[NUMBER,22], 
       "DIR"."REG_VISIT"[NUMBER,22], "DIR"."DOC_COMMENT"[VARCHAR2,4000], "EMPA"."FIRSTNAME"[VARCHAR2,40], "EMPA"."SURNAME"[VARCHAR2,40], "EX"."FILTER_SERVICE"[NUMBER,2]
 549 - "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], 
       "PCT"."GAI"[NUMBER,22], "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."CID"[NUMBER,22], "PCS"."STATE"[NUMBER,22], 
       "PCS"."STATE_DATE"[DATE,7], "PCS"."DIRECTION"[NUMBER,22], "SERV"."SE_CODE"[VARCHAR2,30], "SERV"."SE_NAME"[VARCHAR2,1000], "SERV"."SE_TYPE"[NUMBER,22], 
       "PCDIRS"."DIR_SERV"[NUMBER,22], "DIRS"."ID"[NUMBER,22], "DIRS"."HID"[NUMBER,22], "DIRS"."EMPLOYER_TO"[NUMBER,22], "DIRS"."CABLAB_TO"[NUMBER,22], "DIRS"."REC_DATE"[DATE,7], 
       "DIRS"."DISEASECASE"[NUMBER,22], "DIRS"."SERV_STATUS"[NUMBER,22], "DIRS"."S_COMMNET"[VARCHAR2,1200], "DIRS"."SERV_STATUS_REASON"[VARCHAR2,250], 
       "DIRS"."NURSE_USER_TEMPLATES"[NUMBER,22], "EMP"."KOD_VRACHA"[VARCHAR2,11], "V"."ID"[NUMBER,22], "V"."EMPLOYER"[NUMBER,22], "V"."VISIT_DATE"[DATE,7], "DIR"."ID"[NUMBER,22], 
       "DIR"."REG_VISIT"[NUMBER,22], "DIR"."DOC_COMMENT"[VARCHAR2,4000], "EMPA"."FIRSTNAME"[VARCHAR2,40], "EMPA"."SURNAME"[VARCHAR2,40], "EMPA"."LASTNAME"[VARCHAR2,40]
 550 - "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], 
       "PCT"."GAI"[NUMBER,22], "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."CID"[NUMBER,22], "PCS"."STATE"[NUMBER,22], 
       "PCS"."STATE_DATE"[DATE,7], "PCS"."DIRECTION"[NUMBER,22], "SERV"."SE_CODE"[VARCHAR2,30], "SERV"."SE_NAME"[VARCHAR2,1000], "SERV"."SE_TYPE"[NUMBER,22], 
       "PCDIRS"."DIR_SERV"[NUMBER,22], "DIRS"."ID"[NUMBER,22], "DIRS"."HID"[NUMBER,22], "DIRS"."EMPLOYER_TO"[NUMBER,22], "DIRS"."CABLAB_TO"[NUMBER,22], "DIRS"."REC_DATE"[DATE,7], 
       "DIRS"."DISEASECASE"[NUMBER,22], "DIRS"."SERV_STATUS"[NUMBER,22], "DIRS"."S_COMMNET"[VARCHAR2,1200], "DIRS"."SERV_STATUS_REASON"[VARCHAR2,250], 
       "DIRS"."NURSE_USER_TEMPLATES"[NUMBER,22], "EMP"."KOD_VRACHA"[VARCHAR2,11], "EMP"."AGENT"[NUMBER,22], "V"."ID"[NUMBER,22], "V"."EMPLOYER"[NUMBER,22], "V"."VISIT_DATE"[DATE,7], 
       "DIR"."ID"[NUMBER,22], "DIR"."REG_VISIT"[NUMBER,22], "DIR"."DOC_COMMENT"[VARCHAR2,4000]
 551 - "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], 
       "PCT"."GAI"[NUMBER,22], "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."CID"[NUMBER,22], "PCS"."STATE"[NUMBER,22], 
       "PCS"."STATE_DATE"[DATE,7], "PCS"."DIRECTION"[NUMBER,22], "SERV"."SE_CODE"[VARCHAR2,30], "SERV"."SE_NAME"[VARCHAR2,1000], "SERV"."SE_TYPE"[NUMBER,22], 
       "PCDIRS"."DIR_SERV"[NUMBER,22], "DIRS"."ID"[NUMBER,22], "DIRS"."PID"[NUMBER,22], "DIRS"."HID"[NUMBER,22], "DIRS"."EMPLOYER_TO"[NUMBER,22], "DIRS"."CABLAB_TO"[NUMBER,22], 
       "DIRS"."REC_DATE"[DATE,7], "DIRS"."DISEASECASE"[NUMBER,22], "DIRS"."SERV_STATUS"[NUMBER,22], "DIRS"."S_COMMNET"[VARCHAR2,1200], "DIRS"."SERV_STATUS_REASON"[VARCHAR2,250], 
       "DIRS"."NURSE_USER_TEMPLATES"[NUMBER,22], "EMP"."KOD_VRACHA"[VARCHAR2,11], "EMP"."AGENT"[NUMBER,22], "V"."ID"[NUMBER,22], "V"."EMPLOYER"[NUMBER,22], "V"."VISIT_DATE"[DATE,7]
 552 - "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], 
       "PCT"."GAI"[NUMBER,22], "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."CID"[NUMBER,22], "PCS"."STATE"[NUMBER,22], 
       "PCS"."STATE_DATE"[DATE,7], "PCS"."DIRECTION"[NUMBER,22], "SERV"."SE_CODE"[VARCHAR2,30], "SERV"."SE_NAME"[VARCHAR2,1000], "SERV"."SE_TYPE"[NUMBER,22], 
       "PCDIRS"."DIR_SERV"[NUMBER,22], "DIRS"."ID"[NUMBER,22], "DIRS"."PID"[NUMBER,22], "DIRS"."HID"[NUMBER,22], "DIRS"."EMPLOYER_TO"[NUMBER,22], "DIRS"."CABLAB_TO"[NUMBER,22], 
       "DIRS"."REC_DATE"[DATE,7], "DIRS"."DISEASECASE"[NUMBER,22], "DIRS"."SERV_STATUS"[NUMBER,22], "DIRS"."S_COMMNET"[VARCHAR2,1200], "DIRS"."SERV_STATUS_REASON"[VARCHAR2,250], 
       "DIRS"."NURSE_USER_TEMPLATES"[NUMBER,22], "EMP"."KOD_VRACHA"[VARCHAR2,11], "EMP"."AGENT"[NUMBER,22]
 553 - "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], 
       "PCT"."GAI"[NUMBER,22], "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."CID"[NUMBER,22], "PCS"."STATE"[NUMBER,22], 
       "PCS"."STATE_DATE"[DATE,7], "PCS"."DIRECTION"[NUMBER,22], "SERV"."SE_CODE"[VARCHAR2,30], "SERV"."SE_NAME"[VARCHAR2,1000], "SERV"."SE_TYPE"[NUMBER,22], 
       "PCDIRS"."DIR_SERV"[NUMBER,22], "DIRS"."ID"[NUMBER,22], "DIRS"."PID"[NUMBER,22], "DIRS"."HID"[NUMBER,22], "DIRS"."EMPLOYER_TO"[NUMBER,22], "DIRS"."CABLAB_TO"[NUMBER,22], 
       "DIRS"."REC_DATE"[DATE,7], "DIRS"."DISEASECASE"[NUMBER,22], "DIRS"."SERV_STATUS"[NUMBER,22], "DIRS"."S_COMMNET"[VARCHAR2,1200], "DIRS"."SERV_STATUS_REASON"[VARCHAR2,250], 
       "DIRS"."NURSE_USER_TEMPLATES"[NUMBER,22]
 554 - "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], 
       "PCT"."GAI"[NUMBER,22], "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."CID"[NUMBER,22], "PCS"."STATE"[NUMBER,22], 
       "PCS"."STATE_DATE"[DATE,7], "PCS"."DIRECTION"[NUMBER,22], "SERV"."SE_CODE"[VARCHAR2,30], "SERV"."SE_NAME"[VARCHAR2,1000], "SERV"."SE_TYPE"[NUMBER,22], 
       "PCDIRS"."DIR_SERV"[NUMBER,22]
 555 - "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], 
       "PCT"."GAI"[NUMBER,22], "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."CID"[NUMBER,22], "PCS"."STATE"[NUMBER,22], 
       "PCS"."STATE_DATE"[DATE,7], "PCS"."DIRECTION"[NUMBER,22], "SERV"."SE_CODE"[VARCHAR2,30], "SERV"."SE_NAME"[VARCHAR2,1000], "SERV"."SE_TYPE"[NUMBER,22]
 556 - "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], 
       "PCT"."GAI"[NUMBER,22], "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."CID"[NUMBER,22], "PCS"."STATE"[NUMBER,22], 
       "PCS"."STATE_DATE"[DATE,7], "PCS"."DIRECTION"[NUMBER,22]
 557 - "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22], "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], 
       "PCT"."GAI"[NUMBER,22]
 558 - "PC"."PROF_CARD_TYPE"[NUMBER,22], "PC"."CID"[NUMBER,22], "PC"."PROF_CARD_MODEL"[NUMBER,22]
 559 - "PC".ROWID[ROWID,10]
 560 - "PCT"."ID"[NUMBER,22], "PCT"."PCT_CODE"[NUMBER,22], "PCT"."VERSION"[NUMBER,22], "PCT"."ARMS"[NUMBER,22], "PCT"."GAI"[NUMBER,22]
 561 - "PCT".ROWID[ROWID,10], "PCT"."ID"[NUMBER,22]
 562 - "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], "PCS"."SERVICE"[NUMBER,22], "PCS"."LPU"[NUMBER,22], "PCS"."CID"[NUMBER,22], "PCS"."STATE"[NUMBER,22], 
       "PCS"."STATE_DATE"[DATE,7], "PCS"."DIRECTION"[NUMBER,22]
 563 - "PCS".ROWID[ROWID,10], "PCS"."PID"[NUMBER,22]
 564 - "SERV"."SE_CODE"[VARCHAR2,30], "SERV"."SE_NAME"[VARCHAR2,1000], "SERV"."SE_TYPE"[NUMBER,22]
 565 - "SERV".ROWID[ROWID,10]
 566 - "PCDIRS"."DIR_SERV"[NUMBER,22]
 567 - "PCDIRS".ROWID[ROWID,10]
 568 - "DIRS"."ID"[NUMBER,22], "DIRS"."PID"[NUMBER,22], "DIRS"."HID"[NUMBER,22], "DIRS"."EMPLOYER_TO"[NUMBER,22], "DIRS"."CABLAB_TO"[NUMBER,22], "DIRS"."REC_DATE"[DATE,7], 
       "DIRS"."DISEASECASE"[NUMBER,22], "DIRS"."SERV_STATUS"[NUMBER,22], "DIRS"."S_COMMNET"[VARCHAR2,1200], "DIRS"."SERV_STATUS_REASON"[VARCHAR2,250], 
       "DIRS"."NURSE_USER_TEMPLATES"[NUMBER,22]
 569 - "DIRS".ROWID[ROWID,10], "DIRS"."ID"[NUMBER,22]
 570 - "EMP"."KOD_VRACHA"[VARCHAR2,11], "EMP"."AGENT"[NUMBER,22]
 571 - "EMP".ROWID[ROWID,10]
 572 - "V"."ID"[NUMBER,22], "V"."EMPLOYER"[NUMBER,22], "V"."VISIT_DATE"[DATE,7]
 573 - "V".ROWID[ROWID,10]
 574 - "DIR"."ID"[NUMBER,22], "DIR"."REG_VISIT"[NUMBER,22], "DIR"."DOC_COMMENT"[VARCHAR2,4000]
 575 - "DIR".ROWID[ROWID,10], "DIR"."ID"[NUMBER,22]
 576 - "EMPA"."FIRSTNAME"[VARCHAR2,40], "EMPA"."SURNAME"[VARCHAR2,40], "EMPA"."LASTNAME"[VARCHAR2,40]
 577 - "EMPA".ROWID[ROWID,10]
 578 - "EX"."FILTER_SERVICE"[NUMBER,2], "EX"."PID"[NUMBER,22], "EX"."OBR_RANK"[NUMBER,22]
 579 - (#keys=2) "PCS"."PID"[NUMBER,22], "ID"[NUMBER,22], "D_EX_SYSTEM_VALUES".ROWID[ROWID,10], "PCS"."CID"[NUMBER,22], "PID"[NUMBER,22], "VAL_CODE"[VARCHAR2,50], 
       "UNIT"[VARCHAR2,30], "UNIT_ID"[NUMBER,22], "STR_VALUE"[VARCHAR2,4000], "T".ROWID[ROWID,10], "T"."CID"[NUMBER,22], "T"."PID"[NUMBER,22], "T"."DIR_SERV"[NUMBER,22], 
       "PCS".ROWID[ROWID,10], "PCS"."ID"[NUMBER,22], RANK() OVER ( PARTITION BY "PCS"."PID" ORDER BY INTERNAL_FUNCTION("ID") DESC )[22]
 580 - "D_EX_SYSTEM_VALUES".ROWID[ROWID,10], "ID"[NUMBER,22], "PID"[NUMBER,22], "VAL_CODE"[VARCHAR2,50], "UNIT"[VARCHAR2,30], "UNIT_ID"[NUMBER,22], "STR_VALUE"[VARCHAR2,4000], 
       "T".ROWID[ROWID,10], "T"."CID"[NUMBER,22], "T"."PID"[NUMBER,22], "T"."DIR_SERV"[NUMBER,22], "PCS".ROWID[ROWID,10], "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], 
       "PCS"."CID"[NUMBER,22]
 581 - "D_EX_SYSTEM_VALUES".ROWID[ROWID,10], "ID"[NUMBER,22], "PID"[NUMBER,22], "VAL_CODE"[VARCHAR2,50], "UNIT"[VARCHAR2,30], "UNIT_ID"[NUMBER,22], "STR_VALUE"[VARCHAR2,4000], 
       "T".ROWID[ROWID,10], "T"."CID"[NUMBER,22], "T"."PID"[NUMBER,22], "T"."DIR_SERV"[NUMBER,22], "PCS".ROWID[ROWID,10], "PCS"."ID"[NUMBER,22], "PCS"."PID"[NUMBER,22], 
       "PCS"."CID"[NUMBER,22]
 582 - "D_EX_SYSTEM_VALUES".ROWID[ROWID,10], "ID"[NUMBER,22], "PID"[NUMBER,22], "VAL_CODE"[VARCHAR2,50], "UNIT"[VARCHAR2,30], "UNIT_ID"[NUMBER,22], "STR_VALUE"[VARCHAR2,4000], 
       "T".ROWID[ROWID,10], "T"."CID"[NUMBER,22], "T"."PID"[NUMBER,22], "T"."DIR_SERV"[NUMBER,22], "PCS".ROWID[ROWID,10], "PCS"."ID"[NUMBER,22]
 583 - "D_EX_SYSTEM_VALUES".ROWID[ROWID,10], "ID"[NUMBER,22], "PID"[NUMBER,22], "VAL_CODE"[VARCHAR2,50], "UNIT"[VARCHAR2,30], "UNIT_ID"[NUMBER,22], "STR_VALUE"[VARCHAR2,4000], 
       "T".ROWID[ROWID,10], "T"."CID"[NUMBER,22], "T"."PID"[NUMBER,22], "T"."DIR_SERV"[NUMBER,22]
 584 - "D_EX_SYSTEM_VALUES".ROWID[ROWID,10], "ID"[NUMBER,22], "PID"[NUMBER,22], "VAL_CODE"[VARCHAR2,50], "UNIT"[VARCHAR2,30], "UNIT_ID"[NUMBER,22], "STR_VALUE"[VARCHAR2,4000]
 585 - "D_EX_SYSTEM_VALUES".ROWID[ROWID,10], "UNIT"[VARCHAR2,30], "VAL_CODE"[VARCHAR2,50]
 586 - "T".ROWID[ROWID,10], "T"."CID"[NUMBER,22], "T"."PID"[NUMBER,22], "T"."DIR_SERV"[NUMBER,22]
 587 - "T".ROWID[ROWID,10], "T"."DIR_SERV"[NUMBER,22]
 588 - "PCS".ROWID[ROWID,10], "PCS"."ID"[NUMBER,22]
 589 - "PCS".ROWID[ROWID,10], "PCS"."PID"[NUMBER,22], "PCS"."CID"[NUMBER,22]
 592 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 594 - "US"."ID"[NUMBER,22]
 598 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 600 - "US"."ID"[NUMBER,22]
 604 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 606 - "US"."ID"[NUMBER,22]
 610 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 612 - "US"."ID"[NUMBER,22]
 616 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 618 - "US"."ID"[NUMBER,22]
 620 - "PCC"."ZAKL"[LOB,4000]
 621 - "PCC"."ZAKL"[LOB,4000]
 622 - "PCC"."CID"[NUMBER,22], "PCC"."ZAKL"[LOB,4000]
 623 - "PCC"."CID"[NUMBER,22], "PCC"."ZAKL"[LOB,4000]
 624 - "SRV"."ID"[NUMBER,22], "PCC"."CID"[NUMBER,22], "PCC"."ZAKL"[LOB,4000], "DRS".ROWID[ROWID,10]
 625 - "SRV"."ID"[NUMBER,22], "PCC"."CID"[NUMBER,22], "PCC"."ZAKL"[LOB,4000], "V"."PID"[NUMBER,22]
 626 - "SRV"."ID"[NUMBER,22], "PCC"."CID"[NUMBER,22], "PCC"."VISIT"[NUMBER,22], "PCC"."ZAKL"[LOB,4000]
 627 - "SRV"."ID"[NUMBER,22]
 628 - (#keys=0) "PCC"."CID"[NUMBER,22], "PCC"."VISIT"[NUMBER,22], "PCC"."ZAKL"[LOB,4000]
 629 - "PCC".ROWID[ROWID,10], "PCC"."CID"[NUMBER,22], "PCC"."PID"[NUMBER,22], "PCC"."VISIT"[NUMBER,22], "PCC"."ZAKL"[LOB,4000]
 630 - "PCC".ROWID[ROWID,10], "PCC"."PID"[NUMBER,22]
 631 - "V"."PID"[NUMBER,22]
 632 - "V".ROWID[ROWID,10]
 633 - "DRS".ROWID[ROWID,10]
 637 - "UP"."USERNAME"[VARCHAR2,30], "UP"."ROLEID"[NUMBER,22]
 639 - "US"."ID"[NUMBER,22]
 
Query Block Registry:
---------------------
 
  <q o="2"><n><![CDATA[SEL$28]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$28]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$317]]></n><f><h><t><![CDATA[from$_subquery$_194]]></t><s><![CDATA[SEL$317]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$157]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$157]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$9CC480F5]]></n><p><![CDATA[SEL$371]]></p><i><o><t>VW</t><v><![CDATA[SEL$369]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$369]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$369]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$334]]></n><f><h><t><![CDATA[OTR]]></t><s><![CDATA[SEL$334]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$399]]></n><f><h><t><![CDATA[from$_subquery$_091]]></t><s><![CDATA[SEL$399]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$C5D9AD8A]]></n><p><![CDATA[SEL$57]]></p><i><o><t>VW</t><v><![CDATA[SEL$58]]></v></o><o><t>VW</t><v><![CDATA[SEL$63]]></v></o></i><f><h><t><![CDATA[T
        ]]></t><s><![CDATA[SEL$58]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$63]]></s></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$68774E43]]></n><p><![CDATA[SEL$2021A073]]></p><i><o><t>TA</t><v><![CDATA[D1@SEL$213]]></v></o><o><t>TA</t><v><![CDATA[T9@SEL$214]]></v></o></i><f><h
        ><t><![CDATA[T]]></t><s><![CDATA[SEL$214]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$69]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$69]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$CA8CE374]]></n><p><![CDATA[SEL$124]]></p><i><o><t>VW</t><v><![CDATA[SEL$125]]></v></o><o><t>VW</t><v><![CDATA[SEL$1FCC0E3C]]></v></o></i><f><h><t><!
        [CDATA[AT]]></t><s><![CDATA[SEL$114]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$119]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$125]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$C28125FF]]></n><p><![CDATA[SEL$380]]></p><i><o><t>VW</t><v><![CDATA[SEL$379]]></v></o></i><f><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h>
        <h><t><![CDATA[from$_subquery$_071]]></t><s><![CDATA[SEL$380]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$327]]></n><f><h><t><![CDATA[DEP]]></t><s><![CDATA[SEL$327]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$F9DD4CB9]]></n><p><![CDATA[SEL$160]]></p><i><o><t>VW</t><v><![CDATA[SEL$158]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$158]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$158]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$4B7AE55C]]></n><p><![CDATA[SEL$192]]></p><i><o><t>VW</t><v><![CDATA[SEL$193]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$193]]></s
        ></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$6AE10BBD]]></n><p><![CDATA[SEL$90]]></p><i><o><t>VW</t><v><![CDATA[SEL$65F26A31]]></v></o><o><t>VW</t><v><![CDATA[SEL$91]]></v></o></i><f><h><t><![C
        DATA[PCSOR]]></t><s><![CDATA[SEL$91]]></s></h><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$97]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$97]]></s></h><h><t><![CDATA[ST]]></t><s><
        ![CDATA[SEL$98]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$248]]></n><f><h><t><![CDATA[J5]]></t><s><![CDATA[SEL$248]]></s></h><h><t><![CDATA[from$_subquery$_217]]></t><s><![CDATA[SEL$248]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$3856FDC7]]></n><p><![CDATA[SEL$150]]></p><i><o><t>VW</t><v><![CDATA[SEL$152]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$152]]></s></h><
        /f></q>
  <q o="2"><n><![CDATA[SEL$171]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$171]]></s></h><h><t><![CDATA[T1]]></t><s><![CDATA[SEL$171]]></s></h><h><t><![CDATA[T2]]></t><s><![CDATA
        [SEL$171]]></s></h><h><t><![CDATA[T3]]></t><s><![CDATA[SEL$171]]></s></h><h><t><![CDATA[T4]]></t><s><![CDATA[SEL$171]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$322]]></n><f><h><t><![CDATA[from$_subquery$_221]]></t><s><![CDATA[SEL$322]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$199]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$199]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$7]]></n><f><h><t><![CDATA[from$_subquery$_365]]></t><s><![CDATA[SEL$7]]></s></h></f></q>
  <q o="35" h="y"><n><![CDATA[SEL$609DDCFC]]></n><p><![CDATA[SEL$71D841EC]]></p><i><o><t>TA</t><v><![CDATA[PCC@SEL$271]]></v></o></i><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$269]]
        ></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$270]]></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$271]]></s></h><h><t><![CDATA[PCL]]></t><s><![CDATA[SEL$273]]></s></h></f></q
        >
  <q o="18" h="y"><n><![CDATA[SEL$01CE0F83]]></n><p><![CDATA[SEL$364]]></p><i><o><t>VW</t><v><![CDATA[SEL$363]]></v></o></i><f><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$363]]></s></h>
        <h><t><![CDATA[S]]></t><s><![CDATA[SEL$363]]></s></h><h><t><![CDATA[ST]]></t><s><![CDATA[SEL$364]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$405]]></n><f><h><t><![CDATA[from$_subquery$_066]]></t><s><![CDATA[SEL$405]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$293]]></n><f><h><t><![CDATA[from$_subquery$_292]]></t><s><![CDATA[SEL$293]]></s></h><h><t><![CDATA[from$_subquery$_304]]></t><s><![CDATA[SEL$293]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$351]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$351]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$351]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$DF1510EF]]></n><p><![CDATA[SEL$332]]></p><i><o><t>VW</t><v><![CDATA[SEL$262]]></v></o></i><f><h><t><![CDATA[MS]]></t><s><![CDATA[SEL$262]]></s
        ></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$262]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$387]]></n><f><h><t><![CDATA[S]]></t><s><![CDATA[SEL$387]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$149]]></n><f><h><t><![CDATA[T1]]></t><s><![CDATA[SEL$149]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$303]]></n><f><h><t><![CDATA[from$_subquery$_148]]></t><s><![CDATA[SEL$303]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$D2574228]]></n><p><![CDATA[SEL$323]]></p><i><o><t>VW</t><v><![CDATA[SEL$02EC525C]]></v></o></i><f><h><t><![CDATA[PCDS]]></t><s><![CDATA[SEL$251]]></
        s></h><h><t><![CDATA[TT]]></t><s><![CDATA[SEL$251]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$252]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$253]]></s></h></f></q>
  <q o="7" f="y" h="y"><n><![CDATA[SEL$C6D4F03D]]></n><p><![CDATA[SEL$68E06B2D]]></p><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$12]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$35]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$35]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$35]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$197]]></n><f><h><t><![CDATA[from$_subquery$_540]]></t><s><![CDATA[SEL$197]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$CBF62EE2]]></n><p><![CDATA[SEL$299]]></p><i><o><t>VW</t><v><![CDATA[SEL$298]]></v></o><o><t>VW</t><v><![CDATA[SEL$3A98FED6]]></v></o></i><f><h><t><!
        [CDATA[PCS]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h><h><t><![CDATA[DIRS
        ]]></t><s><![CDATA[SEL$290]]></s></h><h><t><![CDATA[EMP]]></t><s><![CDATA[SEL$292]]></s></h><h><t><![CDATA[EMPA]]></t><s><![CDATA[SEL$294]]></s></h><h><t><![CDATA[V]]></t><s><![CDA
        TA[SEL$296]]></s></h><h><t><![CDATA[DIR]]></t><s><![CDATA[SEL$298]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$408]]></n><f><h><t><![CDATA[T3]]></t><s><![CDATA[SEL$408]]></s></h><h><t><![CDATA[from$_subquery$_349]]></t><s><![CDATA[SEL$408]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$4766B431]]></n><p><![CDATA[SEL$365]]></p><i><o><t>VW</t><v><![CDATA[SEL$01CE0F83]]></v></o></i><f><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$363]]></s
        ></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$363]]></s></h><h><t><![CDATA[ST]]></t><s><![CDATA[SEL$364]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$202]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$202]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$107]]></n><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$107]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$7C70D976]]></n><p><![CDATA[SEL$319]]></p><i><o><t>VW</t><v><![CDATA[SEL$239]]></v></o></i><f><h><t><![CDATA[MVD]]></t><s><![CDATA[SEL$239]]></
        s></h><h><t><![CDATA[VD]]></t><s><![CDATA[SEL$239]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$50]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$50]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$50]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$231]]></n><f><h><t><![CDATA[from$_subquery$_323]]></t><s><![CDATA[SEL$231]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$E12F393B]]></n><p><![CDATA[SEL$198]]></p><i><o><t>VW</t><v><![CDATA[SEL$199]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$199]]></s>
        </h></f></q>
  <q o="2"><n><![CDATA[SEL$244]]></n><f><h><t><![CDATA[from$_subquery$_208]]></t><s><![CDATA[SEL$244]]></s></h><h><t><![CDATA[from$_subquery$_325]]></t><s><![CDATA[SEL$244]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$331]]></n><f><h><t><![CDATA[from$_subquery$_252]]></t><s><![CDATA[SEL$331]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$244A394E]]></n><p><![CDATA[SEL$384]]></p><i><o><t>VW</t><v><![CDATA[SEL$383]]></v></o></i><f><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h><
        h><t><![CDATA[from$_subquery$_075]]></t><s><![CDATA[SEL$384]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$285]]></n><f><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$285]]></s></h><h><t><![CDATA[from$_subquery$_278]]></t><s><![CDATA[SEL$285]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$109]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$109]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$109]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$624FDCF8]]></n><p><![CDATA[SEL$B32B9E55]]></p><i><o><t>VW</t><v><![CDATA[SEL$266DEF5D]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h><h><t><
        ![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h><h><t><![CDATA[A]]></t><s><![CDATA[SEL$385]]></s></h><h><t><![CDATA[S]]></t><s>
        <![CDATA[SEL$387]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$389]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]></s></h><h><t><![CDATA[DRS]]></t><s><![CDATA[SEL$393]]
        ></s></h><h><t><![CDATA[SRV]]></t><s><![CDATA[SEL$395]]></s></h><h><t><![CDATA[DUG]]></t><s><![CDATA[SEL$397]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$261]]></n><f><h><t><![CDATA[DS1]]></t><s><![CDATA[SEL$261]]></s></h><h><t><![CDATA[from$_subquery$_250]]></t><s><![CDATA[SEL$261]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$27]]></n><f><h><t><![CDATA[E]]></t><s><![CDATA[SEL$27]]></s></h><h><t><![CDATA[E2]]></t><s><![CDATA[SEL$27]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$121]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$121]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$121]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$12]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$12]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$224]]></n><f><h><t><![CDATA[L]]></t><s><![CDATA[SEL$224]]></s></h><h><t><![CDATA[LD]]></t><s><![CDATA[SEL$224]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$1797E9EC]]></n><p><![CDATA[SEL$282]]></p><i><o><t>VW</t><v><![CDATA[SEL$280]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$280]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$280]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$304]]></n><f><h><t><![CDATA[CL]]></t><s><![CDATA[SEL$304]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$1D01BD5E]]></n><p><![CDATA[SEL$247]]></p><i><o><t>VW</t><v><![CDATA[SEL$B987E809]]></v></o></i><f><h><t><![CDATA[J1]]></t><s><![CDATA[SEL$245]]></s>
        </h><h><t><![CDATA[J2]]></t><s><![CDATA[SEL$245]]></s></h><h><t><![CDATA[J3]]></t><s><![CDATA[SEL$246]]></s></h><h><t><![CDATA[J4]]></t><s><![CDATA[SEL$247]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$328]]></n><f><h><t><![CDATA[CAB]]></t><s><![CDATA[SEL$328]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$245]]></n><f><h><t><![CDATA[J1]]></t><s><![CDATA[SEL$245]]></s></h><h><t><![CDATA[J2]]></t><s><![CDATA[SEL$245]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$3A30E29F]]></n><p><![CDATA[SEL$86]]></p><i><o><t>VW</t><v><![CDATA[SEL$88]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$88]]></s></
        h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$1952D768]]></n><p><![CDATA[SEL$216]]></p><i><o><t>VW</t><v><![CDATA[SEL$218]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$218]]></s
        ></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$44D94F01]]></n><p><![CDATA[SEL$96]]></p><i><o><t>VW</t><v><![CDATA[SEL$94]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$94]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$94]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$180]]></n><f><h><t><![CDATA[from$_subquery$_518]]></t><s><![CDATA[SEL$180]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$259]]></n><f><h><t><![CDATA[S]]></t><s><![CDATA[SEL$259]]></s></h><h><t><![CDATA[from$_subquery$_245]]></t><s><![CDATA[SEL$259]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$201]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$201]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$201]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$247]]></n><f><h><t><![CDATA[J4]]></t><s><![CDATA[SEL$247]]></s></h><h><t><![CDATA[from$_subquery$_215]]></t><s><![CDATA[SEL$247]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$770E79DD]]></n><p><![CDATA[SEL$146]]></p><i><o><t>VW</t><v><![CDATA[SEL$419D8FE3]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$80]]>
        </s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$85]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$403]]></n><f><h><t><![CDATA[from$_subquery$_108]]></t><s><![CDATA[SEL$403]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$C6BD8978]]></n><p><![CDATA[SEL$276]]></p><i><o><t>VW</t><v><![CDATA[SEL$79EC03D4]]></v></o></i><f><h><t><![CDATA[D1]]></t><s><![CDATA[SEL$276]]></s>
        </h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$277]]></s></h><h><t><![CDATA[T9]]></t><s><![CDATA[SEL$277]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$EEB295B0]]></n><p><![CDATA[SEL$111]]></p><i><o><t>VW</t><v><![CDATA[SEL$109]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$109]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$109]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$354]]></n><f><h><t><![CDATA[EX]]></t><s><![CDATA[SEL$354]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$307]]></n><f><h><t><![CDATA[from$_subquery$_158]]></t><s><![CDATA[SEL$307]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$29]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$29]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$52]]></n><f><h><t><![CDATA[from$_subquery$_404]]></t><s><![CDATA[SEL$52]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$57018A77]]></n><p><![CDATA[SEL$B9A95C06]]></p><i><o><t>VW</t><v><![CDATA[SEL$2C4774CE]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h><h><t><
        ![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h><h><t><![CDATA[A]]></t><s><![CDATA[SEL$385]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$AEAAFD30]]></n><p><![CDATA[SEL$321]]></p><i><o><t>VW</t><v><![CDATA[SEL$CCCF656D]]></v></o></i><f><h><t><![CDATA[J1]]></t><s><![CDATA[SEL$241]
        ]></s></h><h><t><![CDATA[J2]]></t><s><![CDATA[SEL$241]]></s></h><h><t><![CDATA[J3]]></t><s><![CDATA[SEL$242]]></s></h><h><t><![CDATA[DL]]></t><s><![CDATA[SEL$243]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$192]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$192]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$319]]></n><f><h><t><![CDATA[from$_subquery$_200]]></t><s><![CDATA[SEL$319]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$D1D519EA]]></n><p><![CDATA[SEL$408]]></p><i><o><t>VW</t><v><![CDATA[SEL$407]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$407]]></s></h><h
        ><t><![CDATA[T1]]></t><s><![CDATA[SEL$407]]></s></h><h><t><![CDATA[T3]]></t><s><![CDATA[SEL$408]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$83]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$83]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$368]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$368]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$B987E809]]></n><p><![CDATA[SEL$246]]></p><i><o><t>VW</t><v><![CDATA[SEL$245]]></v></o></i><f><h><t><![CDATA[J1]]></t><s><![CDATA[SEL$245]]></s></h><
        h><t><![CDATA[J2]]></t><s><![CDATA[SEL$245]]></s></h><h><t><![CDATA[J3]]></t><s><![CDATA[SEL$246]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$82]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$82]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$82]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$291]]></n><f><h><t><![CDATA[from$_subquery$_290]]></t><s><![CDATA[SEL$291]]></s></h><h><t><![CDATA[from$_subquery$_303]]></t><s><![CDATA[SEL$291]]></s></h>
        </f></q>
  <q o="18" h="y"><n><![CDATA[SEL$6E00D23F]]></n><p><![CDATA[SEL$234]]></p><i><o><t>VW</t><v><![CDATA[SEL$2C920A48]]></v></o></i><f><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$232]]></s>
        </h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$232]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$233]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$234]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$79EC03D4]]></n><p><![CDATA[SEL$278]]></p><i><o><t>VW</t><v><![CDATA[SEL$277]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$277]]></s></h><h
        ><t><![CDATA[T9]]></t><s><![CDATA[SEL$277]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$195]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$195]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$195]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$383]]></n><f><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$5B5117AB]]></n><p><![CDATA[SEL$188]]></p><i><o><t>VW</t><v><![CDATA[SEL$190]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$190]]></s></h><
        /f></q>
  <q o="2"><n><![CDATA[SEL$184]]></n><f><h><t><![CDATA[from$_subquery$_523]]></t><s><![CDATA[SEL$184]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$268]]></n><f><h><t><![CDATA[from$_subquery$_260]]></t><s><![CDATA[SEL$268]]></s></h><h><t><![CDATA[from$_subquery$_329]]></t><s><![CDATA[SEL$268]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$257]]></n><f><h><t><![CDATA[DL]]></t><s><![CDATA[SEL$257]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$257]]></s></h></f></q>
  <q o="24"><n><![CDATA[SEL$0FFCFA0B]]></n><p><![CDATA[SEL$241484AA]]></p><i><o><t>VW</t><v><![CDATA[SEL$5B5117AB]]></v></o></i><f><h><t><![CDATA[VW_SQ_4]]></t><s><![CDATA[SEL$0FFCFA
        0B]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$187]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$8A9147A6]]></n><p><![CDATA[SEL$52]]></p><i><o><t>VW</t><v><![CDATA[SEL$50]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$50]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$50]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$240]]></n><f><h><t><![CDATA[K1]]></t><s><![CDATA[SEL$240]]></s></h><h><t><![CDATA[K2]]></t><s><![CDATA[SEL$240]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$105]]></n><f><h><t><![CDATA[from$_subquery$_486]]></t><s><![CDATA[SEL$105]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$232]]></n><f><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$232]]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$232]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$55F6C155]]></n><p><![CDATA[SEL$264]]></p><i><o><t>VW</t><v><![CDATA[SEL$263]]></v></o></i><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$263]]></s></h>
        <h><t><![CDATA[PC]]></t><s><![CDATA[SEL$264]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$623FEB7C]]></n><p><![CDATA[SEL$144]]></p><i><o><t>VW</t><v><![CDATA[SEL$BE10A7DB]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$69]]>
        </s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$74]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$276]]></n><f><h><t><![CDATA[D1]]></t><s><![CDATA[SEL$276]]></s></h><h><t><![CDATA[ODIRS]]></t><s><![CDATA[SEL$276]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$306]]></n><f><h><t><![CDATA[from$_subquery$_155]]></t><s><![CDATA[SEL$306]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$C2C6E2EA]]></n><p><![CDATA[SEL$44]]></p><i><o><t>VW</t><v><![CDATA[SEL$46]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$46]]></s></
        h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$FC7715CF]]></n><p><![CDATA[SEL$28551BD7]]></p><i><o><t>VW</t><v><![CDATA[SEL$39]]></v></o></i><f><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDA
        TA[SEL$39]]></s></h><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDATA[SEL$41]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$63]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$63]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$B9383990]]></n><p><![CDATA[SEL$40]]></p><i><o><t>VW</t><v><![CDATA[SEL$38]]></v></o><o><t>VW</t><v><![CDATA[SEL$41]]></v></o></i><f><h><t><![CDATA[R
        ESP]]></t><s><![CDATA[SEL$38]]></s></h><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDATA[SEL$41]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$90]]></n><f><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$90]]></s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$90]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$64D77254]]></n><p><![CDATA[SEL$157]]></p><i><o><t>VW</t><v><![CDATA[SEL$159]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$159]]></s
        ></h></f></q>
  <q o="2"><n><![CDATA[SEL$253]]></n><f><h><t><![CDATA[V]]></t><s><![CDATA[SEL$253]]></s></h><h><t><![CDATA[from$_subquery$_226]]></t><s><![CDATA[SEL$253]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$194]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$194]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$374]]></n><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$374]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$11]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$11]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$11]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$236]]></n><f><h><t><![CDATA[L]]></t><s><![CDATA[SEL$236]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$346]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$346]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$33]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$33]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$2A4F3908]]></n><p><![CDATA[SEL$316]]></p><i><o><t>VW</t><v><![CDATA[SEL$2FDF64D0]]></v></o></i><f><h><t><![CDATA[D1]]></t><s><![CDATA[SEL$225]]></s>
        </h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$226]]></s></h><h><t><![CDATA[T9]]></t><s><![CDATA[SEL$226]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$289]]></n><f><h><t><![CDATA[from$_subquery$_288]]></t><s><![CDATA[SEL$289]]></s></h><h><t><![CDATA[from$_subquery$_302]]></t><s><![CDATA[SEL$289]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$154]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$154]]></s></h><h><t><![CDATA[from$_subquery$_464]]></t><s><![CDATA[SEL$154]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$16]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$16]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$311]]></n><f><h><t><![CDATA[from$_subquery$_172]]></t><s><![CDATA[SEL$311]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$142]]></n><f><h><t><![CDATA[from$_subquery$_022]]></t><s><![CDATA[SEL$142]]></s></h></f></q>
  <q o="19" f="y" h="y"><n><![CDATA[SEL$8D1A81FE]]></n><p><![CDATA[SEL$80B75D33]]></p><i><o><t>SQ</t><v><![CDATA[SEL$8D164D70]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$
        171]]></s></h><h><t><![CDATA[VW_SQ_3]]></t><s><![CDATA[SEL$80B75D33]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$00D15238]]></n><p><![CDATA[SEL$303]]></p><i><o><t>VW</t><v><![CDATA[SEL$208]]></v></o></i><f><h><t><![CDATA[LDL]]></t><s><![CDATA[SEL$208]]></
        s></h><h><t><![CDATA[LDS]]></t><s><![CDATA[SEL$208]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$32561052]]></n><p><![CDATA[SEL$19]]></p><i><o><t>VW</t><v><![CDATA[SEL$17]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$17]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$17]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$26]]></n><f><h><t><![CDATA[from$_subquery$_385]]></t><s><![CDATA[SEL$26]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$229]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$229]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$229]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$9FCE29B2]]></n><p><![CDATA[SEL$112]]></p><i><o><t>VW</t><v><![CDATA[SEL$106]]></v></o><o><t>VW</t><v><![CDATA[SEL$6AE10BBD]]></v></o></i><f><h><t><!
        [CDATA[PC]]></t><s><![CDATA[SEL$106]]></s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$91]]></s></h><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$97]]></s></h><h><t><![CDATA[S]]></t><
        s><![CDATA[SEL$97]]></s></h><h><t><![CDATA[ST]]></t><s><![CDATA[SEL$98]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$FA8321DB]]></n><p><![CDATA[SEL$16]]></p><i><o><t>VW</t><v><![CDATA[SEL$18]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$18]]></s></
        h></f></q>
  <q o="2"><n><![CDATA[SEL$200]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$200]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$131]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$131]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$7057249E]]></n><p><![CDATA[SEL$331]]></p><i><o><t>VW</t><v><![CDATA[SEL$2BF2BB32]]></v></o></i><f><h><t><![CDATA[PDS1]]></t><s><![CDATA[SEL$26
        0]]></s></h><h><t><![CDATA[PS1]]></t><s><![CDATA[SEL$260]]></s></h><h><t><![CDATA[DS1]]></t><s><![CDATA[SEL$261]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$218]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$218]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$168]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$168]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$18BE6699]]></n><p><![CDATA[SEL$10]]></p><i><o><t>VW</t><v><![CDATA[SEL$12]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$12]]></s></h></f>
        </q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$1ADC8C15]]></n><p><![CDATA[SEL$118]]></p><i><o><t>VW</t><v><![CDATA[SEL$116]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$116]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$116]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$F9DE4AF1]]></n><p><![CDATA[SEL$102]]></p><i><o><t>VW</t><v><![CDATA[SEL$104]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$104]]></s
        ></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$1F3EA0DC]]></n><p><![CDATA[SEL$187]]></p><i><o><t>TA</t><v><![CDATA[T4@SEL$187]]></v></o><o><t>TA</t><v><![CDATA[T5@SEL$187]]></v></o><o><t>TA</t><v
        ><![CDATA[T6@SEL$187]]></v></o><o><t>TA</t><v><![CDATA[T7@SEL$187]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$187]]></s></h><h><t><![CDATA[T2]]></t><s><![CDATA[SEL$187]
        ]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$409]]></n><f><h><t><![CDATA[T2]]></t><s><![CDATA[SEL$409]]></s></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$F09BF2C7]]></n><p><![CDATA[SEL$35BFE6AB]]></p><i><o><t>TA</t><v><![CDATA[T2@SEL$409]]></v></o><o><t>TA</t><v><![CDATA[T3@SEL$408]]></v></o></i><f><h
        ><t><![CDATA[T]]></t><s><![CDATA[SEL$407]]></s></h><h><t><![CDATA[T1]]></t><s><![CDATA[SEL$407]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$294]]></n><f><h><t><![CDATA[EMPA]]></t><s><![CDATA[SEL$294]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$150]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$150]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$28F00AFB]]></n><p><![CDATA[SEL$142]]></p><i><o><t>VW</t><v><![CDATA[SEL$C5D9AD8A]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$58]]>
        </s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$63]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$401]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$401]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$401]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$71]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$71]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$71]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$2AEBFB23]]></n><p><![CDATA[SEL$324]]></p><i><o><t>VW</t><v><![CDATA[SEL$254]]></v></o></i><f><h><t><![CDATA[RA]]></t><s><![CDATA[SEL$254]]></s
        ></h><h><t><![CDATA[RE]]></t><s><![CDATA[SEL$254]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$45]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$45]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$45]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$6]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$6]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$29A4ECCD]]></n><p><![CDATA[SEL$339]]></p><i><o><t>VW</t><v><![CDATA[SEL$341]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$341]]></s
        ></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$B9A6188B]]></n><p><![CDATA[SEL$205]]></p><i><o><t>VW</t><v><![CDATA[SEL$343]]></v></o><o><t>VW</t><v><![CDATA[SEL$52D6E3A9]]></v></o></i><f><h><t><!
        [CDATA[PCS]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h><h><t><![CDATA[DIRS
        ]]></t><s><![CDATA[SEL$290]]></s></h><h><t><![CDATA[EMP]]></t><s><![CDATA[SEL$292]]></s></h><h><t><![CDATA[EMPA]]></t><s><![CDATA[SEL$294]]></s></h><h><t><![CDATA[V]]></t><s><![CDA
        TA[SEL$296]]></s></h><h><t><![CDATA[DIR]]></t><s><![CDATA[SEL$298]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$343]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$0A384FF1]]></n><p><![CDATA[SEL$203]]></p><i><o><t>VW</t><v><![CDATA[SEL$201]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$201]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$201]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$271]]></n><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$271]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$126]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$126]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$6ED195B1]]></n><p><![CDATA[SEL$221]]></p><i><o><t>VW</t><v><![CDATA[SEL$220]]></v></o></i><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$220]]></s></h><h
        ><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$220]]></s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$221]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$19]]></n><f><h><t><![CDATA[from$_subquery$_378]]></t><s><![CDATA[SEL$19]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$FBD07C95]]></n><p><![CDATA[SEL$394]]></p><i><o><t>VW</t><v><![CDATA[SEL$393]]></v></o></i><f><h><t><![CDATA[DRS]]></t><s><![CDATA[SEL$393]]></s></h>
        <h><t><![CDATA[from$_subquery$_085]]></t><s><![CDATA[SEL$394]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$345]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$345]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$345]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$FD582BC8]]></n><p><![CDATA[SEL$55]]></p><i><o><t>VW</t><v><![CDATA[SEL$53]]></v></o><o><t>VW</t><v><![CDATA[SEL$56]]></v></o></i><f><h><t><![CDATA[R
        ESP]]></t><s><![CDATA[SEL$53]]></s></h><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDATA[SEL$56]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$78]]></n><f><h><t><![CDATA[from$_subquery$_434]]></t><s><![CDATA[SEL$78]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$0929CC96]]></n><p><![CDATA[SEL$93]]></p><i><o><t>VW</t><v><![CDATA[SEL$95]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$95]]></s></
        h></f></q>
  <q o="34" f="y" h="y"><n><![CDATA[SEL$72C161FC]]></n><p><![CDATA[SEL$2A4F3908]]></p><i><o><t>TA</t><v><![CDATA[D1@SEL$225]]></v></o><o><t>TA</t><v><![CDATA[T9@SEL$226]]></v></o></i
        ><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$226]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$246]]></n><f><h><t><![CDATA[J3]]></t><s><![CDATA[SEL$246]]></s></h><h><t><![CDATA[from$_subquery$_213]]></t><s><![CDATA[SEL$246]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$287]]></n><f><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$125]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$125]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$388]]></n><f><h><t><![CDATA[from$_subquery$_079]]></t><s><![CDATA[SEL$388]]></s></h><h><t><![CDATA[from$_subquery$_099]]></t><s><![CDATA[SEL$388]]></s></h>
        </f></q>
  <q o="34" f="y" h="y"><n><![CDATA[SEL$15D00A3E]]></n><p><![CDATA[SEL$D2574228]]></p><i><o><t>TA</t><v><![CDATA[DS@SEL$252]]></v></o></i><f><h><t><![CDATA[PCDS]]></t><s><![CDATA[SEL
        $251]]></s></h><h><t><![CDATA[TT]]></t><s><![CDATA[SEL$251]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$253]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$260]]></n><f><h><t><![CDATA[PDS1]]></t><s><![CDATA[SEL$260]]></s></h><h><t><![CDATA[PS1]]></t><s><![CDATA[SEL$260]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$266]]></n><f><h><t><![CDATA[from$_subquery$_258]]></t><s><![CDATA[SEL$266]]></s></h><h><t><![CDATA[from$_subquery$_328]]></t><s><![CDATA[SEL$266]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$67]]></n><f><h><t><![CDATA[from$_subquery$_419]]></t><s><![CDATA[SEL$67]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$203]]></n><f><h><t><![CDATA[from$_subquery$_546]]></t><s><![CDATA[SEL$203]]></s></h></f></q>
  <q o="24"><n><![CDATA[SEL$80B75D33]]></n><p><![CDATA[SEL$A23C6FA4]]></p><i><o><t>VW</t><v><![CDATA[SEL$8D164D70]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$171]]></s></
        h><h><t><![CDATA[VW_SQ_3]]></t><s><![CDATA[SEL$80B75D33]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$75546432]]></n><p><![CDATA[SEL$200]]></p><i><o><t>VW</t><v><![CDATA[SEL$202]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$202]]></s
        ></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$4DF7A7FF]]></n><p><![CDATA[SEL$01090876]]></p><i><o><t>TA</t><v><![CDATA[EM@SEL$383]]></v></o></i><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]>
        </s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]></s></h><h><t><![CDATA[DRS]]></t><s><![CDATA[SEL$393]]></s></h><h><t><![CDATA[SRV]]></t><s><![CDATA[SEL$395]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$88C79FCA]]></n><p><![CDATA[SEL$184]]></p><i><o><t>VW</t><v><![CDATA[SEL$182]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$182]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$182]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$249]]></n><f><h><t><![CDATA[DL]]></t><s><![CDATA[SEL$249]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$B03545E5]]></n><p><![CDATA[SEL$307]]></p><i><o><t>VW</t><v><![CDATA[SEL$211]]></v></o></i><f><h><t><![CDATA[MVD]]></t><s><![CDATA[SEL$211]]></
        s></h><h><t><![CDATA[VD]]></t><s><![CDATA[SEL$211]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$377]]></n><f><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$348]]></n><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$348]]></s></h><h><t><![CDATA[from$_subquery$_055]]></t><s><![CDATA[SEL$348]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$102F8B08]]></n><p><![CDATA[SEL$222]]></p><i><o><t>VW</t><v><![CDATA[SEL$6ED195B1]]></v></o></i><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$220]]></s><
        /h><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$220]]></s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$221]]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$222]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$2021A073]]></n><p><![CDATA[SEL$312]]></p><i><o><t>VW</t><v><![CDATA[SEL$A855AFED]]></v></o></i><f><h><t><![CDATA[D1]]></t><s><![CDATA[SEL$213]]></s>
        </h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$214]]></s></h><h><t><![CDATA[T9]]></t><s><![CDATA[SEL$214]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$350]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$350]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$89359AEE]]></n><p><![CDATA[SEL$181]]></p><i><o><t>VW</t><v><![CDATA[SEL$183]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$183]]></s
        ></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$C9F0CD94]]></n><p><![CDATA[SEL$64]]></p><i><o><t>VW</t><v><![CDATA[SEL$66]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$66]]></s></
        h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$326]]></n><f><h><t><![CDATA[CAB]]></t><s><![CDATA[SEL$326]]></s></h></f></q>
  <q o="7" f="y" h="y"><n><![CDATA[SEL$BC875581]]></n><p><![CDATA[SEL$FDD0F22A]]></p><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$414]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$44]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$44]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$96]]></n><f><h><t><![CDATA[from$_subquery$_493]]></t><s><![CDATA[SEL$96]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$159]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$159]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$267]]></n><f><h><t><![CDATA[PCL]]></t><s><![CDATA[SEL$267]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$146]]></n><f><h><t><![CDATA[from$_subquery$_029]]></t><s><![CDATA[SEL$146]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$250]]></n><f><h><t><![CDATA[from$_subquery$_219]]></t><s><![CDATA[SEL$250]]></s></h><h><t><![CDATA[from$_subquery$_326]]></t><s><![CDATA[SEL$250]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$36]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$36]]></s></h></f></q>
  <q o="12"><n><![CDATA[SEL$68E06B2D]]></n><p><![CDATA[SEL$18BE6699]]></p><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$12]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$158]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$158]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$158]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$74]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$74]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$53]]></n><f><h><t><![CDATA[RESP]]></t><s><![CDATA[SEL$53]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$6B41E1E4]]></n><p><![CDATA[SEL$373]]></p><i><o><t>VW</t><v><![CDATA[SEL$354]]></v></o><o><t>VW</t><v><![CDATA[SEL$53FEB0C4]]></v></o></i><f><h
        ><t><![CDATA[PCS]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h><h><t><![CDAT
        A[DIRS]]></t><s><![CDATA[SEL$290]]></s></h><h><t><![CDATA[EMP]]></t><s><![CDATA[SEL$292]]></s></h><h><t><![CDATA[EMPA]]></t><s><![CDATA[SEL$294]]></s></h><h><t><![CDATA[V]]></t><s>
        <![CDATA[SEL$296]]></s></h><h><t><![CDATA[DIR]]></t><s><![CDATA[SEL$298]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$343]]></s></h><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$349
        ]]></s></h><h><t><![CDATA[EX]]></t><s><![CDATA[SEL$354]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$141]]></n><f><h><t><![CDATA[from$_subquery$_013]]></t><s><![CDATA[SEL$141]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$62]]></n><f><h><t><![CDATA[from$_subquery$_425]]></t><s><![CDATA[SEL$62]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$BF7C3312]]></n><p><![CDATA[SEL$284]]></p><i><o><t>VW</t><v><![CDATA[SEL$283]]></v></o></i><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$283]]></s></h><h
        ><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$283]]></s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$284]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$227]]></n><f><h><t><![CDATA[from$_subquery$_318]]></t><s><![CDATA[SEL$227]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$124]]></n><f><h><t><![CDATA[VIS]]></t><s><![CDATA[SEL$124]]></s></h><h><t><![CDATA[from$_subquery$_046]]></t><s><![CDATA[SEL$124]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$A5BAA20F]]></n><p><![CDATA[SEL$120]]></p><i><o><t>VW</t><v><![CDATA[SEL$122]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$122]]></s
        ></h></f></q>
  <q o="2"><n><![CDATA[SEL$181]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$181]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$324]]></n><f><h><t><![CDATA[from$_subquery$_231]]></t><s><![CDATA[SEL$324]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$4]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$4]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$C2C6B5C4]]></n><p><![CDATA[SEL$361]]></p><i><o><t>VW</t><v><![CDATA[SEL$359]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$359]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$359]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$251]]></n><f><h><t><![CDATA[PCDS]]></t><s><![CDATA[SEL$251]]></s></h><h><t><![CDATA[TT]]></t><s><![CDATA[SEL$251]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$88]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$88]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$73281751]]></n><p><![CDATA[SEL$396]]></p><i><o><t>VW</t><v><![CDATA[SEL$395]]></v></o></i><f><h><t><![CDATA[SRV]]></t><s><![CDATA[SEL$395]]></s></h>
        <h><t><![CDATA[from$_subquery$_087]]></t><s><![CDATA[SEL$396]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$3D1041AC]]></n><p><![CDATA[SEL$75]]></p><i><o><t>VW</t><v><![CDATA[SEL$77]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$77]]></s></
        h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$3E0B8B1B]]></n><p><![CDATA[SEL$320]]></p><i><o><t>VW</t><v><![CDATA[SEL$240]]></v></o></i><f><h><t><![CDATA[K1]]></t><s><![CDATA[SEL$240]]></s
        ></h><h><t><![CDATA[K2]]></t><s><![CDATA[SEL$240]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$221]]></n><f><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$221]]></s></h><h><t><![CDATA[from$_subquery$_166]]></t><s><![CDATA[SEL$221]]></s></h></f></q>
  <q o="7" f="y" h="y"><n><![CDATA[SEL$2634090D]]></n><p><![CDATA[SEL$D857C0AC]]></p><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$174]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$57]]></n><f><h><t><![CDATA[E]]></t><s><![CDATA[SEL$57]]></s></h><h><t><![CDATA[E2]]></t><s><![CDATA[SEL$57]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$F2E67D0D]]></n><p><![CDATA[SEL$404F1C3B]]></p><i><o><t>VW</t><v><![CDATA[SEL$54]]></v></o></i><f><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDA
        TA[SEL$54]]></s></h><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDATA[SEL$56]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$23FC1809]]></n><p><![CDATA[SEL$368]]></p><i><o><t>VW</t><v><![CDATA[SEL$370]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$370]]></s
        ></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$7A8D133E]]></n><p><![CDATA[SEL$62]]></p><i><o><t>VW</t><v><![CDATA[SEL$60]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$60]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$60]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$282]]></n><f><h><t><![CDATA[from$_subquery$_340]]></t><s><![CDATA[SEL$282]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$223]]></n><f><h><t><![CDATA[S]]></t><s><![CDATA[SEL$223]]></s></h><h><t><![CDATA[from$_subquery$_170]]></t><s><![CDATA[SEL$223]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$F9CD0431]]></n><p><![CDATA[SEL$342]]></p><i><o><t>VW</t><v><![CDATA[SEL$340]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$340]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$340]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$391]]></n><f><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$361]]></n><f><h><t><![CDATA[from$_subquery$_126]]></t><s><![CDATA[SEL$361]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$54]]></n><f><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDATA[SEL$54]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$323]]></n><f><h><t><![CDATA[from$_subquery$_228]]></t><s><![CDATA[SEL$323]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$EA442AA0]]></n><p><![CDATA[SEL$73]]></p><i><o><t>VW</t><v><![CDATA[SEL$71]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$71]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$71]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$51F04F9E]]></n><p><![CDATA[SEL$405]]></p><i><o><t>VW</t><v><![CDATA[SEL$67A83AA1]]></v></o></i><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$374
        ]]></s></h><h><t><![CDATA[from$_subquery$_064]]></t><s><![CDATA[SEL$404]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$AB0185AF]]></n><p><![CDATA[SEL$250]]></p><i><o><t>VW</t><v><![CDATA[SEL$249]]></v></o><o><t>VW</t><v><![CDATA[SEL$BE7172B4]]></v></o></i><f><h><t><!
        [CDATA[J1]]></t><s><![CDATA[SEL$245]]></s></h><h><t><![CDATA[J2]]></t><s><![CDATA[SEL$245]]></s></h><h><t><![CDATA[J3]]></t><s><![CDATA[SEL$246]]></s></h><h><t><![CDATA[J4]]></t><s
        ><![CDATA[SEL$247]]></s></h><h><t><![CDATA[J5]]></t><s><![CDATA[SEL$248]]></s></h><h><t><![CDATA[DL]]></t><s><![CDATA[SEL$249]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$175]]></n><f><h><t><![CDATA[from$_subquery$_511]]></t><s><![CDATA[SEL$175]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$BFD74306]]></n><p><![CDATA[SEL$358]]></p><i><o><t>VW</t><v><![CDATA[SEL$360]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$360]]></s
        ></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$F490752B]]></n><p><![CDATA[SEL$180]]></p><i><o><t>VW</t><v><![CDATA[SEL$20D1D2E8]]></v></o></i><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$177]]></s>
        </h><h><t><![CDATA[DSS]]></t><s><![CDATA[SEL$177]]></s></h><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$178]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$179]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$6A269FB7]]></n><p><![CDATA[SEL$207]]></p><i><o><t>VW</t><v><![CDATA[SEL$206]]></v></o></i><f><h><t><![CDATA[LDL]]></t><s><![CDATA[SEL$206]]></s></h>
        <h><t><![CDATA[LDS]]></t><s><![CDATA[SEL$206]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$207]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$7D443A45]]></n><p><![CDATA[SEL$259]]></p><i><o><t>VW</t><v><![CDATA[SEL$684DCB1D]]></v></o></i><f><h><t><![CDATA[DL]]></t><s><![CDATA[SEL$257]]></s>
        </h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$257]]></s></h><h><t><![CDATA[SD]]></t><s><![CDATA[SEL$258]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$259]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$220]]></n><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$220]]></s></h><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$220]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$B75A2FFF]]></n><p><![CDATA[SEL$415]]></p><i><o><t>VW</t><v><![CDATA[SEL$413]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$413]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$413]]></s></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$A23C6FA4]]></n><p><![CDATA[SEL$3C0ECB29]]></p><i><o><t>TA</t><v><![CDATA[T3@SEL$171]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$171]]></
        s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$8E26BC93]]></n><p><![CDATA[SEL$42]]></p><i><o><t>VW</t><v><![CDATA[SEL$43]]></v></o><o><t>VW</t><v><![CDATA[SEL$48]]></v></o></i><f><h><t><![CDATA[T
        ]]></t><s><![CDATA[SEL$43]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$48]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$97238E9E]]></n><p><![CDATA[SEL$353]]></p><i><o><t>VW</t><v><![CDATA[SEL$351]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$351]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$351]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$270]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$270]]></s></h><h><t><![CDATA[from$_subquery$_330]]></t><s><![CDATA[SEL$270]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$5D7B7D17]]></n><p><![CDATA[SEL$302]]></p><i><o><t>VW</t><v><![CDATA[SEL$6A269FB7]]></v></o></i><f><h><t><![CDATA[LDL]]></t><s><![CDATA[SEL$206
        ]]></s></h><h><t><![CDATA[LDS]]></t><s><![CDATA[SEL$206]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$207]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$A426E5F1]]></n><p><![CDATA[SEL$219]]></p><i><o><t>VW</t><v><![CDATA[SEL$217]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$217]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$217]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$166]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$166]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$147]]></n><f><h><t><![CDATA[DUAL]]></t><s><![CDATA[SEL$147]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$275]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$275]]></s></h><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$275]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$305]]></n><f><h><t><![CDATA[CL]]></t><s><![CDATA[SEL$305]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$137]]></n><f><h><t><![CDATA[from$_subquery$_004]]></t><s><![CDATA[SEL$137]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$110]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$110]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$280]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$280]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$280]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$189]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$189]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$189]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$117]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$117]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$355]]></n><f><h><t><![CDATA[ESV]]></t><s><![CDATA[SEL$355]]></s></h><h><t><![CDATA[PSD]]></t><s><![CDATA[SEL$355]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$312]]></n><f><h><t><![CDATA[from$_subquery$_175]]></t><s><![CDATA[SEL$312]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$352]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$352]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$1861DA60]]></n><p><![CDATA[SEL$138]]></p><i><o><t>VW</t><v><![CDATA[SEL$096670FF]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$14]]
        ></s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$21]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$51F828FA]]></n><p><![CDATA[SEL$126]]></p><i><o><t>VW</t><v><![CDATA[SEL$128]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$128]]></s
        ></h></f></q>
  <q o="2"><n><![CDATA[SEL$272]]></n><f><h><t><![CDATA[from$_subquery$_266]]></t><s><![CDATA[SEL$272]]></s></h><h><t><![CDATA[from$_subquery$_331]]></t><s><![CDATA[SEL$272]]></s></h>
        </f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$518ABD35]]></n><p><![CDATA[SEL$347]]></p><i><o><t>VW</t><v><![CDATA[SEL$345]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$345]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$345]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$155]]></n><f><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$155]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$D2F95C08]]></n><p><![CDATA[SEL$372]]></p><i><o><t>VW</t><v><![CDATA[SEL$288B3780]]></v></o></i><f><h><t><![CDATA[D_EX_SYSTEM_VALUES]]></t><s><![CDAT
        A[SEL$356]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$357]]></s></h><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$363]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$363]]></s></h
        ><h><t><![CDATA[ST]]></t><s><![CDATA[SEL$364]]></s></h></f></q>
  <q o="12"><n><![CDATA[SEL$D857C0AC]]></n><p><![CDATA[SEL$8D164D70]]></p><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$174]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$8D164D70]]></n><p><![CDATA[SEL$172]]></p><i><o><t>VW</t><v><![CDATA[SEL$174]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$174]]></s></h><
        /f></q>
  <q o="18" h="y"><n><![CDATA[SEL$25F6C0FA]]></n><p><![CDATA[SEL$6DF0CB6D]]></p><i><o><t>VW</t><v><![CDATA[SEL$149]]></v></o></i><f><h><t><![CDATA[T1]]></t><s><![CDATA[SEL$149]]></s>
        </h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$155]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$308]]></n><f><h><t><![CDATA[LDL]]></t><s><![CDATA[SEL$308]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$77]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$77]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$269]]></n><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$269]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$41]]></n><f><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDATA[SEL$41]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$85]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$85]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$5D238E44]]></n><p><![CDATA[SEL$13]]></p><i><o><t>VW</t><v><![CDATA[SEL$11]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$11]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$11]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$390]]></n><f><h><t><![CDATA[from$_subquery$_081]]></t><s><![CDATA[SEL$390]]></s></h><h><t><![CDATA[from$_subquery$_100]]></t><s><![CDATA[SEL$390]]></s></h>
        </f></q>
  <q o="18" h="y"><n><![CDATA[SEL$96C8B4DB]]></n><p><![CDATA[SEL$8]]></p><i><o><t>VW</t><v><![CDATA[SEL$2]]></v></o><o><t>VW</t><v><![CDATA[SEL$9]]></v></o></i><f><h><t><![CDATA[PC]]
        ></t><s><![CDATA[SEL$2]]></s></h><h><t><![CDATA[C]]></t><s><![CDATA[SEL$9]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$123]]></n><f><h><t><![CDATA[from$_subquery$_564]]></t><s><![CDATA[SEL$123]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$102B9171]]></n><p><![CDATA[SEL$403]]></p><i><o><t>VW</t><v><![CDATA[SEL$401]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$401]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$401]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$290]]></n><f><h><t><![CDATA[DIRS]]></t><s><![CDATA[SEL$290]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$1FCC0E3C]]></n><p><![CDATA[SEL$113]]></p><i><o><t>VW</t><v><![CDATA[SEL$114]]></v></o><o><t>VW</t><v><![CDATA[SEL$119]]></v></o></i><f><h><t><![CDAT
        A[AT]]></t><s><![CDATA[SEL$114]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$119]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$119]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$119]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$393]]></n><f><h><t><![CDATA[DRS]]></t><s><![CDATA[SEL$393]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$178]]></n><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$178]]></s></h><h><t><![CDATA[from$_subquery$_514]]></t><s><![CDATA[SEL$178]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$35BFE6AB]]></n><p><![CDATA[SEL$406]]></p><i><o><t>VW</t><v><![CDATA[SEL$0633BE9E]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$407]]></s><
        /h><h><t><![CDATA[T1]]></t><s><![CDATA[SEL$407]]></s></h><h><t><![CDATA[T3]]></t><s><![CDATA[SEL$408]]></s></h><h><t><![CDATA[T2]]></t><s><![CDATA[SEL$409]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$7799FE8A]]></n><p><![CDATA[SEL$315]]></p><i><o><t>VW</t><v><![CDATA[SEL$6E00D23F]]></v></o></i><f><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$232]
        ]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$232]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$233]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$234]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$139]]></n><f><h><t><![CDATA[from$_subquery$_010]]></t><s><![CDATA[SEL$139]]></s></h></f></q>
  <q o="19" f="y" h="y"><n><![CDATA[SEL$058EA8D5]]></n><p><![CDATA[SEL$25F6C0FA]]></p><i><o><t>SQ</t><v><![CDATA[SEL$3856FDC7]]></v></o></i><f><h><t><![CDATA[T1]]></t><s><![CDATA[SEL
        $149]]></s></h><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$152]]></s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$155]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$400]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$400]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$113]]></n><f><h><t><![CDATA[AT]]></t><s><![CDATA[SEL$113]]></s></h><h><t><![CDATA[ATV]]></t><s><![CDATA[SEL$113]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$265]]></n><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$265]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$226]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$226]]></s></h><h><t><![CDATA[T9]]></t><s><![CDATA[SEL$226]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$2D5B589B]]></n><p><![CDATA[SEL$162]]></p><i><o><t>VW</t><v><![CDATA[SEL$9FCE29B2]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$106]]></s>
        </h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$91]]></s></h><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$97]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$97]]></s></h><h><t><![CDATA
        [ST]]></t><s><![CDATA[SEL$98]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$152]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$152]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$380]]></n><f><h><t><![CDATA[from$_subquery$_071]]></t><s><![CDATA[SEL$380]]></s></h><h><t><![CDATA[from$_subquery$_095]]></t><s><![CDATA[SEL$380]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$415]]></n><f><h><t><![CDATA[from$_subquery$_359]]></t><s><![CDATA[SEL$415]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$302]]></n><f><h><t><![CDATA[from$_subquery$_145]]></t><s><![CDATA[SEL$302]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$297]]></n><f><h><t><![CDATA[from$_subquery$_296]]></t><s><![CDATA[SEL$297]]></s></h><h><t><![CDATA[from$_subquery$_306]]></t><s><![CDATA[SEL$297]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$133]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$133]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$133]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$CCCF656D]]></n><p><![CDATA[SEL$244]]></p><i><o><t>VW</t><v><![CDATA[SEL$243]]></v></o><o><t>VW</t><v><![CDATA[SEL$A29A9A6B]]></v></o></i><f><h><t><!
        [CDATA[J1]]></t><s><![CDATA[SEL$241]]></s></h><h><t><![CDATA[J2]]></t><s><![CDATA[SEL$241]]></s></h><h><t><![CDATA[J3]]></t><s><![CDATA[SEL$242]]></s></h><h><t><![CDATA[DL]]></t><s
        ><![CDATA[SEL$243]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$169]]></n><f><h><t><![CDATA[from$_subquery$_501]]></t><s><![CDATA[SEL$169]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$F37F9FD3]]></n><p><![CDATA[SEL$169]]></p><i><o><t>VW</t><v><![CDATA[SEL$167]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$167]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$167]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$8]]></n><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$8]]></s></h><h><t><![CDATA[from$_subquery$_372]]></t><s><![CDATA[SEL$8]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$217]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$217]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$217]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$032A48B3]]></n><p><![CDATA[SEL$37]]></p><i><o><t>VW</t><v><![CDATA[SEL$35]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$35]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$35]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$136]]></n><f><h><t><![CDATA[V]]></t><s><![CDATA[SEL$136]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$25AB1310]]></n><p><![CDATA[SEL$67]]></p><i><o><t>VW</t><v><![CDATA[SEL$65]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$65]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$65]]></s></h></f></q>
  <q o="34" f="y" h="y"><n><![CDATA[SEL$8DEB7E6D]]></n><p><![CDATA[SEL$7DF6143C]]></p><i><o><t>TA</t><v><![CDATA[PCT@SEL$178]]></v></o></i><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$
        177]]></s></h><h><t><![CDATA[DSS]]></t><s><![CDATA[SEL$177]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$179]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$389]]></n><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$389]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$827DFB84]]></n><p><![CDATA[SEL$344]]></p><i><o><t>VW</t><v><![CDATA[SEL$346]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$346]]></s
        ></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$F576CF67]]></n><p><![CDATA[SEL$2D5B589B]]></p><i><o><t>TA</t><v><![CDATA[ST@SEL$98]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$106]]></
        s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$91]]></s></h><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$97]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$97]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$F4290F7D]]></n><p><![CDATA[SEL$137]]></p><i><o><t>VW</t><v><![CDATA[SEL$96C8B4DB]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$2]]></s></
        h><h><t><![CDATA[C]]></t><s><![CDATA[SEL$9]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$330]]></n><f><h><t><![CDATA[from$_subquery$_247]]></t><s><![CDATA[SEL$330]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$191]]></n><f><h><t><![CDATA[from$_subquery$_534]]></t><s><![CDATA[SEL$191]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$404F1C3B]]></n><p><![CDATA[SEL$143]]></p><i><o><t>VW</t><v><![CDATA[SEL$FD582BC8]]></v></o></i><f><h><t><![CDATA[RESP]]></t><s><![CDATA[SEL$53]]></s
        ></h><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDATA[SEL$56]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$153]]></n><f><h><t><![CDATA[from$_subquery$_468]]></t><s><![CDATA[SEL$153]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$315]]></n><f><h><t><![CDATA[from$_subquery$_185]]></t><s><![CDATA[SEL$315]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$86]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$86]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$CE5A1A76]]></n><p><![CDATA[SEL$306]]></p><i><o><t>VW</t><v><![CDATA[SEL$DC51C721]]></v></o></i><f><h><t><![CDATA[VF]]></t><s><![CDATA[SEL$209]
        ]></s></h><h><t><![CDATA[VTF]]></t><s><![CDATA[SEL$209]]></s></h><h><t><![CDATA[ADV]]></t><s><![CDATA[SEL$210]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$193]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$193]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$145]]></n><f><h><t><![CDATA[DUAL]]></t><s><![CDATA[SEL$145]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$21CF4C06]]></n><p><![CDATA[SEL$89]]></p><i><o><t>VW</t><v><![CDATA[SEL$87]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$87]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$87]]></s></h></f></q>
  <q o="34" f="y" h="y"><n><![CDATA[SEL$0A8A44CF]]></n><p><![CDATA[SEL$F576CF67]]></p><i><o><t>TA</t><v><![CDATA[S@SEL$97]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$106
        ]]></s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$91]]></s></h><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$97]]></s></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$1880377E]]></n><p><![CDATA[SEL$D2F95C08]]></p><i><o><t>TA</t><v><![CDATA[ST@SEL$364]]></v></o></i><f><h><t><![CDATA[D_EX_SYSTEM_VALUES]]></t><s><![C
        DATA[SEL$356]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$357]]></s></h><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$363]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$363]]></s>
        </h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$3A98FED6]]></n><p><![CDATA[SEL$297]]></p><i><o><t>VW</t><v><![CDATA[SEL$296]]></v></o><o><t>VW</t><v><![CDATA[SEL$EA954C6E]]></v></o></i><f><h><t><!
        [CDATA[PCS]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h><h><t><![CDATA[DIRS
        ]]></t><s><![CDATA[SEL$290]]></s></h><h><t><![CDATA[EMP]]></t><s><![CDATA[SEL$292]]></s></h><h><t><![CDATA[EMPA]]></t><s><![CDATA[SEL$294]]></s></h><h><t><![CDATA[V]]></t><s><![CDA
        TA[SEL$296]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$7B3F1794]]></n><p><![CDATA[SEL$231]]></p><i><o><t>VW</t><v><![CDATA[SEL$229]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$229]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$229]]></s></h></f></q>
  <q o="34" f="y" h="y"><n><![CDATA[SEL$838BDF1F]]></n><p><![CDATA[SEL$61DEC2DE]]></p><i><o><t>TA</t><v><![CDATA[D@SEL$235]]></v></o></i><f><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$
        235]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$81]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$81]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$273]]></n><f><h><t><![CDATA[PCL]]></t><s><![CDATA[SEL$273]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$6D9A86AF]]></n><p><![CDATA[SEL$191]]></p><i><o><t>VW</t><v><![CDATA[SEL$189]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$189]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$189]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$25]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$25]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$132]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$132]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$BE10A7DB]]></n><p><![CDATA[SEL$68]]></p><i><o><t>VW</t><v><![CDATA[SEL$69]]></v></o><o><t>VW</t><v><![CDATA[SEL$74]]></v></o></i><f><h><t><![CDATA[T
        ]]></t><s><![CDATA[SEL$69]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$74]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$239]]></n><f><h><t><![CDATA[MVD]]></t><s><![CDATA[SEL$239]]></s></h><h><t><![CDATA[VD]]></t><s><![CDATA[SEL$239]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$414]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$414]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$112]]></n><f><h><t><![CDATA[from$_subquery$_034]]></t><s><![CDATA[SEL$112]]></s></h><h><t><![CDATA[from$_subquery$_494]]></t><s><![CDATA[SEL$112]]></s></h>
        </f></q>
  <q o="18" h="y"><n><![CDATA[SEL$1CF2BDA4]]></n><p><![CDATA[SEL$6823446A]]></p><i><o><t>VW</t><v><![CDATA[SEL$C90D5F44]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h><h><t><
        ![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$95]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$95]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$97]]></n><f><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$97]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$97]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$163]]></n><f><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$163]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$F7E4EAE9]]></n><p><![CDATA[SEL$310]]></p><i><o><t>VW</t><v><![CDATA[SEL$212]]></v></o></i><f><h><t><![CDATA[ORES]]></t><s><![CDATA[SEL$212]]><
        /s></h><h><t><![CDATA[OV]]></t><s><![CDATA[SEL$212]]></s></h></f></q>
  <q o="7" f="y" h="y"><n><![CDATA[SEL$C482CF97]]></n><p><![CDATA[SEL$107]]></p><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$107]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$281]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$281]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$6A01E28F]]></n><p><![CDATA[SEL$5239749C]]></p><i><o><t>VW</t><v><![CDATA[SEL$DF7D0533]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h><h><t><
        ![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h><h><t><![CDATA[A]]></t><s><![CDATA[SEL$385]]></s></h><h><t><![CDATA[S]]></t><s>
        <![CDATA[SEL$387]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$389]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$1]]></n><f><h><t><![CDATA[from$_subquery$_001]]></t><s><![CDATA[SEL$1]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$213]]></n><f><h><t><![CDATA[D1]]></t><s><![CDATA[SEL$213]]></s></h><h><t><![CDATA[ODIRS]]></t><s><![CDATA[SEL$213]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$BD5F85D1]]></n><p><![CDATA[SEL$148]]></p><i><o><t>VW</t><v><![CDATA[SEL$1E0AAD4F]]></v></o></i><f><h><t><![CDATA[from$_subquery$_464]]></t><s><![CDA
        TA[SEL$154]]></s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$155]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$53FEB0C4]]></n><p><![CDATA[SEL$348]]></p><i><o><t>VW</t><v><![CDATA[SEL$349]]></v></o><o><t>VW</t><v><![CDATA[SEL$B9A6188B]]></v></o></i><f><h><t><!
        [CDATA[PCS]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h><h><t><![CDATA[DIRS
        ]]></t><s><![CDATA[SEL$290]]></s></h><h><t><![CDATA[EMP]]></t><s><![CDATA[SEL$292]]></s></h><h><t><![CDATA[EMPA]]></t><s><![CDATA[SEL$294]]></s></h><h><t><![CDATA[V]]></t><s><![CDA
        TA[SEL$296]]></s></h><h><t><![CDATA[DIR]]></t><s><![CDATA[SEL$298]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$343]]></s></h><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$349]]></s
        ></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$46A3E3EC]]></n><p><![CDATA[SEL$228]]></p><i><o><t>VW</t><v><![CDATA[SEL$230]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$230]]></s
        ></h></f></q>
  <q o="2"><n><![CDATA[SEL$30]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$30]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$30]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$162]]></n><f><h><t><![CDATA[from$_subquery$_036]]></t><s><![CDATA[SEL$162]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$206]]></n><f><h><t><![CDATA[LDL]]></t><s><![CDATA[SEL$206]]></s></h><h><t><![CDATA[LDS]]></t><s><![CDATA[SEL$206]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$138]]></n><f><h><t><![CDATA[from$_subquery$_007]]></t><s><![CDATA[SEL$138]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$BCB735A9]]></n><p><![CDATA[SEL$98]]></p><i><o><t>VW</t><v><![CDATA[SEL$97]]></v></o></i><f><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$97]]></s></h><h>
        <t><![CDATA[S]]></t><s><![CDATA[SEL$97]]></s></h><h><t><![CDATA[ST]]></t><s><![CDATA[SEL$98]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$43ECFA2E]]></n><p><![CDATA[SEL$FEC32A10]]></p><i><o><t>VW</t><v><![CDATA[SEL$6A01E28F]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h><h><t><
        ![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h><h><t><![CDATA[A]]></t><s><![CDATA[SEL$385]]></s></h><h><t><![CDATA[S]]></t><s>
        <![CDATA[SEL$387]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$389]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$7DF6143C]]></n><p><![CDATA[SEL$176]]></p><i><o><t>VW</t><v><![CDATA[SEL$F490752B]]></v></o></i><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$177]]></s>
        </h><h><t><![CDATA[DSS]]></t><s><![CDATA[SEL$177]]></s></h><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$178]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$179]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$13]]></n><f><h><t><![CDATA[from$_subquery$_371]]></t><s><![CDATA[SEL$13]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$215]]></n><f><h><t><![CDATA[from$_subquery$_310]]></t><s><![CDATA[SEL$215]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$320]]></n><f><h><t><![CDATA[from$_subquery$_203]]></t><s><![CDATA[SEL$320]]></s></h></f></q>
  <q o="7" h="y"><n><![CDATA[SEL$F7F100ED]]></n><p><![CDATA[SEL$4DF7A7FF]]></p><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]>
        </s></h><h><t><![CDATA[DRS]]></t><s><![CDATA[SEL$393]]></s></h><h><t><![CDATA[SRV]]></t><s><![CDATA[SEL$395]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$2BF2BB32]]></n><p><![CDATA[SEL$261]]></p><i><o><t>VW</t><v><![CDATA[SEL$260]]></v></o></i><f><h><t><![CDATA[PDS1]]></t><s><![CDATA[SEL$260]]></s></h
        ><h><t><![CDATA[PS1]]></t><s><![CDATA[SEL$260]]></s></h><h><t><![CDATA[DS1]]></t><s><![CDATA[SEL$261]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$187]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$187]]></s></h><h><t><![CDATA[T2]]></t><s><![CDATA[SEL$187]]></s></h><h><t><![CDATA[T4]]></t><s><![CDATA
        [SEL$187]]></s></h><h><t><![CDATA[T5]]></t><s><![CDATA[SEL$187]]></s></h><h><t><![CDATA[T6]]></t><s><![CDATA[SEL$187]]></s></h><h><t><![CDATA[T7]]></t><s><![CDATA[SEL$187]]></s></h
        ></f></q>
  <q o="2"><n><![CDATA[SEL$135]]></n><f><h><t><![CDATA[from$_subquery$_552]]></t><s><![CDATA[SEL$135]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$C7322B17]]></n><p><![CDATA[SEL$410]]></p><i><o><t>VW</t><v><![CDATA[SEL$409]]></v></o><o><t>VW</t><v><![CDATA[SEL$D1D519EA]]></v></o></i><f><h><t><!
        [CDATA[T]]></t><s><![CDATA[SEL$407]]></s></h><h><t><![CDATA[T1]]></t><s><![CDATA[SEL$407]]></s></h><h><t><![CDATA[T3]]></t><s><![CDATA[SEL$408]]></s></h><h><t><![CDATA[T2]]></t><s>
        <![CDATA[SEL$409]]></s></h></f></q>
  <q o="7" f="y" h="y"><n><![CDATA[SEL$F5405A97]]></n><p><![CDATA[SEL$15]]></p><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$15]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$179]]></n><f><h><t><![CDATA[S]]></t><s><![CDATA[SEL$179]]></s></h><h><t><![CDATA[from$_subquery$_516]]></t><s><![CDATA[SEL$179]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$21]]></n><f><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$21]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$372]]></n><f><h><t><![CDATA[from$_subquery$_063]]></t><s><![CDATA[SEL$372]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$364]]></n><f><h><t><![CDATA[ST]]></t><s><![CDATA[SEL$364]]></s></h><h><t><![CDATA[from$_subquery$_113]]></t><s><![CDATA[SEL$364]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$342]]></n><f><h><t><![CDATA[from$_subquery$_344]]></t><s><![CDATA[SEL$342]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$22CC368D]]></n><p><![CDATA[SEL$237]]></p><i><o><t>VW</t><v><![CDATA[SEL$236]]></v></o></i><f><h><t><![CDATA[L]]></t><s><![CDATA[SEL$236]]></s></h><h
        ><t><![CDATA[DD]]></t><s><![CDATA[SEL$237]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$347]]></n><f><h><t><![CDATA[from$_subquery$_139]]></t><s><![CDATA[SEL$347]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$48]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$48]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$906D331B]]></n><p><![CDATA[SEL$350]]></p><i><o><t>VW</t><v><![CDATA[SEL$352]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$352]]></s
        ></h></f></q>
  <q o="2"><n><![CDATA[SEL$365]]></n><f><h><t><![CDATA[from$_subquery$_115]]></t><s><![CDATA[SEL$365]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$177]]></n><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$177]]></s></h><h><t><![CDATA[DSS]]></t><s><![CDATA[SEL$177]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$A855AFED]]></n><p><![CDATA[SEL$213]]></p><i><o><t>VW</t><v><![CDATA[SEL$95CEFA00]]></v></o></i><f><h><t><![CDATA[D1]]></t><s><![CDATA[SEL$213]]></s>
        </h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$214]]></s></h><h><t><![CDATA[T9]]></t><s><![CDATA[SEL$214]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$161]]></n><f><h><t><![CDATA[from$_subquery$_455]]></t><s><![CDATA[SEL$161]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$C68B223C]]></n><p><![CDATA[SEL$49]]></p><i><o><t>VW</t><v><![CDATA[SEL$51]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$51]]></s></
        h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$D603CBAF]]></n><p><![CDATA[SEL$178]]></p><i><o><t>VW</t><v><![CDATA[SEL$177]]></v></o></i><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$177]]></s></h><
        h><t><![CDATA[DSS]]></t><s><![CDATA[SEL$177]]></s></h><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$178]]></s></h></f></q>
  <q o="7" f="y" h="y"><n><![CDATA[SEL$B01C6807]]></n><p><![CDATA[SEL$3]]></p><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$3]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$336]]></n><f><h><t><![CDATA[from$_subquery$_273]]></t><s><![CDATA[SEL$336]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$321]]></n><f><h><t><![CDATA[from$_subquery$_210]]></t><s><![CDATA[SEL$321]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$385]]></n><f><h><t><![CDATA[A]]></t><s><![CDATA[SEL$385]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$299]]></n><f><h><t><![CDATA[from$_subquery$_298]]></t><s><![CDATA[SEL$299]]></s></h><h><t><![CDATA[from$_subquery$_307]]></t><s><![CDATA[SEL$299]]></s></h>
        </f></q>
  <q o="34" f="y" h="y"><n><![CDATA[SEL$B0D01609]]></n><p><![CDATA[SEL$ADE031A8]]></p><i><o><t>TA</t><v><![CDATA[D@SEL$283]]></v></o></i><f><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$
        283]]></s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$284]]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$285]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$286]]></s></h></f>
        </q>
  <q o="2"><n><![CDATA[SEL$108]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$108]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$684DCB1D]]></n><p><![CDATA[SEL$258]]></p><i><o><t>VW</t><v><![CDATA[SEL$257]]></v></o></i><f><h><t><![CDATA[DL]]></t><s><![CDATA[SEL$257]]></s></h><
        h><t><![CDATA[DS]]></t><s><![CDATA[SEL$257]]></s></h><h><t><![CDATA[SD]]></t><s><![CDATA[SEL$258]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$170]]></n><f><h><t><![CDATA[MC]]></t><s><![CDATA[SEL$170]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$254]]></n><f><h><t><![CDATA[RA]]></t><s><![CDATA[SEL$254]]></s></h><h><t><![CDATA[RE]]></t><s><![CDATA[SEL$254]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$15]]></n><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$15]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$EAC689DF]]></n><p><![CDATA[SEL$412]]></p><i><o><t>VW</t><v><![CDATA[SEL$414]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$414]]></s></h><
        /f></q>
  <q o="18" h="y"><n><![CDATA[SEL$FEC32A10]]></n><p><![CDATA[SEL$392]]></p><i><o><t>VW</t><v><![CDATA[SEL$391]]></v></o></i><f><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]></s></h><h
        ><t><![CDATA[from$_subquery$_083]]></t><s><![CDATA[SEL$392]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$20D1D2E8]]></n><p><![CDATA[SEL$179]]></p><i><o><t>VW</t><v><![CDATA[SEL$D603CBAF]]></v></o></i><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$177]]></s>
        </h><h><t><![CDATA[DSS]]></t><s><![CDATA[SEL$177]]></s></h><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$178]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$179]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$F2A4B3EE]]></n><p><![CDATA[SEL$317]]></p><i><o><t>VW</t><v><![CDATA[SEL$22CC368D]]></v></o></i><f><h><t><![CDATA[L]]></t><s><![CDATA[SEL$236]]
        ></s></h><h><t><![CDATA[DD]]></t><s><![CDATA[SEL$237]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$0CBCACBD]]></n><p><![CDATA[SEL$105]]></p><i><o><t>VW</t><v><![CDATA[SEL$103]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$103]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$103]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$344]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$344]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$371]]></n><f><h><t><![CDATA[from$_subquery$_120]]></t><s><![CDATA[SEL$371]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$9100DC0B]]></n><p><![CDATA[SEL$108]]></p><i><o><t>VW</t><v><![CDATA[SEL$110]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$110]]></s
        ></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$0FD46156]]></n><p><![CDATA[SEL$1]]></p><i><o><t>VW</t><v><![CDATA[SEL$136]]></v></o></i><f><h><t><![CDATA[V]]></t><s><![CDATA[SEL$136]]></s></
        h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$2C920A48]]></n><p><![CDATA[SEL$233]]></p><i><o><t>VW</t><v><![CDATA[SEL$232]]></v></o></i><f><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$232]]></s></h><
        h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$232]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$233]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$255]]></n><f><h><t><![CDATA[DDS]]></t><s><![CDATA[SEL$255]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$255]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$412]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$412]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$A29A9A6B]]></n><p><![CDATA[SEL$242]]></p><i><o><t>VW</t><v><![CDATA[SEL$241]]></v></o></i><f><h><t><![CDATA[J1]]></t><s><![CDATA[SEL$241]]></s></h><
        h><t><![CDATA[J2]]></t><s><![CDATA[SEL$241]]></s></h><h><t><![CDATA[J3]]></t><s><![CDATA[SEL$242]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$338]]></n><f><h><t><![CDATA[from$_subquery$_285]]></t><s><![CDATA[SEL$338]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$45167930]]></n><p><![CDATA[SEL$291]]></p><i><o><t>VW</t><v><![CDATA[SEL$290]]></v></o><o><t>VW</t><v><![CDATA[SEL$58628C10]]></v></o></i><f><h><t><!
        [CDATA[PCS]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h><h><t><![CDATA[DIRS
        ]]></t><s><![CDATA[SEL$290]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$160]]></n><f><h><t><![CDATA[from$_subquery$_463]]></t><s><![CDATA[SEL$160]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$0B74ABC2]]></n><p><![CDATA[SEL$186]]></p><i><o><t>VW</t><v><![CDATA[SEL$1F3EA0DC]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$187]]></s><
        /h><h><t><![CDATA[T2]]></t><s><![CDATA[SEL$187]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$80]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$80]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$407]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$407]]></s></h><h><t><![CDATA[T1]]></t><s><![CDATA[SEL$407]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$58]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$58]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$67A83AA1]]></n><p><![CDATA[SEL$404]]></p><i><o><t>VW</t><v><![CDATA[SEL$374]]></v></o></i><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$374]]></s></h>
        <h><t><![CDATA[from$_subquery$_064]]></t><s><![CDATA[SEL$404]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$B9991707]]></n><p><![CDATA[SEL$153]]></p><i><o><t>VW</t><v><![CDATA[SEL$151]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$151]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$151]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$292]]></n><f><h><t><![CDATA[EMP]]></t><s><![CDATA[SEL$292]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$71D841EC]]></n><p><![CDATA[SEL$335]]></p><i><o><t>VW</t><v><![CDATA[SEL$52874634]]></v></o></i><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$269]]></s
        ></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$270]]></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$271]]></s></h><h><t><![CDATA[PCL]]></t><s><![CDATA[SEL$273]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$379]]></n><f><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h></f></q>
  <q o="12"><n><![CDATA[SEL$FDD0F22A]]></n><p><![CDATA[SEL$EAC689DF]]></p><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$414]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$382]]></n><f><h><t><![CDATA[from$_subquery$_073]]></t><s><![CDATA[SEL$382]]></s></h><h><t><![CDATA[from$_subquery$_096]]></t><s><![CDATA[SEL$382]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$362]]></n><f><h><t><![CDATA[PS]]></t><s><![CDATA[SEL$362]]></s></h><h><t><![CDATA[from$_subquery$_061]]></t><s><![CDATA[SEL$362]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$359]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$359]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$359]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$115]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$115]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$2002CBB4]]></n><p><![CDATA[SEL$197]]></p><i><o><t>VW</t><v><![CDATA[SEL$195]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$195]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$195]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$59]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$59]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$55]]></n><f><h><t><![CDATA[REQ]]></t><s><![CDATA[SEL$55]]></s></h><h><t><![CDATA[from$_subquery$_428]]></t><s><![CDATA[SEL$55]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$1E0AAD4F]]></n><p><![CDATA[SEL$161]]></p><i><o><t>VW</t><v><![CDATA[SEL$F0FAD245]]></v></o></i><f><h><t><![CDATA[from$_subquery$_464]]></t><s><![CDA
        TA[SEL$154]]></s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$155]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$10]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$10]]></s></h></f></q>
  <q o="24"><n><![CDATA[SEL$A884B7E2]]></n><p><![CDATA[SEL$F4290F7D]]></p><i><o><t>VW</t><v><![CDATA[SEL$18BE6699]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$2]]></s></h
        ><h><t><![CDATA[C]]></t><s><![CDATA[SEL$9]]></s></h><h><t><![CDATA[VW_SQ_2]]></t><s><![CDATA[SEL$A884B7E2]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$FA386CED]]></n><p><![CDATA[SEL$123]]></p><i><o><t>VW</t><v><![CDATA[SEL$121]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$121]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$121]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$207]]></n><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$207]]></s></h><h><t><![CDATA[from$_subquery$_143]]></t><s><![CDATA[SEL$207]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$31]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$31]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$394]]></n><f><h><t><![CDATA[from$_subquery$_085]]></t><s><![CDATA[SEL$394]]></s></h><h><t><![CDATA[from$_subquery$_102]]></t><s><![CDATA[SEL$394]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$118]]></n><f><h><t><![CDATA[from$_subquery$_570]]></t><s><![CDATA[SEL$118]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$381]]></n><f><h><t><![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$73]]></n><f><h><t><![CDATA[from$_subquery$_440]]></t><s><![CDATA[SEL$73]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$61]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$61]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$CBB9BA06]]></n><p><![CDATA[SEL$204]]></p><i><o><t>VW</t><v><![CDATA[SEL$6A4B05D8]]></v></o></i><f><h><t><![CDATA[AT]]></t><s><![CDATA[SEL$114]
        ]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$119]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$125]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$131]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$99]]></n><f><h><t><![CDATA[from$_subquery$_481]]></t><s><![CDATA[SEL$99]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$40]]></n><f><h><t><![CDATA[REQ]]></t><s><![CDATA[SEL$40]]></s></h><h><t><![CDATA[from$_subquery$_413]]></t><s><![CDATA[SEL$40]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$FCF0E762]]></n><p><![CDATA[SEL$285]]></p><i><o><t>VW</t><v><![CDATA[SEL$BF7C3312]]></v></o></i><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$283]]></s><
        /h><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$283]]></s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$284]]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$285]]></s></h></f></q>
  <q o="34" f="y" h="y"><n><![CDATA[SEL$CD5BF647]]></n><p><![CDATA[SEL$4C987CF0]]></p><i><o><t>TA</t><v><![CDATA[T1@SEL$407]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$40
        7]]></s></h><h><t><![CDATA[VW_SQ_1]]></t><s><![CDATA[SEL$659B72BF]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$277]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$277]]></s></h><h><t><![CDATA[T9]]></t><s><![CDATA[SEL$277]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$16DAEBA1]]></n><p><![CDATA[SEL$311]]></p><i><o><t>VW</t><v><![CDATA[SEL$43111103]]></v></o></i><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$220]]></s><
        /h><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$220]]></s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$221]]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$222]]></s></h><h><t><![CDA
        TA[S]]></t><s><![CDATA[SEL$223]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$4D82D6A1]]></n><p><![CDATA[SEL$26]]></p><i><o><t>VW</t><v><![CDATA[SEL$24]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$24]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$24]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$61DEC2DE]]></n><p><![CDATA[SEL$313]]></p><i><o><t>VW</t><v><![CDATA[SEL$235]]></v></o></i><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$235]]></s></h><h
        ><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$235]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$B7ED7A58]]></n><p><![CDATA[SEL$286]]></p><i><o><t>VW</t><v><![CDATA[SEL$FCF0E762]]></v></o></i><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$283]]></s><
        /h><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$283]]></s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$284]]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$285]]></s></h><h><t><![CDA
        TA[S]]></t><s><![CDATA[SEL$286]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$343]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$343]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$2]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$2]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$6BA534D9]]></n><p><![CDATA[SEL$59]]></p><i><o><t>VW</t><v><![CDATA[SEL$61]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$61]]></s></
        h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$2977D0E0]]></n><p><![CDATA[SEL$81]]></p><i><o><t>VW</t><v><![CDATA[SEL$83]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$83]]></s></
        h></f></q>
  <q o="2"><n><![CDATA[SEL$91]]></n><f><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$91]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$5027E41D]]></n><p><![CDATA[SEL$268]]></p><i><o><t>VW</t><v><![CDATA[SEL$267]]></v></o><o><t>VW</t><v><![CDATA[SEL$9FCC41F1]]></v></o></i><f><h><t><!
        [CDATA[PCT]]></t><s><![CDATA[SEL$263]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$264]]></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$265]]></s></h><h><t><![CDATA[PCL]]></t
        ><s><![CDATA[SEL$267]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$56]]></n><f><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDATA[SEL$56]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$106]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$106]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$BE7172B4]]></n><p><![CDATA[SEL$248]]></p><i><o><t>VW</t><v><![CDATA[SEL$1D01BD5E]]></v></o></i><f><h><t><![CDATA[J1]]></t><s><![CDATA[SEL$245]]></s>
        </h><h><t><![CDATA[J2]]></t><s><![CDATA[SEL$245]]></s></h><h><t><![CDATA[J3]]></t><s><![CDATA[SEL$246]]></s></h><h><t><![CDATA[J4]]></t><s><![CDATA[SEL$247]]></s></h><h><t><![CDATA
        [J5]]></t><s><![CDATA[SEL$248]]></s></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$241484AA]]></n><p><![CDATA[SEL$0B74ABC2]]></p><i><o><t>TA</t><v><![CDATA[T2@SEL$187]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$187]]></
        s></h></f></q>
  <q o="2"><n><![CDATA[SEL$219]]></n><f><h><t><![CDATA[from$_subquery$_315]]></t><s><![CDATA[SEL$219]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$397]]></n><f><h><t><![CDATA[DUG]]></t><s><![CDATA[SEL$397]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$167]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$167]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$167]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$58628C10]]></n><p><![CDATA[SEL$289]]></p><i><o><t>VW</t><v><![CDATA[SEL$287]]></v></o><o><t>VW</t><v><![CDATA[SEL$288]]></v></o></i><f><h><t><![CDAT
        A[PCS]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$28D2B949]]></n><p><![CDATA[SEL$270]]></p><i><o><t>VW</t><v><![CDATA[SEL$269]]></v></o></i><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$269]]></s></h>
        <h><t><![CDATA[PC]]></t><s><![CDATA[SEL$270]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$225]]></n><f><h><t><![CDATA[D1]]></t><s><![CDATA[SEL$225]]></s></h><h><t><![CDATA[ODIRS]]></t><s><![CDATA[SEL$225]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$C44BA534]]></n><p><![CDATA[SEL$166]]></p><i><o><t>VW</t><v><![CDATA[SEL$168]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$168]]></s
        ></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$30E1352B]]></n><p><![CDATA[SEL$23]]></p><i><o><t>VW</t><v><![CDATA[SEL$25]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$25]]></s></
        h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$185]]></n><f><h><t><![CDATA[DUAL]]></t><s><![CDATA[SEL$185]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$510A50D5]]></n><p><![CDATA[SEL$376]]></p><i><o><t>VW</t><v><![CDATA[SEL$375]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]></s></h><
        h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$406]]></n><f><h><t><![CDATA[SS]]></t><s><![CDATA[SEL$406]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$0DAFA1FC]]></n><p><![CDATA[SEL$4]]></p><i><o><t>VW</t><v><![CDATA[SEL$6]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$6]]></s></h><
        /f></q>
  <q o="2"><n><![CDATA[SEL$337]]></n><f><h><t><![CDATA[from$_subquery$_282]]></t><s><![CDATA[SEL$337]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$148]]></n><f><h><t><![CDATA[ATOV]]></t><s><![CDATA[SEL$148]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$395]]></n><f><h><t><![CDATA[SRV]]></t><s><![CDATA[SEL$395]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$349]]></n><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$349]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$87]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$87]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$87]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$94]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$94]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$94]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$404]]></n><f><h><t><![CDATA[from$_subquery$_064]]></t><s><![CDATA[SEL$404]]></s></h><h><t><![CDATA[from$_subquery$_346]]></t><s><![CDATA[SEL$404]]></s></h>
        </f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$C6517114]]></n><p><![CDATA[SEL$34]]></p><i><o><t>VW</t><v><![CDATA[SEL$36]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$36]]></s></
        h></f></q>
  <q o="2"><n><![CDATA[SEL$103]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$103]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$103]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$262]]></n><f><h><t><![CDATA[MS]]></t><s><![CDATA[SEL$262]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$262]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$F87F4B43]]></n><p><![CDATA[SEL$27]]></p><i><o><t>VW</t><v><![CDATA[SEL$28]]></v></o><o><t>VW</t><v><![CDATA[SEL$33]]></v></o></i><f><h><t><![CDATA[T
        ]]></t><s><![CDATA[SEL$28]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$33]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$353]]></n><f><h><t><![CDATA[from$_subquery$_133]]></t><s><![CDATA[SEL$353]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$222]]></n><f><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$222]]></s></h><h><t><![CDATA[from$_subquery$_168]]></t><s><![CDATA[SEL$222]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$F590F9F1]]></n><p><![CDATA[SEL$55E97992]]></p><i><o><t>VW</t><v><![CDATA[SEL$510A50D5]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$298]]></n><f><h><t><![CDATA[DIR]]></t><s><![CDATA[SEL$298]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$235]]></n><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$235]]></s></h><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$235]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$55E97992]]></n><p><![CDATA[SEL$378]]></p><i><o><t>VW</t><v><![CDATA[SEL$377]]></v></o></i><f><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><
        h><t><![CDATA[from$_subquery$_069]]></t><s><![CDATA[SEL$378]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$143]]></n><f><h><t><![CDATA[from$_subquery$_019]]></t><s><![CDATA[SEL$143]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$BB55E40B]]></n><p><![CDATA[SEL$388]]></p><i><o><t>VW</t><v><![CDATA[SEL$387]]></v></o></i><f><h><t><![CDATA[S]]></t><s><![CDATA[SEL$387]]></s></h><h
        ><t><![CDATA[from$_subquery$_079]]></t><s><![CDATA[SEL$388]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$5239749C]]></n><p><![CDATA[SEL$390]]></p><i><o><t>VW</t><v><![CDATA[SEL$389]]></v></o></i><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$389]]></s></h><
        h><t><![CDATA[from$_subquery$_081]]></t><s><![CDATA[SEL$390]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$23]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$23]]></s></h></f></q>
  <q o="7" f="y" h="y"><n><![CDATA[SEL$CD4C9210]]></n><p><![CDATA[SEL$8993CE0A]]></p><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$190]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$0B0BE1F3]]></n><p><![CDATA[SEL$330]]></p><i><o><t>VW</t><v><![CDATA[SEL$7D443A45]]></v></o></i><f><h><t><![CDATA[DL]]></t><s><![CDATA[SEL$257]
        ]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$257]]></s></h><h><t><![CDATA[SD]]></t><s><![CDATA[SEL$258]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$259]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$204]]></n><f><h><t><![CDATA[from$_subquery$_050]]></t><s><![CDATA[SEL$204]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$360]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$360]]></s></h></f></q>
  <q o="19" f="y" h="y"><n><![CDATA[SEL$306633FD]]></n><p><![CDATA[SEL$6137B0AF]]></p><i><o><t>SQ</t><v><![CDATA[SEL$68774E43]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$
        214]]></s></h><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$220]]></s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$221]]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$222]]></s></h><
        h><t><![CDATA[S]]></t><s><![CDATA[SEL$223]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$95CEFA00]]></n><p><![CDATA[SEL$215]]></p><i><o><t>VW</t><v><![CDATA[SEL$214]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$214]]></s></h><h
        ><t><![CDATA[T9]]></t><s><![CDATA[SEL$214]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$173]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$173]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$173]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$188]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$188]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$205]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$205]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$205]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$283]]></n><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$283]]></s></h><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$283]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$122]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$122]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$130]]></n><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$130]]></s></h><h><t><![CDATA[from$_subquery$_048]]></t><s><![CDATA[SEL$130]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$266DEF5D]]></n><p><![CDATA[SEL$73281751]]></p><i><o><t>VW</t><v><![CDATA[SEL$B6D482DA]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h><h><t><
        ![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h><h><t><![CDATA[A]]></t><s><![CDATA[SEL$385]]></s></h><h><t><![CDATA[S]]></t><s>
        <![CDATA[SEL$387]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$389]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]></s></h><h><t><![CDATA[DRS]]></t><s><![CDATA[SEL$393]]
        ></s></h><h><t><![CDATA[SRV]]></t><s><![CDATA[SEL$395]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$129]]></n><f><h><t><![CDATA[from$_subquery$_558]]></t><s><![CDATA[SEL$129]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$278]]></n><f><h><t><![CDATA[from$_subquery$_335]]></t><s><![CDATA[SEL$278]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$7D0723C2]]></n><p><![CDATA[SEL$139]]></p><i><o><t>VW</t><v><![CDATA[SEL$F87F4B43]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$28]]>
        </s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$33]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$196]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$196]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$72EEAF55]]></n><p><![CDATA[SEL$194]]></p><i><o><t>VW</t><v><![CDATA[SEL$196]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$196]]></s
        ></h></f></q>
  <q o="2"><n><![CDATA[SEL$182]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$182]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$182]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$310]]></n><f><h><t><![CDATA[from$_subquery$_163]]></t><s><![CDATA[SEL$310]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$295]]></n><f><h><t><![CDATA[from$_subquery$_294]]></t><s><![CDATA[SEL$295]]></s></h><h><t><![CDATA[from$_subquery$_305]]></t><s><![CDATA[SEL$295]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$286]]></n><f><h><t><![CDATA[S]]></t><s><![CDATA[SEL$286]]></s></h><h><t><![CDATA[from$_subquery$_280]]></t><s><![CDATA[SEL$286]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$102]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$102]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$AFCA664F]]></n><p><![CDATA[SEL$399]]></p><i><o><t>VW</t><v><![CDATA[SEL$624FDCF8]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]></s>
        </h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h><h><t><![CDA
        TA[VR]]></t><s><![CDATA[SEL$381]]></s></h><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h><h><t><![CDATA[A]]></t><s><![CDATA[SEL$385]]></s></h><h><t><![CDATA[S]]></t><s><![CD
        ATA[SEL$387]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$389]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]></s></h><h><t><![CDATA[DRS]]></t><s><![CDATA[SEL$393]]></s>
        </h><h><t><![CDATA[SRV]]></t><s><![CDATA[SEL$395]]></s></h><h><t><![CDATA[DUG]]></t><s><![CDATA[SEL$397]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$209]]></n><f><h><t><![CDATA[VF]]></t><s><![CDATA[SEL$209]]></s></h><h><t><![CDATA[VTF]]></t><s><![CDATA[SEL$209]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$300]]></n><f><h><t><![CDATA[from$_subquery$_300]]></t><s><![CDATA[SEL$300]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$75]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$75]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$2C4774CE]]></n><p><![CDATA[SEL$244A394E]]></p><i><o><t>VW</t><v><![CDATA[SEL$1CF2BDA4]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h><h><t><
        ![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$64]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$64]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$28551BD7]]></n><p><![CDATA[SEL$141]]></p><i><o><t>VW</t><v><![CDATA[SEL$B9383990]]></v></o></i><f><h><t><![CDATA[RESP]]></t><s><![CDATA[SEL$38]]></s
        ></h><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDATA[SEL$41]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$38]]></n><f><h><t><![CDATA[RESP]]></t><s><![CDATA[SEL$38]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$252]]></n><f><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$252]]></s></h><h><t><![CDATA[from$_subquery$_224]]></t><s><![CDATA[SEL$252]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$341]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$341]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$0633BE9E]]></n><p><![CDATA[SEL$411]]></p><i><o><t>VW</t><v><![CDATA[SEL$C7322B17]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$407]]></s><
        /h><h><t><![CDATA[T1]]></t><s><![CDATA[SEL$407]]></s></h><h><t><![CDATA[T3]]></t><s><![CDATA[SEL$408]]></s></h><h><t><![CDATA[T2]]></t><s><![CDATA[SEL$409]]></s></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$01090876]]></n><p><![CDATA[SEL$AFCA664F]]></p><i><o><t>TA</t><v><![CDATA[A@SEL$385]]></v></o><o><t>TA</t><v><![CDATA[DS@SEL$389]]></v></o><o><t>TA</
        t><v><![CDATA[DUG@SEL$397]]></v></o><o><t>TA</t><v><![CDATA[MKB@SEL$379]]></v></o><o><t>TA</t><v><![CDATA[PC@SEL$375]]></v></o><o><t>TA</t><v><![CDATA[PG@SEL$377]]></v></o><o><t>TA
        </t><v><![CDATA[S@SEL$387]]></v></o><o><t>TA</t><v><![CDATA[VR@SEL$381]]></v></o></i><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[EM]]></t><s><![CDATA[S
        EL$383]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]></s></h><h><t><![CDATA[DRS]]></t><s><![CDATA[SEL$393]]></s></h><h><t><![CDATA[SRV]]></t><s><![CDATA[SEL$395]]></s></h>
        </f></q>
  <q o="18" h="y"><n><![CDATA[SEL$DC51C721]]></n><p><![CDATA[SEL$210]]></p><i><o><t>VW</t><v><![CDATA[SEL$209]]></v></o></i><f><h><t><![CDATA[VF]]></t><s><![CDATA[SEL$209]]></s></h><
        h><t><![CDATA[VTF]]></t><s><![CDATA[SEL$209]]></s></h><h><t><![CDATA[ADV]]></t><s><![CDATA[SEL$210]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$151]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$151]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$151]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$258]]></n><f><h><t><![CDATA[SD]]></t><s><![CDATA[SEL$258]]></s></h><h><t><![CDATA[from$_subquery$_243]]></t><s><![CDATA[SEL$258]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$5]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$5]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$5]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$190]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$190]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$128]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$128]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$3]]></n><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$3]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$34]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$34]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$127]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$127]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$127]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$120]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$120]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$335]]></n><f><h><t><![CDATA[from$_subquery$_270]]></t><s><![CDATA[SEL$335]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$375]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$296]]></n><f><h><t><![CDATA[V]]></t><s><![CDATA[SEL$296]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$885A6771]]></n><p><![CDATA[SEL$325]]></p><i><o><t>VW</t><v><![CDATA[SEL$E10926EF]]></v></o></i><f><h><t><![CDATA[DDS]]></t><s><![CDATA[SEL$255
        ]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$255]]></s></h><h><t><![CDATA[DSDS]]></t><s><![CDATA[SEL$256]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$370]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$370]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$402]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$402]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$243]]></n><f><h><t><![CDATA[DL]]></t><s><![CDATA[SEL$243]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$2FDF64D0]]></n><p><![CDATA[SEL$225]]></p><i><o><t>VW</t><v><![CDATA[SEL$C9A6D0E0]]></v></o></i><f><h><t><![CDATA[D1]]></t><s><![CDATA[SEL$225]]></s>
        </h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$226]]></s></h><h><t><![CDATA[T9]]></t><s><![CDATA[SEL$226]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$BA42F60A]]></n><p><![CDATA[SEL$279]]></p><i><o><t>VW</t><v><![CDATA[SEL$281]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$281]]></s
        ></h></f></q>
  <q o="2"><n><![CDATA[SEL$51]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$51]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$134]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$134]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$212]]></n><f><h><t><![CDATA[ORES]]></t><s><![CDATA[SEL$212]]></s></h><h><t><![CDATA[OV]]></t><s><![CDATA[SEL$212]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$72]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$72]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$274]]></n><f><h><t><![CDATA[from$_subquery$_268]]></t><s><![CDATA[SEL$274]]></s></h><h><t><![CDATA[from$_subquery$_332]]></t><s><![CDATA[SEL$274]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$37]]></n><f><h><t><![CDATA[from$_subquery$_392]]></t><s><![CDATA[SEL$37]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$340]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$340]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$340]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$60]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$60]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$60]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$68F5C6F7]]></n><p><![CDATA[SEL$47]]></p><i><o><t>VW</t><v><![CDATA[SEL$45]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$45]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$45]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$AE143F5E]]></n><p><![CDATA[SEL$338]]></p><i><o><t>VW</t><v><![CDATA[SEL$C6BD8978]]></v></o></i><f><h><t><![CDATA[D1]]></t><s><![CDATA[SEL$276]]></s>
        </h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$277]]></s></h><h><t><![CDATA[T9]]></t><s><![CDATA[SEL$277]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$172]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$172]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$6A4B05D8]]></n><p><![CDATA[SEL$130]]></p><i><o><t>VW</t><v><![CDATA[SEL$131]]></v></o><o><t>VW</t><v><![CDATA[SEL$CA8CE374]]></v></o></i><f><h><t><!
        [CDATA[AT]]></t><s><![CDATA[SEL$114]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$119]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$125]]></s></h><h><t><![CDATA[T]]></t><s><!
        [CDATA[SEL$131]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$233]]></n><f><h><t><![CDATA[V]]></t><s><![CDATA[SEL$233]]></s></h><h><t><![CDATA[from$_subquery$_181]]></t><s><![CDATA[SEL$233]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$241]]></n><f><h><t><![CDATA[J1]]></t><s><![CDATA[SEL$241]]></s></h><h><t><![CDATA[J2]]></t><s><![CDATA[SEL$241]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$378]]></n><f><h><t><![CDATA[from$_subquery$_069]]></t><s><![CDATA[SEL$378]]></s></h><h><t><![CDATA[from$_subquery$_094]]></t><s><![CDATA[SEL$378]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$210]]></n><f><h><t><![CDATA[ADV]]></t><s><![CDATA[SEL$210]]></s></h><h><t><![CDATA[from$_subquery$_153]]></t><s><![CDATA[SEL$210]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$474C6891]]></n><p><![CDATA[SEL$84]]></p><i><o><t>VW</t><v><![CDATA[SEL$82]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$82]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$82]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$510E2E97]]></n><p><![CDATA[SEL$272]]></p><i><o><t>VW</t><v><![CDATA[SEL$271]]></v></o><o><t>VW</t><v><![CDATA[SEL$28D2B949]]></v></o></i><f><h><t><!
        [CDATA[PCT]]></t><s><![CDATA[SEL$269]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$270]]></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$271]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$4B944954]]></n><p><![CDATA[SEL$78]]></p><i><o><t>VW</t><v><![CDATA[SEL$76]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$76]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$76]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$EA954C6E]]></n><p><![CDATA[SEL$295]]></p><i><o><t>VW</t><v><![CDATA[SEL$294]]></v></o><o><t>VW</t><v><![CDATA[SEL$8D19839F]]></v></o></i><f><h><t><!
        [CDATA[PCS]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h><h><t><![CDATA[DIRS
        ]]></t><s><![CDATA[SEL$290]]></s></h><h><t><![CDATA[EMP]]></t><s><![CDATA[SEL$292]]></s></h><h><t><![CDATA[EMPA]]></t><s><![CDATA[SEL$294]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$256]]></n><f><h><t><![CDATA[DSDS]]></t><s><![CDATA[SEL$256]]></s></h><h><t><![CDATA[from$_subquery$_234]]></t><s><![CDATA[SEL$256]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$20]]></n><f><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$20]]></s></h><h><t><![CDATA[from$_subquery$_386]]></t><s><![CDATA[SEL$20]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$43111103]]></n><p><![CDATA[SEL$223]]></p><i><o><t>VW</t><v><![CDATA[SEL$102F8B08]]></v></o></i><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$220]]></s><
        /h><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$220]]></s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$221]]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$222]]></s></h><h><t><![CDA
        TA[S]]></t><s><![CDATA[SEL$223]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$216]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$216]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$316]]></n><f><h><t><![CDATA[from$_subquery$_188]]></t><s><![CDATA[SEL$316]]></s></h></f></q>
  <q o="12"><n><![CDATA[SEL$8993CE0A]]></n><p><![CDATA[SEL$5B5117AB]]></p><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$190]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$356]]></n><f><h><t><![CDATA[D_EX_SYSTEM_VALUES]]></t><s><![CDATA[SEL$356]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$02EC525C]]></n><p><![CDATA[SEL$253]]></p><i><o><t>VW</t><v><![CDATA[SEL$44B82241]]></v></o></i><f><h><t><![CDATA[PCDS]]></t><s><![CDATA[SEL$251]]></
        s></h><h><t><![CDATA[TT]]></t><s><![CDATA[SEL$251]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$252]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$253]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$234]]></n><f><h><t><![CDATA[S]]></t><s><![CDATA[SEL$234]]></s></h><h><t><![CDATA[from$_subquery$_183]]></t><s><![CDATA[SEL$234]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$79]]></n><f><h><t><![CDATA[E]]></t><s><![CDATA[SEL$79]]></s></h><h><t><![CDATA[E2]]></t><s><![CDATA[SEL$79]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$18]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$18]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$376]]></n><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[from$_subquery$_093]]></t><s><![CDATA[SEL$376]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$B9A95C06]]></n><p><![CDATA[SEL$386]]></p><i><o><t>VW</t><v><![CDATA[SEL$385]]></v></o></i><f><h><t><![CDATA[A]]></t><s><![CDATA[SEL$385]]></s></h><h
        ><t><![CDATA[from$_subquery$_077]]></t><s><![CDATA[SEL$386]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$43]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$43]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$373]]></n><f><h><t><![CDATA[from$_subquery$_057]]></t><s><![CDATA[SEL$373]]></s></h><h><t><![CDATA[from$_subquery$_345]]></t><s><![CDATA[SEL$373]]></s></h>
        </f></q>
  <q o="24"><n><![CDATA[SEL$659B72BF]]></n><p><![CDATA[SEL$F09BF2C7]]></p><i><o><t>VW</t><v><![CDATA[SEL$EAC689DF]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$407]]></s></
        h><h><t><![CDATA[T1]]></t><s><![CDATA[SEL$407]]></s></h><h><t><![CDATA[VW_SQ_1]]></t><s><![CDATA[SEL$659B72BF]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$329]]></n><f><h><t><![CDATA[DEP]]></t><s><![CDATA[SEL$329]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$46]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$46]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$230]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$230]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$208]]></n><f><h><t><![CDATA[LDL]]></t><s><![CDATA[SEL$208]]></s></h><h><t><![CDATA[LDS]]></t><s><![CDATA[SEL$208]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$325]]></n><f><h><t><![CDATA[from$_subquery$_236]]></t><s><![CDATA[SEL$325]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$3C0ECB29]]></n><p><![CDATA[SEL$170]]></p><i><o><t>VW</t><v><![CDATA[SEL$E208A177]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$171]]></s><
        /h><h><t><![CDATA[T3]]></t><s><![CDATA[SEL$171]]></s></h></f></q>
  <q o="35" h="y"><n><![CDATA[SEL$6DF0CB6D]]></n><p><![CDATA[SEL$BD5F85D1]]></p><i><o><t>TA</t><v><![CDATA[from$_subquery$_464@SEL$154]]></v></o></i><f><h><t><![CDATA[from$_subquery$
        _464]]></t><s><![CDATA[SEL$154]]></s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$155]]></s></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$6137B0AF]]></n><p><![CDATA[SEL$16DAEBA1]]></p><i><o><t>TA</t><v><![CDATA[D@SEL$220]]></v></o></i><f><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$220]]>
        </s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$221]]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$222]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$223]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$1F8A2BDC]]></n><p><![CDATA[SEL$140]]></p><i><o><t>VW</t><v><![CDATA[SEL$8E26BC93]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$43]]>
        </s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$48]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$314]]></n><f><h><t><![CDATA[from$_subquery$_178]]></t><s><![CDATA[SEL$314]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$410]]></n><f><h><t><![CDATA[from$_subquery$_351]]></t><s><![CDATA[SEL$410]]></s></h><h><t><![CDATA[from$_subquery$_355]]></t><s><![CDATA[SEL$410]]></s></h>
        </f></q>
  <q o="19" f="y" h="y"><n><![CDATA[SEL$FF54AA42]]></n><p><![CDATA[SEL$A884B7E2]]></p><i><o><t>SQ</t><v><![CDATA[SEL$18BE6699]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL
        $2]]></s></h><h><t><![CDATA[C]]></t><s><![CDATA[SEL$9]]></s></h><h><t><![CDATA[VW_SQ_2]]></t><s><![CDATA[SEL$A884B7E2]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$288]]></n><f><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$0CAA258E]]></n><p><![CDATA[SEL$115]]></p><i><o><t>VW</t><v><![CDATA[SEL$117]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$117]]></s
        ></h></f></q>
  <q o="34" f="y" h="y"><n><![CDATA[SEL$8CEE2984]]></n><p><![CDATA[SEL$AE143F5E]]></p><i><o><t>TA</t><v><![CDATA[D1@SEL$276]]></v></o><o><t>TA</t><v><![CDATA[T9@SEL$277]]></v></o></i
        ><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$277]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$186]]></n><f><h><t><![CDATA[MS]]></t><s><![CDATA[SEL$186]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$27147FD9]]></n><p><![CDATA[SEL$400]]></p><i><o><t>VW</t><v><![CDATA[SEL$402]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$402]]></s
        ></h></f></q>
  <q o="2"><n><![CDATA[SEL$47]]></n><f><h><t><![CDATA[from$_subquery$_410]]></t><s><![CDATA[SEL$47]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$332]]></n><f><h><t><![CDATA[from$_subquery$_255]]></t><s><![CDATA[SEL$332]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$228]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$228]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$411]]></n><f><h><t><![CDATA[from$_subquery$_353]]></t><s><![CDATA[SEL$411]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$176]]></n><f><h><t><![CDATA[DIS]]></t><s><![CDATA[SEL$176]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$413]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$413]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$413]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$65]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$65]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$65]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$318]]></n><f><h><t><![CDATA[from$_subquery$_197]]></t><s><![CDATA[SEL$318]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$9FCC41F1]]></n><p><![CDATA[SEL$266]]></p><i><o><t>VW</t><v><![CDATA[SEL$265]]></v></o><o><t>VW</t><v><![CDATA[SEL$55F6C155]]></v></o></i><f><h><t><!
        [CDATA[PCT]]></t><s><![CDATA[SEL$263]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$264]]></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$265]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$B6D482DA]]></n><p><![CDATA[SEL$FBD07C95]]></p><i><o><t>VW</t><v><![CDATA[SEL$43ECFA2E]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h><h><t><
        ![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h><h><t><![CDATA[A]]></t><s><![CDATA[SEL$385]]></s></h><h><t><![CDATA[S]]></t><s>
        <![CDATA[SEL$387]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$389]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]></s></h><h><t><![CDATA[DRS]]></t><s><![CDATA[SEL$393]]
        ></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$98]]></n><f><h><t><![CDATA[ST]]></t><s><![CDATA[SEL$98]]></s></h><h><t><![CDATA[from$_subquery$_479]]></t><s><![CDATA[SEL$98]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$14]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$14]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$D2A93C17]]></n><p><![CDATA[SEL$175]]></p><i><o><t>VW</t><v><![CDATA[SEL$173]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$173]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$173]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$339]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$339]]></s></h></f></q>
  <q o="19" h="y"><n><![CDATA[SEL$4C987CF0]]></n><p><![CDATA[SEL$659B72BF]]></p><i><o><t>SQ</t><v><![CDATA[SEL$EAC689DF]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$407]]>
        </s></h><h><t><![CDATA[T1]]></t><s><![CDATA[SEL$407]]></s></h><h><t><![CDATA[VW_SQ_1]]></t><s><![CDATA[SEL$659B72BF]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$0D40BBC1]]></n><p><![CDATA[SEL$318]]></p><i><o><t>VW</t><v><![CDATA[SEL$238]]></v></o></i><f><h><t><![CDATA[ORES]]></t><s><![CDATA[SEL$238]]><
        /s></h><h><t><![CDATA[OV]]></t><s><![CDATA[SEL$238]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$93]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$93]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$B32B9E55]]></n><p><![CDATA[SEL$398]]></p><i><o><t>VW</t><v><![CDATA[SEL$397]]></v></o></i><f><h><t><![CDATA[DUG]]></t><s><![CDATA[SEL$397]]></s></h>
        <h><t><![CDATA[from$_subquery$_089]]></t><s><![CDATA[SEL$398]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$288B3780]]></n><p><![CDATA[SEL$362]]></p><i><o><t>VW</t><v><![CDATA[SEL$4766B431]]></v></o><o><t>VW</t><v><![CDATA[SEL$D9097786]]></v></o></i><f><h>
        <t><![CDATA[D_EX_SYSTEM_VALUES]]></t><s><![CDATA[SEL$356]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$357]]></s></h><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$363]]></s></h><h><t
        ><![CDATA[S]]></t><s><![CDATA[SEL$363]]></s></h><h><t><![CDATA[ST]]></t><s><![CDATA[SEL$364]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$7C3F09F1]]></n><p><![CDATA[SEL$70]]></p><i><o><t>VW</t><v><![CDATA[SEL$72]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$72]]></s></
        h></f></q>
  <q o="2"><n><![CDATA[SEL$32]]></n><f><h><t><![CDATA[from$_subquery$_398]]></t><s><![CDATA[SEL$32]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$198]]></n><f><h><t><![CDATA[DSC]]></t><s><![CDATA[SEL$198]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$88C6B492]]></n><p><![CDATA[SEL$29]]></p><i><o><t>VW</t><v><![CDATA[SEL$31]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$31]]></s></
        h></f></q>
  <q o="19" f="y" h="y"><n><![CDATA[SEL$AD8C7765]]></n><p><![CDATA[SEL$0FFCFA0B]]></p><i><o><t>SQ</t><v><![CDATA[SEL$5B5117AB]]></v></o></i><f><h><t><![CDATA[VW_SQ_4]]></t><s><![CDAT
        A[SEL$0FFCFA0B]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$187]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$333]]></n><f><h><t><![CDATA[from$_subquery$_262]]></t><s><![CDATA[SEL$333]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$358]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$358]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$279]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$279]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$ADE031A8]]></n><p><![CDATA[SEL$337]]></p><i><o><t>VW</t><v><![CDATA[SEL$B7ED7A58]]></v></o></i><f><h><t><![CDATA[D]]></t><s><![CDATA[SEL$283]]></s><
        /h><h><t><![CDATA[ODIR]]></t><s><![CDATA[SEL$283]]></s></h><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$284]]></s></h><h><t><![CDATA[ODS]]></t><s><![CDATA[SEL$285]]></s></h><h><t><![CDA
        TA[S]]></t><s><![CDATA[SEL$286]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$164]]></n><f><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$164]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$84]]></n><f><h><t><![CDATA[from$_subquery$_452]]></t><s><![CDATA[SEL$84]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$419D8FE3]]></n><p><![CDATA[SEL$79]]></p><i><o><t>VW</t><v><![CDATA[SEL$80]]></v></o><o><t>VW</t><v><![CDATA[SEL$85]]></v></o></i><f><h><t><![CDATA[T
        ]]></t><s><![CDATA[SEL$80]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$85]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$E10926EF]]></n><p><![CDATA[SEL$256]]></p><i><o><t>VW</t><v><![CDATA[SEL$255]]></v></o></i><f><h><t><![CDATA[DDS]]></t><s><![CDATA[SEL$255]]></s></h>
        <h><t><![CDATA[PC]]></t><s><![CDATA[SEL$255]]></s></h><h><t><![CDATA[DSDS]]></t><s><![CDATA[SEL$256]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$386]]></n><f><h><t><![CDATA[from$_subquery$_077]]></t><s><![CDATA[SEL$386]]></s></h><h><t><![CDATA[from$_subquery$_098]]></t><s><![CDATA[SEL$386]]></s></h>
        </f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$CC1EF0E8]]></n><p><![CDATA[SEL$129]]></p><i><o><t>VW</t><v><![CDATA[SEL$127]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$127]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$127]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$7FF20CC2]]></n><p><![CDATA[SEL$314]]></p><i><o><t>VW</t><v><![CDATA[SEL$224]]></v></o></i><f><h><t><![CDATA[L]]></t><s><![CDATA[SEL$224]]></s>
        </h><h><t><![CDATA[LD]]></t><s><![CDATA[SEL$224]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$70]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$70]]></s></h></f></q>
  <q o="35" f="y" h="y"><n><![CDATA[SEL$B560D28C]]></n><p><![CDATA[SEL$457DE630]]></p><i><o><t>TA</t><v><![CDATA[PCC@SEL$265]]></v></o></i><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL
        $263]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$264]]></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$265]]></s></h><h><t><![CDATA[PCL]]></t><s><![CDATA[SEL$267]]></s></h><
        /f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$CFD2D090]]></n><p><![CDATA[SEL$132]]></p><i><o><t>VW</t><v><![CDATA[SEL$134]]></v></o></i><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$134]]></s
        ></h></f></q>
  <q o="34" f="y" h="y"><n><![CDATA[SEL$169CD701]]></n><p><![CDATA[SEL$1880377E]]></p><i><o><t>TA</t><v><![CDATA[S@SEL$363]]></v></o></i><f><h><t><![CDATA[D_EX_SYSTEM_VALUES]]></t><s
        ><![CDATA[SEL$356]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$357]]></s></h><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$363]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$24]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$24]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$24]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$264]]></n><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$264]]></s></h><h><t><![CDATA[from$_subquery$_327]]></t><s><![CDATA[SEL$264]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$52874634]]></n><p><![CDATA[SEL$274]]></p><i><o><t>VW</t><v><![CDATA[SEL$273]]></v></o><o><t>VW</t><v><![CDATA[SEL$510E2E97]]></v></o></i><f><h><t><!
        [CDATA[PCT]]></t><s><![CDATA[SEL$269]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$270]]></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$271]]></s></h><h><t><![CDATA[PCL]]></t
        ><s><![CDATA[SEL$273]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$114]]></n><f><h><t><![CDATA[AT]]></t><s><![CDATA[SEL$114]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$17]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$17]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$17]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$F23444D6]]></n><p><![CDATA[SEL$7]]></p><i><o><t>VW</t><v><![CDATA[SEL$5]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$5]]></s></h><
        h><t><![CDATA[US]]></t><s><![CDATA[SEL$5]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$C9A6D0E0]]></n><p><![CDATA[SEL$227]]></p><i><o><t>VW</t><v><![CDATA[SEL$226]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$226]]></s></h><h
        ><t><![CDATA[T9]]></t><s><![CDATA[SEL$226]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$301]]></n><f><h><t><![CDATA[T2]]></t><s><![CDATA[SEL$301]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$66]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$66]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$F0FAD245]]></n><p><![CDATA[SEL$154]]></p><i><o><t>VW</t><v><![CDATA[SEL$155]]></v></o></i><f><h><t><![CDATA[from$_subquery$_464]]></t><s><![CDATA[SE
        L$154]]></s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$155]]></s></h></f></q>
  <q o="34" h="y"><n><![CDATA[SEL$E208A177]]></n><p><![CDATA[SEL$171]]></p><i><o><t>TA</t><v><![CDATA[T1@SEL$171]]></v></o><o><t>TA</t><v><![CDATA[T2@SEL$171]]></v></o><o><t>TA</t><v
        ><![CDATA[T4@SEL$171]]></v></o></i><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$171]]></s></h><h><t><![CDATA[T3]]></t><s><![CDATA[SEL$171]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$363]]></n><f><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$363]]></s></h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$363]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$4A8506B4]]></n><p><![CDATA[SEL$336]]></p><i><o><t>VW</t><v><![CDATA[SEL$275]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$275]]></s
        ></h><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$275]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$C90D5F44]]></n><p><![CDATA[SEL$C28125FF]]></p><i><o><t>VW</t><v><![CDATA[SEL$F590F9F1]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h></f></q
        >
  <q o="34" f="y" h="y"><n><![CDATA[SEL$09C8BA82]]></n><p><![CDATA[SEL$609DDCFC]]></p><i><o><t>TA</t><v><![CDATA[PCL@SEL$273]]></v></o></i><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL
        $269]]></s></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$270]]></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$271]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$39]]></n><f><h><t><![CDATA[INT_HL7V3_MSGS]]></t><s><![CDATA[SEL$39]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$7C84398F]]></n><p><![CDATA[SEL$32]]></p><i><o><t>VW</t><v><![CDATA[SEL$30]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$30]]></s></
        h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$30]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$89]]></n><f><h><t><![CDATA[from$_subquery$_446]]></t><s><![CDATA[SEL$89]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$52D6E3A9]]></n><p><![CDATA[SEL$300]]></p><i><o><t>VW</t><v><![CDATA[SEL$CBF62EE2]]></v></o></i><f><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$287]]></s
        ></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h><h><t><![CDATA[DIRS]]></t><s><![CDATA[SEL$290]]></s></h><h><t
        ><![CDATA[EMP]]></t><s><![CDATA[SEL$292]]></s></h><h><t><![CDATA[EMPA]]></t><s><![CDATA[SEL$294]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$296]]></s></h><h><t><![CDATA[DIR]]>
        </t><s><![CDATA[SEL$298]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$237]]></n><f><h><t><![CDATA[DD]]></t><s><![CDATA[SEL$237]]></s></h><h><t><![CDATA[from$_subquery$_324]]></t><s><![CDATA[SEL$237]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$144]]></n><f><h><t><![CDATA[from$_subquery$_025]]></t><s><![CDATA[SEL$144]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$211]]></n><f><h><t><![CDATA[MVD]]></t><s><![CDATA[SEL$211]]></s></h><h><t><![CDATA[VD]]></t><s><![CDATA[SEL$211]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$6823446A]]></n><p><![CDATA[SEL$382]]></p><i><o><t>VW</t><v><![CDATA[SEL$381]]></v></o></i><f><h><t><![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h><
        h><t><![CDATA[from$_subquery$_073]]></t><s><![CDATA[SEL$382]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$369]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$369]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$369]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$DF7D0533]]></n><p><![CDATA[SEL$BB55E40B]]></p><i><o><t>VW</t><v><![CDATA[SEL$57018A77]]></v></o></i><f><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$375]]
        ></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[PG]]></t><s><![CDATA[SEL$377]]></s></h><h><t><![CDATA[MKB]]></t><s><![CDATA[SEL$379]]></s></h><h><t><
        ![CDATA[VR]]></t><s><![CDATA[SEL$381]]></s></h><h><t><![CDATA[EM]]></t><s><![CDATA[SEL$383]]></s></h><h><t><![CDATA[A]]></t><s><![CDATA[SEL$385]]></s></h><h><t><![CDATA[S]]></t><s>
        <![CDATA[SEL$387]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$384]]></n><f><h><t><![CDATA[from$_subquery$_075]]></t><s><![CDATA[SEL$384]]></s></h><h><t><![CDATA[from$_subquery$_097]]></t><s><![CDATA[SEL$384]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$116]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$116]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$116]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$FF307D9F]]></n><p><![CDATA[SEL$163]]></p><i><o><t>VW</t><v><![CDATA[SEL$164]]></v></o></i><f><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$164]]>
        </s></h></f></q>
  <q o="2"><n><![CDATA[SEL$9]]></n><f><h><t><![CDATA[C]]></t><s><![CDATA[SEL$9]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$313]]></n><f><h><t><![CDATA[from$_subquery$_191]]></t><s><![CDATA[SEL$313]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$263]]></n><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$263]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$44B82241]]></n><p><![CDATA[SEL$252]]></p><i><o><t>VW</t><v><![CDATA[SEL$251]]></v></o></i><f><h><t><![CDATA[PCDS]]></t><s><![CDATA[SEL$251]]></s></h
        ><h><t><![CDATA[TT]]></t><s><![CDATA[SEL$251]]></s></h><h><t><![CDATA[DS]]></t><s><![CDATA[SEL$252]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$284]]></n><f><h><t><![CDATA[OD]]></t><s><![CDATA[SEL$284]]></s></h><h><t><![CDATA[from$_subquery$_276]]></t><s><![CDATA[SEL$284]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$42]]></n><f><h><t><![CDATA[E]]></t><s><![CDATA[SEL$42]]></s></h><h><t><![CDATA[E2]]></t><s><![CDATA[SEL$42]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$357]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$357]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$096670FF]]></n><p><![CDATA[SEL$20]]></p><i><o><t>VW</t><v><![CDATA[SEL$14]]></v></o><o><t>VW</t><v><![CDATA[SEL$21]]></v></o></i><f><h><t><![CDATA[P
        C]]></t><s><![CDATA[SEL$14]]></s></h><h><t><![CDATA[PCSOR]]></t><s><![CDATA[SEL$21]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$183]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$183]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$174]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$174]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$BA458DC4]]></n><p><![CDATA[SEL$135]]></p><i><o><t>VW</t><v><![CDATA[SEL$133]]></v></o></i><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$133]]></s
        ></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$133]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$238]]></n><f><h><t><![CDATA[ORES]]></t><s><![CDATA[SEL$238]]></s></h><h><t><![CDATA[OV]]></t><s><![CDATA[SEL$238]]></s></h></f></q>
  <q o="2" f="y"><n><![CDATA[SEL$309]]></n><f><h><t><![CDATA[CL]]></t><s><![CDATA[SEL$309]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$104]]></n><f><h><t><![CDATA[UP]]></t><s><![CDATA[SEL$104]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$111]]></n><f><h><t><![CDATA[from$_subquery$_474]]></t><s><![CDATA[SEL$111]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$457DE630]]></n><p><![CDATA[SEL$333]]></p><i><o><t>VW</t><v><![CDATA[SEL$5027E41D]]></v></o></i><f><h><t><![CDATA[PCT]]></t><s><![CDATA[SEL$263]]></s
        ></h><h><t><![CDATA[PC]]></t><s><![CDATA[SEL$264]]></s></h><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$265]]></s></h><h><t><![CDATA[PCL]]></t><s><![CDATA[SEL$267]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$140]]></n><f><h><t><![CDATA[from$_subquery$_016]]></t><s><![CDATA[SEL$140]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$242]]></n><f><h><t><![CDATA[J3]]></t><s><![CDATA[SEL$242]]></s></h><h><t><![CDATA[from$_subquery$_206]]></t><s><![CDATA[SEL$242]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$392]]></n><f><h><t><![CDATA[from$_subquery$_083]]></t><s><![CDATA[SEL$392]]></s></h><h><t><![CDATA[from$_subquery$_101]]></t><s><![CDATA[SEL$392]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$68]]></n><f><h><t><![CDATA[E]]></t><s><![CDATA[SEL$68]]></s></h><h><t><![CDATA[E2]]></t><s><![CDATA[SEL$68]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$D9097786]]></n><p><![CDATA[SEL$355]]></p><i><o><t>VW</t><v><![CDATA[SEL$356]]></v></o><o><t>VW</t><v><![CDATA[SEL$357]]></v></o></i><f><h><t><![CDAT
        A[D_EX_SYSTEM_VALUES]]></t><s><![CDATA[SEL$356]]></s></h><h><t><![CDATA[T]]></t><s><![CDATA[SEL$357]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$76]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$76]]></s></h><h><t><![CDATA[US]]></t><s><![CDATA[SEL$76]]></s></h></f></q>
  <q o="35" f="y" h="y"><n><![CDATA[SEL$F306E5BC]]></n><p><![CDATA[SEL$F7F100ED]]></p><i><o><t>TA</t><v><![CDATA[DRS@SEL$393]]></v></o><o><t>TA</t><v><![CDATA[SRV@SEL$395]]></v></o><
        o><t>TA</t><v><![CDATA[V@SEL$391]]></v></o></i><f><h><t><![CDATA[PCC]]></t><s><![CDATA[SEL$376]]></s></h><h><t><![CDATA[V]]></t><s><![CDATA[SEL$391]]></s></h><h><t><![CDATA[DRS]]><
        /t><s><![CDATA[SEL$393]]></s></h><h><t><![CDATA[SRV]]></t><s><![CDATA[SEL$395]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$398]]></n><f><h><t><![CDATA[from$_subquery$_089]]></t><s><![CDATA[SEL$398]]></s></h><h><t><![CDATA[from$_subquery$_104]]></t><s><![CDATA[SEL$398]]></s></h>
        </f></q>
  <q o="2"><n><![CDATA[SEL$396]]></n><f><h><t><![CDATA[from$_subquery$_087]]></t><s><![CDATA[SEL$396]]></s></h><h><t><![CDATA[from$_subquery$_103]]></t><s><![CDATA[SEL$396]]></s></h>
        </f></q>
  <q o="18" h="y"><n><![CDATA[SEL$65F26A31]]></n><p><![CDATA[SEL$99]]></p><i><o><t>VW</t><v><![CDATA[SEL$BCB735A9]]></v></o></i><f><h><t><![CDATA[PCS]]></t><s><![CDATA[SEL$97]]></s><
        /h><h><t><![CDATA[S]]></t><s><![CDATA[SEL$97]]></s></h><h><t><![CDATA[ST]]></t><s><![CDATA[SEL$98]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$49]]></n><f><h><t><![CDATA[UR]]></t><s><![CDATA[SEL$49]]></s></h></f></q>
  <q o="2"><n><![CDATA[SEL$214]]></n><f><h><t><![CDATA[T]]></t><s><![CDATA[SEL$214]]></s></h><h><t><![CDATA[T9]]></t><s><![CDATA[SEL$214]]></s></h></f></q>
  <q o="18" h="y"><n><![CDATA[SEL$8D19839F]]></n><p><![CDATA[SEL$293]]></p><i><o><t>VW</t><v><![CDATA[SEL$292]]></v></o><o><t>VW</t><v><![CDATA[SEL$45167930]]></v></o></i><f><h><t><!
        [CDATA[PCS]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[SERV]]></t><s><![CDATA[SEL$287]]></s></h><h><t><![CDATA[PCDIRS]]></t><s><![CDATA[SEL$288]]></s></h><h><t><![CDATA[DIRS
        ]]></t><s><![CDATA[SEL$290]]></s></h><h><t><![CDATA[EMP]]></t><s><![CDATA[SEL$292]]></s></h></f></q>
  <q o="18" f="y" h="y"><n><![CDATA[SEL$4E5B4514]]></n><p><![CDATA[SEL$322]]></p><i><o><t>VW</t><v><![CDATA[SEL$AB0185AF]]></v></o></i><f><h><t><![CDATA[J1]]></t><s><![CDATA[SEL$245]
        ]></s></h><h><t><![CDATA[J2]]></t><s><![CDATA[SEL$245]]></s></h><h><t><![CDATA[J3]]></t><s><![CDATA[SEL$246]]></s></h><h><t><![CDATA[J4]]></t><s><![CDATA[SEL$247]]></s></h><h><t><!
        [CDATA[J5]]></t><s><![CDATA[SEL$248]]></s></h><h><t><![CDATA[DL]]></t><s><![CDATA[SEL$249]]></s></h></f></q>
 
 
