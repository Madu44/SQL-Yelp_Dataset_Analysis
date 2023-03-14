/* Done By: Madu Chibuike
Date: 22nd Feb. 2023


Data Scientist Role Play: Profiling and Analyzing the Yelp Dataset Coursera Worksheet

This is a 2-part assignment. In the first part, you are asked a series of questions that will help you profile and understand the data just like a data scientist would. For this first part of the assignment, you will be assessed both on the correctness of your findings, as well as the code you used to arrive at your answer. You will be graded on how easy your code is to read, so remember to use proper formatting and comments where necessary.

In the second part of the assignment, you are asked to come up with your own inferences and analysis of the data for a particular research question you want to answer. You will be required to prepare the dataset for the analysis you choose to do. As with the first part, you will be graded, in part, on how easy your code is to read, so use proper formatting and comments to illustrate and communicate your intent as required.

For both parts of this assignment, use this "worksheet." It provides all the questions you are being asked, and your job will be to transfer your answers and SQL coding where indicated into this worksheet so that your peers can review your work. You should be able to use any Text Editor (Windows Notepad, Apple TextEdit, Notepad ++, Sublime Text, etc.) to copy and paste your answers. If you are going to use Word or some other page layout application, just be careful to make sure your answers and code are lined appropriately.
In this case, you may want to save as a PDF to ensure your formatting remains intact for you reviewer. */



-- Part 1: Yelp Dataset Profiling and Understanding

1. Profile the data by finding the total number of records for each of the tables below:

SELECT COUNT(*)
FROM table
	
	


/*2. Find the total distinct records by either the foreign key or primary key for each table. If two foreign keys are listed in the table, please specify which --foreign key.*/

SELECT COUNT(DISTINCT(key))
FROM table



--Note: Primary Keys are denoted in the ER-Diagram with a yellow key icon.	



--3. Are there any columns with null values in the Users table? Indicate "yes," or "no."

	Answer: No
	
	
-- SQL code used to arrive at answer:
	SELECT COUNT(*)
		FROM user
		WHERE id IS NULL OR 
		  name IS NULL OR
		  yelping_since IS NULL OR 
		  review_count IS NULL OR 
		  useful IS NULL OR 
		  funny IS NULL OR 
		  cool IS NULL OR 
		  fans IS NULL OR 
		  average_stars IS NULL OR 
		  compliment_hot IS NULL OR 
		  compliment_more IS NULL OR 
		  compliment_profile IS NULL OR 
		  compliment_cute IS NULL OR 
		  compliment_list IS NULL OR 
		  compliment_funny IS NULL OR 
		  compliment_writer IS NULL OR 
		  compliment_note IS NULL OR 
		  compliment_plain IS NULL OR 
		  compliment_cool IS NULL OR 
		  compliment_photos IS NULL 
	
	

	
-- 4. For each table and column listed below, display the smallest (minimum), largest (maximum), and average (mean) value for the following fields:

	SELECT AVG(column)
		FROM table


	


-- 5. List the cities with the most reviews in descending order:

	-- SQL code used to arrive at answer: 
		SELECT city,
		SUM(review_count) AS reviews
		FROM business
		GROUP BY city
		ORDER BY reviews DESC
	
	
	

	
-- 6. Find the distribution of star ratings to the business in the following cities:

-- i. Avon

-- SQL code used to arrive at answer:
			SELECT stars,
				   SUM(review_count) AS count
			FROM business
			WHERE city == 'Avon'
			GROUP BY stars	



-- ii. Beachwood

-- SQL code used to arrive at answer:
			SELECT stars,
				SUM(review_count) AS count
			FROM business
			WHERE city == 'Beachwood'
			GROUP BY stars


		


-- 7. Find the top 3 users based on their total number of reviews:
		
-- SQL code used to arrive at answer:
		
		SELECT id,
			name, 
			review_count
		FROM user
		ORDER BY review_count DESC
		LIMIT 3	
	

		


-- 8. Does posing more reviews correlate with more fans?

-- Please explain your findings and interpretation of the results:

-- Yes, but also the amount of time that they have been involved in yelping. The longer the yelp, the more reviews they give has a higher fan count.
		SELECT id,
			   name,
			   review_count,
			   fans,
			   yelping_since
		FROM user
		ORDER BY fans DESC
	

	
-- 9. Are there more reviews with the word "love" or with the word "hate" in them?

-- Answer: Yes, love has 1780, while hate only has 232 which means there are more reviews with the word love.

	
	--SQL code used to arrive at answer:
		SELECT COUNT(*)									
		FROM review									
		WHERE text LIKE "%love%"	

		
		SELECT COUNT(*)
		FROM review		
		WHERE text LIKE "%hate%"

	
	
-- 10. Find the top 10 users with the most fans:

	-- SQL code used to arrive at answer:
		SELECT id,
			   name,
			   fans
		FROM user
		ORDER BY fans DESC
		LIMIT 10
