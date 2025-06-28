-- -------------------------------------------------------------------------------------
-- ---------------------------- EVALUACIÓN FINAL MÓDULO 2 ------------------------------
-- -------------------------------------------------------------------------------------

-- EJERCICIOS --

USE sakila; -- Base de datos que vamos a utilizar. 

/*
1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
*/

SELECT DISTINCT title
FROM film;


/*
2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
*/

SELECT title
FROM film
WHERE rating = 'PG-13';


/*
3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su
descripción.
*/

SELECT title, description
FROM film
WHERE description LIKE '%amazing%';


/*
4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
*/

SELECT title
FROM film
WHERE length > 120;


/*
5. Recupera los nombres de todos los actores.
*/

-- Si queremos saber los nombre de los actores, independientemente del actor en sí, es decir, de la persona; 
-- entonces lo haríamos de la siguiente manera: . 
SELECT DISTINCT first_name
FROM actor; 

-- Si entendemos el nombre del actor como 'persoma', es decir, el nombre completo; emtonces lo haríamos de la 
-- siguiente manera: 

SELECT DISTINCT CONCAT(first_name, ' ', last_name) AS name -- para asegurarnos de que no se repite ningún actor, ponemos el DISTINCT
FROM actor;


/*
6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
*/

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%Gibson%';


/*
7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
*/

-- Solo nombre
SELECT first_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;


-- Nombre completo
SELECT first_name, last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;


/*
8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
clasificación.
*/

SELECT title, rating
FROM film
WHERE rating != 'R' AND rating != 'PG-13';


/*
9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación
junto con el recuento.
*/

SELECT rating, COUNT(title) AS recuento
FROM film
GROUP BY rating;


/*
10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas.
*/

SELECT 					-- Seleccionamos las columnas que se nos pide
	c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(r.customer_id) AS number_film_rental
FROM customer AS c		-- De la tabla customer (donde se encuentra los datos de los clientes)
INNER JOIN rental AS r USING (customer_id) -- Utilizamos un INNER JOIN para cruzar la tabla CUSTOMER junto con RENTAL devolviéndonos todas las filas en la que coinciden valores de ambas tablas.
GROUP BY c.customer_id;


/*
11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
junto con el recuento de alquileres.
*/

/*
12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
clasificación junto con el promedio de duración.
*/

/*
13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
*/

/*
14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
*/

/*
15. Encuentr a el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
*/

/*
16. Encuentra el título de todas las películas que son de la misma categoría que "Family".
*/

/*
17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla
film.
*/



