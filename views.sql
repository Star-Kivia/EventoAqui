-- VIEW 1: painel_eventos_ativos
-- Relatório diário dos eventos publicados para o time de operações
create or replace view painel_eventos_ativos as
select
  e.id as "ID Evento", -- ID do evento
  e.titulo as "Evento", -- Título do evento
  o.nome as "Organizador", -- Nome do organizador
  e.data_inicio as "Data de Início", -- Data e hora de início
  e.cidade as "Cidade", -- Cidade onde ocorre
  cat.nome as "Categoria", -- Categoria do evento
  COUNT(i.id) as "Ingressos Vendidos", -- Total de ingressos não cancelados
  SUM(l.capacidade_maxima) - COUNT(i.id) as "Capacidade Restante"
  -- Soma das capacidades de todos os lotes menos os já vendidos
from
  evento e
  inner join organizador o on e.organizador_id = o.id
  inner join categoria_evento cat on e.categoria_id = cat.id
  inner join lote_ingresso l on l.evento_id = e.id
  left join ingresso i on i.lote_id = l.id
  and i.status in ('valido', 'utilizado') -- Só conta ingressos não cancelados
where
  e.status = 'publicado' -- Apenas eventos publicados
group by
  e.id,
  e.titulo,
  o.nome,
  e.data_inicio,
  e.cidade,
  cat.nome
order by
  e.data_inicio asc;

-- Do mais próximo para o mais distante

-- VIEW 2: receita_por_organizador
-- Relatório financeiro mensal para o time financeiro
create or replace view receita_por_organizador as
select
  o.id as "ID Organizador", -- ID do organizador
  o.nome as "Organizador", -- Nome do organizador
  COUNT(distinct e.id) as "Total de Eventos", -- Quantos eventos distintos publicou
  COUNT(distinct c.id) as "Total de Compras Aprovadas", -- Compras aprovadas distintas
  COALESCE(SUM(c.valor_total), 0) as "Receita Acumulada"
  -- Soma dos valores das compras aprovadas; 0 se não houver
from
  organizador o
  inner join evento e on o.id = e.organizador_id
  inner join lote_ingresso l on e.id = l.evento_id -- Correção: e.id no lugar de e.d
  inner join ingresso i on l.id = i.lote_id
  and i.status in ('valido', 'utilizado') -- Só ingressos não cancelados
  inner join compra c on i.compra_id = c.id
  and c.status = 'aprovado' -- Só compras aprovadas
group by
  o.id,
  o.nome -- Correção: vírgula entre os campos
having
  COUNT(distinct c.id) > 0 -- Correção: espaço removido do COUNT
order by
  "Receita Acumulada" desc;

-- Maior receita primeiro

-- Teste das views
select
  *
from
  painel_eventos_ativos;

select
  *
from
  receita_por_organizador;
