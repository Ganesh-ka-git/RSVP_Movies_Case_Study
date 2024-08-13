USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/

-- Segment 1:

-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

-- Calculating number of rows in director_mapping table 
SELECT COUNT(*) AS NumberofRows_director_mapping
FROM   director_mapping;
-- Calculating number of rows in genre table 
SELECT COUNT(*) AS NumberofRows_genre
FROM   genre;
-- Calculating number of rows in movie table 
SELECT COUNT(*) AS NumberofRows_movies
FROM   movie;
-- Calculating number of rows in names table 
SELECT COUNT(*) AS NumberofRows_names
FROM   names;
-- Calculating number of rows in ratings table 
SELECT COUNT(*) AS NumberofRows_ratings
FROM   ratings;
-- Calculating number of rows in role_mapping table 
SELECT COUNT(*) AS NumberofRows_role_mapping
FROM   role_mapping; 


-- Q2. Which columns in the movie table have null values?
-- Type your code below:

-- Approach-1: Using COUNT(*)-COUNT(col_Name). Where COUNT(COL_Name) gives the number of non-null values in the col_Name
SELECT 
    COUNT(*) - COUNT(id) AS Id_null_count,         									-- Finding non null values in Id column
    COUNT(*) - COUNT(title) AS title_null_count,									-- Finding non null values in title column
    COUNT(*) - COUNT(year) AS year_null_count,										-- Finding non null values in year column
    COUNT(*) - COUNT(date_published) AS date_published_null_count,					-- Finding non null values in date_published column
    COUNT(*) - COUNT(duration) AS duration_null_count,								-- Finding non null values in duration column
    COUNT(*) - COUNT(country) AS country_null_count,								-- Finding non null values in country column
    COUNT(*) - COUNT(worlwide_gross_income) AS worlwide_gross_income_null_count, 	-- Finding non null values in worlwide_gross_income column
    COUNT(*) - COUNT(languages) AS languages_null_count,							-- Finding non null values in languages column
    COUNT(*) - COUNT(production_company) AS production_company_null_count			-- Finding non null values in production_company column
FROM
    movie;


-- Approach-2: Finding non-null values from each column using CASE statements
SELECT 	-- Finding non null values in Id column
		SUM(CASE
             WHEN id IS NULL THEN 1
             ELSE 0
           END) AS Id_null_count,
		-- Finding non null values in title column
       SUM(CASE
             WHEN title IS NULL THEN 1
             ELSE 0
           END) AS title_null_count,
		-- Finding non null values in year column
       SUM(CASE
             WHEN year IS NULL THEN 1
             ELSE 0
           END) AS year_null_count,
		-- Finding non null values in date_published column
       SUM(CASE
             WHEN date_published IS NULL THEN 1
             ELSE 0
           END) AS date_published_null_count,
		-- Finding non null values in duration column
       SUM(CASE
             WHEN duration IS NULL THEN 1
             ELSE 0
           END) AS duration_null_count,
		-- Finding non null values in country column
       SUM(CASE
             WHEN country IS NULL THEN 1
             ELSE 0
           END) AS country_null_count,
		-- Finding non null values in worlwide_gross_income column
       SUM(CASE
             WHEN worlwide_gross_income IS NULL THEN 1
             ELSE 0
           END) AS worlwide_gross_income_null_count,
		-- Finding non null values in languages column
       SUM(CASE
             WHEN languages IS NULL THEN 1
             ELSE 0
           END) AS languages_null_count,
		-- Finding non null values in production_company column
       SUM(CASE
             WHEN production_company IS NULL THEN 1
             ELSE 0
           END) AS production_company_null_count
FROM   movie; 
/*
Analysis: 
There are no null values in Id, title, year,date_published,duration columns. 
3724 rows of worlwide_gross_income are null values
*/ 		

-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+

Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Total number of movies released in each year where data taken from movie table
SELECT year         AS Year,
       COUNT(id) AS number_of_movies
