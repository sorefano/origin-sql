-- -- The is returns the table name and row_count
-- SELECT table_id,  row_count
-- FROM gc-r-prj-originmig.Origin_Migration_omar_public.__TABLES__
-- WHERE table_id like 'dq%'
-- ORDER BY row_count DESC



-- These don't have the DQ columns set out  in the same why as the others 
-- debit breakdowns 
-- transactions 
-- revenue accounts 
-- account balances 
-- arrrears actions

SELECT * FROM gc-r-prj-originmig.Origin_Migration_omar_public.dq_fct_estates_property_elements