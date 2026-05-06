@@ -1,35 +1,35 @@
-- ESQUELETO: schema.sql

-- Crie as tabelas na ordem: pai → filha → neta → bisneta

-- TABELA: organizador
-- Colunas: id, nome, documento, contato, cidade, status
-- Regras: id automático e único, nome obrigatório, documento obrigatório e sem repetição, status só aceita 'ativo' ou 'suspenso' e tem valor padrão

CREATE TABLE IF NOT EXISTS organizador (
  id SERIAL PRIMARY KEY,

  nome VARCHAR(100) NOT NULL,

  documento VARCHAR(14) NOT NULL UNIQUE,
  CHECK (documento ~ '^[0-9]+$' AND length(documento) IN (11,14)),

  contato VARCHAR(100),

  cidade VARCHAR(80),

  status VARCHAR(10) DEFAULT 'ativo'
  CHECK (status IN ('ativo', 'suspenso')),
  
  criado_em TIMESTAMPTZ DEFAULT now()
);

teste(martins)
-- TABELA: categoria_evento
-- Colunas: id, nome
-- Regras: id automático e único, nome obrigatório sem repetição, só aceita 6 valores (show, festival, workshop, palestra, teatro, esporte)
teste (vitor)
-- TABELA: participante
-- Colunas: id, nome, email, cpf, data_nascimento, status
-- Regras: id automático e único, nome obrigatório, email obrigatório e sem repetição, cpf obrigatório e sem repetição (11 dígitos), data de nascimento obrigatória (só data, sem hora), status só aceita 'ativo' ou 'banido' com valor padrão


CREATE TABLE IF NOT EXISTS participante (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) not null,
  email VARCHAR(100) UNIQUE not null,
  cpf VARCHAR(11) UNIQUE not null,
  data_nascimento DATE not null,
  status VARCHAR(20) not null check (status in ('ativo', 'suspenso')) default 'ativo'
);


Teste(kauã)
-- TABELA: evento
-- Colunas: id, titulo, descricao, data_inicio, data_fim, local, cidade, status, organizador_id, categoria_id
-- Regras: id automático e único, titulo obrigatório, descricao opcional e sem limite de tamanho, datas obrigatórias e com fuso horário, local e cidade obrigatórios, status com 4 valores possíveis e padrão 'rascunho', organizador_id e categoria_id obrigatórios e ligados às tabelas pai (impede apagar pai se tiver evento vinculado)

-- TABELA: lote_ingresso
-- Colunas: id, nome, preco, capacidade_maxima, status, evento_id
-- Regras: id automático e único, nome obrigatório, preço obrigatório (tipo para dinheiro com precisão exata, não pode ser negativo), capacidade obrigatória e maior que zero, status com 3 valores e padrão, evento_id obrigatório ligado à tabela evento, não pode ter dois lotes com mesmo nome no mesmo evento
teste(Kauã_santos) 
-- TABELA: compra
-- Colunas: id, data_compra, valor_total, metodo_pagamento, status, participante_id
-- Regras: id automático e único, data preenchida automaticamente com o momento atual, valor obrigatório e não negativo, método de pagamento opcional, status com 4 valores e padrão 'pendente', participante_id obrigatório ligado à tabela participante

teste(isaac)
-- TABELA: ingresso
-- Colunas: id, codigo, status, data_validacao, compra_id, lote_id
-- Regras: id automático e único, código obrigatório e sem repetição (cada ingresso tem código único de validação), status com 3 valores e padrão, data de validação opcional (preenchida só no check-in), compra_id e lote_id obrigatórios ligados às tabelas pai

-- TABELA: checkin
-- Colunas: id, data_entrada, responsavel, ingresso_id
-- Regras: id automático e único, data preenchida automaticamente, responsável opcional, ingresso_id obrigatório, sem repetição (cada ingresso só tem um check-in) e ligado à tabela ingresso