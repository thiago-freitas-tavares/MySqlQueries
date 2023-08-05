-- Design de Banco de Dados

-- Entidades (Tabelas)
-- Representam objetos tangíveis (produto, carro), funções (cliente, professor) e eventos/ocorrências (pedidos, posts).
-- Tipos: forte (independente), fraca (dependente) e associativa (associada a um relacionamento).

-- Atributos (Propriedades das Entidades - Colunas)
-- Tipos: simples (indivisível), composto (divisível em partes menores), monovalorado, multivalorado, derivado (de outro atributo ou entidade), chave (único).
-- Domínio: o domínio de um atributo define qual o tipo de dado e o formato que o dado pode ser armazenado.

-- Relacionamento entre Entidades
-- 1. One to One (1:1): quando as duas entidades possuem apenas um registro de ligação entre elas (ex: usuário e endereço).
-- 2. One to Many (1:n): quando uma entidade possui várias ligações na outra e o oposto não ocorre (ex: usuário e pedidos). 
-- 3. Many to Many (n:m): quando ambas entidades possuem múltiplos relacionamentos (ex: produtos e pedidos) utilizamos entidade pivot para intermediar.

-- Os dados de cada Linha de uma entidade são armazenados em Tuplas.
-- Chave Estrangeira (Foreign Key - FK) consiste no valor da Chave Primária (Primary Key - PK) onde a entidade tem ligação.

-- Fase Conceitual: definição das entidades (tabelas) envolvidas no projeto.
-- Fase Lógica: definição das relações entre as entidades e seus atributos.
-- Fase Física: implementação das entidades em SQL num SGBD.

-- Integridade de Domínio: restringir infos armazenadas e identificar dados indispensáveis ao DB.
-- Integridade Referencial: garantir que linhas relacionadas entre duas entidades continuem relacionadas mesmo após alterações nas entidades.

-- Documentação: definição formal dos elementos (Dicionário de Dados) a fim de evitar dúvidas.

-- Normalização: otimizar o banco de dados através de formas normais, como NF1, NF2 e NF3.

-- Requisitos NF1
-- 1. colunas com apenas um tipo de dado e apenas um valor em cada célula (atomicidade).
-- 2. colunas com nomes únicos.
-- 3. ordem das colunas não importam.

-- Requisitos NF2
-- 1. todos os requisitos da NF1 devem estar resolvidos.
-- 2. não haver dependências parciais nas tabelas -> coluna que não tem relação direta com a tabela -> jogar para outra tabela.
-- 3. criar todos os relacionamentos entre tabelas, fazendo os ajustes necessários.

-- Requisitos NF3
-- 1. todos os requisitos da NF2 devem estar resolvidos.
-- 2. remoção de dependências transitivas -> colunas que possuem relação com a chave primária, mas por otimização é melhor que estejam em outra tabela.

---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PROJETO: BLOG

-- salvar os posts do blog, que vão ter: título, categoria, corpo do texto, tag, data de criação e data de atualização.
-- salvar nome e cargo do autor do post, que apenas funcionários podem criar.
-- salvar comentários, que apenas usuários autenticados podem criar.
-- salvar nome, e-mail e senha dos usuários autenticados.
-- possibilidade de dar likes e avaliar posts com notas entre 1 e 5.

-- Fase Conceitual

-- no workbench -> Models -> + -> Add Diagram.
-- cria uma tabela chamada post e uma chamada user com as colunas descritas no enunciado.
-- Aplicando NF1
-- coluna post/comment precisa ir para uma tabela separada, pois pode haver mais de um comentário para cada post (atomicidade).
-- coluna post/tag precisa ir para uma tabela separada, pois pode haver mais de uma tag para cada post.
-- coluna post/like precisa ir para uma tabela separada, pois pode haver mais de um like para cada post. Depois da um JOIN / COUNT.
-- coluna post/rating precisa ir para uma tabela separada, pois pode haver mais de um rate para cada post. Depois da um JOIN / AVG.
-- coluna user/name deve ser dividida em duas colunas (first_name e last_name).

-- Fase Lógica

-- Aplicando NF2
-- cria relação 1:n entre as tabelas post & user, pois um user pode ter vários posts. Com isso, podemos deletar as colunas author e author_job da tabela post.
-- cria relação 1:n entre as tabelas comment & post e entre as tabelas comment & user, pois um post pode ter vários comments e um user pode ter vários comments.
-- cria relação n:m entre as tabelas post & tag, pois um post pode ter várias tags e uma tag pode estar em vários posts. Tabela pivot criada automaticamente.
-- cria relação 1:n entre as tabelas like & post e entre as tabelas like & user, pois um post pode ter vários likes e um user pode dar vários likes.
-- cria relação 1:n entre as tabelas rating & post e entre as tabelas rating & user, pois um post pode ter vários rates e um user pode dar vários rates.
-- coluna like/like pode ser deletada, pois os atributos teriam somente uma opção de valor. Coluna rating/rate mantém, pois podem ter valor de 1 a 5.
-- aplicando NF3
-- coluna post/category pode ir para uma tabela separada, pois se refere a atributos que podem ter características, como category_description por exemplo.
-- coluna user/job pode ir para uma tabela separada, pois se refere a atributos que podem ter características, como job_description por exemplo.
-- ajusta o tipo de dado de cada coluna de todas as tabelas.

-- Fase Física

CREATE DATABASE blog;
USE blog;
CREATE TABLE post(
    post_id INT,
    title VARCHAR(255),
    body LONGTEXT,
    user_id INT,
    created_at DATE,
    updated_at DATE,
    category_id INT    
);
CREATE TABLE user(
    user_id INT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(255),
    password VARCHAR(255),
    is_employee TINYINT,
    job_id INT
);
CREATE TABLE job(
    job_id INT,
    job VARCHAR(45),
);
CREATE TABLE category(
    category_id INT,
    category VARCHAR(45),
);
CREATE TABLE comment(
    comment_id INT,
    comment MEDIUMTEXT,
    post_id INT,
    user_id INT
);
CREATE TABLE post_tags(
    post_tags_id INT,
    post_id INT,
    tag_id INT
);
CREATE TABLE tag(
    tag_id INT,
    tag VARCHAR(45),
);
CREATE TABLE like(
    like_id INT,
    post_id INT,
    user_id INT
);
CREATE TABLE rating(
    rating_id INT,
    rate TINYINT(5),
    post_id INT,
    user_id INT
);