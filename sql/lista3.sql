--1) Selecione o título e a duração de todos os filmes com duração maior que 120 minutos, ordenando do mais longo para o mais curto.
SELECT film.title, film.length 
FROM public.film
WHERE film.length >120
ORDER BY length DESC;

--2) Exiba o nome completo de cada cliente e o nome da cidade onde ele mora.
SELECT CONCAT(customer.first_name,' ', customer.last_name) AS nome_completo, city.city
FROM public.city
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON address.address_id = customer.address_id;

--3) Conte quantos filmes existem em cada classificação, exibindo apenas as classificações com mais de 150 filmes.
SELECT film.rating, COUNT(film.rating) AS quantidade
FROM public.film
GROUP BY film.rating
HAVING COUNT(film.rating) > 150;

--4) Exiba o nome completo de cada cliente e o total gasto em pagamentos. Mostre apenas os clientes que gastaram mais de 100.
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS nome_completo, SUM(payment.amount)
FROM public.customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING SUM(payment.amount) > 100;

--5) Classifique os filmes em três categorias: 'Curto' para filmes com menos de 60 minutos, 'Médio' para filmes de 60 a 120 minutos e 'Longo' para filmes com mais de 120 minutos.
SELECT film.title,
CASE 
	WHEN film.length < 60 THEN 'curto'
	WHEN film.length >=60 AND film.length <=120 THEN 'medio'
	ELSE 'longo'
 END duracao
FROM public.film;

--6) Selecione os filmes cuja duração seja maior que a duração média de todos os filmes.
WITH filme AS (
	SELECT AVG(film.length) AS duracao
	FROM public.film
	
)

SELECT film.title, film.length
FROM public.film
WHERE film.length>(
	SELECT duracao
	FROM filme
);

--7) Encontre os clientes que possuem pelo menos um pagamento registrado.
SELECT DISTINCT(CONCAT(customer.first_name,' ', customer.last_name)) AS nome_completo
FROM public.payment
INNER JOIN customer ON payment.customer_id = customer.customer_id;

--8) Exiba o nome completo dos clientes e o total pago por cada um, mostrando somente aqueles cujo total seja maior que 150.
SELECT (CONCAT(customer.first_name,' ', customer.last_name)) AS nome_completo, SUM(payment.amount) AS valor_total
FROM public.payment
INNER JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id
HAVING SUM(payment.amount) > 150;

--9) Exiba os títulos dos filmes em letras maiúsculas e a quantidade de caracteres de cada título.
SELECT UPPER(film.title), LENGTH(film.title)
FROM public.film;

--10) Selecione os pagamentos realizados entre 1 e 15 de fevereiro de 2007, incluindo todo o dia 15. Ordene pela data do pagamento.
SELECT *
FROM public.payment
WHERE payment_date >= '2007-02-01' AND payment_date < '2007-02-16'
ORDER BY payment_date;

--11) Exiba cada pagamento com seu valor e o total gasto pelo respectivo cliente, mantendo todas as linhas do resultado.
SELECT payment.payment_id, payment.amount, SUM(payment.amount) OVER(PARTITION BY payment.customer_id) AS valor_total
FROM public.payment;

--12) Numere os pagamentos de cada cliente em ordem crescente de data do pagamento.
SELECT payment.payment_id, payment.customer_id, payment.amount, ROW_NUMBER() OVER( PARTITION BY payment.customer_id ORDER BY payment.payment_date ASC) AS numero_pagamento
FROM public.payment
ORDER BY payment.customer_id, numero_pagamento;

--13) Classifique os pagamentos de cada cliente do maior para o menor valor. Exiba payment_id, customer_id, amount e a posição no ranking.
SELECT payment.payment_id, payment.customer_id, payment.amount, RANK() OVER(PARTITION BY payment.customer_id ORDER BY payment.amount DESC) AS ranking
FROM public.payment
ORDER BY payment.customer_id, ranking;

--14) Combine os primeiros nomes dos clientes e dos funcionários, mantendo as duplicatas.
SELECT customer.first_name
FROM public.customer

UNION ALL

SELECT staff.first_name
FROM public.staff;

--15) Encontre os primeiros nomes que aparecem tanto entre os clientes quanto entre os funcionários.
SELECT first_name
FROM public.customer
INTERSECT
SELECT first_name
FROM public.staff;

