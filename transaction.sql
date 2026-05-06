-- ESQUELETO: transaction.sql

-- CENÁRIO: Cancelamento de uma compra aprovada com 2 ou mais ingressos

-- PASSO 1: Mostrar os dados antes da transaction
-- Tabelas: compra, ingresso, lote_ingresso
-- Filtro: id da compra escolhida (precisa estar aprovada e ter pelo menos 2 ingressos)

-- PASSO 2: Abrir transaction e executar as 3 operações
-- Operação 1: mudar status da compra para 'cancelado'
-- Operação 2: mudar status de todos os ingressos vinculados para 'cancelado'
-- Operação 3: explicar que os ingressos cancelados não ocupam mais vagas
-- Mostrar os dados dentro da transaction (status devem aparecer como cancelado)

-- PASSO 3: Forçar ROLLBACK
-- Desfazer todas as alterações

-- PASSO 4: Mostrar os dados depois do ROLLBACK
-- Comprovar que tudo voltou ao estado original (compra aprovada, ingressos válidos)
