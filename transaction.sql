-- CONTEXTO DO CENÁRIO:
-- Quando um participante cancela uma compra aprovada, três operações
-- precisam acontecer JUNTAS:
--   1. Atualizar o status da compra para "cancelado"
--   2. Atualizar o status de TODOS os ingressos vinculados para "cancelado"
--   3. Os ingressos cancelados voltam a ser vagas disponíveis nos lotes
-- Se qualquer operação falhar, NENHUMA pode ser confirmada.
-- Uma compra cancelada com ingressos ainda "válidos" quebraria o controle
-- de capacidade do evento (grave erro de integridade de negócio).

-- PASSO 1: Verificar a situação ANTES da transaction
-- A compra 4 tem 2 ingressos (EVT-0004-G7H8 e EVT-0005-I9J0) e está "aprovado"
SELECT 'ANTES DA TRANSACTION' AS momento;
SELECT 
    c.id AS compra_id,
    c.status AS status_compra,
    i.id AS ingresso_id,
    i.codigo AS codigo_ingresso,
    i.status AS status_ingresso,
    l.id AS lote_id,
    l.nome AS lote_nome,
    l.status AS status_lote
FROM compra c
INNER JOIN ingresso i ON c.id = i.compra_id
INNER JOIN lote_ingresso l ON i.lote_id = l.id
WHERE c.id = 4;


-- PASSO 2: Iniciar a transaction e executar as 3 operações
BEGIN;  -- Abre a transaction. Tudo daqui pra frente é isolado e provisório.

-- Operação 1: Atualizar o status da compra para "cancelado"
UPDATE compra 
SET status = 'cancelado' 
WHERE id = 4;

-- Operação 2: Atualizar o status de TODOS os ingressos vinculados para "cancelado"
UPDATE ingresso 
SET status = 'cancelado' 
WHERE compra_id = 4;

-- Operação 3: Os ingressos cancelados voltam a ser vagas disponíveis.
-- Na prática, isso significa que a capacidade dos lotes NÃO é mais afetada
-- por esses ingressos. Como o status do ingresso mudou para "cancelado",
-- ele não será mais contado nas queries de ocupação (que filtram por
-- status IN ('valido', 'utilizado')).
-- Não é necessário alterar o status do lote, pois a capacidade continua a mesma;
-- o que muda é a contagem de ingressos válidos.

-- Verificar o resultado DENTRO da transaction (visão isolada)
SELECT 'DENTRO DA TRANSACTION' AS momento;
SELECT 
    c.id AS compra_id,
    c.status AS status_compra,
    i.id AS ingresso_id,
    i.codigo AS codigo_ingresso,
    i.status AS status_ingresso
FROM compra c
INNER JOIN ingresso i ON c.id = i.compra_id
WHERE c.id = 4;


-- PASSO 3: Forçar ROLLBACK para provar que as alterações não persistem
-- Este ROLLBACK é DELIBERADO para a demonstração.
-- Em um cenário real, o ROLLBACK seria acionado APENAS se alguma
-- das operações falhasse (ex: um ingresso não existe, violação de FK, etc.).
-- Aqui forçamos o ROLLBACK para PROVAR que nenhuma alteração persiste.
ROLLBACK;  -- Desfaz TUDO que foi feito desde o BEGIN


-- PASSO 4: Verificar que os dados voltaram ao estado original
SELECT 'DEPOIS DO ROLLBACK' AS momento;
SELECT 
    c.id AS compra_id,
    c.status AS status_compra,
    i.id AS ingresso_id,
    i.codigo AS codigo_ingresso,
    i.status AS status_ingresso,
    l.id AS lote_id,
    l.nome AS lote_nome,
    l.status AS status_lote
FROM compra c
INNER JOIN ingresso i ON c.id = i.compra_id
INNER JOIN lote_ingresso l ON i.lote_id = l.id
WHERE c.id = 4;
-- O status da compra volta a ser "aprovado" e os ingressos voltam a ser "valido"
-- PROVA de que o ROLLBACK desfez todas as alterações da transaction.
