# EventoAqui — Banco de Dados

Projeto final da formação Dev Junior da CajuHub. O objetivo foi construir do zero o banco de dados central de uma plataforma fictícia de venda de ingressos chamada **EventoAqui**.

---

## O problema que o banco resolve

A EventoAqui conecta organizadores de eventos com o público, mas cada organizador controlava suas vendas em planilhas próprias — sem padrão, sem visibilidade central. O banco foi construído para centralizar toda a operação: cadastro de eventos, controle de lotes e capacidade, compras, ingressos individuais com código único de validação e registro de entrada no evento (check-in).

---

## Squad

| Nome | Papel |
|------|-------|
| Kivia | Tech Lead |
| Kauan Oliveira | Dev Junior |
| Kauã Vicente | Dev Junior |
| Isac | Dev Junior |
| Gabriel | Dev Junior |
| Vitor | Dev Junior |

---

## Arquivos do projeto

| Arquivo | O que tem dentro |
|---------|-----------------|
| `schema.sql` | Criação de todas as tabelas com constraints e relacionamentos |
| `seed.sql` | Dados simulados cobrindo dois meses de operação |
| `queries.sql` | 12 consultas respondendo as perguntas de negócio do briefing |
| `views.sql` | As duas views do painel de operações e do relatório financeiro |
| `transaction.sql` | Cancelamento de compra com ROLLBACK forçado demonstrado |
| `README.md` | Este arquivo |

---

## Diagrama ER

O banco tem 8 tabelas. A hierarquia de dependências fica assim:

```
organizador (pai)
    └── evento (filha)              [1 organizador → N eventos]
            ├── categoria_evento    (referenciada, independente)
            └── lote_ingresso (filha)       [1 evento → N lotes]
                    └── ingresso (neta)     [1 lote → N ingressos]
                            └── checkin (bisneta)  [1 ingresso → 0..1 check-in]

participante (pai independente)
    └── compra (filha)              [1 participante → N compras]
            └── ingresso (filha)    [1 compra → N ingressos]
```

### Cardinalidades

| Relacionamento | Tipo | Descrição |
|----------------|------|-----------|
| `organizador` → `evento` | 1:N | Um organizador publica vários eventos |
| `categoria_evento` → `evento` | 1:N | Uma categoria classifica vários eventos |
| `evento` → `lote_ingresso` | 1:N | Um evento tem múltiplos lotes |
| `lote_ingresso` → `ingresso` | 1:N | Um lote gera vários ingressos individuais |
| `participante` → `compra` | 1:N | Um participante faz várias compras |
| `compra` → `ingresso` | 1:N | Uma compra contém um ou mais ingressos |
| `ingresso` → `checkin` | 1:0..1 | Cada ingresso tem zero ou um check-in |

Não existe N:N explícito no modelo. A relação entre `participante` e `evento` é naturalmente N:N, mas é resolvida pela cadeia `compra → ingresso`, que já faz esse papel com significado de negócio real: um participante não "vai a um evento" de forma abstrata, ele compra um ingresso de um lote daquele evento.

---

## Decisões de modelagem

### Por que `lote_ingresso` e `ingresso` são entidades separadas?

**Lote** é um tipo de acesso — tem nome, preço e capacidade (ex: "VIP", "Meia-entrada"). **Ingresso** é uma unidade individual desse acesso, com código único de validação e histórico de uso.

Juntar os dois em uma tabela só inviabilizaria o controle de capacidade (quantos já foram vendidos desse lote?), tornaria impossível rastrear cada ingresso individualmente e quebraria a unicidade do código de entrada.

### Como foi garantida a unicidade do código do ingresso?

```sql
codigo VARCHAR(20) UNIQUE NOT NULL
```

A constraint `UNIQUE` no campo `codigo` garante em nível de banco que dois ingressos jamais terão o mesmo código — mesmo que a aplicação tente inserir um duplicado, o PostgreSQL rejeita com erro. Não é uma convenção de código, é uma regra do banco.

### O que acontece ao tentar deletar um evento com compras?

O schema usa `ON DELETE RESTRICT` em todas as FKs:

```sql
organizador_id INTEGER NOT NULL REFERENCES organizador(id) ON DELETE RESTRICT
```

