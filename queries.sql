-- ESQUELETO: queries.sql

-- PERGUNTA 1: Eventos publicados futuros
-- Tabelas: evento, organizador, categoria_evento
-- Filtros: status 'publicado', data de início maior que agora
-- Ordenação: data de início crescente (mais próximo primeiro)
-- Colunas: título do evento, nome do organizador, cidade, data de início, nome da categoria
select
  evento.titulo as "titulo do evento", -- Seleciona o título do evento
  organizador.nome as "nome do organizador", -- Nome
  evento.cidade as "cidade", -- cidade do evento
  evento.data_inicio as "data de início", -- data do inicio
  categoria_evento.nome as "categoria" --categoria do evento 
  from
  evento 
  inner join organizador on evento.organizador_id = organizador.id
  inner join categoria_evento on evento.categoria_id = categoria_evento.id
  where
  evento.status = 'publicado'  and  --filtro pra pegar so publicando
  evento.data_inicio > now() --funcaozinha pra puxar apenas os eventos que vão acontecer no FUTURO
  order by 
  evento.data_inicio asc;

-- PERGUNTA 2: Ocupação por lote
-- Tabelas: lote_ingresso, evento, ingresso
-- Cálculo: ingressos com status 'valido' ou 'utilizado' dividido pela capacidade máxima, vezes 100
-- Filtro nos ingressos: ignorar cancelados
-- Ordenação: percentual decrescente (mais cheio primeiro)
-- Colunas: título do evento, nome do lote, capacidade, quantidade de ingressos válidos, percentual com 2 casas decimais
-- Atenção: lotes sem ingresso vendido devem aparecer com 0%

  select
  evento.titulo as "Evento", -- Nome do evento
  lote.nome as "Lote", -- Nome do lote 
  lote.capacidade_maxima as "Capacidade", -- Capacidade máxima do lote
  COUNT(ingresso.id) as "Vendidos", -- Conta quantos ingressos existem neste lote
  ROUND((COUNT(ingresso.id) * 100.0 / lote.capacidade_maxima), 2) as "Ocupação (%)" --calculo percentual de ocupação
from
  lote_ingresso lote
  inner join evento  on lote.evento_id = evento.id -- INNER JOIN: cada lote pertence a um evento
  left join ingresso  on ingresso.lote_id = lote.id -- LEFT JOIN: quero TODOS os lotes, mesmo os sem ingresso vendido
  and ingresso.status in ('valido', 'utilizado') -- filtra apenas os ingressos validos ou utilizados
group by
  evento.titulo,
  lote.nome,
  lote.capacidade_maxima -- Agrupa por evento e lote; capacidade entra no GROUP BY por estar no SELECT
order by
  "Ocupação (%)" desc;  

-- PERGUNTA 3: Participantes com ingressos em mais de um evento
-- Tabelas: participante, compra, ingresso, lote_ingresso
-- Filtros: apenas compras aprovadas, apenas ingressos não cancelados
-- Agrupamento: por participante
-- Condição do grupo: contar eventos distintos, mostrar apenas quem tem mais de 1
-- Colunas: nome do participante, quantidade de eventos distintos

select
  participante.nome as "Participante", -- Nome do participante
  COUNT(distinct lote.evento_id) as "Eventos Distintos"
  -- COUNT(DISTINCT): conta cada evento uma única vez por participante. Impede com que aparecam tipo 5 eventos com o mesmo ingresso 
  -- lote está ligado a evento
from
  participante 
  inner join compra on participante.id = compra.participante_id -- Puxa apenas participantes que tem pelo menos uma compra 
  inner join ingresso  on compra.id = ingresso.compra_id -- pega os ingressos que o compra_id sejam iguais ao id da compra
  inner join lote_ingresso lote on ingresso.lote_id = lote.id -- vai pegar o ID do loteingresso e comparar com lote_id puxando apenas o lote cujo id seja igual ao lote_id do ingresso
where
  ingresso.status in ('valido', 'utilizado') -- Só conta ingressos não cancelados
  and compra.status = 'aprovado' -- Só conta compras aprovadas
group by
  participante.id, --se tiver 2 pessoas com mesmo nome vai separar 
  participante.nome -- Agrupa por participante (id e nome)
having
  COUNT(distinct lote.evento_id) > 1 -- Filtra quem tem mais de 1 evento distinto
order by
  "Eventos Distintos" desc;

-- PERGUNTA 4: Receita total por evento
-- Tabelas: evento, organizador, lote_ingresso, ingresso, compra
-- Filtros: apenas compras aprovadas
-- Agrupamento: por evento e organizador
-- Ordenação: receita decrescente
-- Colunas: título do evento, nome do organizador, soma do valor_total

select
  evento.titulo as "Evento", -- Título do evento
  organizador.nome as "Organizador", -- Nome do organizador
  COALESCE(SUM(compra.valor_total), 0) as "Receita Total" -- COALESCE: se não houver compras, retorna 0 em vez de NULL ( COALESCE(..., 0) ). SUM = soma 
