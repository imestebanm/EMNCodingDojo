-- 1. Todos los clientes dentro de city_id = 312 // nombre, apellido, correo electrónico y dirección del cliente.
SELECT customer.first_name, customer.last_name, customer.email, address.address
FROM customer
JOIN address ON customer.address_id = address.address_id
WHERE address.city_id = 312;

-- 2. Todas las películas de comedia // título de la película, descripción, año de estreno, calificación, características especiales y categoría.
SELECT film.title, film.description, film.release_year, film.rating, film.special_features, category.name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy';

-- 3. Todas las películas unidas por actor_id = 5 // identificación del actor, nombre del actor, título de la película, descripción y año de lanzamiento.
SELECT actor.actor_id, CONCAT(actor.first_name,' ',actor.last_name) AS nombre_actor, film.title, film.description, film.release_year
FROM actor
JOIN film_actor ON film_actor.actor_id = actor.actor_id
JOIN film ON film.film_id = film_actor.film_id
WHERE actor.actor_id = 5;

-- 4. Todos los clientes en store_id = 1 y dentro de estas ciudades (1, 42, 312 y 459) // nombre, apellido, correo electrónico y dirección del cliente.
SELECT customer.first_name, customer.last_name, customer.email, address.address
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE customer.store_id = 1 AND city.city_id IN (1, 42, 312, 459);

-- 5. Todas las películas con una "calificación = G" y "característica especial = detrás de escena", unidas por actor_id = 15 // título de la película, descripción, año de lanzamiento, calificación y característica especial. Sugerencia: puede usar la función LIKE para obtener la parte 'detrás de escena'.
SELECT film.title, film.description, film.release_year, film.rating, film.special_features
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.rating = 'G'
AND film.special_features LIKE '%Behind the scenes%'
AND actor.actor_id = 15;

-- 6. Todos los actores que se unieron en el film_id = 369 // film_id, title, actor_id y actor_name.
SELECT film.film_id, film.title, actor.actor_id, CONCAT(actor.first_name,' ',actor.last_name) AS nombre_actor
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.film_id =369;

-- 7. Todas las películas dramáticas con una tarifa de alquiler de 2.99 // título de la película, descripción, año de estreno, calificación, características especiales y categoría.
SELECT film.title, film.description, film.release_year, film.rating, film.special_features, category.name
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Drama' AND film.rental_rate = 2.99;

-- 8. Todas las películas de acción a las que participa SANDRA KILMER // título de la película, descripción, año de estreno, calificación, características especiales, categoría y nombre completo del actor.
SELECT film.title, film.description, film.release_year, film.rating, film.special_features, category.name, CONCAT(actor.first_name,' ',actor.last_name) AS nombre_actor
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE actor.first_name = 'SANDRA' AND actor.last_name = 'KILMER' AND category.name = 'Action';
