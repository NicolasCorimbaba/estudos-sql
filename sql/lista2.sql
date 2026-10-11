--1) Na tabela film, selecione os atributos title, length e crie uma classificação para a duração dos filmes:
--   filmes com duração menor que 60 minutos devem ser classificados como "Curto";
--   filmes com duração entre 60 e 120 minutos devem ser classificados como "Médio";
--   filmes com duração maior que 120 minutos devem ser classificados como "Longo".
SELECT film.title,
CASE
	WHEN length <60 THEN 'curto'
	WHEN length >=60 AND length <=120 THEN 'medio'
	ELSE 'longo'
END classificacao
FROM public.film;


--2) Na tabela customer, selecione os atributos first_name, last_name e active e crie uma nova coluna chamada status:
--   clientes com active igual a 1 devem ser classificados como "Ativo";
--   clientes com active igual a 0 devem ser classificados como "Inativo".
SELECT customer.first_name, customer.last_name, customer.active,
CASE
	WHEN active = '1' THEN 'ativo'
	ELSE 'inativo'
END status
FROM public.customer;


--3) Na tabela payment, selecione os atributos customer_id, amount e crie uma classificação para o valor dos pagamentos:
--   pagamentos menores que 2 devem ser classificados como "Baixo";
--   pagamentos entre 2 e 5 devem ser classificados como "Médio";
--   pagamentos maiores que 5 devem ser classificados como "Alto".
SELECT payment.customer_id, payment.amount, 
CASE
	WHEN amount < 2 THEN 'baixo'
	WHEN amount >=2 AND amount <=5 THEN 'medio'
	ELSE 'alto'
END classificacao
FROM public.payment;

--4) Na tabela film, selecione os atributos title, rating e crie uma nova coluna chamada classificacao:
--   filmes com rating G devem ser classificados como "Livre";
--   filmes com rating PG ou PG-13 devem ser classificados como "Adolescente";
--   filmes com rating R ou NC-17 devem ser classificados como "Adulto".
SELECT film.title, film.rating,
CASE 
	WHEN rating = 'G' THEN 'livre'
	WHEN rating = 'PG' OR rating = 'PG-13' THEN 'adolescentes'
	ELSE 'Adulto'
END classificacao
FROM public.film;


--5) Na tabela film, selecione os atributos title, length e rating e crie uma nova coluna chamada classificacao:
--   filmes com duração maior que 120 minutos e rating R ou NC-17 devem ser classificados como "Longo para adultos";
--   filmes com duração maior que 120 minutos devem ser classificados como "Longo";
--   filmes com duração entre 60 e 120 minutos devem ser classificados como "Médio";
--   os demais filmes devem ser classificados como "Curto".
SELECT film.title, film.length, film.rating,
CASE 
	WHEN length > 120 AND rating ='R' OR rating = 'NC-17' THEN 'longo para adultos'
	WHEN length > 120 THEN 'Longo'
	WHEN length >=60 AND  length <=120 THEN 'medio'
	ELSE 'curto'
END classificacao
FROM public.film;

--6) Na tabela film, selecione os atributos title e length dos filmes que possuem duração maior que a duração média de todos os filmes.
SELECT film.title, film.length
FROM public.film
WHERE film.length > (
	SELECT AVG (film.length)
	FROM public.film
);

--7) Na tabela payment, selecione os atributos payment_id, customer_id e amount dos pagamentos que possuem valor maior que o valor médio de todos os pagamentos.
SELECT payment.payment_id, payment.customer_id, payment.amount
FROM public.payment
WHERE payment.amount > (
	SELECT AVG(payment.amount)
	FROM public.payment
);

--8) Na tabela film, selecione os atributos title e rental_rate dos filmes que possuem rental_rate igual ao maior rental_rate encontrado na tabela.
SELECT film.title, film.rental_rate
FROM public.film
WHERE film.rental_rate = (
	SELECT (film.rental_rate)
	FROM public.film
	ORDER BY rental_rate DESC
	LIMIT 1
);

--9) Na tabela customer, selecione os atributos customer_id, first_name e last_name dos clientes que realizaram pelo menos um pagamento com valor superior a 10.
SELECT customer.customer_id, customer.first_name, customer.last_name
FROM public.customer
WHERE EXISTS (
    SELECT 1
    FROM public.payment
    WHERE payment.customer_id = customer.customer_id
      AND payment.amount > 10
);

