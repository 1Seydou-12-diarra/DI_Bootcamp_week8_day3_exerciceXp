-- 1- Utilisez UPDATE pour changer la langue de certains films. Assurez-vous d'utiliser des langues valides.
UPDATE films
SET language_id = 5
WHERE film_id = 1;

-- 2- Quelles clés étrangères (références) sont définies pour la table client ? Comment cela affecte-t-il la manière dont nous INSÉRONS dans la table client ?


-- 3- Nous avons créé une nouvelle table appelée customer_review . Déposez ce tableau. Est-ce une étape facile ou nécessite-t-elle une vérification supplémentaire ?
DROP TABLE customer_review;

-- 4- Découvrez combien de locations sont encore en suspens (c'est-à-dire qu'elles n'ont pas encore été retournées au magasin).
SELECT COUNT(*) AS num_outstanding_rentals
FROM rental
WHERE return_date IS NULL;


-- 5- Trouvez les 30 films les plus chers qui sont exceptionnels (c'est-à-dire qui n'ont pas encore été retournés au magasin)
SELECT film.title, rental.rental_date, rental.return_date, film.rental_rate
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental.return_date IS NULL
ORDER BY film.rental_rate DESC
LIMIT 30;


-- 6- Votre ami est au magasin et décide de louer un film
-- 6.1- Le 1er film : Le film parle d'un lutteur de sumo, et l'un des acteurs est Penelope Monroe.
SELECT title
FROM film
WHERE description LIKE '%sumo wrestler%'
AND (actor_id IN (SELECT actor_id FROM actor WHERE first_name = 'Penelope' AND last_name = 'Monroe')
     OR film_id IN (SELECT film_id FROM film_actor WHERE actor_id IN (SELECT actor_id FROM actor WHERE first_name = 'Penelope' AND last_name = 'Monroe')));
-- 6.2- Le 2ème film : Un court documentaire (moins d'1h), noté « R ».
SELECT title
FROM film
WHERE length < 60
AND rating = 'R';
-- 6.3- Le 3ème film : Un film que son ami Matthew Mahan a loué. Il a payé plus de 4,00 $ pour la location et il l'a rendue entre le 28 juillet et le 1er août 2005.
SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.first_name = 'Matthew' AND c.last_name = 'Mahan'
AND r.rental_rate > 4.00
AND r.return_date BETWEEN '2005-07-28'

-- 6.4- Le 4ème film : Son ami Matthew Mahan a également regardé ce film. Il y avait le mot «bateau» dans le titre ou la description, et il semblait que c'était un DVD très coûteux à remplacer.
SELECT f.title, f.rental_rate, COUNT(*) AS num_rentals
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN customer AS c ON r.customer_id = c.customer_id
WHERE c.first_name = 'Matthew' AND c.last_name = 'Mahan'
AND (f.title LIKE '%boat%' OR f.description LIKE '%boat%')
AND r.rental_date >= '2005-07-28' AND r.rental_date <= '2005-08-01'
AND r.return_date IS NULL
GROUP BY f.title, f.rental_rate
ORDER BY f.rental_rate DESC
LIMIT 1;

