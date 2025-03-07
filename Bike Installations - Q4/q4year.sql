-- Extract year from Date_Inst and count installations by year
WITH year_data AS (
SELECT 
CASE 
WHEN EXTRACT(YEAR FROM Date_Inst) < 0 THEN 'Invalid Year'
ELSE EXTRACT(YEAR FROM Date_Inst)::text
END as installation_year,
COUNT(*) as racks_installed
FROM bicycle_parking
WHERE Date_Inst IS NOT NULL
GROUP BY 
CASE 
WHEN EXTRACT(YEAR FROM Date_Inst) < 0 THEN 'Invalid Year'
ELSE EXTRACT(YEAR FROM Date_Inst)::text
END
)
SELECT installation_year, racks_installed
FROM year_data
ORDER BY racks_installed DESC;