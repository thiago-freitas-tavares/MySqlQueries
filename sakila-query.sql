-- 5. Comando JOIN para relacionar diferentes tabelas no DB.

-- Continuação

SELECT 
	f.title,
    c.name,
    l.name,
    a.first_name,
    a.last_name
FROM
	film AS f								-- utilizando alias (pseudônimo).
JOIN film_category AS fc					-- dois JOINs, pois a tabela film não possui conexão direta com a tabela category.
-- ON f.film_id = fc.film_id				-- se o nome das colunas das tabelas forem o mesmo, da para usar o comando USING ao invés do comando ON.
	USING(film_id)
JOIN category AS c
	USING(category_id)
JOIN language AS l
	USING(language_id)
JOIN film_actor AS fa
	USING(film_id)
JOIN actor AS a
	USING(actor_id)
WHERE a.last_name LIKE("%Cruise%");			-- código alternativo: WHERE a.last_name = "Cruise"

SELECT c.country, city.city
FROM city
LEFT JOIN country AS c USING(country_id)
UNION										-- MySQL não possui o comando FULL JOIN ou OUTER JOIN -> utilizamos UNION como artifício.
SELECT c.country, city.city
FROM city
RIGHT JOIN country AS c USING(country_id);

-- 6. Comandos Avançados

-- SUBQUERY: uma query que contém outra query.

SELECT title
FROM film
WHERE rental_duration > (SELECT AVG(rental_duration) FROM film);

-- STORED PROCEDURE: uma query que pode ser executada depois por um nome (similar a funções).

/*
DELIMITER //
CREATE PROCEDURE select_all_active_users()
BEGIN
	SELECT * FROM customer
	WHERE active = 1;
END //
DELIMITER ;
*/
CALL select_all_active_users();
/*
DELIMITER //
CREATE PROCEDURE get_movies_from_category(category_name VARCHAR(100))
BEGIN
	SELECT f.title, c.name
    FROM film f
    JOIN film_category fc
    USING(film_id)
    JOIN category c
    USING(category_id)
    WHERE c.name = category_name;			-- c.name é igual ao dado passado como argumento na chamada do PROCEDURE.
END //
DELIMITER;
*/
CALL get_movies_from_category("action");
/*
DELIMITER //
CREATE PROCEDURE get_movies_by_rental_duration(rd INT)
BEGIN
	SELECT title, rental_duration
    FROM film
    WHERE rental_duration > rd;
END //
DELIMITER //
*/
-- DROP PROCEDURE get_movies_by_rental_duration;
CALL get_movies_by_rental_duration(4);

-- VIEWS: uma tabela que é formada por uma query.

/*
CREATE VIEW film_title_and_category
AS
SELECT f.film_id, f.title, c.name
FROM film f
JOIN film_category fc
USING(film_id)
JOIN category c
USING(category_id);
*/
SELECT * FROM film_title_and_category WHERE film_id = 97;
/*
CREATE VIEW customer_address
AS
SELECT cr.first_name, cr.last_name, ad.address, ct.city
FROM customer cr
JOIN address ad
USING(address_id)
JOIN city ct
USING(city_id);
*/
-- DROP VIEW customer_address;
SELECT * FROM customer_address;

-- TRIGGER: uma ação que é ativada com base em algum comportamento.

CREATE TRIGGER before_update_customer
	BEFORE UPDATE ON customer
    FOR EACH ROW
    SET NEW.last_update = NOW();
-- DROP TRIGGER before_update_customer;

UPDATE customer
SET first_name = "Leonildo"
WHERE customer_id = 2;

SELECT * FROM customer;