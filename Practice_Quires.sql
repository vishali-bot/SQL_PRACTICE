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