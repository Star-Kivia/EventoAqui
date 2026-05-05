-- =====================================================
-- ESQUELETO: schema.sql
-- Objetivo: Criar todas as tabelas do zero sem erros
-- =====================================================

-- 1. Tabelas "pai" (não dependem de ninguém)
-- (Organizador, CategoriaEvento, Participante)

-- Tabela: organizador
-- TODO: Incluir id (SERIAL PK), nome, cnpj_cpf (UNIQUE), contato, cidade, status (com CHECK)
CREATE TABLE organizador ();

-- Tabela: categoria_evento
-- TODO: Incluir id (PK), nome (UNIQUE)
CREATE TABLE categoria_evento ();

-- Tabela: participante
-- TODO: Incluir id (PK), nome, email (UNIQUE), cpf (UNIQUE), data_nasc, status
CREATE TABLE participante ();

-- 2. Tabelas "filhas" (dependem das pais)
-- (Evento depende de Organizador e Categoria)

-- Tabela: evento
-- TODO: FK para organizador, FK para categoria. Campos: titulo, descricao, data_inicio, data_fim, local, status
CREATE TABLE evento ();

-- 3. Tabelas "netas" (dependem das filhas)
-- (Lote depende de Evento. Compra depende de Participante)

-- Tabela: lote
-- TODO: FK para evento. Campos: nome, preco (NUMERIC), capacidade_max, status
CREATE TABLE lote ();

-- Tabela: compra
-- TODO: FK para participante. Campos: data, valor_total, metodo_pagamento, status
CREATE TABLE compra ();

-- 4. Tabelas "bisnetas" (folhas da árvore)
-- (Ingresso depende de Compra e Lote. Check-in depende de Ingresso)

-- Tabela: ingresso
-- IMPORTANTE: codigo_unico deve ter CONSTRAINT UNIQUE
-- TODO: FK para compra, FK para lote. Campos: codigo_unico (TEXT UNIQUE NOT NULL), status, data_validacao
CREATE TABLE ingresso ();

-- Tabela: check_in
-- TODO: FK para ingresso. Campos: timestamp, responsavel
CREATE TABLE check_in ();