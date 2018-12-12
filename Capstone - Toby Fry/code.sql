-- The Survey Funnel
-- Question 1: Determining the columns

 SELECT *
 FROM survey
 LIMIT 10;



 -- Question 2 - Finding the funnel

 SELECT question, COUNT(*)
 FROM survey
 GROUP BY question;



 -- Question 2a - Improving readability

 SELECT 
 	question AS 'Question',
 	COUNT(*) AS 'Responses'
 FROM survey
 GROUP BY question;


-- The Home Try-On Funnel
-- Question 4 - Column Names

SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;





-- Question 5 - Combining the tables

SELECT DISTINCT quiz.user_id, 

CASE
    WHEN home_try_on.user_id IS NOT NULL THEN 'True'

    ELSE 'False'
    END AS 'is_home_try_on', 
    
home_try_on.number_of_pairs, 
  
CASE
	WHEN purchase.user_id IS NOT NULL THEN 'True'
	ELSE 'False' 
	END AS 'is_purchase' 

FROM quiz

LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id

LEFT JOIN purchase
	ON quiz.user_id = purchase.user_id

LIMIT 10;




-- Question 6 - Home Try-On Analysis

-- Count users at each step

WITH 'funnel' AS(

--Boilerplate Query

SELECT DISTINCT quiz.user_id, 
	
	CASE
		WHEN home_try_on.user_id IS NOT NULL THEN 'True'
		END AS 'is_home_try_on',
    
	home_try_on.number_of_pairs, 
  
	CASE
		WHEN purchase.user_id IS NOT NULL THEN 'True'
		END AS 'is_purchase' 

FROM quiz

LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id

LEFT JOIN purchase
	ON quiz.user_id = purchase.user_id)

--Boilerplate End

SELECT COUNT (*) as 'Took Quiz', 
COUNT(is_home_try_on) AS 'Tried On', 
COUNT(is_purchase) AS 'Purchased'
from funnel;





-- Three pairs or five?

WITH 'funnel' AS(

--Boilerplate Query

SELECT DISTINCT quiz.user_id, 
	
	CASE
		WHEN home_try_on.user_id IS NOT NULL THEN 'True'
		END AS 'is_home_try_on',
    
	home_try_on.number_of_pairs AS 'Pairs', 
  
	CASE
		WHEN purchase.user_id IS NOT NULL THEN 'True'
		END AS 'is_purchase' 

FROM quiz

LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id

LEFT JOIN purchase
	ON quiz.user_id = purchase.user_id)

--Boilerplate End

SELECT pairs,
COUNT (*) as 'Took Quiz', 
COUNT(is_home_try_on) AS 'Tried On', 
COUNT(is_purchase) AS 'Purchased'
from funnel
GROUP BY pairs;




-- Question 7 - Additional Insights


-- How many answers to each quiz question?

SELECT quiz.style AS 'Style', COUNT(*)
FROM quiz
GROUP BY 1
ORDER BY 2 desc;

SELECT quiz.fit AS 'Fit', COUNT(*)
FROM quiz
GROUP BY 1
ORDER BY 2 desc;

SELECT quiz.shape AS 'Shape', COUNT(*)
FROM quiz
GROUP BY 1
ORDER BY 2 desc;

SELECT quiz.color AS 'Colour', COUNT(*)
FROM quiz
GROUP BY 1
ORDER BY 2 desc;




-- What did they buy?