FROM   movie
GROUP  BY year			-- Counting number of movies grouping by year
ORDER  BY year; 
-- Analysis: Most number of movies produced in 2017 i.e. 3052. The number of movies produced decreased from year on year from 2017 to 2019 

-- Total number of movies released month wise where details taken from the movie table
SELECT month(date_published) AS month_num,			
       COUNT(id)          	 AS number_of_movies
FROM   movie
GROUP  BY Month(date_published)						-- Counting number of movies grouping by month of date_published
ORDER  BY Month(date_published); 
-- Analysis: Highest number of movies produced in March i.e. 824


/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

SELECT COUNT(id)
FROM   movie
WHERE  year=2019
		AND (country LIKE '%USA%' OR country LIKE '%India%');
-- Analysis: 1059 out of 2001 movies produced in USA or India in the year 2019 which constitutes 52.9% of movies produced in 2019.

/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

-- Genres list from genres table and used DISTINCT keyword to find different genres.
SELECT 
	DISTINCT genre			-- Using DISTINCT keyword for finding the unique values in the table
FROM
    genre
WHERE
    genre IS NOT NULL;


/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

SELECT genre,
       COUNT(id) AS movie_count
FROM   genre AS g
       INNER JOIN movie AS m
               ON g.movie_id = m.id
GROUP  BY genre
ORDER  BY COUNT(id) DESC
LIMIT 1; 
-- Analysis: 4285 movies produced in Drama genre.

/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

-- Collecting info about all movies with number of genres as CTE movie_counts
WITH movie_counts AS 
(
	SELECT 	 movie_id,
         COUNT(movie_id) AS cnt
	FROM   genre
    GROUP  BY movie_id
),
-- Collecting movie-id which belong to single genre as CTE count_1
count_1	AS				 
(
	SELECT movie_id
	FROM   movie_counts
	WHERE  cnt = 1
)
-- Counting number of movies that belongs to single genre which are obtained from CTE-count_1
SELECT COUNT(movie_id) AS "Number_Of_Single_Genre_Movies"
FROM   count_1; 

-- Analysis: There are 3289 of 7997 movies are single genre.

/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT genre,
       ROUND(AVG(duration),2) AS avg_duration	-- Avg duration of movies by genre wise
FROM   movie AS m
       INNER JOIN genre AS g
               ON m.id = g.movie_id
GROUP  BY genre
ORDER BY avg_duration DESC; 

/*
Analysis: 
The Action genre movies are having high average_duration of 112.88
Drama genre movies which are highest produced in 2019 has average duration of 106.77
*/


/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)

/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:


-- CTE for genre rankings based on movie count and by using RANK function
WITH genre_rankings AS 
(		
		SELECT  genre,
                COUNT(movie_id) AS movie_count,
                RANK() 
                  OVER (ORDER BY COUNT(movie_id) DESC) AS genre_rank
		FROM   movie AS m
                INNER JOIN genre AS g
                        ON m.id = g.movie_id
        GROUP  BY genre
)							-- Extracting the Thriller genre details from CTE 
SELECT genre,					 
       movie_count,
       genre_rank
FROM   genre_rankings
WHERE  genre = 'Thriller'; 
/*
Analysis: 
Thriller movies stood at rank 3 with movie count as 1484.
Where the Drama and Comedy genres are ranked in top 2 positions with 4285 and 2412 movie count respectively.
*/





/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

-- Analysing the ratings table

SELECT Min(avg_rating)    AS min_avg_rating,		-- Minimum average rating of rating table
       Max(avg_rating)    AS max_avg_rating,		-- Maximum average rating of rating table
       Min(total_votes)   AS min_total_votes,		-- Minimum total votes of rating table
       Max(total_votes)   AS max_total_votes,		-- Maximum total votes of rating table
       Min(median_rating) AS min_median_rating,		-- Minimum median_rating of rating table
       Max(median_rating) AS min_median_rating		-- Maximum median_rating of rating table
FROM   ratings;

/* Analysis:
Minimum and maximum values in avg_rating and median_rating columns are in the range of 1-10. 
This implies there are no outliers in the table. 
*/

