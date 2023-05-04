/*
Profile and Analyze Yelp Dataset 
*/

--- null values in the Users table

SELECT *
FROM user
WHERE id IS NULL
   OR name IS NULL
   OR review_count IS NULL
   OR yelping_since IS NULL
   OR useful IS NULL
   OR funny IS NULL
   OR cool IS NULL
   OR fans IS NULL
   OR average_stars IS NULL
   OR compliment_hot IS NULL
   OR compliment_more IS NULL
   OR compliment_profile IS NULL
   OR compliment_cute IS NULL
   OR compliment_list IS NULL
   OR compliment_note IS NULL
   OR compliment_plain IS NULL
   OR compliment_cool IS NULL
   OR compliment_funny IS NULL
   OR compliment_writer IS NULL
   OR compliment_photos IS NULL;

-- List the cities with the most reviews in descending order

SELECT city, sum(review_count) as sum_reviews
FROM business
GROUP BY city
ORDER BY sum_reviews DESC

-- Distribution of star ratings to the business in the city Avon

SELECT stars, count(stars)
FROM business 
WHERE city = 'Avon'
GROUP BY  stars;

---- Distribution of star ratings to the business in the city Beachwood

SELECT stars, count(stars)
FROM business 
WHERE city = 'Beachwood'
GROUP BY  stars;

-- Find the top 3 users base on their total number of reviews

SELECT DISTINCT id, name, review_count
FROM user
GROUP BY id
ORDER BY review_count DESC;

-- Find reviews with the word "love" or "hate" in them

SELECT count(*) as love_count
FROM review
WHERE text like '%love%';

SELECT count(*) as love_count
FROM review
WHERE text like '%hate%';

--Find the top 10 users wht the most fans

SELECT name, fans
FROM user
ORDER BY fans DESC;

--Review a city and group the businesses in that city or category by their overall star rating. 
--Compare the businesses with 2-3 stars to the businesses with 4-5 stars 

SELECT city, stars, name, active_table.hours, review_count
FROM (SELECT hours
	FROM hours join category
	on hours.business_id = category.business_id
	WHERE category = 'Active Life') active_table, business
WHERE city like 'char%' and stars between 2 and 5
GROUP BY stars; 

-- Group businesses based on the ones that are open vs closed
-- 0 represents open businesses and 1 represents closed businesses

SELECT DISTINCT	city, business.is_open, avg(user.fans), avg(funny), avg(useful)
FROM business LEFT JOIN user
on business.id = user.id
WHERE business.is_open = '0'
GROUP BY city, fans, cool
ORDER BY fans DESC;

SELECT DISTINCT	city, business.is_open, avg(user.fans), avg(funny), avg(useful)
FROM business LEFT JOIN user
on business.id = user.id
WHERE business.is_open = '1'
GROUP BY city, fans, cool
ORDER BY fans DESC;

