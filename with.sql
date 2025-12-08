WITH Missing_tenancy AS
-- This represents all tenancies that are not linked to a tenancy people
(
    SELECT t.Ltcy_alt_ref, t.Ltcy_tho_propref1,t.Ltcy_hrv_tst_code, t.Ltcy_correspond_name,  p.*
    FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dim_tenancy` t
    LEFT JOIN (
        SELECT DISTINCT *
        FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people`
        WHERE Lpar_tcy_alt_ref IS NOT NULL
        ) p ON t.Ltcy_alt_ref = p.Lpar_tcy_alt_ref
WHERE p.Lpar_tcy_alt_ref IS NULL 
AND t.Ltcy_alt_ref IN ('ORGN48765', 'ORGN49488', 'ORGN70308', 'ORGN31784', 'ORGN33036', 'ORGN43170', 'ORGN29551', 'ORGN24626', 'ORGN30891')
),

People AS (
SELECT *
FROM  `gc-r-prj-originmig.Origin_Migration_omar_public.dim_people`
 WHERE Lpar_tcy_alt_ref like '%8282'
),

Property AS (
    SELECT *
    FROM `gc-r-prj-originmig`.`Origin_Migration_omar_staging`.`stg_dim_property`
),


Tenancy AS (
    SELECT *,
    FROM `gc-r-prj-originmig`.`Origin_Migration_omar_staging`.`int_dim_tenancy`
    -- `gc-r-prj-originmig.Origin_Migration_omar_Source.dim_tenancy`
)

SELECT DISTINCT T.* FROM Tenancy T
JOIN Property P ON P.Property_id = T.Property_id
JOIN People Pl ON Pl.
WHERE P.Lpro_propref = 8282
-- WHERE T.Tenancy_number = '48765'

-- SELECT * FROM Property P
-- WHERE P.Lpro_propref = 8282
-- SELECT  *
-- FROM Missing_tenancy Mt
-- JOIN Tenancy T ON Mt.Ltcy_alt_ref = T.Ltcy_alt_ref
-- JOIN Property P ON P.Lpro_propref = Mt.Ltcy_tho_propref1
-- JOIN People Pl ON Pl.Lpar_per_alt_ref  = ,Tenancy_number = T.Tenancy_number
 -- The number shown with the Alt Ref is the tenancy number 48765 
 -- which is linked the property ref 8282 
 -- and you should also have a person number =25179 which I cannot see on your spreadsheet. 
--  THIS JOIN IS NOT DONE The person number will give you the main tenant and there will be another person number if it is a joint account.
--   Each household will have a unique Person number which should be linked to a property Ref, but only main and joint tenants will have a tenancy number.
  -- Some household members are not linked to tenancy numbers on our system as they are not liable for the rents.
 

--  Since person_number exists only in dim_contact and not in dim_tenancy, it cannot be used to join contact and tenancy data.
-- The most reliable join path is to use primary_account_tenancy_id from dim_contact_history and match it to tenancy_id in dim_tenancy.

-- After joining on tenancy_id, if some contact details are still missing, 
-- you can use the ltcy_correspond_name field in the Tenancy table as a fallback to search for corresponding contacts in dim_contact_history.
