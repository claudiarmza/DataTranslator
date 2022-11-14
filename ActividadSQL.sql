-- Actividad SQL

--Parte 1
--1.1
SELECT first_name, last_name
FROM actor;

--1.2
SELECT
UPPER(first_name)||' '||UPPER(last_name) AS 'Actor Name'
FROM actor;

--1.3
SELECT actor_id, first_name,last_name
FROM actor
WHERE first_name LIKE 'JOE';

--1.4
SELECT actor_id, first_name,last_name
FROM actor
WHERE last_name LIKE '%GEN%';

--1.5
SELECT first_name,last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name ASC, first_name ASC;

--1.6
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

--Parte 2
--2.1
select last_name, count(last_name)
from actor
group by last_name
having count(last_name);

--2.2
select last_name, count(last_name)
from actor
group by last_name
having count(last_name)>1;

--2.3
SELECT st.first_name, st.last_name, ad.address
FROM staff st
INNER JOIN address ad
ON st.address_id=ad.address_id;

--2.4
SELECT st.staff_id, st.first_name, st.last_name, round(sum(py.amount),2) as TAmount
FROM staff st
LEFT JOIN payment py
ON st.staff_id=py.staff_id
GROUP BY st.staff_id;

--2.5
SELECT fi.title as FilmTitle, count(fa.actor_id) as NumActors
FROM film fi
INNER JOIN film_actor fa
ON fi.film_id=fa.film_id
GROUP BY fi.title;

--2.6
SELECT fi.film_id as ID, fi.title as FilmTitle, count(inv.inventory_id) as NCopies
FROM film fi
INNER JOIN inventory inv
ON inv.film_id=fi.film_id
WHERE fi.film_id=439
GROUP BY fi.film_id;

--2.7
SELECT cu.customer_id, cu.last_name, cu.first_name, round(sum(py.amount),2) AS Total_paid
FROM customer cu
INNER JOIN payment py
ON cu.customer_id=py.customer_id
GROUP BY cu.customer_id
ORDER BY cu.last_name ASC;

--Parte 3
--3.1
SELECT title
FROM film
WHERE title LIKE 'Q%' AND (SELECT language_id FROM language WHERE name='English');

--3.2
SELECT fi.title, ac.first_name, ac.last_name
FROM actor ac
INNER JOIN film_actor fa ON ac.actor_id=fa.actor_id
INNER JOIN film fi ON fi.film_id=fa.film_id
WHERE fi.title in (SELECT fi.title FROM film WHERE fi.title='ALONE TRIP');

--3.3
SELECT co.country, cu.first_name, cu.last_name, cu.email
FROM customer cu
INNER JOIN address ad ON cu.address_id=ad.address_id
INNER JOIN city ci ON ci.city_id=ad.city_id
INNER JOIN country co ON co.country_id=ci.country_id
WHERE co.country='Canada';

--3.4
SELECT ca.name AS 'Category', fi.title AS 'FilmTitle'
FROM film fi
INNER JOIN film_category fc ON fi.film_id=fc.film_id
INNER JOIN category ca ON fc.category_id=ca.category_id
WHERE ca.name='Family';

--3.5 Muestre el nombre de películas más alquiladas en orden descendente
SELECT fi.title AS 'Movie Title', fi.rental_rate AS 'Rental Rate'
from film fi
ORDER BY fi.rental_rate DESC;

--3.6 Mostrar el volumen de negocio en dolares de cada tienda
SELECT st.store_id AS 'Store', round(sum(py.amount),2) AS 'Business Volume'
FROM store st
INNER JOIN payment py ON py.customer_id=cu.customer_id
INNER JOIN customer cu ON cu.store_id=st.store_id
GROUP BY st.store_id

--3.7 Mostrar para cada tienda su ID, ciudad y país
SELECT st.store_id AS 'Store ID', ci.city AS 'City', co.country AS 'Country'
FROM store st
INNER JOIN address ad ON ad.address_id=st.address_id
INNER JOIN city ci ON ci.city_id=ad.city_id
INNER JOIN country co ON co.country_id=ci.country_id

--3.8 Enumere los cinco géneros más importantes en ingresos brutos en orden descendente
--(Sugerencia: category, film_category, inventario, pago y alquiler)
SELECT ca.name AS 'Category', round(sum(pa.amount),2) AS Gross_Income
FROM payment pa
INNER JOIN rental re ON re.rental_id=pa.rental_id
INNER JOIN inventory inv ON inv.inventory_id=re.inventory_id
INNER JOIN film_category fc ON fc.film_id=inv.film_id
INNER JOIN category ca ON ca.category_id=fc.category_id
GROUP BY ca.name
ORDER BY Gross_Income DESC
LIMIT 5