-- Now, let’s find out the top 10 movies based on average rating.

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

-- Approach 1: Top 10 movies using RANK function
SELECT     title,
           avg_rating,
           RANK() over (ORDER BY avg_rating DESC) AS movie_rank
FROM       movie                                  AS m
INNER JOIN ratings                                AS r
ON         m.id=r.movie_id
LIMIT 10;


-- Approach 2: Top 10 rankings movies using ROW_NUMBER are as below.
WITH movie_avg_ratings AS
(
SELECT     title,
           avg_rating,
           ROW_NUMBER() OVER(ORDER BY avg_rating DESC) AS movie_rank
FROM       ratings                               AS r
INNER JOIN movie                                 AS m
ON         m.id = r.movie_id
)
SELECT * 
FROM movie_avg_ratings
WHERE movie_rank<=10;

/* Analysis:
As per rankings, there are 5 movies with Ranking 10 with avg_rating as 9.4.
Collected top 10 movies as per the table information using ROW_NUMBER in 2nd approach.
*/


/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

SELECT median_rating,						-- Median rating 
       COUNT(movie_id) AS movie_count		-- Movie count grouped by median rating
FROM   ratings
GROUP  BY median_rating
ORDER  BY median_rating;

/* Analysis:
As per median_rating, Movies with median rating 1 is lowest i.e.94 movies in number and Movies with a median rating of 7 is highest in number i.e.2257 movies.
50% of movies are having median_rating with 7 and above.
*/


/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:

-- CTE for calculating the production company rankings based on number of movies produced
WITH prod_comp_rankings AS
(
SELECT     production_company,
           COUNT(id)                             AS movie_count,
           RANK() 
				OVER (ORDER BY COUNT(id) DESC) 	 AS prod_company_rank
FROM       movie                                 AS m
INNER JOIN ratings                               AS r
ON         m.id=r.movie_id
WHERE      r.avg_rating>8
AND        production_company IS NOT NULL
GROUP BY   production_company
)  -- Extracting the company names who stood in Top position
SELECT *
FROM prod_comp_rankings
WHERE prod_company_rank=1;

/* Analysis:
Dream Warrior Pictures and National Theatre Live production companies stood at Ranking 1 with 3 movies where the movie ratings are greater than 8
*/


-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:


SELECT g.genre     AS genre,
       COUNT(m.id) AS movie_count
FROM   genre AS g
       LEFT JOIN movie AS m
              ON m.id = g.movie_id
       LEFT JOIN ratings AS r
              ON m.id = r.movie_id
WHERE  Month(date_published) = 3			-- Condition are movie released in March 2017 and votes>1000 and released in USA
       AND year = 2017
       AND total_votes > 1000
       AND country LIKE "%USA%"
GROUP  BY genre
ORDER  BY movie_count DESC; 

/* Analysis:
There are 24 Drama movies with highest number released in March 2017 which are having 1000 votes and above in USA
*/

-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

SELECT title,					-- Movie name
       avg_rating,				-- Avg_rating
       genre					-- genre is belongs
FROM   genre AS g
       LEFT JOIN movie AS m
              ON m.id = g.movie_id
       LEFT JOIN ratings AS r
              ON m.id = r.movie_id
WHERE  title LIKE "the%"		-- Movie name starts with The and with avg_rating > 8
       AND avg_rating > 8
ORDER BY genre DESC;


/* Analysis:
There are 8 movies where movie name starts with "THE" and avg_ratings > 8.
The Blue Elephant 2, The Irishman, The Gambinos, Theeran Adhigaaram Ondru, The King and I belong to multiple genres
*/

-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

SELECT median_rating,					-- Median ratings from 1 to 10
       COUNT(id) AS movie_count			-- Number of movies count
FROM   movie m
       INNER JOIN ratings r
               ON m.id = r.movie_id
WHERE  (date_published BETWEEN "2018-04-01" AND "2019-04-01")
       AND median_rating = 8; 
       