--10) Na tabela film, selecione os atributos title e length dos filmes que possuem duração maior que a duração média dos filmes da categoria "Action".
SELECT film.title, film.length
FROM public.film
WHERE film.length > (
    SELECT AVG(film.length)
    FROM public.film
    INNER JOIN public.film_category
        ON film.film_id = film_category.film_id
    INNER JOIN public.category
        ON film_category.category_id = category.category_id
    WHERE category.name = 'Action'
);
--11) Na tabela payment, crie uma CTE para calcular o valor total gasto por cada cliente. Depois, mostre o customer_id e o total gasto dos clientes que gastaram mais de 100.
WITH pagamento AS (
	SELECT customer_id, SUM(payment.amount) as valor
	FROM public.payment
	GROUP BY payment.customer_id
)

SELECT customer_id, valor
FROM pagamento
WHERE valor >100;

--12) Na tabela film, crie uma CTE para calcular a duração média de todos os filmes. Depois, mostre o título e a duração dos filmes que possuem duração maior que essa média.
WITH filmes AS(
	SELECT AVG(film.length) as duracao
	FROM public.film
)

SELECT film.title, film.length
FROM public.film
WHERE film.length >(
	SELECT duracao
	FROM filmes 
);


--13) Relacione as tabelas rental, inventory e film e crie uma CTE para calcular quantas vezes cada filme foi alugado. Depois, mostre o título e a quantidade de aluguéis dos filmes que foram alugados mais de 20 vezes.
WITH aluguel AS (
	SELECT film.title, COUNT(inventory.film_id) as quantidade
	FROM public.rental
	INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
	INNER JOIN film ON inventory.film_id = film.film_id
	GROUP BY film.title
)

SELECT title, quantidade
FROM aluguel
WHERE quantidade > 20;

--14) Relacione as tabelas customer, address e city e crie uma CTE para calcular a quantidade de clientes de cada cidade. Depois, mostre as cidades que possuem mais de 10 clientes.
WITH cliente AS (
    SELECT city.city_id, city.city, COUNT(customer.customer_id) AS quantidade
    FROM public.customer
    INNER JOIN address ON customer.address_id = address.address_id
    INNER JOIN city ON address.city_id = city.city_id
    GROUP BY city.city_id, city.city
	ORDER BY quantidade DESC
)
SELECT city, quantidade
FROM cliente
WHERE quantidade > 10;

--15) Relacione as tabelas necessárias e crie uma CTE para calcular o valor total gasto por cada cliente. Depois, utilize essa CTE para mostrar o nome, sobrenome e total gasto dos 10 clientes que mais gastaram.
WITH cliente AS (
	SELECT payment.customer_id, SUM(payment.amount) AS valor
	FROM public.payment
	GROUP BY payment.customer_id
	ORDER BY valor DESC
	LIMIT 10
)

SELECT customer.first_name, customer.last_name, cliente.valor
FROM public.customer
INNER JOIN cliente ON customer.customer_id = cliente.customer_id;

--16) Na tabela customer, selecione os atributos first_name e last_name e mostre também o nome e o sobrenome dos clientes em letras maiúsculas.
SELECT customer.first_name, customer.last_name, UPPER(customer.first_name) AS nome_maiusculo, UPPER(customer.last_name) AS sobrenome_maiusculo
FROM public.customer;
 
--17) Na tabela customer, selecione os atributos first_name e last_name e mostre também a quantidade de caracteres de cada nome.
SELECT customer.first_name, customer.last_name, LENGTH(customer.first_name) AS quantidade_nome, LENGTH(customer.last_name) AS quantidade_sobrenome
FROM public.customer;
 
--18) Na tabela film, selecione o atributo title e crie uma nova coluna que mostre o título dos filmes em letras minúsculas.
SELECT film.title, LOWER(film.title)
FROM public.film;
 
--19) Na tabela customer, selecione first_name e last_name e crie uma nova coluna chamada nome_completo, juntando o nome e o sobrenome em uma única coluna.
SELECT customer.first_name, customer.last_name, CONCAT(customer.first_name,' ', customer.last_name) AS nome_completo
FROM public.customer;
 
--20) Na tabela film, selecione title e description e crie uma nova coluna chamada descricao_sem_espacos, removendo os espaços existentes no início e no final da descrição.
SELECT film.title, film.description, TRIM(film.description) AS descricao_sem_espacos
FROM public.film;

--21) Na tabela customer, selecione o atributo first_name e crie uma nova coluna chamada primeiros_3_caracteres contendo somente os 3 primeiros caracteres do nome.
SELECT customer.first_name, SUBSTRING(customer.first_name FROM 1 FOR 3) AS primeiros_3_caracteres
FROM public.customer;

--22) Na tabela film, selecione o atributo title e mostre somente os filmes cujo título começa com a letra "A", utilizando LIKE.
SELECT film.title
FROM public.film
WHERE film.title LIKE  'A%';

