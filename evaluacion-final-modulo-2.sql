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

SELECT ctg.name, COUNT(ren.rental_id) AS number_film_rental
FROM category AS ctg
INNER JOIN film_category AS fctg USING (category_id)
INNER JOIN film AS f USING (film_id)
INNER JOIN inventory AS inv USING (film_id)
INNER JOIN rental AS ren USING (inventory_id)
GROUP BY ctg.name;


/*
12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
clasificación junto con el promedio de duración.
*/

SELECT rating, AVG(length) AS avg_length
FROM film
GROUP BY rating;


/*
13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
*/

SELECT 
	act.first_name, 
    act.last_name
FROM actor AS act
INNER JOIN film_actor AS fact USING (actor_id)
INNER JOIN film AS f USING (film_id)
WHERE f.title = "Indian Love";

/*
14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
*/

SELECT title
FROM film
WHERE description LIKE '%dog%' OR '%cat%';


/*
15. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
*/

SELECT title, release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;


/*
16. Encuentra el título de todas las películas que son de la misma categoría que "Family".
*/

SELECT f.title
FROM film AS f
INNER JOIN film_category AS fctg USING (film_id)
INNER JOIN category AS ctg USING (category_id)
WHERE ctg.name = 'Family';


/*
17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla
film.
*/

SELECT title
FROM film
WHERE rating = 'R' AND length > 120;


-- BONUS --

/*
 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
 */
 
 SELECT 
	act.first_name, 
    act.last_name, 
    COUNT(f.film_id) AS numbers_films
 FROM actor AS act
 INNER JOIN film_actor AS fact USING (actor_id) 
 INNER JOIN film AS f USING (film_id)
 GROUP BY act.first_name, act.last_name
 HAVING numbers_films > 10;
 
 
 /*
 19. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
 */
 
 -- OPCIÓN 1 DE RESPUESTA: 
 -- No hace falta escribir ninguna consulta ya que la respuesta sería NO, debido a que, 
 -- si entendemos que lo tenemos que responder SOLO con la tabla film_actor
 -- en esa tabla nunca va a aparecer un actor_id sin film_id; al igual que 
 -- no va a aparecer ningún film_id sin actor_id. Por lo tanto, no va a aparecer un 
 -- actor_id sin film_id. 
 
 
 -- OPCIÓN 2 DE RESPUESTA:
 -- Si entendemos que necesitamos la tabla film_actor como una tabla que nos
 -- da la información del cruce de actores con peliculas pero que para 
 -- responder a la pregunta necesitamos como tabla principal la de actor, 
 -- enotnces: 
 
 -- OPCIÓN 2.1: Con un RIGHT JOIN
 
 SELECT 
	act.actor_id, 
    act.first_name, 
    act.last_name, 
    COUNT(fact.film_id) AS numbers_films
 FROM film_actor AS fact
 RIGHT JOIN actor AS act USING (actor_id)
 GROUP BY act.actor_id
 HAVING numbers_films = 0;


-- OPCIÓN 2.2: Con un LEFT JOIN

 SELECT 
	act.actor_id, 
    act.first_name, 
    act.last_name, 
    COUNT(fact.film_id) AS numbers_films
 FROM actor AS act
 LEFT JOIN film_actor AS fact USING (actor_id)
 GROUP BY act.actor_id
 HAVING numbers_films = 0;
 
 
 /*
 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
 muestra el nombre de la categoría junto con el promedio de duración.
 */
 
 SELECT 
	catg.name, 
    AVG(f.length) AS avg_length
 FROM category AS catg
 INNER JOIN film_category AS fcatg USING (category_id)
 INNER JOIN film AS f USING (film_id)
 GROUP BY catg.name
 HAVING avg_length > 120;
 
 
 /*
 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con
 la cantidad de películas en las que han actuado.
 */
 
 SELECT 
	act.first_name, 
    act.last_name, 
    COUNT(act.actor_id) AS count_film
 FROM actor AS act
 INNER JOIN film_actor AS fact USING (actor_id)
 INNER JOIN film AS f USING (film_id)
 GROUP BY act.first_name, act.last_name
 HAVING count_film >= 5;
 
 /*
 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
 subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
 películas correspondientes.
 */
 
 SELECT DISTINCT f.title -- Se pone un DISTINCT porque si no se pusiera saldría repetido las películas, ya que puede haver varios rental_id de una misma película. 
 FROM film AS f
 INNER JOIN inventory AS i USING (film_id)
 INNER JOIN rental AS r USING (inventory_id)
 WHERE r.rental_id IN (
		  SELECT r.rental_id  -- rental_id con una duración superior a 5 días. 
		  FROM rental AS r
		  INNER JOIN inventory AS i USING (inventory_id)
		  INNER JOIN film AS f USING (film_id)
		  WHERE f.rental_duration > 5
		) ;
  
  
 /*
 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
 "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
 categoría "Horror" y luego exclúyelos de la lista de actores.
 */

 SELECT 
    first_name, 
    last_name 
 FROM actor
 WHERE actor_id NOT IN ( 
							SELECT DISTINCT -- Para quitar posibles actores duplicados que han actuado en peliculas de la categoría 'Horror'.
								act.actor_id -- Se hace por el id del actor en lugar de por nombre y apellido, debido a que se ha detectado 2 actrices que tienen mismo nombre y apellido pero son 2 personas distintas ya que tiene id diferentes. 
							 FROM actor AS act
							 INNER JOIN film_actor AS fact USING (actor_id)
							 INNER JOIN film AS f USING (film_id)
							 INNER JOIN film_category AS fcatg USING (film_id)
							 INNER JOIN category AS catg USING (category_id)
							 WHERE catg.name = 'Horror'
                             );
 
 
 /*
 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
 tabla film.
 */
 
 SELECT f.title
 FROM film AS f
 INNER JOIN film_category AS fcatg USING (film_id)
 INNER JOIN category AS catg USING (category_id)
 WHERE f.length > 180 AND catg.name = 'Comedy';

 
 /*
 25. Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar
 el nombre y apellido de los actores y el número de películas en las que han actuado juntos.
*/

-- Estamos haciendi un SELF JOIN, es decir, estamos combinando una tabla consigo misma, en este caso la tabla ACTOR consigo misma.
--  Pero también necesitamos hacer una LEFT JOIN para traer de la tabla FILM_ACTOR los datos a ambas tablas ACTOR. 

SELECT
	CONCAT(act1.first_name, ' ', act1.last_name) AS complete_name_actor1, -- Nombre actor 1. Concatenamos para tener solo una col con el nombre completo del actor 1.
    CONCAT(act2.first_name, ' ', act2.last_name) AS complete_name_actor2, -- Nombre actor 2. Concatenamos para tener solo una col con el nombre completo del actor 2.
    COUNT(fact.film_id) AS numbers_films_actors -- Contamos los id de las peliculas. 
FROM
	actor AS act1, 
    actor AS act2
LEFT JOIN film_actor AS fact USING (actor_id)
WHERE act1.actor_id <> act2.actor_id -- Indicamos que los id de las parejas de actores sean diferentes. Esto es para que no haga parejas de actores entre los mismos actores. Ejemplo: no cuente el número de peliculas de Adam Grant con él mismo. 
GROUP BY act1.first_name, act1.last_name, act2.first_name, act2.last_name; -- Agrupamos por los nombres y apellidos de los dos actores. De esta manera contamos el número de películas que tienen por parejas. 