/* Analysis:
361 movies released between 1 April 2018 and 1 April 2019 with a median rating of 8
*/

-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

-- Approach 1: This will provide the result as Yes/No where the number of total german movie votes are comapred with total Italian movie votes
-- CTE for collecting the german movie votes for each movie
WITH german
     AS (SELECT SUM(total_votes) AS german_votes
         FROM   movie m
                inner join ratings r
                        ON m.id = r.movie_id
         WHERE  languages LIKE "%german%"
         GROUP  BY languages
),
-- CTE for collecting the italian movie votes for each movie
italian
     AS (SELECT SUM(total_votes) AS italian_votes
         FROM   movie m
                inner join ratings r
                        ON m.id = r.movie_id
         WHERE  languages LIKE "%italian%"
         GROUP  BY languages
)
SELECT IF((SELECT SUM(german_votes)
           FROM   german) > SUM(italian_votes), "Yes", "No") AS		-- Adding all the votes from german and italian movies and comapring them
       "Do German movies get more votes than Italian movies?"
FROM   italian; 

-- Approach 2: This will give the total votes obtained for german and italian movies.
-- CTE for collecting the german movie votes for each movie
WITH german	AS 
(
		SELECT languages,
                SUM(total_votes) AS german_votes
         FROM   movie m
                INNER JOIN ratings r
                        ON m.id = r.movie_id
         WHERE  languages LIKE "%german%"
         GROUP  BY languages
),
-- CTE for collecting the italian movie votes for each movie
italian  AS 
(		
		SELECT languages,
                SUM(total_votes) AS italian_votes
         FROM   movie m
                INNER JOIN ratings r
                        ON m.id = r.movie_id
         WHERE  languages LIKE "%italian%"
         GROUP  BY languages
)
SELECT 
		(SELECT SUM(german_votes) FROM german) AS German_movies_votes,
        SUM(italian_votes) AS Italian_movies_votes
FROM   italian; 

-- Analysis:  Answer is Yes


/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:
-- Approach 1:
SELECT COUNT(*) - COUNT(NAME)             AS name_nulls,			-- Non nulls for name column
       COUNT(*) - COUNT(height)           AS height_nulls,			-- Non nulls for height column
       COUNT(*) - COUNT(date_of_birth)    AS date_of_birth_nulls,	-- Non nulls for date_of_birth column
       COUNT(*) - COUNT(known_for_movies) AS known_for_movies_nulls	-- Non nulls for known_for_movies column
FROM   names; 

-- Approach 2:
SELECT SUM(CASE
             WHEN NAME IS NULL THEN 1
             ELSE 0
           END) AS name_nulls,				-- Non nulls for name column
       SUM(CASE
             WHEN height IS NULL THEN 1
             ELSE 0
           END) AS height_nulls,			-- Non nulls for height column
       SUM(CASE
             WHEN date_of_birth IS NULL THEN 1
             ELSE 0
           END) AS date_of_birth_nulls,		-- Non nulls for date_of_birth column
       SUM(CASE
             WHEN known_for_movies IS NULL THEN 1
             ELSE 0
           END) AS known_for_movies_nulls	-- Non nulls for known_for_movies column
FROM   names; 
-- Analysis: No null values in name column. Height column has more null values

/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
WITH top3_genres AS				-- identifying top 3 genres based on movie count whose movie rating is more than 8
(
           SELECT     COUNT(m.id) AS count_rating_above_8,
                      g.genre     AS genre
           FROM       genre g
           INNER JOIN movie m
           ON         g.movie_id = m.id
           INNER JOIN ratings r
           ON         m.id = r.movie_id
           WHERE      r.avg_rating > 8
           GROUP BY   genre
           ORDER BY   count_rating_above_8 DESC limit 3 
), 
movies AS						-- identifying top 3 directors from top 3 genres based on movie count and movie rating is more than 8
(
           SELECT     n.NAME                                       AS director_name,
                      COUNT(m.id)                                  AS movie_count,
                      ROW_NUMBER() OVER(ORDER BY COUNT(m.id) DESC) AS movie_rank
           FROM       names n
           INNER JOIN director_mapping d
           ON         n.id = d.name_id
           INNER JOIN movie m
           ON         d.movie_id = m.id
           INNER JOIN genre g
           ON         m.id = g.movie_id
           INNER JOIN ratings r
           ON         m.id = r.movie_id
           WHERE      genre IN ( SELECT  genre 	FROM   top3_genres) 
						AND 	avg_rating > 8
           GROUP BY   NAME 
)
SELECT director_name,			-- Director name and number of movies directed
       movie_count
