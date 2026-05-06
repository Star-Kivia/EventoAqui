-- Quem publica eventos na plataforma (empresa ou pessoa física)
-- Relacionamento: um organizador pode ter VÁRIOS eventos (1:N)
CREATE TABLE organizador (
  id SERIAL PRIMARY KEY,                    -- PK automática, incrementa 1, 2, 3...
  nome VARCHAR(100) NOT NULL,               -- Nome obrigatório
  documento VARCHAR(14) NOT NULL UNIQUE,    -- CNPJ (14) ou CPF (11), não pode repetir
  CHECK (
    documento ~ '^[0-9]+$'                 -- Aceita apenas números
    AND length(documento) IN (11, 14)       -- 11 dígitos (CPF) ou 14 (CNPJ)
  ),
  contato VARCHAR(100),                     -- Telefone ou email (opcional)
  cidade VARCHAR(80),                       -- Cidade do organizador (opcional)
  status VARCHAR(20) DEFAULT 'ativo' CHECK (status IN ('ativo', 'suspenso')),
  criado_em TIMESTAMPTZ DEFAULT NOW()       -- Data de cadastro automática
);

-- Classificação do tipo de evento (show, festival, workshop...)
-- Relacionamento: uma categoria pode ter VÁRIOS eventos (1:N)
CREATE TABLE categoria_evento (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE,        -- Nome único, não pode repetir
  CHECK (
    nome IN (                               -- Só aceita estes 6 valores
      'show',
      'festival',
      'workshop',
      'palestra',
      'teatro',
      'esporte'
    )
  )
);

-- Pessoa que compra ingressos na plataforma
-- Relacionamento: um participante pode fazer VÁRIAS compras (1:N)
CREATE TABLE participante (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,       -- Email obrigatório e sem repetição
  cpf VARCHAR(11) UNIQUE NOT NULL,          -- CPF obrigatório, 11 dígitos, sem repetição
  data_nascimento DATE NOT NULL,            -- Apenas data (dia/mês/ano), sem hora
  status VARCHAR(20) NOT NULL CHECK (status IN ('ativo', 'banido')) DEFAULT 'ativo'
);

-- O acontecimento publicado na plataforma
-- Depende de: organizador (FK) e categoria_evento (FK)
-- Relacionamento: um evento pertence a UM organizador e UMA categoria um evento pode ter VÁRIOS lotes (1:N)
CREATE TABLE evento (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  descricao TEXT,                           -- TEXT: sem limite de tamanho, aceita NULL
  data_inicio TIMESTAMPTZ NOT NULL,         -- TIMESTAMPTZ: data/hora COM fuso horário
  data_fim TIMESTAMPTZ NOT NULL,            -- Converte para UTC e devolve no fuso do cliente
  local VARCHAR(150) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  status VARCHAR(20) NOT NULL CHECK (
    status IN ('rascunho', 'publicado', 'cancelado', 'encerrado')
  ) DEFAULT 'rascunho',
  organizador_id INTEGER NOT NULL REFERENCES organizador(id) ON DELETE RESTRICT,
  -- FK: impede apagar organizador se existir evento vinculado
  categoria_id INTEGER NOT NULL REFERENCES categoria_evento(id) ON DELETE RESTRICT
  -- FK: impede apagar categoria se existir evento vinculado
);

-- Tipos de ingresso de um evento (inteira, meia, VIP...)
-- Depende de: evento (FK)
-- Relacionamento: um lote pertence a UM evento um lote pode ter VÁRIOS ingressos (1:N)
CREATE TABLE lote_ingresso (
    id SERIAL PRIMARY KEY,
    evento_id INTEGER NOT NULL,             -- FK para evento
    nome VARCHAR(50) NOT NULL,              -- Nome do lote (ex: Inteira, Meia, VIP)
    preco NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
    -- NUMERIC(10,2): dinheiro com precisão exata, nunca usar REAL
    capacidade_maxima INT NOT NULL CHECK (capacidade_maxima > 0),
    -- CHECK: capacidade não pode ser zero nem negativa
    status VARCHAR(20) NOT NULL CHECK (status IN ('disponivel', 'esgotado', 'encerrado')) DEFAULT 'disponivel',
    FOREIGN KEY (evento_id) REFERENCES evento(id) ON DELETE RESTRICT,
    UNIQUE (evento_id, nome)
    -- Não pode ter dois lotes com mesmo nome no mesmo evento
);

-- Pedido de ingresso feito por um participante
-- Depende de: participante (FK)
-- Relacionamento: uma compra pertence a UM participante uma compra pode ter VÁRIOS ingressos (1:N)
CREATE TABLE compra (
    id SERIAL PRIMARY KEY,
    participante_id INTEGER NOT NULL REFERENCES participante(id) ON DELETE RESTRICT,
    -- FK: impede apagar participante se existir compra vinculada
    data_compra TIMESTAMPTZ DEFAULT NOW(),  -- Data/hora preenchida automaticamente
    valor_total NUMERIC(10,2) NOT NULL CHECK (valor_total >= 0),
    -- NUMERIC(10,2): precisão exata para dinheiro
    metodo_pagamento VARCHAR(50),           -- Ex: cartao, pix, boleto (opcional)
    status VARCHAR(20) NOT NULL CHECK (status IN ('pendente', 'aprovado', 'cancelado', 'estornado')) DEFAULT 'pendente'
);

-- Unidade individual de acesso, vinculada a uma compra e um lote
-- Depende de: compra (FK) e lote_ingresso (FK)
-- Relacionamento: um ingresso pertence a UMA compra e UM lote um ingresso pode ter NO MÁXIMO UM check-in (1:1)
CREATE TABLE ingresso (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,     -- Código único de validação
    -- UNIQUE: garantia de que não existem dois ingressos com o mesmo código
    status VARCHAR(20) NOT NULL CHECK (status IN ('valido', 'utilizado', 'cancelado')) DEFAULT 'valido',
    data_validacao TIMESTAMPTZ,             -- Preenchida no check-in, NULL enquanto não usado
    compra_id INTEGER NOT NULL REFERENCES compra(id) ON DELETE RESTRICT,
    -- FK: ingresso pertence a uma compra
    lote_id INTEGER NOT NULL REFERENCES lote_ingresso(id) ON DELETE RESTRICT
    -- FK: ingresso pertence a um lote específico
);

-- Registro de entrada do participante no evento
-- Depende de: ingresso (FK)
-- Relacionamento: cada check-in pertence a UM ingresso cada ingresso pode ter NO MÁXIMO UM check-in (1:1)
CREATE TABLE checkin (
    id SERIAL PRIMARY KEY,
    data_entrada TIMESTAMPTZ DEFAULT NOW(), -- Momento exato da validação na porta
    responsavel VARCHAR(100),               -- Nome do porteiro/validador
    ingresso_id INTEGER NOT NULL UNIQUE REFERENCES ingresso(id) ON DELETE RESTRICT
    -- FK UNIQUE: garante que cada ingresso tenha apenas UM check-in
);
