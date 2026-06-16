--Exercise 1 — Tasks (SELECT queries)

--Find the title of each film
SELECT title FROM movies;
--Find the director of each film
SELECT director FROM movies;
--Find the title and director of each film
SELECT title,director FROM movies;
--Find the title and year of each film
SELECT title,year FROM movies;
--Find all the information about each film
SELECT * FROM movies;

--Exercise 2 — Tasks (Queries with constraints)

--Find the movie with a row id of 6
SELECT * FROM movies WHERE id =6;
--Find the movies released in the years between 2000 and 2010
SELECT * FROM movies WHERE year BETWEEN 2000 AND 2010;
--Find the movies not released in the years between 2000 and 2010
SELECT * FROM movies WHERE year NOT BETWEEN 2000 AND 2010;
--Find the first 5 Pixar movies and their release year
SELECT title FROM movies LIMIT 5;


--Exercise 3 — Tasks (Queries with constraints)

--Find all the Toy Story movies
SELECT * FROM movies WHERE Title LIKE "Toy Story%";
--Find all the movies directed by John Lasseter
SELECT * FROM movies WHERE director LIKE "john lasseter";
--Find all the movies (and director) not directed by John Lasseter
SELECT * FROM movies WHERE director  NOT LIKE "john lasseter";
--Find all the WALL-* movies
SELECT * FROM movies WHERE title LIKE "wall-_";

--Exercise 4 — Tasks (Filtering and sorting Query results)

--List all directors of Pixar movies (alphabetically), without duplicates
SELECT DISTINCT director FROM movies ORDER BY  director asc;
--List the last four Pixar movies released (ordered from most recent to least)
SELECT title ,year FROM movies ORDER BY year DESC LIMIT 4;
--List the first five Pixar movies sorted alphabetically
SELECT title  FROM movies ORDER BY title ASC LIMIT 5;
--List the next five Pixar movies sorted alphabetically
SELECT * FROM movies ORDER BY TITLE ASC LIMIT 5 OFFSET 5;


--Exercise 5 — Tasks Multi-table queries with JOINs 
--(MOVIES and BOXOFFICE TABLES ARE USED)

--Find the domestic and international sales for each movie

SELECT title, Domestic_sales, International_sales 
    FROM movies 
    INNER JOIN Boxoffice 
    ON id = Movie_id; 

--Show the sales numbers for each movie that did better internationally rather than domestically

SELECT title, domestic_sales, international_sales
    FROM movies
    JOIN boxoffice
    ON movies.id = boxoffice.movie_id
    WHERE international_sales > domestic_sales;

--List all the movies by their ratings in descending order

SELECT title, rating
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id
 ORDER BY Rating DESC;


--Exercise 6 — Tasks 
--(BUILDINGS and EMPLOYEES TABLES ARE USED)

--Find the list of all buildings that have employees

SELECT DISTINCT building FROM employees;

--Find the list of all buildings and their capacity

SELECT building_name , capacity FROM buildings ;

--List all buildings and the distinct employee roles in each building (including empty buildings)

SELECT DISTINCT building_name, role 
FROM buildings 
  LEFT JOIN employees
    ON building_name = building;

--Exercise 7 — Tasks(Select query with constraints on NULL values)
--(BUILDINGS and EMPLOYEES TABLES ARE USED)

--Find the name and role of all employees who have not been assigned to a building

SELECT name, role FROM employees WHERE Building IS NULL ;

--Find the names of the buildings that hold no employees

SELECT building_name , name FROM buildings b
    LEFT JOIN Employees e 
    ON b.building_name = e.Building 
    WHERE name IS  NULL ;

--Exercise 8 — Tasks (Queries with expressions)
--(MOVIES and BOXOFFICE TABLES ARE USED)

--List all movies and their combined sales in millions of dollars

SELECT title, (domestic_sales + international_sales) / 1000000 AS millions
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;

--List all movies and their ratings in percent

SELECT title, rating * 10 AS percent
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;

--List all movies that were released on even number years

SELECT title, year
FROM movies
WHERE year % 2 = 0;


--Exercise 9 — Tasks (Queries with aggregates)
--(EMPLOYEES TABLE USED)


--Find the longest time that an employee has been at the studio

SELECT name,MAX(years_employed) FROM employees;

--For each role, find the average number of years employed by employees in that role

SELECT role ,AVG(years_employed) FROM employees
GROUP BY role;

--Find the total number of employee years worked in each building

SELECT role, building, SUM(years_employed) AS Total_no_emp 
FROM employees
GROUP BY building ;

--Find the number of Artists in the studio (without a HAVING clause)

SELECT role, COUNT(role) FROM employees where role = 'Artist';

--Find the number of Employees of each role in the studio

SELECT role, COUNT(name) FROM employees 
GROUP BY role ;

--Find the total number of years employed by all Engineers

SELECT role , SUM(years_employed) FROM employees
GRoup BY role
HAVING role = 'Engineer';


--Exercise 10 — Tasks (Order of execution of a Query)
--(MOVIES and BOXOFFICE TABLES ARE USED)

--Find the number of movies each director has directed ✓

SELECT  COUNT(title) AS no_movies , director 
FROM Movies
GROUP BY director;

--Find the total domestic and international sales that can be attributed to each director

SELECT  director,SUM(domestic_sales + international_sales)  AS Total_Sales
FROM Movies m
INNER JOIN boxoffice b
ON m.id = b.movie_id
GROUP BY director;


--Exercise 11 — Tasks(Inserting rows)

--Add the studio's new production, Toy Story 4 to the list of movies (you can use any director)

INSERT INTO movies 
VALUES (4, "Toy Story 4", "El Directore", 2015, 90);

--Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.

INSERT INTO boxoffice  
VALUES (4,  8.7, 340, 270);

--Exercise 12 — Tasks(Updating rows)

--The director for A Bug's Life is incorrect, it was actually directed by John Lasseter

UPDATE movies
SET director = "John Lasseter"
WHERE id = 2;

--The year that Toy Story 2 was released is incorrect, it was actually released in 1999

UPDATE movies
SET year = 1999
WHERE id = 3;

--Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich

UPDATE movies
SET title =  "Toy Story 3" ,  director = "Lee Unkrich"
WHERE id = 11 ;

--Exercise 13 — Tasks(Deleting rows)

--This database is getting too big, lets remove all movies that were released before 2005.

DELETE FROM movies
WHERE year < 2005;

--Andrew Stanton has also left the studio, so please remove all movies directed by him.

DELETE FROM movies
WHERE director = "Andrew Stanton";



--Exercise 14 — Tasks(Creating tables)

--Create a new table named Database with the following columns:
--Name A string (text) describing the name of the database
--Version A number (floating point) of the latest version of this database
--Download_count An integer count of the number of times this database was downloaded

CREATE TABLE IF NOT EXISTS Database(
    Name Varchar(50),
    Version NUMERIC(10,3),
    Download_count INTEGER
); 

SELECT * FROM database;

--Exercise 15 — Tasks (Altering tables)

--Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in.

ALTER TABLE movies ADD COLUMN Aspect_ratio FLOAT;

--Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English.

ALTER TABLE movies ADD COLUMN Language TEXT DEFAULT "English";

--Exercise 16 — Tasks ()

--clean up by removing the Movies table

DROP TABLE movies;

--And drop the BoxOffice table as well

DROP TABLE movies;