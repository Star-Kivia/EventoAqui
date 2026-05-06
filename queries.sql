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

-- PERGUNTA 4: Receita total por evento
-- Tabelas: evento, organizador, lote_ingresso, ingresso, compra
-- Filtros: apenas compras aprovadas
-- Agrupamento: por evento e organizador
-- Ordenação: receita decrescente
-- Colunas: título do evento, nome do organizador, soma do valor_total

-- PERGUNTA 5: Eventos com lote esgotado
-- Tabelas: evento, lote_ingresso
-- Filtro: status do lote igual a 'esgotado'
-- Colunas: título do evento, nome do lote

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

-- PERGUNTA 8: Organizador com maior receita
-- Tabelas: organizador, evento, lote_ingresso, ingresso, compra
-- Filtros: compras aprovadas
-- Agrupamento: por organizador
-- Ordenação: receita decrescente, trazer só o primeiro
-- Colunas: nome do organizador, valor acumulado

-- PERGUNTA 9: Eventos com mais cancelamentos que check-ins
-- Tabelas: evento, lote_ingresso, ingresso, checkin
-- Filtros: separar ingressos cancelados e ingressos válidos
-- Agrupamento: por evento
-- Condição do grupo: contagem de cancelados maior que contagem de check-ins
-- Colunas: título do evento, total de cancelamentos, total de check-ins

-- PERGUNTA 10: Categoria mais popular nos últimos 60 dias
-- Tabelas: categoria_evento, evento, lote_ingresso, ingresso, compra
-- Filtros: ingresso não cancelado, compra aprovada, data da compra nos últimos 60 dias a partir de hoje
-- Agrupamento: por categoria
-- Ordenação: total de ingressos decrescente, trazer só a primeira
-- Colunas: nome da categoria, total de ingressos

-- PERGUNTA 11: Compras pendentes há mais de 2 dias
-- Tabelas: participante, compra, ingresso, lote_ingresso, evento
-- Filtros: status pendente, data da compra anterior a 2 dias atrás
-- Ordenação: data da compra crescente (mais antigas primeiro)
-- Colunas: nome do participante, título do evento, valor da compra, data da compra

-- PERGUNTA 12: Top 5 eventos por receita por vaga
-- Tabelas: evento, lote_ingresso, ingresso, compra
-- Cálculo: receita total com compras aprovadas dividido pela soma da capacidade de todos os lotes
-- Agrupamento: por evento
-- Ordenação: receita por vaga decrescente, trazer só os 5 primeiros
-- Colunas: título do evento, capacidade total, receita por vaga (2 casas decimais)