O PostgreSQL bloqueia a deleção de qualquer registro pai que ainda tenha filhos vinculados. Tentar apagar um organizador com eventos, ou um evento com lotes, resulta em erro. A decisão foi intencional: dados históricos de negócio não devem ser apagados silenciosamente.

### Por que `checkin` é uma entidade separada e não um campo no `ingresso`?

Um campo `data_checkin` no ingresso responderia *quando* alguém entrou, mas não *quem validou*. A entidade `checkin` armazena o timestamp de entrada e o responsável pela validação (porteiro), permitindo auditoria. Além disso, separa responsabilidades: `ingresso` guarda dados de compra e acesso, `checkin` modela o ato físico de entrada no evento.

### Por que `NUMERIC(10,2)` e não `REAL` ou `FLOAT` para preços?

`REAL` e `FLOAT` são tipos de ponto flutuante com imprecisão binária — somar centenas de transações financeiras produziria erros de arredondamento invisíveis. `NUMERIC(10,2)` é precisão exata, padrão para qualquer valor monetário em banco relacional.

### Por que `TIMESTAMPTZ` e não `TIMESTAMP`?

`TIMESTAMPTZ` armazena o instante em UTC e converte automaticamente para o fuso horário do cliente. Como a EventoAqui opera em múltiplas cidades, usar `TIMESTAMP` sem fuso poderia gerar inconsistências em datas de início de eventos e registros de compra.

### Por que a `categoria_evento` tem um CHECK com valores fixos?

```sql
CHECK (nome IN ('show', 'festival', 'workshop', 'palestra', 'teatro', 'esporte'))
```

O briefing define exatamente 6 categorias válidas. Usar `CHECK` em vez de deixar o campo livre garante que nenhum dado inconsistente entre no banco — sem precisar de uma tabela de lookup separada para algo que o negócio trata como enumeração fechada.

### Por que `UNIQUE(evento_id, nome)` na tabela `lote_ingresso`?

Impede que um mesmo evento tenha dois lotes com o mesmo nome (ex: dois lotes "VIP" no mesmo show). A unicidade é composta — o mesmo nome pode existir em eventos diferentes, mas não dentro do mesmo evento.

### Por que `NOT NULL` em tantas colunas?

`NOT NULL` impede que um campo seja salvo sem valor. Foi aplicado em todos os campos obrigatórios para o negócio funcionar — como `nome`, `email`, `cpf`, `titulo` e `status`. Sem isso, o banco aceitaria um evento sem título ou um participante sem CPF, quebrando todas as queries que dependem desses campos.

### Por que alguns campos têm `DEFAULT`?

`DEFAULT` define um valor automático quando o campo não é informado na inserção. Foi usado em três situações: `status DEFAULT 'ativo'` (novo cadastro começa ativo), `status DEFAULT 'rascunho'` (novo evento começa como rascunho) e `DEFAULT NOW()` nos campos de data (timestamp preenchido automaticamente no momento da inserção, sem depender da aplicação).

### Por que `SERIAL` para as PKs e não `BIGINT` ou `UUID`?

`SERIAL` cria um inteiro auto-incremental (1, 2, 3...) como chave primária. Foi escolhido por ser simples, direto e suficiente para o volume desta plataforma. `BIGINT` seria necessário para volumes na casa dos bilhões. `UUID` seria mais adequado para sistemas distribuídos onde múltiplos servidores geram IDs simultaneamente — desnecessário para um banco centralizado como esse.

---

## Dados do seed

Todos os volumes mínimos exigidos pelo briefing foram atingidos:

| Requisito | Mínimo exigido | Entregue |
|-----------|---------------|---------|
| Organizadores (com ao menos 1 suspenso) | 5 | 5 ✅ |
| Categorias de evento | 5 | 6 ✅ |
| Eventos com status variados e datas em 2+ meses | 10 | 10 ✅ |
| Lotes por evento (com preços diferentes) | 2+ | 2 por evento ✅ |
| Participantes cadastrados (com ao menos 1 banido) | 50 | 50 ✅ |
| Compras com status variados | 80 | 80 ✅ |
| Códigos de ingresso únicos | todos únicos | ✅ |
| Check-ins em eventos encerrados | 30 | 30+ ✅ |
| Compras canceladas ou estornadas | 10 | 10+ ✅ |

---

## Lógica das queries

### Query 1 — Eventos publicados com data futura