-- Note: In SQL Server, you can use SELECT TOP 10 instead of using LIMIT 10
	
	
	
	
		

-- Part 2: Inferences and Analysis

/*1. Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. Include your code.
	
i. Do the two groups you chose to analyze have a different distribution of hours?
Answer: There are actually different distribution of hours. The the 2-3 star group has more hours than the 4-5 star group. This query returned only three businesses may not be significan.


ii. Do the two groups you chose to analyze have a different number of reviews?
Answer: Either yes or no, because one of the 4-5 star group has a lot more reviews but then the other 4-5 star group has close to the same number of reviews as the 2-3 star group
         
iii. Are you able to infer anything from the location data provided between these two groups? Explain.
Answer: No, I am not able to infer anything from the location data because every business is in a different zip-code. */


-- SQL code used for analysis:
		SELECT B.name,
			   B.review_count,
			   H.hours,
			   postal_code,
			   CASE
				  WHEN hours LIKE "%monday%" THEN 1
				  WHEN hours LIKE "%tuesday%" THEN 2
				  WHEN hours LIKE "%wednesday%" THEN 3
				  WHEN hours LIKE "%thursday%" THEN 4
				  WHEN hours LIKE "%friday%" THEN 5
				  WHEN hours LIKE "%saturday%" THEN 6
				  WHEN hours LIKE "%sunday%" THEN 7
			   END AS NumRange,
			   CASE
				  WHEN B.stars BETWEEN 2 AND 3 THEN '2-3 stars'
				  WHEN B.stars BETWEEN 4 AND 5 THEN '4-5 stars'
			   END AS star_rating
		FROM business B 
		INNER JOIN hours H
		ON B.id = H.business_id
		INNER JOIN category C
		ON C.business_id = B.id
		WHERE (B.city == 'Las Vegas'
		AND
		C.category LIKE 'shopping')
		AND
		(B.stars BETWEEN 2 AND 3
		OR
		B.stars BETWEEN 4 AND 5)
		GROUP BY stars, NumRange
		ORDER BY NumRange, star_rating ASC


		
/* 2. Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones that are closed? List at least two differences and the SQL code you used to arrive at your answer.
		
i. Difference 1:
Answer: The open businesses have more reviews than the ones that are closed on average.
		
			Open:   AVG(review_count) is 31.757
			Closed: AVG(review_count0 is 23.198
         
         
ii. Difference 2:
Answer: The average star rating is higher for businesses that are open than businesses that are closed.
	
			Open:   AVG(stars) = 3.679
			Closed: AVG(stars) = 3.520 */
         
         
-- SQL code used for analysis:
		SELECT COUNT(DISTINCT(id)),
			   AVG(review_count),
			   SUM(review_count),
			   AVG(stars),
			   is_open
		FROM business
		GROUP BY is_open

	
	
/* 3. For this last part of your analysis, you are going to choose the type of analysis you want to conduct on the Yelp dataset and are going to prepare the data for analysis.

Ideas for analysis include: Parsing out keywords and business attributes for sentiment analysis, clustering businesses to find commonalities or anomalies between them, predicting the overall star rating for a business, predicting the number of fans a user will have, 
and so on. These are just a few examples to get you started, so feel free to be creative and come up with your own problem you want to solve. Provide answers, in-line, to all of the following:
	
i. Indicate the type of analysis you chose to do:
Answer: To predict whether a business will stay open or close.
         
         
ii. Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data:
Answer: To better help businesses understand the importance of different factors which will help their business stay open. Some data that may be important; number of reviews, star rating of business, hours open, and of course location location
	location. We will gather the latitude and longitude as well as city, state, postal_code, and address to make processing easier later on. Categories and attributes will be used to better distinguish between different types of 
	businesses. is_open`column will determine which business is open and which business have closed (not hours) but permanently. */
                           
          
         
-- iv. Provide the SQL code you used to create your final dataset:
		SELECT B.id,
			   B.name,
			   B.address,
			   B.city,
			   B.state,
			   B.postal_code,
			   B.latitude,
			   B.longitude,
			   B.review_count,
			   B.stars,
			   MAX(CASE
			   WHEN H.hours LIKE "%monday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS monday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%tuesday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS tuesday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%wednesday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS wednesday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%thursday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS thursday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%friday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS friday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%saturday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS saturday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%sunday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS sunday_hours,
			   GROUP_CONCAT(DISTINCT(C.category)) AS categories,
			   GROUP_CONCAT(DISTINCT(A.name)) AS attributes,
			   B.is_open
		FROM business B
		INNER JOIN hours H
		ON B.id = H.business_id
		INNER JOIN category C
		ON B.id = C.business_id
		INNER JOIN attribute A
		ON B.id = A.business_id
		GROUP BY B.id
