-- 7. Criando um Banco de Dados com três tabelas.

CREATE DATABASE xidiomas;
USE xidiomas;								-- apresenta o DB no Navigator.
CREATE TABLE cursos(						-- tipos de dados: INT, DECIMAL(qtd máx de algarismos, dígitos depois da vírgula), VARCHAR(qtd máx de caracteres), DATE.
	id_curso INT,
    nome_curso VARCHAR(50),
    valor_curso DECIMAL(10, 2)
);
CREATE TABLE alunos(
	id_aluno INT,
    nome_aluno VARCHAR(50),
    email VARCHAR(50)
);
CREATE TABLE vendas(
	id_venda INT,
    data_venda DATE,
    id_curso INT,
    id_aluno INT
);

INSERT INTO cursos(id_curso, nome_curso, valor_curso)
VALUES
	(1, 'Inglês', 1200),
    (2, 'Espanhol', 1000),
    (3, 'Francês', 900);

INSERT INTO alunos(id_aluno, nome_aluno, email)
VALUES
	(1, 'Eliane', 'eliane@gmail.com'),
    (2, 'João', 'j.123@hotmail,com'),
    (3, 'Pedro', 'pedrinho@gmail.com');

INSERT INTO vendas							-- se os valores atribuídos estiverem na mesma ordem das colunas da tabela não precisa declarar as colunas no argumento da tabela no INSERT INTO.
VALUES
	(1, '2022-01-10', 1, 1),
    (2, '2022-01-10', 2, 1),
    (3, '2022-01-10', 3, 1),
    (4, '2022-01-13', 1, 2),
    (5, '2022-01-21', 2, 3);

UPDATE cursos								-- atualiza uma célula específica.
SET valor_curso = 750
WHERE id_curso = 3;

DELETE FROM vendas							-- deleta uma linha específica.
WHERE id_venda = 5;

SELECT * FROM cursos;
SELECT * FROM alunos;
SELECT * FROM vendas;

-- DROP TABLE vendas;						-- deleta a tabela.
-- DROP DATABASE xidiomas;					-- deleta o banco de dados.