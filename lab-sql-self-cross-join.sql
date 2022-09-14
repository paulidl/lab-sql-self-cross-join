-- Lab | SQL Self and cross join: In this lab, you will be using the Sakila database of movie rentals.
USE sakila;

-- Instructions
-- 1. Get all pairs of actors that worked together.

SELECT * FROM sakila.film_actor;	-- actor_id, film_id 

SELECT fa1.film_id, fa1.actor_id AS ID_actor1, fa2.actor_id AS ID_actor2
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2 ON fa1.film_id = fa2.film_id 
WHERE fa1.actor_id != fa2.actor_id AND fa1.actor_id < fa2.actor_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.

SELECT * FROM sakila.rental;			-- customer_id, inventory_id
SELECT * FROM sakila.inventory;			-- inventory_id, film_id

SELECT r1.customer_id AS customer1, r2.customer_id AS customer2, COUNT(i.film_id) AS same_film_rented
FROM sakila.rental r1
JOIN sakila.inventory i ON r1.inventory_id = i.inventory_id
JOIN sakila.rental r2 ON r2.inventory_id = i.inventory_id
WHERE r1.customer_id > r2.customer_id
GROUP BY r1.customer_id, r2.customer_id
HAVING same_film_rented > 3;

-- 3. Get all possible pairs of actors and films.

SELECT * FROM sakila.film_actor;

SELECT actor_id, film_id
FROM (select distinct actor.actor_id from actor) fa1
CROSS JOIN (select distinct film_id from film) fa2
ORDER BY actor_id, film_id;
