-- select the missing contacts with no tenancy

WITH Tenancy AS
(
    SELECT * 
    FROM gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_tenancy T
    WHERE T.Ltcy_alt_ref like '%ORGN48765' -- this teneacy is not link to a people 
),

Property AS
(
    SELECT *
    FROM gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_property P
),

Contact_hist_raw AS (
  SELECT
      Primary_account_tenancy_id,
      Contact_id,
      Title,
      First_name,
      Last_name,
      Date_of_birth,
      Full_name,
      ROW_NUMBER()
          OVER (PARTITION BY Contact_id ORDER BY Modified_on DESC)
          AS Rn,
  FROM `gc-r-prj-originmig`.`Origin_Migration_omar_Source`.`dim_contact_history`
),

Contact_hist AS (
    SELECT DISTINCT *,
    FROM Contact_hist_raw
    WHERE Rn = 1
),


People AS (
SELECT *
FROM  `gc-r-prj-originmig.Origin_Migration_omar_public.dim_people`
-- WHERE Lpar_tcy_alt_ref is not null --like '%48765%'
)

SELECT 'name' as sql , Ch.* ,T.tenancy_id, T.ltcy_correspond_name,T.Ltcy_tho_propref1, T.Ltcy_alt_ref,T.*
FROM Tenancy T
JOIN Property P ON P.Property_id = T.Property_id
JOIN Contact_hist Ch ON T.ltcy_correspond_name =  ch.Full_name
UNION ALL
SELECT 'tenancy_id' ,Ch.* ,T.tenancy_id, T.ltcy_correspond_name,T.Ltcy_tho_propref1, T.Ltcy_alt_ref,T.*
FROM Tenancy T
JOIN Property P ON P.Property_id = T.Property_id
JOIN Contact_hist Ch ON T.tenancy_id = Ch.Primary_account_tenancy_id
Lpar_tcy_alt_ref