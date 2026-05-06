-- Esqueleto 
-- Crie as tabelas na ordem: pai → filha → neta → bisneta

--Viktor
-- TABELA: organizador
-- Colunas: id, nome, documento, contato, cidade, status
-- Regras: id automático e único, nome obrigatório, documento obrigatório e sem repetição, status só aceita 'ativo' ou 'suspenso' e tem valor padrão

create table organizador (
  id SERIAL primary key,
  nome VARCHAR(100) not null,
  documento VARCHAR(14) not null unique,
  check (
    documento ~ '^[0-9]+$'
    and length(documento) in (11, 14)
  ),
  contato VARCHAR(100),
  cidade VARCHAR(80),
  status VARCHAR(10) default 'ativo' check (status in ('ativo', 'suspenso')),
  criado_em TIMESTAMPTZ default now()
);

--martins
-- TABELA: categoria_evento
-- Colunas: id, nome
-- Regras: id automático e único, nome obrigatório sem repetição, só aceita 6 valores (show, festival, workshop, palestra, teatro, esporte)

create table evento (
  id serial primary key,
  titulo varchar(150) not null,
  descricao text,
  data_inicio timestamp not null,
  data_fim timestamp not null,
  local varchar(150) not null,
  cidade varchar(100) not null,
  status varchar(20) not null check (
    status in ('rascunho', 'publicado', 'cancelado', 'encerrado')
  ) default 'rascunho',
  organizador_id integer not null references organizador (id) on delete restrict,
  categoria_id integer not null references categoria_evento (id) on delete restrict
);

--categoria de eventos  classificação do tipo de evento (show, festival, 
--workshop, palestra,teatro, esporte). Um evento pertence a uma categoria.

create table if not exists CategoriaEvento (
  id serial primary key,
  nome varchar(100) not null unique 
  check (
    nome in (
      'show',
      'festival',
      'workshop',
      'palestra',
      'teatro',
      'esporte'
    )
  )
----check garante que categoria só pode existir se for o que está listado 
);

--martins | viktor
-- TABELA: participante
-- Colunas: id, nome, email, cpf, data_nascimento, status
-- Regras: id automático e único, nome obrigatório, email obrigatório e sem repetição, cpf obrigatório e sem repetição (11 dígitos), data de nascimento obrigatória (só data, sem hora), status só aceita 'ativo' ou 'banido' com valor padrão

create table participante (
  id SERIAL primary key,
  nome VARCHAR(100) not null,
  email VARCHAR(100) unique not null,
  cpf VARCHAR(11) unique not null,
  data_nascimento DATE not null,
  status VARCHAR(20) not null check (status in ('ativo', 'suspenso')) default 'ativo'
);

--martins
create table if not exists Participante (
  id_participante serial primary key ,
  Nome varchar(50) not null,
  Cpf varchar(11) unique not null, -- unique garante que só pode ser repetido uma vez por Participante e not null garante que o campo n pode ser nulo
  email varchar(50) unique not null,
  DataNascimento DATE not null, --Date  =  faz com que o que o campo seja preenchido apenas por dia/mes/ano
  Status not null check (status in ('ativo', 'banido')) default 'ativo'
);

--isaac
-- TABELA: evento
-- Colunas: id, titulo, descricao, data_inicio, data_fim, local, cidade, status, organizador_id, categoria_id
-- Regras: id automático e único, titulo obrigatório, descricao opcional e sem limite de tamanho, datas obrigatórias e com fuso horário, local e cidade obrigatórios, status com 4 valores possíveis e padrão 'rascunho', organizador_id e categoria_id obrigatórios e ligados às tabelas pai (impede apagar pai se tiver evento vinculado)

--kauã_oliveira
-- TABELA: lote_ingresso
-- Colunas: id, nome, preco, capacidade_maxima, status, evento_id
-- Regras: id automático e único, nome obrigatório, preço obrigatório (tipo para dinheiro com precisão exata, não pode ser negativo), capacidade obrigatória e maior que zero, status com 3 valores e padrão, evento_id obrigatório ligado à tabela evento, não pode ter dois lotes com mesmo nome no mesmo evento

--kauã_oliveira
-- TABELA: compra
-- Colunas: id, data_compra, valor_total, metodo_pagamento, status, participante_id
-- Regras: id automático e único, data preenchida automaticamente com o momento atual, valor obrigatório e não negativo, método de pagamento opcional, status com 4 valores e padrão 'pendente', participante_id obrigatório ligado à tabela participante

--kauã_vicente
--CREATE comando que cria a tabela ingresso, seguido do if not exists para no caso da tabela existir ele não cria-la novamente
CREATE TABLE IF NOT EXISTS ingresso(
    --chave primária da tabela que ao ser criada uma nova linha vai incrementando o id seguindo de 1, 2, 3... 
    id SERIAL PRIMARY KEY,
    --codigo único onde não pode repetir em outro id de ingresso ao mesmo tempo e não pode ser nulo
    codigo VARCHAR(20) UNIQUE NOT NULL,
    --Status atual do ingresso com logíca para saber se está ativo, utilizado ou cancelado e DEFAULT comando que ao criar um ingresso faça com que ele esteja configurado como válido
    status VARCHAR(20) NOT NULL CHECK(status in
    ('valido', 'utilizado', 'cancelado')) DEFAULT 'valido',
    --data de validação guarda o momento em que o ingresso for utilizado
    data_validacao TIMESTAMPTZ,
    --chave estrangeira referenciada da tabela compra, on delete restrict impede que se deletar a tabela pai as tabelas filhas sejam excluídas 
    compra_id INTEGER NOT NULL REFERENCES compra(id) ON DELETE RESTRICT,
    ----chave estrangeira referenciada da tabela lote_ingresso, on delete restrict impede que se deletar a tabela pai as tabelas filhas sejam excluídas
    lote_id INTEGER NOT NULL REFERENCES lote_ingresso(id) ON DELETE RESTRICT
);
-- TABELA: ingresso
-- Colunas: id, codigo, status, data_validacao, compra_id, lote_id
-- Regras: id automático e único, código obrigatório e sem repetição (cada ingresso tem código único de validação), status com 3 valores e padrão, data de validação opcional (preenchida só no check-in), compra_id e lote_id obrigatórios ligados às tabelas pai

--Kauã_vicente
CREATE TABLE IF NOT EXISTS checkin (
    --chave primária da tabela que ao ser criada uma nova linha vai incrementando o id seguindo de 1, 2, 3... 
    id SERIAL PRIMARY KEY,
    data_entrada TIMESTAMPTZ DEFAULT NOW(),
    responsavel VARCHAR(100),
    ingresso_id INTEGER NOT NULL UNIQUE REFERENCES ingresso(id) ON DELETE RESTRICT
);
-- TABELA: checkin
-- Colunas: id, data_entrada, responsavel, ingresso_id
-- Regras: id automático e único, data preenchida automaticamente, responsável opcional, ingresso_id obrigatório, sem repetição (cada ingresso só tem um check-in) e ligado à tabela ingresso