FROM   movies
WHERE  movie_rank <= 3;

/* Analysis:
James Mangold, Anthony Russo and Joe Russo are identified as top 3 directors 
*/

/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT n.name                 	AS actor_name,		-- Actor name 
       COUNT(r.movie_id) 		AS movie_count		-- number of movies acted
FROM   role_mapping ro
       INNER JOIN names n
               ON ro.name_id = n.id
       INNER JOIN ratings r
               ON ro.movie_id = r.movie_id
WHERE  r.median_rating >= 8						--  median rating is atleast 8
       AND category LIKE "actor"
GROUP  BY actor_name
ORDER  BY movie_count DESC
LIMIT  2; 

/* Analysis:
Mammootty and Mohanlal are top 2 actors whose movies have median rating is atleast 8
*/


/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

-- Approach 1: Using select statement and limit condition
SELECT     production_company,
           SUM(total_votes)                             AS vote_count,		-- Adding number of votes
           Rank() OVER (ORDER BY SUM(total_votes) DESC) AS prod_comp_rank	-- Ranking based on number of votes 
FROM       movie                                        AS m
INNER JOIN ratings                                      AS r
ON         m.id=r.movie_id
GROUP BY   production_company 		-- Grouping by production_company which produced movies
LIMIT 3;							-- Top 3 production_companies			

-- Approach 2: Using CTE
WITH prod_comp_rankings			-- Collecting complete info about the production company and the total votes received for their movies
     AS (SELECT production_company,
                Sum(total_votes) AS vote_count,
                RANK() OVER( ORDER BY Sum(total_votes) DESC) AS prod_comp_rank	-- Ranking the production company based on votes
		FROM   movie AS m
                INNER JOIN ratings AS r
                        ON r.movie_id = m.id
         GROUP  BY production_company
)
SELECT *
FROM   prod_comp_rankings
WHERE  prod_comp_rank < 4; 			-- Top 3 production_companies	

/* Analysis:
Marvel Studios, Twentieth Century Fox, Warner Bros stood in top 3 positions in production_company rankings which are based on total_vote_count.
All three are international production companies.
*/

/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
WITH actors_info AS			-- Collecting the actor info along with weighted avg of movies acted
(
SELECT NAME AS actor_name,
       SUM(total_votes) AS total_votes,
       COUNT(rm.movie_id) AS movie_count,
       ROUND(SUM(r.avg_rating * r.total_votes) / SUM(r.total_votes), 2) AS actor_avg_rating,
       Rank() 
         OVER (ORDER BY ROUND(SUM(r.avg_rating * r.total_votes) / SUM(r.total_votes), 2) DESC) AS actor_rank
FROM   names AS n
       INNER JOIN role_mapping AS rm
               ON n.id = rm.name_id
       INNER JOIN movie AS m
               ON m.id = rm.movie_id
       INNER JOIN ratings AS r
               ON m.id = r.movie_id
WHERE  category LIKE "actor"					-- Actor who is Indian and acted in atleast 5 movies
       AND country LIKE "%india%"
GROUP  BY n.NAME
HAVING COUNT(rm.movie_id) >= 5
)
SELECT *
FROM actors_info
WHERE actor_rank=1; 		-- Top most actor details

/* Analysis:
RSVP which is based from Mumbai based company can consider Indian actors who are very good based on avg_ratings and acted atleast 5 movies.
Vijay Sethupathi tops the list of actors.
Vijay Sethupathi, Fahadh Faasil, Yogi Babu stood in top 3 positions
*/


