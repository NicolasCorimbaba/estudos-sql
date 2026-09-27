--1)Selecione os atributos nome e microregião da tabela rs_cidades e nome e tipo da tabela rs_sistema_viario
SELECT rs_cidades.nome, rs_cidades.microregiao, rs_sistema_viario.nome, rs_sistema_viario.tipo
FROM rs_cidades
INNER JOIN rs_sistema_viario ON  rs_sistema_viario.gid_rs_cidades = rs_cidades.gid;


--2)Selecione os atributos nome e microregião da tabela rs_cidades e nome e tipo da tabela rs_sistema_viario cujo tipo seja Estrada Municipal sem pavimentação.
SELECT rs_cidades.nome, rs_cidades.microregiao, rs_sistema_viario.nome, rs_sistema_viario.tipo
FROM rs_cidades
INNER JOIN rs_sistema_viario ON  rs_sistema_viario.gid_rs_cidades = rs_cidades.gid
WHERE tipo = 'Estrada Municipal sem pavimentacao';


--3)Selecione os atributos nome e microregião da tabela rs_cidades e nome e tipo da tabela rs_sistema_viario cujo tipo seja Estrada Municipal sem pavimentação e cuja resgião seja SUDOESTE RIO-GRANDENSE;
SELECT rs_cidades.nome, rs_cidades.microregiao, rs_sistema_viario.nome, rs_sistema_viario.tipo
FROM rs_cidades
INNER JOIN rs_sistema_viario ON  rs_sistema_viario.gid_rs_cidades = rs_cidades.gid
WHERE tipo = 'Estrada Municipal sem pavimentacao' AND microregiao ='SUDOESTE RIO-GRANDENSE';


--4)Selecione os atributos nome e microregiao da tabela rs_cidades e nome e tipo da tabela rs_hidrografia
SELECT rs_cidades.nome, rs_cidades.microregiao, rs_hidrografia.nome, rs_hidrografia.tipo
FROM rs_cidades
INNER JOIN rs_hidrografia ON rs_hidrografia.gid_rs_cidades = rs_cidades.gid;


--5)Selecione os atributos nome e microregiao da tabela rs_cidade e nome e tipo da tabela rs_hidrografia e cujo tipo seja Perene
SELECT rs_cidades.nome, rs_cidades.microregiao, rs_hidrografia.nome, rs_hidrografia.tipo
FROM rs_cidades
INNER JOIN rs_hidrografia ON rs_hidrografia.gid_rs_cidades = rs_cidades.gid
WHERE tipo ='Perene';

--6)Selecione os atributos nome e microregiao da tabela rs_cidades e nome e tipo da tabela rs_hidrografia e cujo o tipo seja Perene e da microregiao NOROESTE RIO-GRANDENSE
SELECT rs_cidades.nome, rs_cidades.microregiao, rs_hidrografia.nome, rs_hidrografia.tipo
FROM rs_cidades
INNER JOIN rs_hidrografia ON rs_hidrografia.gid_rs_cidades = rs_cidades.gid
WHERE tipo ='Perene' AND microregiao = 'NOROESTE RIO-GRANDENSE';


--7)Selecione os atributos nome e microregiao da tabela rs_cidade e codigo e tipo da tabela rs_curvas
SELECT rs_cidades.nome, rs_cidades.microregiao, rs_curvas.codigo, rs_curvas.tipo
FROM rs_cidades
INNER JOIN rs_curvas ON rs_curvas.gid_rs_cidades = rs_cidades.gid;


--8)Selecione os atributos nome e microregiao da tabela rs_cidade e codigo e tipo da tabela rs_curvas cuja microregiao seja SUDOESTE RIO-GRANDENSE
SELECT rs_cidades.nome, rs_cidades.microregiao, rs_curvas.codigo, rs_curvas.tipo
FROM rs_cidades
INNER JOIN rs_curvas ON rs_curvas.gid_rs_cidades = rs_cidades.gid
WHERE microregiao= 'SUDOESTE RIO-GRANDENSE';


--9)Selecione os atributos nome e microregião da tabela rs_cidades, código e tipo da tabela rs_curvas, nome e tipo da tabela rs_sistema_viario e nome e tipo da tabela rs_hidrografia.
SELECT rs_cidades.nome, rs_cidades.microregiao, rs_curvas.codigo, rs_curvas.tipo, rs_sistema_viario.tipo, rs_sistema_viario.nome, rs_hidrografia.tipo, rs_hidrografia.nome
FROM rs_cidades
INNER JOIN rs_curvas ON rs_curvas.gid_rs_cidades = rs_cidades.gid
INNER JOIN rs_hidrografia ON rs_hidrografia.gid_rs_cidades = rs_cidades.gid
INNER JOIN rs_sistema_viario ON rs_sistema_viario.gid_rs_cidades = rs_cidades.gid