-- Count by borough and NTA with totals for each borough and a grand total
WITH all_data AS (
SELECT 
Borough, 
NTAName, 
COUNT(*) as rack_count,
0 as sort_order,
Borough as sort_borough
FROM bicycle_parking
GROUP BY Borough, NTAName

UNION ALL

SELECT 
Borough, 
'TOTAL FOR BOROUGH' as NTAName, 
COUNT(*) as rack_count,
1 as sort_order,
Borough as sort_borough
FROM bicycle_parking
GROUP BY Borough

UNION ALL

SELECT 
'GRAND TOTAL' as Borough, 
'ALL' as NTAName, 
COUNT(*) as rack_count,
2 as sort_order,
'ZZZZZ' as sort_borough
FROM bicycle_parking
)

SELECT Borough, NTAName, rack_count
FROM all_data
ORDER BY sort_borough, sort_order, NTAName;