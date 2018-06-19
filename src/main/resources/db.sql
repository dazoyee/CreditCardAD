SELECT
	ccs1.service_id, 
	ccs1.creditcard_id  AS creditcard1, 
	ccs2.creditcard_id  AS creditcard2 
FROM 
	creditcard_service AS ccs1 
	JOIN 
		creditcard_service AS ccs2 
		ON ccs1.service_id  = ccs2.service_id 
WHERE 
	ccs1.creditcard_id <>  ccs2.creditcard_id;


SELECT
	ccs1.creditcard_id  AS creditcard1, 
	ccs2.creditcard_id  AS creditcard2,
	COUNT(1) AS cnt 
FROM 
	creditcard_service AS ccs1 
	JOIN 
		creditcard_service AS ccs2 
		ON ccs1.service_id  = ccs2.service_id 
WHERE 
	ccs1.creditcard_id <>  ccs2.creditcard_id
GROUP BY
	ccs1.creditcard_id, ccs2.creditcard_id;


SELECT
	creditcard_id,
	SUM(score) AS sum,
	SQRT(SUM(score)) AS norm
FROM
	creditcard_service
GROUP BY creditcard_id;


SELECT
	service_id,
	creditcard_id,
	SQRT(SUM(score)) AS norm,
	score / SQRT(SUM(score)) AS nscore
FROM
	creditcard_service
GROUP BY creditcard_id, service_id;


WITH
	norm_creditcard_service AS (
		SELECT service_id, creditcard_id
--			score / SQRT(SUM(score) OVER(PARTITION BY creditcard_service.creditcard_id)) AS nscore
		FROM creditcard_service
	)
SELECT
	cs1.creditcard_id AS target,
	cs2.creditcard_id AS recommend
--	SUM(cs1.nscore * cs2.nscore) AS score
FROM
	norm_creditcard_service AS cs1
	JOIN
		norm_creditcard_service AS cs2
		ON cs1.service_id = cs2.service_id
	GROUP BY
		cs1.creditcard_id, cs2.creditcard_id; 

SELECT
	cs1.creditcard_id AS target,
	cs2.creditcard_id AS recommend
--	SUM(cs1.nscore * cs2.nscore) AS score
FROM
	creditcard_service AS cs1
	JOIN
		creditcard_service AS cs2
		ON cs1.service_id = cs2.service_id
	WHERE
		cs1.creditcard_id <> cs2.creditcard_id
	GROUP BY
		cs1.creditcard_id, cs2.creditcard_id; 

SELECT * FROM creditcard_service
UNION ALL
SELECT * FROM creditcard_service_user;



SELECT 
	creditcard_id, name, score 
FROM 
	creditcard_service_result 
	JOIN 
		creditcard 
		ON creditcard_service_result.creditcard_id = creditcard.id 
	ORDER BY score DESC;