from
  evento
  inner join organizador on evento.organizador_id = organizador.id -- o organizador_id do evento é igual ao id do organizador, entao ele puxa os dados do organizador
  inner join lote_ingresso lote on lote.evento_id = evento.id -- Conecta evento aos seus lotes. Se o evento tiver 2 lotes, aparece 2 vezes
  inner join ingresso on ingresso.lote_id = lote.id -- -- Puxa os ingressos de cada lote cada ingresso vendido gera uma linha
  inner join compra  on ingresso.compra_id = compra.id -- Puxa a compra de cada ingresso onde esta o valortotal e o status da compra
where
  compra.status = 'aprovado' -- Filtra apenas compras aprovadas
group by
  evento.id, -- Garante que cada evento seja um grupo separado (mesmo que dois eventos tenham o mesmo nome)
  evento.titulo,
  organizador.nome -- Agrupa por evento  organizador
order by
  "Receita Total" desc;

-- PERGUNTA 5: Eventos com lote esgotado
-- Tabelas: evento, lote_ingresso
-- Filtro: status do lote igual a 'esgotado'
-- Colunas: título do evento, nome do lote

select
  e.titulo as "Evento", -- Nome do evento
  l.nome as "Lote Esgotado" -- Nome do lote esgotado
from
  evento e
  inner join lote_ingresso l on e.id = l.evento_id -- INNER JOIN: lote pertence a um evento
where
  l.status = 'esgotado'; -- Filtra apenas os lotes que já esgotaram

-- PERGUNTA 6: Percentual de presença em eventos encerrados
-- Tabelas: evento, lote_ingresso, ingresso, checkin
-- Filtros: evento status 'encerrado', ingresso não cancelado
-- Cálculo: check-ins dividido por ingressos válidos, vezes 100
-- Atenção: ingressos sem check-in entram no denominador mas não no numerador
-- Agrupamento: por evento
-- Ordenação: percentual decrescente
-- Colunas: título do evento, percentual com 2 casas decimais

-- PERGUNTA 7: Participantes sem check-in em eventos encerrados
-- Tabelas: participante, compra, ingresso, lote_ingresso, evento, checkin
-- Filtros: evento encerrado, compra aprovada, ingresso não cancelado, checkin inexistente
-- Dica: use junção que mantém os registros da esquerda mesmo sem correspondência na direita
-- Colunas: nome do participante, título do evento, data do evento

select
  p.nome as "Participante", -- Nome do participante
  e.titulo as "Evento", -- Título do evento
  e.data_inicio as "Data do Evento" -- Data de início do evento
from
  participante p
  inner join compra c on p.id = c.participante_id -- liga Participante a compra
  inner join ingresso i on c.id = i.compra_id -- Compra ao ingresso
  inner join lote_ingresso l on i.lote_id = l.id -- Ingresso ao lote
  inner join evento e on l.evento_id = e.id -- Lote ao evento
  and e.status = 'encerrado' -- Apenas eventos encerrados
  left join checkin ck on ck.ingresso_id = i.id -- LEFT JOIN: verifica se houve check-in
where
  ck.id is null
  and i.status in ('valido', 'utilizado') -- Ingresso não cancelado
  and c.status = 'aprovado' -- Compra aprovada
order by
  p.nome;


-- PERGUNTA 8: Organizador com maior receita
-- Tabelas: organizador, evento, lote_ingresso, ingresso, compra
-- Filtros: compras aprovadas
-- Agrupamento: por organizador
-- Ordenação: receita decrescente, trazer só o primeiro
-- Colunas: nome do organizador, valor acumulado

select
  o.nome as "Organizador", -- Nome do organizador
  SUM(c.valor_total) as "Receita Acumulada" -- Soma de todas as compras válidas
from
  organizador o
  inner join evento e on o.id = e.organizador_id -- Organizador tem eventos
  inner join lote_ingresso l on e.id = l.evento_id -- Evento possui lotes
  inner join ingresso i on i.lote_id = l.id -- Lote possui ingressos
  inner join compra c on  inner join compra c oni.lote_id = l.id  -- Ingresso vem de uma compra
where
  c.status = 'aprovado' -- Apenas compras válidas
group by
  o.id,
  o.nome -- Agrupa por organizador
order by
  "Receita Acumulada" desc -- Maior receita primeiro
limit
   1; -- Retorna apenas o organizador com maior receita


-- PERGUNTA 9: Eventos com mais cancelamentos que check-ins
-- Tabelas: evento, lote_ingresso, ingresso, checkin
-- Filtros: separar ingressos cancelados e ingressos válidos
-- Agrupamento: por evento
-- Condição do grupo: contagem de cancelados maior que contagem de check-ins
-- Colunas: título do evento, total de cancelamentos, total de check-ins
select
  e.titulo as "Evento", -- Título do evento
  COUNT(i_cancel.id) as "Cancelamentos", -- Conta ingressos cancelados
  COUNT(ck.id) as "Check-ins" -- Conta check-ins realizados
