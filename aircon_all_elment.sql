WITH
Source AS (
    SELECT *,
    FROM `gc-r-prj-originmig`.`Origin_Migration_fili_raw`.`raw_fct_components`
 
),
 
Property AS (
    SELECT *,
    FROM `gc-r-prj-originmig`.`Origin_Migration_fili_raw`.`raw_dim_property`
 
),
 
Phierarchy AS (
    SELECT *,
    FROM `gc-r-prj-originmig`.`Origin_Migration_fili`.`property_hierarchy`
)
 
 
SELECT
  S.Orchard_property_reference AS Lpel_pro_propref,
  AIRCON           AS Lpel_ety_code,
   COALESCE(Source.Installed_on, PR.Acquired_date, CAST(CURRENT_TIMESTAMP() AS DATE))              AS Lpel_start,
   CASE WHEN Source.Component_name='Air Conditioning System' THEN 'Present' ELSE NULL END               AS Lpel_atty_code,
  CAST(NULL AS STRING)         AS Lpel_date,
  CAST(NULL AS INT64)             AS Lpel_value,
  CAST(NULL AS STRING)                 AS Lpel_hrv_repcat,
  CAST(NULL AS STRING)               AS Lpel_end,
  CASE WHEN H.Property_hierarchy = 'AUN'  THEN 'AUN' ELSE 'PRO' END                AS Lpel_hrv_elo_code,
  CAST(NULL AS STRING)               AS Lpel_fat_code,
  CAST(NULL AS STRING)              AS Lpel_text,
  CASE WHEN H.Property_hierarchy = 'AUN'  THEN 'A' ELSE NULL  END                 AS Lpel_aun_ind,
  CAST(NULL AS STRING)               AS Lpel_hrv_rco_code,
  CAST(NULL AS STRING)          AS Lpel_quantity,
  CAST(NULL AS STRING)        AS Lpel_text_value,
   S.Lifespan     AS Lpel_remaining_life,
   S.Installed_on        AS Lpel_install_date,
  CAST(NULL AS STRING)       AS Lpel_repair_cost,
  CAST(NULL AS STRING)       AS Lpel_repair_year,
  CAST(NULL AS STRING)        AS Lpel_hrv_hqdc_code,
  CAST(NULL AS STRING)     AS Lpel_deferral_year,
  CAST(NULL AS STRING)     AS Lpel_override_cost,
  'Compliance'           AS Element_type,
  'Air Conditioning System'           AS Element_name,
  S.Asset_status AS Asset_status,
  S.Asset_subcategory AS Asset_subcategory
FROM Source AS S
              inner join Property as PR on PR.Property_id = S.Property_id
              inner join PHierarchy as H on CAST(H.Orchard_property_reference AS STRING) = PR.Orchard_property_reference