-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:


SELECT NAME  AS actress_name,		-- Collecting the actress info along with weighted avg of movies acted
       Sum(total_votes) AS total_votes,
       Count(rm.movie_id) AS movie_count,
       Round(Sum(r.avg_rating * r.total_votes) / Sum(r.total_votes), 2) AS actress_avg_rating,
       Rank() 
         OVER(ORDER BY Round(Sum(r.avg_rating * r.total_votes) /Sum(r.total_votes), 2) DESC) AS actress_rank
FROM   names AS n
       INNER JOIN role_mapping AS rm
               ON n.id = rm.name_id
       INNER JOIN movie AS m
               ON m.id = rm.movie_id
       INNER JOIN ratings AS r
               ON m.id = r.movie_id
WHERE  category = "actress"						-- Actress who is Indian and acted in atleast 3 movies
       AND country LIKE "india"
       AND languages LIKE "%hindi%"
GROUP  BY NAME
HAVING Count(rm.movie_id) >= 3
ORDER  BY actress_rank
LIMIT 5; 			-- Top 5 actress details


/* Analysis:
RSVP which is based from Mumbai based company can consider Indian actress who are top based on avg_ratings and acted atleast 3 movies.
Taapsee Pannu tops with average rating 7.74
*/




/*
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

SELECT DISTINCT title AS Thriller_movie,		-- Distinct Movie titles
		CASE									-- Thriller movies result based on avg_rating and declaring its results
			when avg_rating > 8 THEN "Superhit movies"
            WHEN avg_rating between 7 and 8 THEN "Hit movies"
            WHEN avg_rating between 5 and 7 THEN "One-time watch movies"
            ELSE "Flop movies"
		END AS Film_Result
FROM genre AS g
	INNER JOIN movie AS m
		ON m.id=g.movie_id
	INNER JOIN ratings AS r
		ON m.id=r.movie_id
WHERE genre LIKE "Thriller"				
ORDER BY title;				

-- SEPERATE ANALYSIS FOR THE ABOVE QUERY:  counting thriller movies by hit or flop
/*WITH thriller_categories AS
(
SELECT DISTINCT title AS Thriller_movie,		-- Distinct Movie titles
		CASE									-- Thriller movies result based on avg_rating and declaring its results
			when avg_rating>8 THEN "Superhit movies"
            WHEN avg_rating between 7 and 8 THEN "Hit movies"
            WHEN avg_rating between 5 and 7 THEN "One-time watch movies"
            ELSE "Flop movies"
		END AS Film_Result
FROM genre AS g
	INNER JOIN movie AS m
		ON m.id=g.movie_id
	INNER JOIN ratings AS r
		ON m.id=r.movie_id
WHERE genre LIKE "Thriller"				
ORDER BY title
)
SELECT Film_Result, COUNT(Thriller_movie) FROM thriller_categories
GROUP BY Film_Result;
*/

/*86% OF Thriller movies were either flop or one time watch movies, 
Hence, rsvp can consider less budget for these types of movies*/


/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:


SELECT genre,
		ROUND(AVG(duration),2) AS avg_duration,							-- Avg duration of movies grouped by genre
        SUM(ROUND(AVG(duration),2)) OVER w AS running_total_duration,	-- Sum of Avg duration which is running total of movies grouped by genre
        AVG(ROUND(AVG(duration),2)) OVER w AS moving_average_duration	-- Avg of Avg duration which is moving avg of movies grouped by genre
FROM movie m
	INNER JOIN genre g
		ON m.id = g.movie_id
GROUP BY genre
WINDOW w AS (ORDER BY genre ROWS UNBOUNDED PRECEDING);		-- Window function with all rows preceeding and the current row for calculating the moving averages


