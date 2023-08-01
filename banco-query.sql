-- SQL (Structured Query Language): linguagem universal de consulta estruturada para manipular banco de dados (conjunto de tabelas).

-- Profissões: Administrador de Dados (AD), Administrador de Banco de Dados (DBA), Cientista de Dados, Desenvolvedor de Banco de Dados (DB), Analista de Business Inteligence, Analista de Dados.

-- SGBD (Sistema de Gestão de Banco de Dados):composto por um servidor e uma interface.
-- MySQL, SQL Server, Oracle Database, PostgreSQL: SGBDs utilizados para manipular banco de dados.
-- MySQL -> MySQL Server (armazenar os dados) + MySQL Workbench (interface para acessar os dados).

-- Em MySQL Workbench -> Create a new schema -> Server -> Data Import -> Import from Dump Project Folder (seleciona) -> Start Import -> Botão de Atualizar o Navigator SCHEMAS.
-- Botão Direito no SCHEMA que irá manipular -> Set as Default Schema.

-- 1. Comando SELECT para selecionar linhas e colunas de tabelas no DB.

-- SELECT FROM: SELECT * FROM Tabela; SELECT Col1, Col2 FROM Tabela; (escolhe colunas).

SELECT *
FROM pedidos;

SELECT
	ID_Cliente,
    Nome,
    Data_Nascimento,
    Email
FROM clientes;

-- SELECT AS: SELECT Col1 AS "Coluna 1", Col2 AS "Coluna 2" FROM Tabela; (escolhe colunas e renomeia).

SELECT
	ID_Cliente AS "ID do Cliente",
    Nome AS 'Nome do Cliente',
    Data_Nascimento AS "Data de Nascimento",
    Email AS 'E-mail do Cliente'
FROM clientes;

-- SELECT LIMIT: SELECT * FROM Tabela LIMIT 2; (escolhe linhas).

SELECT *
FROM produtos
LIMIT 5;

-- ORDER BY: SELECT * FROM Tabela ORDER BY Col3; SELECT * FROM Tabela ORDER BY Col3 DESC; (ordena as linhas em ascendente/descendente de acordo com os dados de coluna específica).

SELECT *
FROM produtos
ORDER BY Preco_Unit
LIMIT 5;

-- 2. Comando WHERE para criar filtros dos tipos números, textos ou datas.

SELECT *
FROM produtos
WHERE Preco_Unit <> 1800;

SELECT *
FROM produtos
WHERE Marca_Produto = 'DELL' OR Marca_Produto = 'SAMSUNG';

SELECT *
FROM pedidos
WHERE Data_Venda <= '2019-01-03';			-- formato americano.

SELECT *
FROM clientes
WHERE Estado_Civil = 'S' AND Sexo = 'M';

-- 3. Funções de Agregação: COUNT, COUNT(*), COUNT(DISTINCT), SUM, AVG, MIN, MAX para realizar cálculos no SQL.

SELECT
	COUNT(telefone),						-- COUNT não conta células vazias.
	COUNT(*),
    COUNT(DISTINCT Escolaridade)			-- retorna a qtd de dados distintos.
FROM clientes;

SELECT
	SUM(Receita_Venda) AS 'Receita Total',
    AVG(Receita_Venda) AS 'Receita Média',
    MIN(Receita_Venda) AS 'Menor Receita',
    MAX(Receita_Venda) AS 'Maior Receita'
FROM pedidos;

--  4. Agrupamentos: GROUP BY para criar tabelas resumo das tabelas originais no SQL.

SELECT
	ID_Loja,
    COUNT(*) AS 'Qtd',
    SUM(Receita_Venda) AS 'Receita Total',
    SUM(Custo_Venda) AS 'Custo Total'
FROM pedidos
GROUP BY ID_Loja;

-- 5. Comando JOIN para relacionar diferentes tabelas no DB.

-- Chave Primária: é a coluna utilizada como identificador único da tabela. Geralmente chamada de ID - toda tabela possui somente uma - sem valores repetidos.
-- Chave Estrangeira: é a coluna de uma tabela, que em outra tabela é Chave Primária, permitindo relacionar os dados de ambas tabelas entre si.
-- Tabela Dimensão: é uma tabela com características de um determinado elemento único.
-- Tabela Fato: é uma tabela com fatos ou acontecimentos de um negócio em determinados períodos de tempo. Geralmente composta por várias colunas ID para acessar informações das tabelas dimensão.

-- LEFT JOIN, RIGHT JOIN, INNER JOIN, FULL JOIN: permitem relacionar duas tabelas e criar uma terceira tabela, que é junção das duas.

-- JOIN = INNER JOIN junta os itens linkados entre as duas tabelas (não inclui nenhuma célula NULL).
-- LEFT JOIN apresenta todas as linhas da(s) coluna(s) selecionada(s) na tabela fato e junta com seus respectivos links da tabela dimensão (dimensão inclui células NULL, fato não).
-- RIGHT JOIN apresenta todas as linhas da(s) coluna(s) selecionada(s) na tabela dimensão e junta com seus respectivos links da tabela fato (fato inclui células NULL, dimensão não).
-- FULL JOIN ou OUTER JOIN é a junção do LEFT com o RIGHT JOIN (apresenta todas as células NULL).

SELECT
	pedidos.*,
    lojas.Loja,
    lojas.Gerente,
    lojas.Telefone
FROM
	pedidos									-- Tabela Fato
INNER JOIN lojas							-- Tabela Dimensão
	ON pedidos.ID_Loja = lojas.ID_Loja;		-- pedidos Chave Estrangeira = lojas Chave Primária.