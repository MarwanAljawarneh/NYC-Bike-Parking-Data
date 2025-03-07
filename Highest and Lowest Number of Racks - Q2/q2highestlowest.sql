-- NTA with highest number of racks
SELECT NTAName, COUNT(*) as rack_count
FROM bicycle_parking
GROUP BY NTAName
ORDER BY rack_count DESC
LIMIT 1;

-- NTA with lowest number of racks
SELECT NTAName, COUNT(*) as rack_count
FROM bicycle_parking
GROUP BY NTAName
ORDER BY rack_count ASC
LIMIT 1