-- SEPERATE ANALYSIS RELATED TO ABOVE QUERY
/*
SELECT genre,
		ROUND(AVG(duration),2) AS avg_duration,							-- Avg duration of movies grouped by genre
        AVG(ROUND(AVG(duration),2)) OVER w AS moving_average_duration,	-- Avg of Avg duration which is moving avg of movies grouped by genre
		COUNT(m.id) AS movie_count,
        ROUND(AVG(r.avg_rating), 2) AS average_rating
FROM movie m
	INNER JOIN genre g
		ON m.id = g.movie_id
        INNER JOIN ratings r
			ON m.id = r.movie_id
GROUP BY genre
WINDOW w AS (ORDER BY ROUND(AVG(duration),2) ROWS CURRENT ROW);
*/
/* ANALYSIS : HORROR MOVIES WITH THEIR CURRENT MOVIE AVERAGE DURATION WHICH IS THE LOWEST AMONG ALL OTHER GENRES
HAVE LOWEST AVERAGE RATINGS. IMPROVEMENT IS REQUIRED FOR THE DIRECTORS WHO CHOOSE HORROR AS GENRE FOR UPCOMING MOVIES.
MOVIES FROM ACTION, ROMANCE, CRIME HAS A HIGH AVERAGE DURATION TIME, WITH DECENT AVERAGE RATINGS AND DECENT COUNT OF MOVIES
PRODUCTING MOVIES FROM THESE GENRES CAN POTENTIALLY ATTRACT BUSINESS.

-- Round is good to have and not a must have; Same thing applies to sorting

-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies


WITH top_3_genres AS		-- Collecting the info of top 3 genres based on number of movies 
(
	SELECT genre,
			COUNT(movie_id) AS tot_movies
	FROM genre
	GROUP BY genre
	ORDER BY tot_movies DESC
    LIMIT 3
), Films AS					-- Collecting movies from top 3 genres from above CTE info based on worldwide_gross_income where the INR and $ are removed and converted to decimal for analysis
(
	SELECT 	genre, 
			year,
			title AS movie_name,
			CAST(REPLACE(REPLACE(worlwide_gross_income,'INR',''),'$ ','') AS decimal(10)) AS worldwide_gross_income 
	FROM movie m
		INNER JOIN genre g
			ON m.id = g.movie_id
	WHERE genre IN (SELECT genre FROM top_3_genres)
), ranking_films AS 			-- Ranking the movies of each genre and each year based on worldwide_gross_income
(
	SELECT *,
			RANK() OVER(PARTITION BY genre, year ORDER BY worldwide_gross_income DESC) AS movie_rank
		FROM Films
)
	SELECT 	genre,	year,	movie_name,
			CONCAT('$', SUBSTRING_INDEX(worldwide_gross_income, ' ', -1)) AS worldwide_gross_income,movie_rank
    FROM ranking_films
	WHERE movie_rank <= 5;		
-- Top five highest-grossing movies of each year from top 3 genres

/*
Analysis:
In comedy the most grossing movie is Toy Story 4 which is released in 2019
In drama the most grossing movie is Avengers: Endgame which is released in 2019
In thriller the most grossing movie is Joker which is released in 2019
*/  



-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:


SELECT     m.production_company,
           COUNT(m.id) AS movie_count,
           ROW_NUMBER() OVER(ORDER BY COUNT(m.id) DESC) AS prod_comp_rank	-- Ranking using the number of movies
FROM       movie m
INNER JOIN ratings r
ON         m.id = r.movie_id
WHERE      median_rating >= 8
		   AND m.languages LIKE '%,%'				-- Logic for Multilingual films where "," is used in languages
		   AND m.production_company IS NOT NULL
GROUP BY   production_company 							-- Number of movies by Grouping production_company
LIMIT 2;			-- Top 2 companies

/*
Analysis:
Star Cinema, Twentieth Century Fox are two top production companies produced multilingual movies with highest number of hits
*/  

-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:


