with public_dim_people AS (
    SELECT *
    FROM gc-r-prj-originmig.Origin_Migration_omar_public.dim_people
)

-- SELECT  P.Lpar_hop_end_date, P.Lpar_tin_end_date, *
-- FROM public_dim_people P
-- WHERE P.Lpar_hop_end_date <> P.Lpar_tin_end_date


-- SELECT count(*) , P.Lpar_hop_end_date 
-- FROM public_dim_people

 SELECT count(*), P.Lpar_hop_end_date--, P.Lpar_hop_hper_code
 FROM public_dim_people P
--  WHERE Lpar_hop_end_date like '%9999'
 GROUP BY P.Lpar_hop_end_date --, P.Lpar_hop_hper_code
 ORDER by 1 DESC


-- SELECT COUNT(*) , LPAR_PER_HOU_HRV_SEXO_CODE
-- FROM public_dim_people
-- GROUP BY LPAR_PER_HOU_HRV_SEXO_CODE
-- Bisexual	73			BISEXUAL		BISEXUAL	Bisexual
-- Gay	125			GAY		GAY	Gay
-- Heterosexual / Straight	8251			HETERO		HETERO	Heterosexual
-- Lesbian	34			LESBIAN		LESBIAN	Lesbian
-- Other	60			OTHER		NOTPERSON	Not a Person - e.g. a Company
-- Prefer Not To Say	1717			NOTSTATED		NOTSTATED	Prefer not to say
-- Unknown	41173			NOTSTATED		TRANSGEND	Transgender


SELECT  
 FORMAT_DATE('%d-%d-%Y',DATE '31-12-2000'),
 CURRENT_DATE()
;

SELECT CASE 
        WHEN 
            CURRENT_DATE() < CAST('9999-12-31' AS DATE) 
        THEN CURRENT_DATE() END as test
        
SELECT FORMAT_DATE('%b-%d-%Y', DATE '2008-12-25') AS formatted;