--16) Encontre os primeiros nomes que aparecem entre os clientes, mas não aparecem entre os funcionários.
SELECT first_name
FROM public.customer
EXCEPT
SELECT first_name
FROM public.staff;

--17) Exiba first_name, last_name e email dos clientes, substituindo emails NULL por 'Sem email'.
SELECT customer.first_name, customer.last_name, COALESCE(customer.email,'Sem email')
FROM public.customer;

--18) Conte quantos clientes possuem email preenchido e quantos possuem email NULL, exibindo os resultados em colunas separadas.
SELECT SUM(CASE WHEN customer.email IS NULL THEN 1 ELSE 0 END) AS sem_email, SUM(CASE WHEN customer.email IS NOT NULL THEN 1 ELSE 0 END) AS tem_email
FROM public.customer;

--19) Crie uma VIEW chamada view_filmes_longos contendo film_id, title e length dos filmes com duração superior a 120 minutos.
CREATE VIEW view_filmes_longos AS (
	SELECT film.film_id, film.title, film.length
	FROM public.film
	WHERE film.length > 120
);

--20) Consulte a VIEW view_filmes_longos e exiba apenas os filmes com duração superior a 150 minutos.
SELECT *
FROM public.view_filmes_longos
WHERE view_filmes_longos.length > 150;

--21) Crie um índice chamado idx_rental_customer_id na coluna customer_id da tabela rental.
CREATE INDEX idx_rental_customer_id 
ON public.rental(customer_id);

--22) Analise o plano de execução de uma consulta que seleciona os pagamentos do cliente cujo customer_id seja 5.
EXPLAIN
SELECT *
FROM public.payment
WHERE payment.customer_id = 5;

--23) Inicie uma transação, atualize o email do cliente cujo customer_id seja 3 para '[cliente3@exemplo.com](mailto:cliente3@exemplo.com)' e desfaça a alteração.
BEGIN;

UPDATE public.customer
SET email = 'cliente3@exemplo.com'
WHERE customer.customer_id = 3;


ROLLBACK;

--24) Inicie uma transação, crie um ponto de salvamento chamado ponto_seguro, atualize o email do cliente cujo customer_id seja 4 para '[cliente4@exemplo.com](mailto:cliente4@exemplo.com)', desfaça essa atualização a partir do ponto de salvamento e finalize a transação.
BEGIN;

SAVEPOINT ponto_seguro;

UPDATE public.customer
SET email = 'cliente4@exemplo.com'
WHERE customer.customer_id = 4;

ROLLBACK TO SAVEPOINT ponto_seguro;

COMMIT;

--25) Conte quantas vezes cada filme foi alugado. Exiba somente os filmes alugados mais de 20 vezes, ordenando pela quantidade de aluguéis em ordem decrescente.
SELECT film.title, COUNT(rental.rental_id) AS quantidade_alugueis
FROM public.rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.film_id, film.title
HAVING COUNT(rental.rental_id) > 20
ORDER BY quantidade_alugueis DESC;


--26) Exiba os pagamentos realizados há mais de seis meses em relação à data atual.
SELECT *
FROM public.payment
WHERE payment.payment_date < (CURRENT_DATE - INTERVAL '6 MONTH');

--27) Substitua os espaços dos títulos dos filmes por sublinhados e exiba somente os títulos que contenham a letra 'A', independentemente de ser maiúscula ou minúscula.
SELECT REPLACE(film.title, ' ','_')
FROM public.film
WHERE film.title ILIKE '%a%';

--28) Calcule a média de duração dos filmes por classificação e exiba somente as classificações cuja duração média seja maior que 100 minutos.
SELECT film.rating, ROUND(AVG(film.length),2)
FROM public.film
GROUP BY film.rating
HAVING AVG(film.length) > 100;

--29) Exiba cada pagamento com o valor acumulado dos pagamentos de cada cliente em ordem cronológica.
SELECT payment.amount, SUM(payment.amount) OVER(PARTITION BY payment.customer_id ORDER BY payment.payment_date)
FROM public.payment; 

--30) Crie um índice chamado idx_customer_email na coluna email da tabela customer e, em seguida, remova esse índice.
CREATE INDEX idx_customer_email
ON public.customer(email);


DROP INDEX idx_customer_email;