from
  evento e
  inner join lote_ingresso l on e.id = l.evento_id -- Evento → lotes
  left join ingresso i_cancel on l.id = i_cancel.lote_id -- LEFT JOIN: ingressos cancelados
  and i_cancel.status = 'cancelado' -- Filtra apenas cancelados
  left join ingresso i_valido on l.id = i_valido.lote_id -- LEFT JOIN: ingressos válidos
  and i_valido.status in ('valido', 'utilizado') -- Filtra apenas válidos
  left join checkin ck on i_valido.id = ck.ingresso_id -- LEFT JOIN: check-ins dos válidos
group by
  e.id,
  e.titulo
having
  COUNT(i_cancel.id) > COUNT(ck.id) -- Filtra: cancelamentos > check-ins
order by
  "Cancelamentos" desc;

-- PERGUNTA 10: Categoria mais popular nos últimos 60 dias
-- Tabelas: categoria_evento, evento, lote_ingresso, ingresso, compra
-- Filtros: ingresso não cancelado, compra aprovada, data da compra nos últimos 60 dias a partir de hoje
-- Agrupamento: por categoria
-- Ordenação: total de ingressos decrescente, trazer só a primeira
-- Colunas: nome da categoria, total de ingressos
select
  cat.nome as "Categoria", -- Nome da categoria
  COUNT(i.id) as "Total de Ingressos" -- Conta todos os ingressos válidos
from
  categoria_evento cat
  inner join evento e on cat.id = e.categoria_id -- Categoria → eventos
  inner join lote_ingresso l on e.id = l.evento_id -- Evento → lotes
  inner join ingresso i on l.id = i.lote_id -- Lote → ingressos
  and i.status in ('valido', 'utilizado') -- Apenas ingressos não cancelados
  inner join compra c on i.compra_id = c.id -- Ingresso → compra
  and c.data_compra >= NOW() - INTERVAL '60 days' -- Filtra compras dos últimos 60 dias
  and c.status = 'aprovado' -- Apenas compras aprovadas
group by
  cat.id,
  cat.nome -- Agrupa por categoria
order by
  "Total de Ingressos" desc -- Maior primeiro
limit
  1;

-- PERGUNTA 11: Compras pendentes há mais de 2 dias
-- Tabelas: participante, compra, ingresso, lote_ingresso, evento
-- Filtros: status pendente, data da compra anterior a 2 dias atrás
-- Ordenação: data da compra crescente (mais antigas primeiro)
-- Colunas: nome do participante, título do evento, valor da compra, data da compra
select
  p.nome as "Participante", -- Nome do participante
  e.titulo as "Evento", -- Título do evento
  c.valor_total as "Valor", -- Valor da compra
  c.data_compra as "Data da Compra" -- Data em que a compra foi feita
from
  participante p
  inner join compra c on p.id = c.participante_id -- Participante → compra
  and c.status = 'pendente' -- Apenas compras pendentes
  and c.data_compra < NOW() - INTERVAL '2 days' -- Pendente há mais de 2 dias
  inner join ingresso i on c.id = i.compra_id -- Compra → ingresso
  inner join lote_ingresso l on i.lote_id = l.id -- Ingresso → lote
  inner join evento e on l.evento_id = e.id -- Lote → evento
order by
  c.data_compra asc;

-- PERGUNTA 12: Top 5 eventos por receita por vaga
-- Tabelas: evento, lote_ingresso, ingresso, compra
-- Cálculo: receita total com compras aprovadas dividido pela soma da capacidade de todos os lotes
-- Agrupamento: por evento
-- Ordenação: receita por vaga decrescente, trazer só os 5 primeiros
-- Colunas: título do evento, capacidade total, receita por vaga (2 casas decimais)
select
  e.titulo as "Evento", -- Título do evento
  SUM(l.capacidade_maxima) as "Capacidade Total", -- Soma da capacidade de todos os lotes
  COALESCE(SUM(c.valor_total), 0) as "Receita Total", -- Soma das compras aprovadas
  ROUND(
    COALESCE(SUM(c.valor_total), 0) / SUM(l.capacidade_maxima),
    2
  ) as "Receita por Vaga"
  -- Divide receita total pela capacidade total; ROUND para 2 casas decimais
from
  evento e
  inner join lote_ingresso l on e.id = l.evento_id -- Evento → lotes
  left join ingresso i on l.id = i.lote_id -- LEFT JOIN: lotes sem ingressos
  and i.status in ('valido', 'utilizado') -- Apenas ingressos não cancelados
  left join compra c on i.compra_id = c.id -- LEFT JOIN: ingressos sem compra
  and c.status = 'aprovado' -- Apenas compras aprovadas
group by
  e.id,
  e.titulo
having
  SUM(l.capacidade_maxima) > 0 -- Garante que há capacidade > 0
order by
  "Receita por Vaga" desc
limit
  5;
