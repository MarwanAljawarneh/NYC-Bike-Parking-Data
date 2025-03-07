-- Analyze bike racks by flood risk category and borough
SELECT 
    Borough,
    CASE 
        WHEN FEMAFldz IN ('A', 'V') THEN 'High Risk'
        WHEN FEMAFldz = 'X' THEN 'Low Risk'
        ELSE 'Other'
    END AS flood_risk,
    COUNT(*) AS rack_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY Borough), 2) AS percentage_in_borough
FROM bicycle_parking
WHERE Borough IS NOT NULL AND FEMAFldz IS NOT NULL
GROUP BY Borough, flood_risk
ORDER BY Borough, flood_risk DESC;