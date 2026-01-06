-- -- The is returns the table name and row_count
SELECT table_id,  row_count
FROM gc-r-prj-originmig.Origin_Migration_omar_public.__TABLES__
WHERE table_id like 'dq%'
ORDER BY row_count DESC

SELECT table_id,  row_count
FROM gc-r-prj-originmig.Origin_Migration_omar_public.__TABLES__
WHERE table_id like 'dim%'
ORDER BY row_count DESC




-- These don't have the DQ columns set out  in the same why as the others 
-- debit breakdowns 
-- transactions 
-- revenue accounts 
-- account balances 
-- arrrears actions

SELECT count(*) AS cnt, 'Total' as Description FROM gc-r-prj-originmig.Origin_Migration_omar_staging.int_account_balances 
-- 12 287 560
UNION ALL 
SELECT count(*) AS cnt, 'With DQ Error' as Description FROM gc-r-prj-originmig.Origin_Migration_omar_staging.int_account_balances ab
WHERE ab.Has_data_quality_issues
-- 496 866

SELECT count(*) ,Is_missing_Laba_pay_ref, Is_missing_Laba_balance, Is_missing_Laba_balance_date, Is_Laba_balance_date_future
 FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_account_balances`
 GROUP BY Is_missing_Laba_pay_ref, Is_missing_Laba_balance, Is_missing_Laba_balance_date, Is_Laba_balance_date_future

SELECT count(*) , Is_missing_lcde_legacy_ref, Is_missing_lcde_contact_name, Is_missing_lcde_comments
 FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dq_dim_contact_details`
GROUP BY Is_missing_lcde_legacy_ref, Is_missing_lcde_contact_name, Is_missing_lcde_comments

SELECT count(*)
 FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dim_account_balances`