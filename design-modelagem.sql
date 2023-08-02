-- Design de Banco de Dados

-- Fase Conceitual: definição das entitades (tabelas) envolvidas no projeto.
-- Fase Lógica: definição das relações entre as entidades e seus atributos.
-- Fase Física: implementação de recursos mais técnicos, como constraints, índices, tipos de dados, triggers, etc.

-- Normalização: otimizar o banco de dados através de formas normais, como NF1, NF2 e NF3.

-- NF1
-- requisitos:
-- 1. colunas com apenas um valor em cada célula (atomicidade).
-- 2. cada coluna com apenas um tipo de dado.
-- 3. colunas com nomes únicos.
-- 4. ordem das colunas não importam.
-- *. atomicidade é o princípio de que uma transação deve ser realizada por completo ou ela não deve ser realizada de forma alguma.

-- NF2
-- requisitos:
-- 1. todos os requisitos da NF1 devem estar resolvidos.
-- 2. não haver dependências parciais nas tabelas -> coluna que não tem relação direta com a tabela -> jogar para outra tabela.

-- Relacionamentos entre Tabelas
-- Principais:
-- 1. One to One (1:1): quando as duas tabelas possuem apenas um registro de ligação entre elas (ex: usuário e endereço).
-- 2. One to Many (1:n): quando uma tabela possui várias ligações na outra e o oposto não ocorre (ex: usuário e pedidos). 
-- 3. Many to Many (n:m): quando ambas tabelas possuem múltiplos relacionamentos (ex: produtos e pedidos) utilizamos tabela pivot para intermediar.
-- *. a chave estrangeira (foreign key - FK) consiste no valor da chave primária (primary key) onde a tabela tem ligação.

-- NF3
-- requisitos:
-- 1. todos os requisitos da NF2 devem estar resolvidos.
-- 2. remoção de dependências transitivas -> colunas que possuem relação com a chave primária, mas por otimização é melhor que estejam em outra tabela.

-- Projeto -> Blog
-- salvar os posts do blog, que vão ter: título, categoria, corpo do texto, tags, data de criação e data de atualização.
-- salvar nome e cargo do autor do post, que apenas funcionários podem criar.
-- salvar comentários, que apenas usuários autenticados podem criar.
-- salvar nome, e-mail e senha dos usuários autenticados.
-- possibilidade de dar likes e avaliar posts com notas entre 1 e 5.

