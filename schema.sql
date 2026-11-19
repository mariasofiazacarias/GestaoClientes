-- 1. Criação da tabela de usuários
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

-- 2. Criação da tabela de Grupos de clientes (Nova Tabela)
CREATE TABLE IF NOT EXISTS grupos (
    id SERIAL PRIMARY KEY,
    descricao_grupo VARCHAR(100) NOT NULL
);

-- 3. Criação da tabela de clientes com a Chave Estrangeira 'grupo_id'
-- A cláusula REFERENCES estabelece o relacionamento N:1 com a tabela grupos.
-- ON DELETE SET NULL garante que, se um grupo for excluído, os clientes vinculados não serão apagados, apenas perderão o vínculo.
CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    cpf NUMERIC(11) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone NUMERIC(20) NOT NULL,
    grupo_id INT REFERENCES grupos(id) ON DELETE SET NULL
);

-- 4. Inserção do usuário administrador inicial
-- EXPLICAÇÃO DA CLÁUSULA 'ON CONFLICT (email) DO NOTHING':
-- Garante a IDEMPOTÊNCIA do script. Se a carga SQL for executada múltiplas vezes no banco,
-- o PostgreSQL ignora a inserção caso o e-mail já esteja cadastrado (devido à restrição UNIQUE),
-- evitando erros de duplicação.
INSERT INTO usuarios (nome, cpf, email, senha, telefone)
VALUES ('Administrador', '12347899870', 'admin@email.com', '$2b$10$ejkEgXrxkc5wAAHG6xFQgeyhScgPSPDgiU363lPkSEMoRv5Mcv38m', '19876542900')
ON CONFLICT (email) DO NOTHING;
-- 5. Inserção de grupos padrão para testes iniciais
INSERT INTO grupos (descricao_grupo) VALUES
( 'Convênio Bronze'),
( 'Particular Especial'),
('Atendimento Social')
ON CONFLICT (id) DO NOTHING;

-- 6. Inserção de clientes vinculados aos grupos
INSERT INTO clientes (nome_cliente, cpf, email, telefone, grupo_id) VALUES
('Gabriela"', 12345678901, 'gabriela@email.com', '19992367890', 1),
('Sofia', 12345678902, 'sofia@email.com', '199990347785', 2),
('Kayla', 12345678903, 'kayla@gmail.com', '199927909865', 3)
ON CONFLICT DO NOTHING;