--23) Na tabela film, selecione o atributo title e mostre somente os filmes que possuem a palavra "LOVE" em qualquer parte do título, utilizando ILIKE.
SELECT film.title
FROM public.film
WHERE film.title ILIKE '%love%';

--24) Na tabela film, selecione o atributo title e crie uma nova coluna chamada titulo_sem_espacos, substituindo todos os espaços do título pelo caractere "_". Mostre também somente os filmes que possuem a letra "A" no título.
SELECT film.title, REPLACE(film.title, ' ', '_') AS titulo_sem_espacos
FROM public.film
WHERE film.title LIKE '%A%';

--25) Na tabela customer, selecione first_name e last_name e crie uma nova coluna chamada identificacao contendo os 3 primeiros caracteres do primeiro nome e os 3 primeiros caracteres do sobrenome, todos em letras maiúsculas. Mostre somente os clientes cujo primeiro nome começa com a letra "J", utilizando ILIKE.
SELECT customer.first_name, customer.last_name, UPPER(CONCAT(SUBSTRING(customer.first_name FROM 1 FOR 3),' ',SUBSTRING(customer.last_name FROM 1 FOR 3))) AS identificacao
FROM public.customer
WHERE customer.first_name ILIKE 'j%';

--26) Na tabela payment, selecione payment_id e payment_date e crie uma nova coluna chamada ano, mostrando somente o ano da data do pagamento.
SELECT payment.payment_id, payment.payment_date, EXTRACT (year FROM payment_date) AS ano
FROM public.payment;

--27) Na tabela payment, selecione payment_id e payment_date e crie uma nova coluna chamada mes, mostrando somente o mês da data do pagamento.
SELECT payment.payment_id, payment.payment_date, EXTRACT(month FROM payment_date)
FROM public.payment;

--28) Na tabela payment, mostre a quantidade de pagamentos realizados em cada ano. Mostre o ano e a quantidade de pagamentos, ordenando pelo ano.
SELECT EXTRACT(year FROM payment_date), COUNT(EXTRACT(year FROM payment_date))
FROM public.payment
GROUP BY EXTRACT(year FROM payment_date)
ORDER BY EXTRACT;

--29) Na tabela payment, mostre a quantidade de pagamentos realizados em cada mês do ano de 2007. Mostre o mês e a quantidade de pagamentos, ordenando pelo mês.
SELECT EXTRACT(month FROM payment_date), COUNT(EXTRACT(month FROM payment_date))
FROM public.payment
WHERE EXTRACT(year FROM payment_date) =2007
GROUP BY EXTRACT(month FROM payment_date)
ORDER BY EXTRACT;

--30) Na tabela payment, mostre os pagamentos realizados depois de 15 de fevereiro de 2007. Mostre payment_id, amount e payment_date e ordene pela data do pagamento.
SELECT payment.payment_id, payment.amount, payment.payment_date
FROM public.payment
WHERE payment.payment_date > '2007-02-15'
ORDER BY payment.payment_date;

--31) Na tabela payment, selecione payment_id e payment_date e crie uma nova coluna chamada tempo_desde_pagamento mostrando quanto tempo se passou desde cada pagamento até a data atual, utilizando AGE().
SELECT payment.payment_id, payment.payment_date, AGE(CURRENT_DATE, payment.payment_date) AS tempo_desde_pagamento
FROM public.payment;

--32) Na tabela payment, selecione payment_id, payment_date e amount e mostre somente os pagamentos realizados há mais de 6 meses em relação à data atual.
SELECT payment.payment_id, payment.payment_date, payment.amount
FROM public.payment
WHERE payment.payment_date < CURRENT_DATE - INTERVAL '6 months';

--33) Na tabela payment, selecione payment_id e payment_date e crie uma nova coluna chamada data_30_dias_depois, mostrando qual seria a data 30 dias após cada pagamento.
SELECT payment.payment_id, payment.payment_date, (payment.payment_date + INTERVAL '30 day') AS data_30_dias_depois
FROM public.payment;

--34) Na tabela payment, selecione payment_id e payment_date e crie uma nova coluna chamada data_30_dias_antes, mostrando qual seria a data 30 dias antes de cada pagamento.
SELECT payment.payment_id, payment.payment_date, (payment.payment_date - INTERVAL '30 day') AS data_30_dias_antes
FROM public.payment;

