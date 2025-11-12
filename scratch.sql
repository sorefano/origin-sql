WITH Latest_partition AS (
    SELECT MAX(Loaded_date) AS Max_date,
    FROM `gc-r-prj-originmig`.`Origin_Migration_omar_Source`.`fct_components`
    WHERE Loaded_date IS NOT NULL

),

Components_casted AS (
    SELECT
        CAST(Component_id AS STRING) AS Component_id,
        CAST(Property_id AS STRING) AS Property_id,
        CAST(Commencement_on AS DATETIME) AS Commencement_on,
        CAST(Calculated_warranty_expires_on AS DATETIME) AS Calculated_warranty_expires_on,
        CAST(Installed_on AS DATETIME) AS Installed_on,
        CAST(Is_determined_multiples_allowed AS BOOLEAN) AS Is_determined_multiples_allowed,
        CAST(Age AS INT64) AS Age,
        CAST(Quantity AS INT64) AS Quantity,
        CAST(Warranty_period AS INT64) AS Warranty_period,
        CAST(Communal_or_domestic AS STRING) AS Communal_or_domestic,
        CAST(Component_servicing_responsibility AS STRING) AS Component_servicing_responsibility,
        CAST(Component_reference AS STRING) AS Component_reference,
        CAST(Component_full_name AS STRING) AS Component_full_name,
        CAST(Location_additional_information AS STRING) AS Location_additional_information,
        CAST(Serial_number AS STRING) AS Serial_number,
        CAST(Is_job_aggregated_by_asset AS BOOLEAN) AS Is_job_aggregated_by_asset,
        CAST(Is_multiple_quantities_allowed AS BOOLEAN) AS Is_multiple_quantities_allowed,
        CAST(Component_name AS STRING) AS Component_name,
        CAST(Decent_homes_key_component AS STRING) AS Decent_homes_key_component,
        CAST(Category_name AS STRING) AS Category_name,
        CAST(Access_name AS STRING) AS Access_name,
        CAST(Aspect_name AS STRING) AS Aspect_name,
        CAST(Fuel_type_name AS STRING) AS Fuel_type_name,
        CAST(Gas_related AS STRING) AS Gas_related,
        CAST(Glazing_type_name AS STRING) AS Glazing_type_name,
        CAST(Component_grade_name AS STRING) AS Component_grade_name,
        CAST(Make_name AS STRING) AS Make_name,
        CAST(Model_name AS STRING) AS Model_name,
        CAST(Make_model_code AS INT64) AS Make_model_code,
        CAST(Monitoring_type_name AS STRING) AS Monitoring_type_name,
        CAST(Power_source_name AS STRING) AS Power_source_name,
        CAST(Preservation_order_name AS STRING) AS Preservation_order_name,
        CAST(Type_name AS STRING) AS Type_name,
        CAST(Lifespan AS INT64) AS Lifespan,
        CAST(Replacement_cost AS NUMERIC) AS Replacement_cost,
        CAST(Loaded_date AS DATETIME) AS Loaded_date,
    FROM `gc-r-prj-originmig`.`Origin_Migration_omar_Source`.`fct_components`
    WHERE Loaded_date = COALESCE(
        
            (SELECT Latest_partition.Max_date, FROM Latest_partition)
        
    )

)

SELECT *,
FROM Components_casted