-- Approach 1: using CTE and SELECT statements with RANK() function
WITH actress_summary AS   			-- Collecting actress info along with weighter avg of the movies acted
(
           SELECT     n.NAME AS actress_name,
                      SUM(total_votes) AS total_votes,
                      Count(r.movie_id)                                     AS movie_count,
                      ROUND(Sum(avg_rating*total_votes)/Sum(total_votes),2) AS actress_avg_rating
           FROM       movie                                                 AS m
           INNER JOIN ratings                                               AS r
           ON         m.id=r.movie_id
           INNER JOIN role_mapping AS rm
           ON         r.movie_id = rm.movie_id
           INNER JOIN names AS n
           ON         rm.name_id = n.id
           INNER JOIN GENRE AS g
           ON 			g.movie_id = m.id
           WHERE      category = 'actress'
           AND        	avg_rating > 8
           AND 			genre LIKE "%Drama%"
           GROUP BY  name 
)
SELECT   *,
         RANK() OVER(ORDER BY movie_count DESC ,actress_avg_rating DESC) AS actress_rank  -- Ranking the actress on weighted avg rating and number of movies
FROM     actress_summary 
LIMIT 3;			-- Top 3 actress details


-- Approach 2: using CTE and SELECT statements with ROW_NUMBER() function

WITH actress_rating_8 AS			-- Collecting actress info along with weighter avg of the movies acted
(
		SELECT 	n.NAME AS actress_name,
				SUM(r.total_votes) AS total_votes,
				COUNT(r.movie_id) AS movie_count,
                ROUND(SUM(avg_rating * total_votes) / SUM(total_votes),2) AS actress_avg_rating
         FROM   names n
                INNER JOIN role_mapping ro
                        ON n.id = ro.name_id
                INNER JOIN ratings r 
                using(movie_id)
                INNER JOIN genre g 
                using(movie_id)
         WHERE  ro.category = 'actress'
                AND r.avg_rating > 8
                AND g.genre LIKE '%Drama%'
         GROUP  BY actress_name
), 
actress_ranking AS 
(		SELECT *,
                ROW_NUMBER() 
					OVER (ORDER BY movie_count DESC, actress_avg_rating DESC) AS actress_rank  -- Ranking the actress on weighted avg rating and number of movies
         FROM   actress_rating_8
)
SELECT *
FROM   actress_ranking
WHERE  actress_rank <= 3; 	-- Top 3 actress details

/*
Analysis:
Susan Brown, Amanda Lawrence, Denise Gough  are the top 3 actress who acted in super hit movies in Drama genre.
All 3 are ranked 1.
*/            
            
/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:

WITH director_details AS		-- Fetching the director details along with director's next movie date
(
	SELECT d.name_id AS director_id,
			n.name AS director_name,
			d.movie_id AS movie_id,
			m.date_published AS release_date,
			LEAD(date_published, 1) OVER(PARTITION BY d.name_id ORDER BY date_published)
            AS next_movie_date,
			r.avg_rating,
			r.total_votes,
			m.duration
		FROM names n
		INNER JOIN director_mapping d
			ON n.id = d.name_id
			INNER JOIN movie m
				ON d.movie_id = m.id
				INNER JOIN ratings r
					ON m.id = r.movie_id
), director_details_1 AS		-- Calculating the difference between the two consecutive movie release dates of a director
(
	SELECT *, DATEDIFF(next_movie_date, release_date) AS inter_movie_days
		FROM director_details
)
	SELECT director_id,
			director_name,
            COUNT(movie_id) AS number_of_movies,			-- Number of movies directed
            ROUND(AVG(inter_movie_days)) AS avg_inter_movie_days, -- Average number of inter movie release days
            ROUND(AVG(avg_rating), 2) AS avg_rating,			  -- Average rating of movie
            SUM(total_votes) AS total_votes,
            MIN(avg_rating) AS min_rating,
            MAX(avg_rating) AS max_rating,
            SUM(duration) AS total_duration
		FROM director_details_1
		GROUP BY director_id									  -- Fetcing the director details by grouping the director id
		ORDER BY number_of_movies DESC,
					avg_rating DESC
        LIMIT 9;

/*
Analysis:
A.L Vijay and Andrew Jones topped in directors list with 5 movies directed
Steven Soderbergh topped the list wrt avg_rating and total_votes.
*/