--35) Na tabela payment, selecione payment_id, payment_date e amount e mostre os pagamentos realizados entre 1º de fevereiro de 2007 e 15 de fevereiro de 2007. Ordene os resultados pela data do pagamento.
SELECT payment.payment_id, payment.payment_date, payment.amount
FROM public.payment
WHERE payment.payment_date >= '2007-02-01' AND payment.payment_date < '2007-02-16'
ORDER BY payment.payment_date;

--36) Na tabela payment, selecione customer_id e amount e crie uma nova coluna chamada total_geral mostrando o valor total de todos os pagamentos. Utilize uma Window Function.
SELECT payment.customer_id, payment.amount, 
	SUM(payment.amount) OVER() AS total_geral
FROM public.payment;

--37) Na tabela payment, selecione customer_id e amount e crie uma nova coluna chamada total_cliente mostrando o valor total gasto por cada cliente, sem reduzir a quantidade de linhas da tabela.
SELECT  payment.customer_id,payment.amount,
    SUM(payment.amount) OVER(PARTITION BY payment.customer_id) AS valor_total
FROM public.payment
ORDER BY payment.customer_id;

--38) Na tabela payment, selecione customer_id e amount e crie uma nova coluna chamada media_cliente mostrando o valor médio dos pagamentos de cada cliente, sem reduzir a quantidade de linhas da tabela.
SELECT payment.customer_id, payment.amount,
	ROUND(AVG(payment.amount) OVER(PARTITION BY payment.customer_id),2) AS media_cliente
FROM public.payment;


--39) Na tabela payment, selecione payment_id, customer_id e amount e crie uma nova coluna chamada numero_pagamento mostrando a posição de cada pagamento dentro dos pagamentos realizados pelo respectivo cliente. Utilize ROW_NUMBER().
SELECT payment.payment_id, payment.customer_id, payment.amount,
	ROW_NUMBER() OVER(PARTITION BY payment.customer_id ORDER BY payment.payment_date) AS numero_pagamento
FROM public.payment;
--40) Na tabela payment, selecione payment_id, customer_id e amount e crie uma nova coluna chamada ranking_valor mostrando a posição dos pagamentos de cada cliente de acordo com o valor do pagamento, do maior para o menor. Utilize RANK() e PARTITION BY.
SELECT payment.payment_id, payment.customer_id, payment.amount,
    RANK() OVER (PARTITION BY payment.customer_id ORDER BY payment.amount DESC) AS ranking_valor
FROM public.payment
ORDER BY payment.customer_id, ranking_valor;

--41) Na tabela customer, selecione first_name de todos os clientes e combine esse resultado com first_name de todos os funcionários da tabela staff, utilizando UNION. Mostre uma única coluna chamada nome.
SELECT customer.first_name AS nome
FROM public.customer 

UNION

SELECT staff.first_name AS nome
FROM public.staff;


--42) Repita a questão anterior, mas utilize UNION ALL. Observe a diferença na quantidade de linhas em relação ao UNION.
SELECT customer.first_name AS nome
FROM public.customer 

UNION ALL

SELECT staff.first_name AS nome
FROM public.staff;


--43) Utilizando as tabelas customer e staff, encontre os primeiros nomes que aparecem tanto entre os clientes quanto entre os funcionários. Utilize INTERSECT.
SELECT customer.first_name AS nome
FROM public.customer 

INTERSECT

SELECT staff.first_name AS nome
FROM public.staff;


--44) Utilizando as tabelas customer e staff, mostre os primeiros nomes que aparecem entre os clientes, mas não aparecem entre os funcionários. Utilize EXCEPT.
SELECT customer.first_name AS nome
FROM public.customer 

EXCEPT

SELECT staff.first_name AS nome
FROM public.staff;


--45) Na tabela customer, combine os primeiros nomes dos clientes da loja 1 com os primeiros nomes dos clientes da loja 2, utilizando UNION. Mostre apenas nomes únicos no resultado.
SELECT customer.first_name AS nome
FROM public.customer
WHERE customer.store_id = 1

UNION

SELECT customer.first_name AS nome
FROM public.customer
WHERE customer.store_id = 2;

--46) Na tabela customer, selecione first_name, last_name e email dos clientes cujo email seja NULL.
SELECT customer.first_name, customer.last_name, customer.email
FROM public.customer
WHERE customer.email IS NULL;

--47) Na tabela customer, selecione first_name, last_name e email. Utilize COALESCE para mostrar 'Sem email' quando o email for NULL.
SELECT customer.first_name, customer.last_name, COALESCE(customer.email, 'Email não inforamdo')
FROM public.customer;

--48) Na tabela film, selecione title e original_language_id dos filmes cujo original_language_id seja NULL.
SELECT film.title, film.original_language_id
FROM public.film
WHERE film.original_language_id IS NULL;

