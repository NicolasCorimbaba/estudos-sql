--1) Na tabela film, selecione os atributos title, release_year e length e ordene os resultados pelo título em ordem alfabética.
SELECT title, release_year, length
FROM public.film
ORDER BY title;

--2) Na tabela customer, selecione os atributos first_name, last_name e email e ordene os resultados pelo sobrenome em ordem alfabética.
SELECT first_name, last_name, email
FROM public.customer
ORDER BY last_name;

--3) Na tabela actor, selecione os atributos first_name e last_name, sem mostrar o actor_id.
SELECT first_name, last_name
FROM public.actor;

--4) Na tabela film, selecione todos os atributos dos filmes que possuem duração maior que 120 minutos.
SELECT *
FROM public.film
WHERE length > 120;

--5) Na tabela film, selecione os atributos title e release_year somente dos filmes lançados em 2006.
SELECT title, release_year
FROM public.film
WHERE release_year =2006;

--6) Na tabela film, selecione os atributos title e length dos filmes que possuem duração maior ou igual a 120 minutos.
SELECT title, length
FROM public.film
WHERE length >=120;

--7) Na tabela film, selecione os filmes que possuem duração menor que 60 minutos.
SELECT title, length
FROM public.film
WHERE length <60;

--8) Na tabela customer, selecione os atributos first_name, last_name e email somente dos clientes que estejam ativos.
SELECT first_name, last_name,email
FROM public.customer
WHERE active =1;

--9) Na tabela film, selecione os filmes que possuem duração entre 90 e 120 minutos.
SELECT title, length
FROM public.film
WHERE length BETWEEN 90 AND 120

--10) Na tabela customer, selecione os atributos customer_id, first_name, last_name e store_id dos clientes que pertencem à loja 1.
SELECT customer_id,first_name, last_name, store_id
FROM public.customer
WHERE store_id = 1;

--11) Na tabela film, selecione os filmes cujo título começa com a letra A.
SELECT title
FROM public.film
WHERE title LIKE 'A%';
--12) Na tabela actor, selecione os atores cujo primeiro nome começa com a letra J.
SELECT first_name, last_name
FROM public.actor
WHERE first_name LIKE 'J%';

--13) Na tabela film, selecione os filmes cujo título contenha a palavra LOVE.
SELECT title
FROM public.film
WHERE title LIKE '%LOVE%';

--14) Na tabela film, selecione os filmes que foram lançados nos anos de 2006 ou 2007.
SELECT title,release_year
FROM public.film
WHERE release_year= 2006 OR release_year=2007;

--15) Na tabela film, selecione os atributos title e length e ordene os filmes da maior duração para a menor.
SELECT title,length
FROM public.film
ORDER BY length DESC; 

--16) Na tabela country, selecione os nomes dos países sem repetir valores.
SELECT DISTINCT country
FROM public.country; 

--17) Na tabela film, selecione os 10 primeiros filmes, ordenados alfabeticamente pelo título.
SELECT title
FROM public.film
ORDER BY title
LIMIT 10; 

--18) Na tabela film, selecione os 10 filmes com maior duração, mostrando title e length.
SELECT title,length
FROM public.film
ORDER BY length DESC
LIMIT 10; 

--19) Na tabela film, descubra a quantidade total de filmes existentes.
SELECT COUNT (film_id) AS quantidade_filmes
FROM public.film;

--20) Na tabela film, calcule a duração média dos filmes.
SELECT ROUND(AVG(length),3) AS duracao_media_filmes
FROM public.film;

--21) Na tabela film, descubra a maior e a menor duração entre os filmes.
SELECT MIN (length) AS menor_duracao, MAX (length) AS maior_duracao
FROM public.film;

--22) Na tabela payment, calcule o valor total de todos os pagamentos.
SELECT SUM (amount) AS valor_total_pagamentos
FROM public.payment;

--23) Na tabela payment, calcule o valor médio dos pagamentos.
SELECT ROUND(AVG(amount),2) AS media_valor_pagamentos
FROM public.payment;


--24) Na tabela customer, descubra a quantidade total de clientes.
SELECT COUNT (customer_id) AS quantidade_total_clientes
FROM public.customer;


--25) Na tabela film, descubra quantos filmes existem em cada ano de lançamento e ordene o resultado pelo ano.
SELECT release_year, COUNT(release_year) 
FROM public.film
GROUP BY release_year
ORDER BY release_year;

--26) Na tabela customer, descubra quantos clientes existem em cada store_id.
SELECT store_id, COUNT(store_id) 
FROM public.customer
GROUP BY store_id;


--27) Na tabela payment, descubra quanto cada cliente gastou no total. Mostre customer_id e o valor total gasto e ordene do maior para o menor.
SELECT customer_id, SUM(amount) 
FROM public.payment
GROUP BY customer_id
ORDER BY SUM DESC;


--28) Na tabela payment, descubra quantos pagamentos cada cliente realizou.
SELECT customer_id, COUNT(amount) 
FROM public.payment
GROUP BY customer_id;


--29) Na tabela payment, calcule a média que cada cliente gastou por pagamento.
SELECT customer_id, ROUND(AVG(amount),2) 
FROM public.payment
GROUP BY customer_id;


--30) Na tabela payment, encontre os clientes cujo gasto total seja maior que 100. Mostre customer_id e o total gasto.
SELECT customer_id, SUM(amount)
FROM public.payment
GROUP BY customer_id
HAVING SUM(amount)>100;


--31) Na tabela payment, encontre os clientes que realizaram mais de 30 pagamentos. Mostre customer_id e a quantidade de pagamentos.
SELECT customer_id, COUNT(amount)
FROM public.payment
GROUP BY customer_id
HAVING COUNT(amount)>30;


