-- ESQUELETO: views.sql

-- VIEW 1: painel_eventos_ativos
-- Objetivo: Relatório diário dos eventos publicados
-- Tabelas: evento, organizador, categoria_evento, lote_ingresso, ingresso
-- Filtro: evento com status 'publicado'
-- Calcular: total de ingressos vendidos (não cancelados) e capacidade restante (soma das capacidades menos vendidos)
-- Colunas: id do evento, título, organizador, data de início, cidade, categoria, ingressos vendidos, capacidade restante
-- Ordenação: data de início crescente

-- VIEW 2: receita_por_organizador
-- Objetivo: Relatório financeiro mensal por organizador
-- Tabelas: organizador, evento, lote_ingresso, ingresso, compra
-- Filtro: compras aprovadas, ingressos não cancelados
-- Calcular: total de eventos distintos, total de compras aprovadas distintas, soma do valor_total
-- Condição do grupo: mostrar apenas organizadores com pelo menos uma compra aprovada
-- Colunas: id do organizador, nome, total de eventos, total de compras, receita acumulada
-- Ordenação: receita acumulada decrescente
