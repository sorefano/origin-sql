with public_dim_people AS (
    SELECT PARSE_DATE('%d-%b-%Y', Lpar_tin_start_date) AS Lpar_tin_start_date1 , PARSE_DATE('%d-%b-%Y',Lpar_tin_end_date) AS Lpar_tin_end_date1 , *
    FROM gc-r-prj-originmig.Origin_Migration_omar_public.dim_people
)
-- LPAR_TIN_START_DATE and LPAR_TIN_END_DATE for LPAR_TCY_ALT_REF
-- SELECT PARSE_DATE('%A %b %e %Y', 'Thursday Dec 25 2008');

SELECT DATE_DIFF (P.Lpar_tin_end_date1, P.Lpar_tin_start_date1 , DAY) AS diff, P.Lpar_tin_start_date , P.Lpar_tin_end_date, *
FROM public_dim_people P
WHERE DATE_DIFF (P.Lpar_tin_end_date1, P.Lpar_tin_start_date1 , DAY)  = 1



-- SELECT count(*) , P.Lpar_hop_end_date 
-- FROM public_dim_people

--  SELECT count(*), P.Lpar_hop_end_date--, P.Lpar_hop_hper_code
--  FROM public_dim_people P
-- --  WHERE Lpar_hop_end_date like '%9999'
--  GROUP BY P.Lpar_hop_end_date --, P.Lpar_hop_hper_code
--  ORDER by 1 DESC


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


-- SELECT  
--  FORMAT_DATE('%d-%d-%Y',DATE '31-12-2000'),
--  CURRENT_DATE()
-- ;

-- SELECT CASE 
--         WHEN 
--             CURRENT_DATE() < CAST('9999-12-31' AS DATE) 
--         THEN CURRENT_DATE() END as test
        
-- SELECT FORMAT_DATE('%b-%d-%Y', DATE '2008-12-25') AS formatted;

-- SELECT * FROM gc-r-prj-originmig.Origin_Migration_omar.language_code_mapping

-- SELECT count(*) ,Lpar_per_frv_fnl_code
-- FROM public_dim_people
-- GROUP BY Lpar_per_frv_fnl_code

-- Before update the seed lanuage_code_mapping.csv
-- count	Lpar_per_frv_fnl_code
-- 22287	null
-- 28245	ENGLISH
-- 717	NEWCODE ##
-- 205	SOMALI
-- 55	GREEK
-- 134	ARABIC
-- 55	AMHARIC
-- 238	BENGALI
-- 683	UNMAPPED ##
-- 141	FRENCH
-- 162	TURKISH
-- 77	ITALIAN
-- 106	PORTUGESE
-- 66	HINDI
-- 51	POLISH
-- 82	FILIPINO
-- 23	CANTONESE
-- 99	SPANISH
-- 16	PUNJABI
-- 12	BOSNIAN
-- 14	GERMAN
-- 28	RUSSIAN
-- 65	KURDISH
-- 53	URDU
-- 10	THAI
-- 40	FARSI
-- 14	DARI
-- 9	MANDARIN
-- 7	SERBOCROAT
-- 13	BSL


-- f0_	Lpar_per_frv_fnl_code
-- 28236	ENGLISH
-- 22287	null
-- 648	OTHER
-- 710	NOTSTATED
-- 99	SPANISH
-- 205	SOMALI
-- 238	BENGALI
-- 77	ITALIAN
-- 40	FARSI
-- 106	PORTUGESE
-- 162	TURKISH
-- 82	FILIPINO
-- 66	HINDI
-- 55	GREEK
-- 13	BSL
-- 51	POLISH
-- 14	GERMAN
-- 141	FRENCH
-- 55	AMHARIC
-- 135	ARABIC
-- 65	KURDISH
-- 16	PUNJABI
-- 10	THAI
-- 28	RUSSIAN
-- 14	DARI
-- 53	URDU
-- 24	CANTONESE
-- 35	OTHCHINESE
-- 2	HEBREW
-- 7	SERBOCROAT
-- 12	BOSNIAN
-- 9	MANDARIN
-- 5	JAPANESE

-- SELECT count(*) ,Lpar_hop_start_date
-- FROM public_dim_people
-- GROUP BY Lpar_hop_start_date
-- ORDER BY 1 DESC

-- SELECT count(*), Lpar_per_title
-- FROM public_dim_people
-- GROUP BY Lpar_per_title
-- WHERE LENGTH(Lpar_per_title) > 8 

