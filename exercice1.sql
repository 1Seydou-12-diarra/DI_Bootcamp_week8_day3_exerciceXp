-- 1- Obtenez une liste de toutes les langues du film
SELECT name FROM language;

--2- Obtenez une liste de tous les films joints avec leurs langues - sélectionnez les détails suivants
-- 2.1- Obtenez tous les films, même s'ils n'ont pas de langues
SELECT film.title, film.description, language.name
FROM film
LEFT JOIN language ON film.language_id = language.language_id;

--2.2- Obtenez toutes les langues, même s'il n'y a pas de films dans ces langues
SELECT film.title, film.description, language.name
FROM film
RIGHT JOIN language ON film.language_id = language.language_id;
 -- 3- Créez une nouvelle table nommée new_film avec les colonnes suivantes : id, name. Ajoutez quelques nouveaux films à la table
 CREATE TABLE new_film (
  id INT NOT NULL   PRIMARY KEY,
  name VARCHAR(255) NOT NULL,

);

-- 4- Create a new table called customer_review, which will contain film reviews that customers will make.
-- 1-review_id - une clé primaire, non nulle, auto-incrémentée.

CREATE TABLE customer_review (
    review_id SERIAL,
    film_id INT,
    language_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    score INT NOT NULL,
    review_text TEXT NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(film_id),
	CONSTRAINT fk_film
		FOREIGN KEY(film_id)
		REFERENCES new_film(id) ON DELETE CASCADE,
	UNIQUE (language_id),
	CONSTRAINT fk_language
    FOREIGN KEY (language_id) REFERENCES language(language_id)
);


-- 5- Ajoutez 2 critiques de films. Assurez-vous de les lier à des objets valides dans les autres tables.
INSERT INTO customer_review (film_id, language_id, title, score, review_text)
VALUES (1, 1, 'Great Film!', 9, 'I loved this movie. The acting was amazing and the storyline was gripping.');

INSERT INTO customer_review (film_id, language_id, title, score, review_text)
VALUES (2, 2, 'Terrible Movie', 3, 'I did not like this movie at all. The plot was confusing and the acting was terrible.');

