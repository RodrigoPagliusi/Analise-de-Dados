SELECT * FROM cap09.tb_global_qualidade_ar;

# 1
SELECT ROUND(AVG(CAST(value AS DECIMAL(5,3))) OVER(ORDER BY CAST(timestamp AS DATE)),3) AS 'Média pm10', DATE_FORMAT(CAST(timestamp AS DATE),'%d-%b-%y') AS Data
FROM cap09.tb_global_qualidade_ar
WHERE pollutant = 'pm10';

# 2
SELECT pollutant AS Poluente, SUM(CAST(value AS DECIMAL(5,3))) AS 'Poluição Total'
FROM cap09.tb_global_qualidade_ar
GROUP BY pollutant
ORDER BY 'Poluição Total' DESC;

# 3
# Ajeitar no Excel depois
SELECT 
	COALESCE(country,'Total dos paises') AS País,
	COALESCE(pollutant,'Total') AS Poluente,
	SUM(CAST(value AS DECIMAL(5,3))) AS Poluição
FROM cap09.tb_global_qualidade_ar
GROUP BY country, pollutant WITH ROLLUP;

# 4
SELECT country AS País, SUM(CAST(value AS DECIMAL(5,3))) AS Poluição_o3
FROM cap09.tb_global_qualidade_ar
WHERE pollutant = 'o3'
GROUP BY country
HAVING Poluição_o3 > 0
ORDER BY Poluição_o3 DESC;

# 5
SELECT location AS Localidade, SUM(CAST(value AS DECIMAL(5,3))) AS Poluição_pm25
FROM cap09.tb_global_qualidade_ar
WHERE pollutant = 'pm25'
GROUP BY location
HAVING Poluição_pm25 <= 5
ORDER BY Poluição_pm25 DESC;