Filtra eventos com `status = 'publicado'` e `data_inicio > NOW()`. Usa `INNER JOIN` com `organizador` e `categoria_evento` para trazer o nome do organizador e da categoria junto. Ordenado por `data_inicio ASC` para o evento mais próximo aparecer primeiro.

### Query 2 — Ocupação por lote

Para cada lote, conta quantos ingressos existem com `status IN ('valido', 'utilizado')` e divide pela `capacidade_maxima`. O `LEFT JOIN` no ingresso é necessário: se fosse `INNER JOIN`, lotes sem nenhum ingresso vendido desapareceriam do resultado em vez de aparecer com 0% de ocupação — o que mascararia lotes vazios.

```
Ocupação (%) = (ingressos válidos / capacidade_maxima) × 100
```

### Query 3 — Participantes com mais de um evento diferente

Percorre a cadeia `participante → compra → ingresso → lote_ingresso` e usa `COUNT(DISTINCT lote.evento_id)` para contar quantos eventos distintos cada participante comprou. O `DISTINCT` é obrigatório porque um participante pode ter comprado mais de um ingresso para o mesmo evento — sem ele, o contador inflaria. O `HAVING > 1` filtra só quem foi a mais de um evento diferente.

### Query 4 — Receita total por evento

Percorre `evento → lote_ingresso → ingresso → compra` e soma `valor_total` apenas das compras `status = 'aprovado'`. O `COALESCE(..., 0)` garante que eventos sem nenhuma compra aprovada aparecem com R$ 0,00 em vez de NULL, o que quebraria a ordenação.

### Query 5 — Eventos com lote esgotado

`INNER JOIN` entre `evento` e `lote_ingresso` com filtro `l.status = 'esgotado'`. Como é `INNER JOIN`, só aparecem eventos que realmente têm pelo menos um lote esgotado — que é exatamente o que a pergunta pede. Um `LEFT JOIN` aqui traria todos os eventos, inclusive os sem lote esgotado.

### Query 6 — Percentual de presença em eventos encerrados

O denominador são todos os ingressos `status IN ('valido', 'utilizado')` — vendidos e não cancelados. O numerador são apenas os que têm um `checkin` vinculado. O `LEFT JOIN` no checkin é obrigatório: se fosse `INNER JOIN`, eventos onde ninguém fez check-in desapareceriam do resultado em vez de aparecer com 0%.

```
Presença (%) = (check-ins realizados / ingressos válidos vendidos) × 100
```

### Query 7 — Participantes que compraram mas não fizeram check-in

Usa o padrão clássico de `LEFT JOIN + WHERE IS NULL` para encontrar "quem não fez algo". A lógica: percorre `participante → compra → ingresso → lote → evento` e faz um `LEFT JOIN` com `checkin`. Quando não existe check-in, o campo `ck.id` vem NULL. O `WHERE ck.id IS NULL` filtra exatamente esses casos.

Se fosse `INNER JOIN` com checkin, o resultado seria o oposto — só apareceriam quem fez check-in. O `LEFT JOIN` mantém no resultado todos os participantes (inclusive os sem check-in) para depois o `IS NULL` filtrar só os que não foram.

### Query 8 — Organizador com maior receita total

Mesma lógica da query 4, mas agrupando por organizador em vez de evento. Soma todas as compras aprovadas de todos os eventos de cada organizador. O `LIMIT 1` no final retorna só o primeiro da lista, que é o de maior receita.

### Query 9 — Eventos com mais cancelamentos do que check-ins

Usa dois `LEFT JOIN` separados na tabela `ingresso` com aliases diferentes (`i_cancel` e `i_valido`) para contar duas coisas ao mesmo tempo dentro do mesmo `GROUP BY`. Um alias filtra `status = 'cancelado'`, o outro filtra `status IN ('valido', 'utilizado')`. Se fosse um único JOIN sem alias, as contagens se misturariam e o resultado ficaria errado.

O `HAVING COUNT(i_cancel.id) > COUNT(ck.id)` compara as duas contagens depois do agrupamento — esse filtro não pode ficar no `WHERE` porque os valores agregados só existem depois do `GROUP BY`.

### Query 10 — Categoria mais popular nos últimos 60 dias

Percorre `categoria_evento → evento → lote_ingresso → ingresso → compra` e filtra por `c.data_compra >= NOW() - INTERVAL '60 days'` e `c.status = 'aprovado'`. Agrupa por categoria e conta os ingressos vendidos. O `LIMIT 1` retorna só a categoria com mais vendas no período.