--49) Na tabela film, selecione title e original_language_id. Utilize COALESCE para exibir 0 quando original_language_id for NULL.
SELECT film.title, COALESCE(film.original_language_id,0)
FROM public.film;


--50) Na tabela customer, conte quantos clientes possuem email preenchido e quantos não possuem email. Apresente os dois resultados em colunas separadas.
SELECT SUM(CASE WHEN customer.email IS NOT NULL THEN 1 ELSE 0 END) AS contas_com_email, SUM(CASE WHEN customer.email IS NULL THEN 1 ELSE 0 END) AS contas_sem_email
FROM public.customer;

--51) Crie uma VIEW chamada view_filmes_classificacao que exiba o título (title), a classificação (rating) e a duração (length) de todos os filmes da tabela film.
CREATE VIEW view_filmes_classificacao AS (
	SELECT film.title, film.rating, film.length
	FROM public.film
);


--52) Crie uma VIEW chamada view_pagamentos_altos que exiba payment_id, customer_id, amount e payment_date dos pagamentos cujo amount seja maior que 5.
CREATE VIEW view_pagamentos_altos AS (
	SELECT payment.payment_id, payment.customer_id, payment.amount, payment.payment_date
	FROM public.payment
	WHERE payment.amount >5
);


--53) Crie uma VIEW chamada view_clientes_ativos que exiba customer_id, first_name, last_name e email dos clientes ativos. Considere que a coluna active vale 1 para clientes ativos.
CREATE VIEW view_clientes_ativos AS (
    SELECT customer.customer_id, customer.first_name,customer.last_name, customer.email
    FROM public.customer
    WHERE customer.active = 1
);


--54) Utilizando a VIEW view_filmes_classificacao criada na questão 51, consulte os filmes cuja classificação seja 'PG-13'.
SELECT *
FROM public.view_filmes_classificacao
WHERE View_filmes_classificacao.rating = 'PG-13';


--55) Remova a VIEW view_pagamentos_altos criada na questão 52.
DROP VIEW view_pagamentos_altos;

--56) Crie um índice chamado idx_payment_customer_id na coluna customer_id da tabela payment.
CREATE INDEX idx_payment_customer_id
ON public.payment (customer_id);


--57) Crie um índice chamado idx_payment_payment_date na coluna payment_date da tabela payment.
CREATE INDEX idx_payment_payment_date
ON public.payment (payment_date);


--58) Crie um índice chamado idx_film_title na coluna title da tabela film.
CREATE INDEX idx_film_title
ON public.film (title);


--59) Utilize EXPLAIN para analisar o plano de execução de uma consulta que seleciona todos os pagamentos cujo customer_id seja igual a 10. Não crie um novo índice nesta questão.
EXPLAIN
SELECT payment.customer_id, payment.amount
FROM public.payment
WHERE payment.customer_id = 10;


--60) Remova o índice idx_film_title criado na questão 58.
DROP INDEX idx_film_title;

--61) Inicie uma transação utilizando BEGIN. Dentro dela, consulte os pagamentos da tabela payment cujo amount seja maior que 10. Finalize a transação com COMMIT.
BEGIN;
SELECT payment.amount
FROM public.payment
WHERE payment.amount > 10;


COMMIT;


--62) Inicie uma transação e atualize o valor amount para 10.00 do pagamento cujo payment_id seja 1. Depois, desfaça a alteração utilizando ROLLBACK.
BEGIN;

UPDATE public.payment
SET amount = 10.00
WHERE payment.payment_id = 1;


ROLLBACK;


--63) Inicie uma transação e altere o email do cliente cujo customer_id seja 1 para 'teste@exemplo.com'. Confirme a alteração com COMMIT.
BEGIN;

UPDATE public.customer
SET email = 'teste@exemplo.com'
WHERE customer_id = 1;

COMMIT;


--64) Inicie uma transação e exclua o pagamento cujo payment_id seja 1. Antes de finalizar, desfaça a exclusão com ROLLBACK.
BEGIN;

DELETE FROM public.payment
WHERE payment_id = 1;


ROLLBACK;


--65) Inicie uma transação e crie um SAVEPOINT chamado ponto_seguro. Depois, atualize o email do cliente cujo customer_id seja 2 para 'teste2@exemplo.com'. Utilize ROLLBACK TO SAVEPOINT para desfazer essa atualização e finalize a transação com COMMIT.
BEGIN;

SAVEPOINT ponto_seguro;

UPDATE public.customer
SET email = 'teste2@exemplo.com'
WHERE customer_id = 2;

ROLLBACK TO SAVEPOINT ponto_seguro;

COMMIT;