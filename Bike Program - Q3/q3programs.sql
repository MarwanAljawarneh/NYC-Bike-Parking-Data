-- Count of racks per program with a row showing total number of programs
WITH program_counts AS (
SELECT 
Program, 
COUNT(*) as rack_count,
1 as sort_order
FROM bicycle_parking
GROUP BY Program
),
program_total AS (
SELECT 
'TOTAL PROGRAMS' as Program,
COUNT(*) as rack_count,
2 as sort_order
FROM (
SELECT DISTINCT Program 
FROM bicycle_parking
) distinct_programs
)
SELECT Program, rack_count
FROM (
SELECT * FROM program_counts
UNION ALL
SELECT * FROM program_total
) combined
ORDER BY sort_order, rack_count DESC;