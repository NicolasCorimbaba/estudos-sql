# 📊 Exercícios de SQL — PostgreSQL

Repositório dedicado à prática de SQL utilizando **PostgreSQL** e o banco de dados **Pagila**, um banco de dados de exemplo que simula o funcionamento de uma locadora de filmes.

O objetivo é consolidar os fundamentos de SQL, desenvolver a capacidade de consultar e manipular dados relacionais e praticar técnicas de análise de dados relevantes para a área de **Engenharia de Dados**.

## 📚 Conteúdos praticados

### 1. Consultas e filtros

* `SELECT` — seleção de colunas e recuperação de dados.
* `WHERE` — filtragem de registros.
* `LIKE` e `ILIKE` — busca por padrões de texto.
* `IN` e `BETWEEN` — filtragem por conjuntos de valores e intervalos.
* `DISTINCT` — eliminação de resultados duplicados.
* `ORDER BY` — ordenação dos resultados.
* `LIMIT` — limitação da quantidade de registros retornados.
* `CASE` — criação de condições dentro das consultas.
* `COALESCE` — tratamento de valores `NULL`.
* `REPLACE` — substituição de caracteres e trechos de texto.

### 2. Funções de agregação

* `COUNT()` — contagem de registros.
* `SUM()` — soma de valores.
* `AVG()` — cálculo de médias.
* `MIN()` e `MAX()` — identificação de valores mínimos e máximos.
* `COUNT(DISTINCT)` — contagem de valores únicos.

### 3. Agrupamento de dados

* `GROUP BY` — agrupamento de registros por critérios.
* `HAVING` — filtragem de grupos após a agregação.
* Combinação de agrupamentos com funções de agregação.
* Análise de quantidades, médias e valores financeiros por categoria.

### 4. Relacionamentos entre tabelas

* `INNER JOIN` — combinação de registros relacionados.
* Múltiplos `JOINs` em uma mesma consulta.
* Consultas envolvendo clientes, filmes, pagamentos, aluguéis e categorias.
* Utilização de chaves para relacionar informações de diferentes tabelas.

### 5. Subconsultas e CTEs

* Subconsultas em condições de filtragem.
* Comparação de valores com resultados de outras consultas.
* `WITH` — criação de expressões de tabela comuns (CTEs).
* Utilização de consultas auxiliares para organizar e estruturar instruções SQL.

### 6. Funções de janela

* `OVER()` — aplicação de funções sobre conjuntos de linhas relacionados.
* `PARTITION BY` — divisão dos dados em grupos para cálculos.
* `ORDER BY` em funções de janela — definição da ordem de cálculo.
* `SUM() OVER()` — cálculo de valores acumulados ou totais por grupo.
* `RANK()` — classificação de registros dentro de grupos.

### 7. Índices e análise de consultas

* `CREATE INDEX` — criação de índices.
* `DROP INDEX` — remoção de índices.
* `EXPLAIN` — análise do plano de execução de consultas.
* Noções de otimização e investigação do acesso aos dados.

### 8. Transações

* `BEGIN` — início de uma transação.
* `COMMIT` — confirmação das alterações.
* `ROLLBACK` — cancelamento de alterações não confirmadas.
* `SAVEPOINT` — criação de pontos de recuperação dentro de uma transação.

## 🗄️ Banco de dados utilizado

**Pagila**

O Pagila é um banco de dados de exemplo inspirado em uma locadora de filmes. Ele permite praticar consultas em um cenário relacional com diferentes entidades e relacionamentos.

Entre os dados utilizados nos exercícios estão:

* Clientes e funcionários.
* Filmes e categorias.
* Pagamentos e aluguéis.
* Inventário e endereços.

## 📝 Organização dos exercícios

Os exercícios estão organizados em arquivos SQL, separados por listas:

* `lista1.sql`
* `lista2.sql`
* `lista3.sql`

Ao todo, foram realizados **50 exercícios**, partindo de consultas básicas e avançando para operações de agrupamento, relacionamentos entre tabelas, subconsultas, funções de janela, índices e transações.

Os exercícios envolvem situações como:

* Filtrar, ordenar e pesquisar registros.
* Calcular quantidades, médias e valores financeiros.
* Analisar clientes, filmes, categorias e pagamentos.
* Combinar informações de várias tabelas.
* Comparar dados com médias e outros resultados de consultas.
* Classificar registros e calcular totais por cliente.
* Examinar planos de execução e praticar operações transacionais.

## 🎯 Objetivos de aprendizagem

* Consolidar os fundamentos de SQL com PostgreSQL.
* Desenvolver consultas cada vez mais complexas.
* Compreender relacionamentos e estruturas de bancos de dados relacionais.
* Praticar agregação, análise e transformação de dados por meio de SQL.
* Desenvolver uma base técnica para projetos de **Engenharia de Dados**.

## 🛠️ Tecnologias e ferramentas

* **SQL**
* **PostgreSQL**
* **Banco de dados Pagila**
* **Git e GitHub** para versionamento e organização dos estudos.

---

Este repositório faz parte da minha jornada de aprendizado em bancos de dados e Engenharia de Dados, reunindo exercícios práticos e registrando minha evolução no uso de SQL.
