--1)Selecione os atributos nome e sigla da tabela da tabela Pais, nome e sigla da tabela UF
SELECT pais.id_pais,pais.nome, pais.sigla, uf.nome,uf.sigla
FROM public.uf
INNER JOIN pais ON uf.id_pais = pais.id_pais;


--2)Selecione os atributos nome e sigla da tabela UF e nome e tam_pop da tabela cidade
SELECT uf.nome,uf.sigla,cidade.nome,cidade.tam_pop
FROM public.uf
INNER JOIN cidade ON uf.id_uf = cidade.id_uf;


--3)Selecione os atributos nome e sigla da tabela UF e nome e tam_pop da tabela cidade, que tenham populção menor que 400 e sejam do RS
SELECT uf.nome,uf.sigla,cidade.nome,cidade.tam_pop
FROM public.uf
INNER JOIN cidade ON uf.id_uf = cidade.id_uf
WHERE tam_pop <400 AND sigla='RS';


--4)Selecione os atributos nome e sigla da tabela UF e nome e tipo_capital da tabela Capital 
SELECT uf.nome,uf.sigla,capital.nome,capital.tipo_capital
FROM public.uf
INNER JOIN capital ON uf.id_uf = capital.id_uf; 


--5)Selecione os atributos nome e sigla da tabela UF e nome e tipo_capital da tabela Capital e que o tipo da capital seja Federal
SELECT uf.nome,uf.sigla,capital.nome,capital.tipo_capital
FROM public.uf
INNER JOIN capital ON uf.id_uf = capital.id_uf
WHERE capital.tipo_capital = 'Federal';


--6)Selecione os atributos nome e sigla da tabela UF e nome e tipo_capital da tabela Capital e nome e tam_pop da tabela da cidade somente do RS
SELECT uf.nome,uf.sigla,capital.nome,capital.tipo_capital, cidade.nome,cidade.tam_pop
FROM public.uf
INNER JOIN capital ON uf.id_uf = capital.id_uf
INNER JOIN cidade ON uf.id_uf = cidade.id_uf
WHERE uf.sigla = 'RS';

--7)Selecione os atributos nome e sigla da tabela Pais, nome e sigla da tabela UF e nome e tipo_capital da tabela Capital somente do RS
SELECT pais.nome, pais.sigla, uf.nome,uf.sigla,capital.nome,capital.tipo_capital
FROM public.uf
INNER JOIN capital ON uf.id_uf = capital.id_uf
INNER JOIN pais ON uf.id_pais = pais.id_pais
WHERE uf.sigla = 'RS';