--32) Relacione as tabelas customer e payment e mostre o nome, o sobrenome e o valor de cada pagamento realizado pelo cliente.
SELECT customer.first_name,customer.last_name,payment.amount
FROM public.payment
INNER JOIN customer ON payment.customer_id =  customer.customer_id;

--33) Relacione as tabelas customer, address e city e mostre o nome, o sobrenome e a cidade de cada cliente.
SELECT customer.first_name,customer.last_name,city.city
FROM public.customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id;

--34) Relacione as tabelas city e country e mostre o nome da cidade e o nome do país ao qual ela pertence.
SELECT city.city,country.country
FROM public.country
INNER JOIN city ON country.country_id = city.country_id;


--35) Relacione as tabelas necessárias para mostrar o título de cada filme e sua respectiva categoria.
SELECT film.title,category.name
FROM public.film_category
INNER JOIN film ON film_category.film_id = film.film_id
INNER JOIN category ON film_category.category_id = category.category_id;

--36) Relacione as tabelas film, film_actor e actor e mostre o título do filme, o nome e o sobrenome dos atores que participam de cada filme.
SELECT film.title,actor.first_name, actor.last_name
FROM public.film_actor
INNER JOIN film ON film_actor.film_id = film.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
ORDER BY title;

--37) Relacione as tabelas necessárias para descobrir quantos filmes existem em cada categoria.
SELECT category.name, COUNT(category.name) AS quantidade
FROM public.film_category
INNER JOIN film ON film_category.film_id = film.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

--38) Relacione as tabelas customer e payment e mostre o nome, o sobrenome, a quantidade de pagamentos e o total gasto por cada cliente. Ordene pelo total gasto do maior para o menor.
SELECT customer.first_name,customer.last_name, COUNT(payment.amount), SUM(payment.amount)
FROM public.payment
INNER JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY SUM DESC;

--39) Relacione as tabelas necessárias para descobrir quantos clientes existem em cada país.
SELECT country.country, COUNT (country.country)
FROM public.customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY country.country;

--40) Relacione as tabelas necessárias para descobrir quantas vezes cada filme foi alugado. Mostre o título e a quantidade de aluguéis e ordene do mais alugado para o menos alugado.
SELECT film.title, COUNT(rental.rental_id)
FROM public.rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY COUNT(rental.rental_id) DESC;

--41) Descubra qual filme possui a maior quantidade de aluguéis. Mostre o título e a quantidade de aluguéis.
SELECT film.title, COUNT (rental.rental_id)
FROM public.payment
INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY COUNT DESC
LIMIT 1;


--42) Descubra quantos aluguéis cada categoria possui e ordene da maior para a menor quantidade.
SELECT category.name, COUNT (rental.rental_id)
FROM public.payment
INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY COUNT DESC;

--43) Descubra quanto cada cliente gastou no total. Mostre o nome, o sobrenome e o total gasto e ordene do maior para o menor.
SELECT customer.first_name, customer.last_name, SUM(payment.amount)
FROM public.customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY SUM DESC;

--44) Utilizando a tabela staff e as tabelas necessárias, descubra quantos pagamentos cada funcionário registrou.
SELECT staff.username, COUNT(payment.payment_id)
FROM public.staff
INNER JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.username;

--45) Descubra qual cidade possui a maior quantidade de clientes. Mostre a cidade e a quantidade de clientes.
SELECT city.city, COUNT(address.city_id)
FROM public.customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
GROUP BY city.city_id
ORDER BY COUNT DESC
LIMIT 1;

--46) Para cada categoria, mostre o nome da categoria, a quantidade de filmes e a duração média dos filmes. Ordene pela duração média da maior para a menor.
SELECT category.name, COUNT(category.category_id), ROUND(AVG(film.length),2)
FROM public.film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY round DESC;

--47) Para cada cidade, mostre a quantidade de clientes e o valor total gasto pelos clientes daquela cidade. Ordene pelo valor total gasto.
SELECT city.city, COUNT(customer.customer_id), ROUND(SUM(payment.amount),2)
FROM public.payment
INNER JOIN customer ON payment.customer_id = customer.customer_id
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
GROUP BY city.city_id
ORDER BY ROUND;


--48) Para cada categoria, descubra a quantidade de filmes, a quantidade de aluguéis e o valor total gerado pelos aluguéis. Será necessário relacionar várias tabelas.
SELECT category.name, COUNT(DISTINCT film.film_id) AS quantidade_filmes, COUNT(rental.rental_id) AS quantidade_alugueis, ROUND(SUM(payment.amount), 2) AS valor_total
FROM public.category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN film ON film_category.film_id = film.film_id
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name;


--49) Para cada cliente, mostre o nome, o sobrenome, a cidade, o país e o total gasto. Ordene pelo total gasto em ordem decrescente.
SELECT customer.first_name, customer.last_name, city.city, country.country, ROUND(SUM(payment.amount),2)
FROM public.payment
INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN customer ON rental.customer_id = customer.customer_id
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY customer.customer_id,city.city,country.country
ORDER BY ROUND DESC;

--50) Descubra os 10 filmes mais alugados e quanto de dinheiro foi gerado pelos aluguéis desses filmes. O resultado deve mostrar o título do filme, a quantidade de aluguéis e a receita total, ordenando pelos filmes com maior quantidade de aluguéis.
SELECT film.title, COUNT(payment.rental_id), SUM(payment.amount)
FROM payment
INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY COUNT DESC
LIMIT 10;