### Query 11 — Compras pendentes há mais de 2 dias

Filtra compras com `status = 'pendente'` e `data_compra < NOW() - INTERVAL '2 days'`. Ordenado por `data_compra ASC` — o mais antigo primeiro — para o time de pagamentos priorizar os casos mais urgentes.

### Query 12 — Top 5 receita por vaga

Divide a receita total de compras aprovadas pela soma da capacidade de todos os lotes do evento. O `LEFT JOIN` em `ingresso` e `compra` garante que eventos sem nenhuma venda apareçam com receita 0 em vez de sumirem do resultado. O `HAVING SUM(l.capacidade_maxima) > 0` protege contra divisão por zero. O `LIMIT 5` retorna só o top 5.

```
Receita por vaga = soma das compras aprovadas / soma das capacidades dos lotes
```

---

## Views

### `painel_eventos_ativos`

Relatório diário do time de operações. Retorna todos os eventos com `status = 'publicado'`, mostrando título, organizador, data de início, cidade, categoria, total de ingressos vendidos e capacidade restante.

A view é dinâmica: assim que um novo ingresso é vendido, o `COUNT` e o cálculo de capacidade restante são atualizados automaticamente na próxima consulta — sem nenhuma atualização manual.

### `receita_por_organizador`

Relatório financeiro mensal. Exibe apenas organizadores com pelo menos uma compra aprovada (`HAVING COUNT(DISTINCT c.id) > 0`). Mostra total de eventos, total de compras aprovadas e receita acumulada.

O filtro `c.status = 'aprovado'` é aplicado diretamente na `compra`, sem depender do status dos ingressos. Isso garante que a receita reflita o negócio corretamente: compra aprovada equivale a receita gerada, independente do que aconteceu com os ingressos depois. Eventos cancelados não entram na conta porque suas compras associadas não passam pelo filtro de `status = 'aprovado'`.

---

## Transaction — Cancelamento de compra

### O cenário

Quando um participante cancela uma compra aprovada, três operações precisam acontecer juntas:

1. `UPDATE compra SET status = 'cancelado'`
2. `UPDATE ingresso SET status = 'cancelado'` para todos os ingressos daquela compra
3. As vagas são liberadas automaticamente — ingressos cancelados param de ser contados nas queries de ocupação, que filtram por `status IN ('valido', 'utilizado')`

### Por que as três operações precisam ser atômicas?

Se o banco falhar depois da operação 1 e antes da operação 2, a compra estaria cancelada mas os ingressos ainda estariam válidos — bloqueando vagas que deveriam estar livres e quebrando o controle de capacidade. A transaction garante que tudo acontece junto ou nada acontece.

### Como a operação 3 libera a capacidade sem UPDATE no lote?

O banco não guarda um contador de vagas em lugar nenhum. A capacidade disponível é sempre calculada na hora: `capacidade_maxima - COUNT(ingressos com status 'valido' ou 'utilizado')`. Quando o ingresso muda para `'cancelado'`, ele para de entrar nessa conta automaticamente — a vaga fica livre na próxima consulta sem precisar de nenhum UPDATE adicional no lote.

### O que o ROLLBACK prova?

Que as três operações são atômicas. O SELECT feito dentro da transaction mostra os dados já atualizados — mas isso é só a visão isolada daquela sessão. Quando o ROLLBACK é executado, o banco descarta tudo. O SELECT depois do ROLLBACK confirma: compra volta para `'aprovado'`, ingressos voltam para `'valido'`. Prova que sem o COMMIT, nada persiste.

---

## Como executar

Execute os arquivos nessa ordem no Supabase ou em qualquer cliente PostgreSQL:

```
1. schema.sql       → cria todas as tabelas e constraints
2. seed.sql         → popula o banco com dados simulados
3. queries.sql      → executa as 12 queries de negócio
4. views.sql        → cria e consulta as duas views
5. transaction.sql  → demonstra a transaction com ROLLBACK
```

O `schema.sql` precisa rodar antes de todos os outros. Depois do seed, a ordem dos demais não importa.

---

## Tecnologias

- **PostgreSQL** — banco de dados relacional
- **SQL** — linguagem de consulta e definição de dados
- **Supabase** — ambiente de execução e apresentação
