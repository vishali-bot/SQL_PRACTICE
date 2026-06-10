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

