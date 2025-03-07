-- Analyze bike rack distribution relative to population by borough
SELECT 
bicycle_parking.Borough,
COUNT(*) as rack_count,
AVG(Latitude) as avg_latitude, 
AVG(Longitude) as avg_longitude,
COUNT(*) / COUNT(DISTINCT BoroCD) as racks_per_community_district
FROM bicycle_parking
WHERE Borough IS NOT NULL
GROUP BY Borough
ORDER BY racks_per_community_district DESC

