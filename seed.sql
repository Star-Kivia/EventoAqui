-- SEED.SQL

-- Dados de exemplo para o banco EventoAqui
-- Volumes mínimos conforme briefing 

-- 1. CATEGORIA_EVENTO (6 categorias)
insert into
  categoria_evento (nome)
values
  ('show'),
  ('festival'),
  ('workshop'),
  ('palestra'),
  ('teatro'),
  ('esporte');

-- 2. ORGANIZADOR (5 organizadores, 1 suspenso)
insert into
  organizador (nome, documento, contato, cidade, status)
values
  (
    'Som & Cia Produções',
    '12345678000199',
    'contato@somcia.com',
    'São Paulo',
    'ativo'
  ),
  (
    'Festival Brasil Ltda',
    '98765432000188',
    'comercial@festivalbrasil.com',
    'Rio de Janeiro',
    'ativo'
  ),
  (
    'Cultura Viva Eventos',
    '45678901000177',
    'cultura@culturaviva.com',
    'Belo Horizonte',
    'ativo'
  ),
  (
    'Tech Talks Organização',
    '78901234000166',
    'eventos@techtalks.com',
    'Curitiba',
    'ativo'
  ),
  (
    'Mega Eventos S.A.',
    '32109876000155',
    'mega@megaeventos.com',
    'Salvador',
    'suspenso'
  );

-- 3. EVENTO (10 eventos, status variados, 2 meses diferentes)
-- Mês 1: Julho/2026
insert into
  evento (
    titulo,
    descricao,
    data_inicio,
    data_fim,
    local,
    cidade,
    status,
    organizador_id,
    categoria_id
  )
values
  (
    'Rock na Praça',
    'Show de rock com bandas locais',
    '2026-07-15 20:00:00-03',
    '2026-07-15 23:00:00-03',
    'Praça Central',
    'São Paulo',
    'encerrado',
    1,
    1
  ),
  (
    'Festival de Inverno',
    'Festival com música, gastronomia e arte',
    '2026-07-20 10:00:00-03',
    '2026-07-22 22:00:00-03',
    'Parque Municipal',
    'Belo Horizonte',
    'encerrado',
    3,
    2
  ),
  (
    'Workshop de Fotografia',
    'Fotografia para iniciantes',
    '2026-07-25 14:00:00-03',
    '2026-07-25 18:00:00-03',
    'Centro Cultural',
    'Curitiba',
    'cancelado',
    4,
    3
  ),
  (
    'Palestra: O Futuro da IA',
    'Tendências de inteligência artificial',
    '2026-07-28 19:00:00-03',
    '2026-07-28 21:00:00-03',
    'Auditório Tech',
    'São Paulo',
    'encerrado',
    4,
    4
  ),
  (
    'Teatro: A Comédia da Vida',
    'Peça teatral comédia',
    '2026-07-30 20:00:00-03',
    '2026-07-30 22:30:00-03',
    'Teatro Municipal',
    'Rio de Janeiro',
    'encerrado',
    2,
    5
  );

-- Mês 2: Agosto/2026 (datas futuras)
insert into
  evento (
    titulo,
    descricao,
    data_inicio,
    data_fim,
    local,
    cidade,
    status,
    organizador_id,
    categoria_id
  )
values
  (
    'Campeonato de Vôlei',
    'Torneio regional de vôlei',
    '2026-08-05 09:00:00-03',
    '2026-08-05 18:00:00-03',
    'Ginásio Esportivo',
    'Salvador',
    'publicado',
    1,
    6
  ),
  (
    'Show do Djavan',
    'Show acústico do Djavan',
    '2026-08-10 21:00:00-03',
    '2026-08-10 23:30:00-03',
    'Arena Central',
    'Rio de Janeiro',
    'publicado',
    2,
    1
  ),
  (
    'Festival de Teatro',
    'Mostra competitiva de teatro',
    '2026-08-15 14:00:00-03',
    '2026-08-17 22:00:00-03',
    'Centro de Convenções',
    'Belo Horizonte',
    'publicado',
    3,
    5
  ),
  (
    'Workshop de SQL',
    'Banco de dados para iniciantes',
    '2026-08-20 08:00:00-03',
    '2026-08-20 12:00:00-03',
    'Sala de Eventos Tech',
    'Curitiba',
    'rascunho',
    4,
    3
  ),
  (
    'Palestra: Empreendedorismo',
    'Como abrir seu negócio',
    '2026-08-25 19:00:00-03',
    '2026-08-25 21:00:00-03',
    'Auditório Central',
    'São Paulo',
    'publicado',
    1,
    4
  );

-- 4. LOTE_INGRESSO (2 lotes por evento = 20 lotes)
-- Evento 1: Rock na Praça
insert into
  lote_ingresso (nome, preco, capacidade_maxima, status, evento_id)
values
  ('Inteira', 50.00, 100, 'encerrado', 1),
  ('Meia-entrada', 25.00, 50, 'encerrado', 1);

-- Evento 2: Festival de Inverno
insert into
  lote_ingresso (nome, preco, capacidade_maxima, status, evento_id)
values
  ('Inteira', 120.00, 200, 'encerrado', 2),
  ('VIP', 200.00, 50, 'encerrado', 2);

-- Evento 3: Workshop de Fotografia (cancelado)
insert into
  lote_ingresso (nome, preco, capacidade_maxima, status, evento_id)
values
  ('Inteira', 80.00, 30, 'encerrado', 3),
  ('Meia-entrada', 40.00, 20, 'encerrado', 3);

-- Evento 4: Palestra IA
insert into
  lote_ingresso (nome, preco, capacidade_maxima, status, evento_id)
values
  ('Inteira', 30.00, 150, 'encerrado', 4),
  ('Meia-entrada', 15.00, 80, 'encerrado', 4);

-- Evento 5: Teatro Comédia
insert into
  lote_ingresso (nome, preco, capacidade_maxima, status, evento_id)
values
  ('Inteira', 60.00, 120, 'encerrado', 5),
  ('VIP', 100.00, 40, 'encerrado', 5);

-- Evento 6: Vôlei
insert into
  lote_ingresso (nome, preco, capacidade_maxima, status, evento_id)
values
  ('Inteira', 20.00, 200, 'disponivel', 6),
  ('Meia-entrada', 10.00, 100, 'disponivel', 6);

-- Evento 7: Djavan
insert into
  lote_ingresso (nome, preco, capacidade_maxima, status, evento_id)
values
  ('Inteira', 150.00, 300, 'disponivel', 7),
  ('VIP', 250.00, 80, 'disponivel', 7);

-- Evento 8: Festival de Teatro
insert into
  lote_ingresso (nome, preco, capacidade_maxima, status, evento_id)
values
  ('Inteira', 90.00, 150, 'disponivel', 8),
  ('Meia-entrada', 45.00, 100, 'disponivel', 8);

-- Evento 9: Workshop SQL (rascunho)
insert into
  lote_ingresso (nome, preco, capacidade_maxima, status, evento_id)
values
  ('Inteira', 100.00, 40, 'disponivel', 9),
  ('Meia-entrada', 50.00, 20, 'disponivel', 9);

-- Evento 10: Empreendedorismo
insert into
  lote_ingresso (nome, preco, capacidade_maxima, status, evento_id)
values
  ('Inteira', 40.00, 100, 'disponivel', 10),
  ('VIP', 70.00, 50, 'disponivel', 10);

-- 5. PARTICIPANTE (50 participantes, 1 banido)
insert into
  participante (nome, email, cpf, data_nascimento, status)
values
  (
    'Ana Silva',
    'ana.silva@email.com',
    '11122233344',
    '1995-03-15',
    'ativo'
  ),
  (
    'Bruno Costa',
    'bruno.costa@email.com',
    '22233344455',
    '1990-07-20',
    'ativo'
  ),
  (
    'Carla Mendes',
    'carla.mendes@email.com',
    '33344455566',
    '1988-12-01',
    'ativo'
  ),
  (
    'Daniel Oliveira',
    'daniel.oliveira@email.com',
    '44455566677',
    '2000-01-25',
    'ativo'
  ),
  (
    'Eduarda Lima',
    'eduarda.lima@email.com',
    '55566677788',
    '1993-05-30',
    'ativo'
  ),
  (
    'Fernando Santos',
    'fernando.santos@email.com',
    '66677788899',
    '1985-09-10',
    'ativo'
  ),
  (
    'Gabriela Rocha',
    'gabriela.rocha@email.com',
    '77788899900',
    '1998-11-22',
    'ativo'
  ),
  (
    'Henrique Alves',
    'henrique.alves@email.com',
    '88899900011',
    '1996-04-17',
    'ativo'
  ),
  (
    'Isabela Ferreira',
    'isabela.ferreira@email.com',
    '99900011122',
    '1987-06-08',
    'ativo'
  ),
  (
    'João Pedro',
    'joao.pedro@email.com',
    '00011122233',
    '1992-08-14',
    'ativo'
  ),
  (
    'Karina Souza',
    'karina.souza@email.com',
    '12121212121',
    '1999-02-28',
    'ativo'
  ),
  (
    'Lucas Martins',
    'lucas.martins@email.com',
    '13131313131',
    '1986-10-05',
    'ativo'
  ),
  (
    'Mariana Dias',
    'mariana.dias@email.com',
    '14141414141',
    '1994-07-12',
    'ativo'
  ),
  (
    'Nicolas Borges',
    'nicolas.borges@email.com',
    '15151515151',
    '1991-03-19',
    'ativo'
  ),
  (
    'Olivia Castro',
    'olivia.castro@email.com',
    '16161616161',
    '1997-12-25',
    'ativo'
  ),
  (
    'Paulo Henrique',
    'paulo.henrique@email.com',
    '17171717171',
    '1989-01-30',
    'banido'
  ),
  (
    'Quésia Andrade',
    'quesia.andrade@email.com',
    '18181818181',
    '1984-06-14',
    'ativo'
  ),
  (
    'Rafael Torres',
    'rafael.torres@email.com',
    '19191919191',
    '2001-09-03',
    'ativo'
  ),
  (
    'Sabrina Costa',
    'sabrina.costa@email.com',
    '20202020202',
    '1990-11-08',
    'ativo'
  ),
  (
    'Thiago Nunes',
    'thiago.nunes@email.com',
    '21212121212',
    '1983-04-21',
    'ativo'
  ),
  (
    'Úrsula Menezes',
    'ursula.menezes@email.com',
    '22222222222',
    '1996-08-17',
    'ativo'
  ),
  (
    'Vinicius Cardoso',
    'vinicius.cardoso@email.com',
    '23232323232',
    '1988-02-10',
    'ativo'
  ),
  (
    'Wanda Freitas',
    'wanda.freitas@email.com',
    '24242424242',
    '1993-07-05',
    'ativo'
  ),
  (
    'Xavier Lopes',
    'xavier.lopes@email.com',
    '25252525252',
    '1987-12-29',
    'ativo'
  ),
  (
    'Yara Barbosa',
    'yara.barbosa@email.com',
    '26262626262',
    '1995-05-16',
    'ativo'
  ),
  (
    'Zeca Moura',
    'zeca.moura@email.com',
    '27272727272',
    '1992-10-11',
    'ativo'
  ),
  (
    'Aline Ramos',
    'aline.ramos@email.com',
    '28282828282',
    '1986-03-07',
    'ativo'
  ),
  (
    'Bernardo Cruz',
    'bernardo.cruz@email.com',
    '29292929292',
    '1998-01-13',
    'ativo'
  ),
  (
    'Camila Teixeira',
    'camila.teixeira@email.com',
    '30303030303',
    '1991-06-22',
    'ativo'
  ),
  (
    'Diego Pires',
    'diego.pires@email.com',
    '31313131313',
    '1989-09-18',
    'ativo'
  ),
  (
    'Elaine Macedo',
    'elaine.macedo@email.com',
    '32323232323',
    '1997-04-25',
    'ativo'
  ),
  (
    'Fábio Santana',
    'fabio.santana@email.com',
    '33333333333',
    '1994-08-09',
    'ativo'
  ),
  (
    'Gisele Campos',
    'gisele.campos@email.com',
    '34343434343',
    '1985-12-03',
    'ativo'
  ),
  (
    'Hugo Barros',
    'hugo.barros@email.com',
    '35353535353',
    '2000-07-27',
    'ativo'
  ),
  (
    'Ingrid Cavalcanti',
    'ingrid.cavalcanti@email.com',
    '36363636363',
    '1993-02-14',
    'ativo'
  ),
  (
    'Júlio Carvalho',
    'julio.carvalho@email.com',
    '37373737373',
    '1988-05-19',
    'ativo'
  ),
  (
    'Larissa Gomes',
    'larissa.gomes@email.com',
    '38383838383',
    '1996-11-02',
    'ativo'
  ),
  (
    'Marcos Vinicius',
    'marcos.vinicius@email.com',
    '39393939393',
    '1990-04-06',
    'ativo'
  ),
  (
    'Natália Farias',
    'natalia.farias@email.com',
    '40404040404',
    '1987-09-30',
    'ativo'
  ),
  (
    'Otávio Ribeiro',
    'otavio.ribeiro@email.com',
    '41414141414',
    '1999-06-11',
    'ativo'
  ),
  (
    'Patrícia Neves',
    'patricia.neves@email.com',
    '42424242424',
    '1984-01-26',
    'ativo'
  ),
  (
    'Renato Duarte',
    'renato.duarte@email.com',
    '43434343434',
    '1992-12-08',
    'ativo'
  ),
  (
    'Sandra Azevedo',
    'sandra.azevedo@email.com',
    '44444444444',
    '1995-07-22',
    'ativo'
  ),
  (
    'Túlio Marques',
    'tulio.marques@email.com',
    '45454545454',
    '1986-10-31',
    'ativo'
  ),
  (
    'Valéria Franco',
    'valeria.franco@email.com',
    '46464646464',
    '1998-03-17',
    'ativo'
  ),
  (
    'William Dantas',
    'william.dantas@email.com',
    '47474747474',
    '1991-08-04',
    'ativo'
  ),
  (
    'Ximena Rangel',
    'ximena.rangel@email.com',
    '48484848484',
    '1989-12-20',
    'ativo'
  ),
  (
    'Yuri Peixoto',
    'yuri.peixoto@email.com',
    '49494949494',
    '2001-05-09',
    'ativo'
  ),
  (
    'Zilda Correia',
    'zilda.correia@email.com',
    '50505050505',
    '1994-02-28',
    'ativo'
  ),
  (
    'Arthur Lemos',
    'arthur.lemos@email.com',
    '51515151515',
    '1987-07-15',
    'ativo'
  );

-- 6. COMPRA (80 compras com status variados)
-- Compras de eventos encerrados (Julho)
insert into
  compra (
    data_compra,
    valor_total,
    metodo_pagamento,
    status,
    participante_id
  )
values
  (
    '2026-07-10 15:30:00-03',
    50.00,
    'pix',
    'aprovado',
    1
  ),
  (
    '2026-07-10 16:00:00-03',
    25.00,
    'cartao',
    'aprovado',
    2
  ),
  (
    '2026-07-11 10:00:00-03',
    50.00,
    'pix',
    'aprovado',
    3
  ),
  (
    '2026-07-12 14:00:00-03',
    100.00,
    'cartao',
    'aprovado',
    4
  ),
  (
    '2026-07-13 09:00:00-03',
    120.00,
    'pix',
    'aprovado',
    5
  ),
  (
    '2026-07-13 11:00:00-03',
    200.00,
    'cartao',
    'aprovado',
    6
  ),
  (
    '2026-07-14 16:00:00-03',
    80.00,
    'pix',
    'cancelado',
    7
  ),
  (
    '2026-07-15 08:00:00-03',
    40.00,
    'cartao',
    'cancelado',
    8
  ),
  (
    '2026-07-15 12:00:00-03',
    30.00,
    'pix',
    'aprovado',
    9
  ),
  (
    '2026-07-16 14:00:00-03',
    15.00,
    'cartao',
    'aprovado',
    10
  ),
  (
    '2026-07-17 10:00:00-03',
    60.00,
    'pix',
    'aprovado',
    11
  ),
  (
    '2026-07-18 11:00:00-03',
    100.00,
    'cartao',
    'aprovado',
    12
  ),
  (
    '2026-07-18 15:00:00-03',
    50.00,
    'pix',
    'cancelado',
    13
  ),
  (
    '2026-07-19 09:00:00-03',
    25.00,
    'cartao',
    'aprovado',
    14
  ),
  (
    '2026-07-20 16:00:00-03',
    120.00,
    'pix',
    'aprovado',
    15
  ),
  (
    '2026-07-21 08:00:00-03',
    200.00,
    'cartao',
    'aprovado',
    16
  ),
  (
    '2026-07-22 12:00:00-03',
    50.00,
    'pix',
    'aprovado',
    17
  ),
  (
    '2026-07-23 14:00:00-03',
    25.00,
    'cartao',
    'aprovado',
    18
  ),
  (
    '2026-07-24 10:00:00-03',
    60.00,
    'pix',
    'aprovado',
    19
  ),
  (
    '2026-07-25 11:00:00-03',
    100.00,
    'cartao',
    'estornado',
    20
  ),
  (
    '2026-07-25 15:00:00-03',
    30.00,
    'pix',
    'aprovado',
    21
  ),
  (
    '2026-07-26 09:00:00-03',
    15.00,
    'cartao',
    'aprovado',
    22
  ),
  (
    '2026-07-27 16:00:00-03',
    120.00,
    'pix',
    'aprovado',
    23
  ),
  (
    '2026-07-28 08:00:00-03',
    200.00,
    'cartao',
    'aprovado',
    24
  ),
  (
    '2026-07-28 12:00:00-03',
    60.00,
    'pix',
    'cancelado',
    25
  ),
  (
    '2026-07-29 14:00:00-03',
    100.00,
    'cartao',
    'cancelado',
    26
  ),
  (
    '2026-07-30 10:00:00-03',
    80.00,
    'pix',
    'cancelado',
    27
  ),
  (
    '2026-07-30 11:00:00-03',
    40.00,
    'cartao',
    'aprovado',
    28
  ),
  (
    '2026-07-31 15:00:00-03',
    30.00,
    'pix',
    'aprovado',
    29
  ),
  (
    '2026-07-31 09:00:00-03',
    15.00,
    'cartao',
    'aprovado',
    30
  );

-- Compras canceladas extras (evento cancelado)
insert into
  compra (
    data_compra,
    valor_total,
    metodo_pagamento,
    status,
    participante_id
  )
values
  (
    '2026-07-20 10:00:00-03',
    80.00,
    'pix',
    'cancelado',
    31
  ),
  (
    '2026-07-20 14:00:00-03',
    40.00,
    'cartao',
    'cancelado',
    32
  );

-- Compras de eventos publicados (Agosto)
insert into
  compra (
    data_compra,
    valor_total,
    metodo_pagamento,
    status,
    participante_id
  )
values
  (
    '2026-08-01 10:00:00-03',
    20.00,
    'pix',
    'aprovado',
    33
  ),
  (
    '2026-08-01 11:00:00-03',
    10.00,
    'cartao',
    'aprovado',
    34
  ),
  (
    '2026-08-02 15:00:00-03',
    150.00,
    'pix',
    'aprovado',
    35
  ),
  (
    '2026-08-02 16:00:00-03',
    250.00,
    'cartao',
    'aprovado',
    36
  ),
  (
    '2026-08-03 09:00:00-03',
    90.00,
    'pix',
    'aprovado',
    37
  ),
  (
    '2026-08-03 10:00:00-03',
    45.00,
    'cartao',
    'aprovado',
    38
  ),
  (
    '2026-08-04 14:00:00-03',
    40.00,
    'pix',
    'aprovado',
    39
  ),
  (
    '2026-08-04 15:00:00-03',
    70.00,
    'cartao',
    'aprovado',
    40
  ),
  (
    '2026-08-05 08:00:00-03',
    20.00,
    'pix',
    'cancelado',
    41
  ),
  (
    '2026-08-05 09:00:00-03',
    150.00,
    'cartao',
    'estornado',
    42
  );

-- Mais compras para completar 80
insert into
  compra (
    data_compra,
    valor_total,
    metodo_pagamento,
    status,
    participante_id
  )
values
  (
    '2026-08-01 12:00:00-03',
    250.00,
    'pix',
    'aprovado',
    1
  ),
  (
    '2026-08-01 13:00:00-03',
    150.00,
    'cartao',
    'aprovado',
    2
  ),
  (
    '2026-08-02 08:00:00-03',
    20.00,
    'pix',
    'aprovado',
    3
  ),
  (
    '2026-08-02 09:00:00-03',
    10.00,
    'cartao',
    'aprovado',
    4
  ),
  (
    '2026-08-03 11:00:00-03',
    90.00,
    'pix',
    'aprovado',
    5
  ),
  (
    '2026-08-03 12:00:00-03',
    45.00,
    'cartao',
    'aprovado',
    6
  ),
  (
    '2026-08-04 10:00:00-03',
    150.00,
    'pix',
    'aprovado',
    7
  ),
  (
    '2026-08-04 11:00:00-03',
    250.00,
    'cartao',
    'aprovado',
    8
  ),
  (
    '2026-08-05 14:00:00-03',
    90.00,
    'pix',
    'pendente',
    9
  ),
  (
    '2026-08-05 15:00:00-03',
    45.00,
    'cartao',
    'pendente',
    10
  ),
  (
    '2026-08-06 09:00:00-03',
    20.00,
    'pix',
    'pendente',
    11
  ),
  (
    '2026-08-06 10:00:00-03',
    150.00,
    'cartao',
    'pendente',
    12
  ),
  (
    '2026-08-06 11:00:00-03',
    40.00,
    'pix',
    'aprovado',
    13
  ),
  (
    '2026-08-06 12:00:00-03',
    70.00,
    'cartao',
    'aprovado',
    14
  ),
  (
    '2026-08-06 14:00:00-03',
    20.00,
    'pix',
    'pendente',
    15
  ),
  (
    '2026-08-06 15:00:00-03',
    10.00,
    'cartao',
    'pendente',
    16
  ),
  (
    '2026-08-06 16:00:00-03',
    150.00,
    'pix',
    'pendente',
    17
  ),
  (
    '2026-08-06 17:00:00-03',
    250.00,
    'cartao',
    'cancelado',
    18
  ),
  (
    '2026-08-01 18:00:00-03',
    150.00,
    'pix',
    'aprovado',
    19
  ),
  (
    '2026-08-02 19:00:00-03',
    250.00,
    'cartao',
    'aprovado',
    20
  ),
  (
    '2026-08-03 20:00:00-03',
    20.00,
    'pix',
    'aprovado',
    21
  ),
  (
    '2026-08-04 21:00:00-03',
    10.00,
    'cartao',
    'aprovado',
    22
  ),
  (
    '2026-08-05 22:00:00-03',
    90.00,
    'pix',
    'aprovado',
    23
  ),
  (
    '2026-08-06 08:00:00-03',
    45.00,
    'cartao',
    'aprovado',
    24
  ),
  (
    '2026-08-01 07:00:00-03',
    40.00,
    'pix',
    'aprovado',
    25
  ),
  (
    '2026-08-02 06:00:00-03',
    70.00,
    'cartao',
    'aprovado',
    26
  ),
  (
    '2026-08-03 05:00:00-03',
    20.00,
    'pix',
    'aprovado',
    27
  ),
  (
    '2026-08-04 04:00:00-03',
    150.00,
    'cartao',
    'aprovado',
    28
  ),
  (
    '2026-08-05 03:00:00-03',
    250.00,
    'pix',
    'cancelado',
    29
  ),
  (
    '2026-08-06 02:00:00-03',
    150.00,
    'cartao',
    'pendente',
    30
  ),
  (
    '2026-08-06 01:00:00-03',
    20.00,
    'pix',
    'pendente',
    31
  ),
  (
    '2026-08-01 23:00:00-03',
    10.00,
    'cartao',
    'pendente',
    32
  ),
  (
    '2026-08-02 22:00:00-03',
    90.00,
    'pix',
    'aprovado',
    33
  ),
  (
    '2026-08-03 21:00:00-03',
    45.00,
    'cartao',
    'aprovado',
    34
  ),
  (
    '2026-08-04 20:00:00-03',
    150.00,
    'pix',
    'aprovado',
    35
  ),
  (
    '2026-08-05 19:00:00-03',
    250.00,
    'cartao',
    'aprovado',
    36
  ),
  (
    '2026-08-06 18:00:00-03',
    40.00,
    'pix',
    'aprovado',
    37
  ),
  (
    '2026-08-06 13:00:00-03',
    70.00,
    'cartao',
    'aprovado',
    38
  );

-- 7. INGRESSO (cada ingresso tem código único, vinculado a compra e lote)
-- Cada compra aprovada gera 1 ou mais ingressos; canceladas geram ingressos cancelados
-- Compras 1 a 6: eventos encerrados, aprovados
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0001-A1B2', 'utilizado', 1, 1),
  ('EVT-0002-C3D4', 'utilizado', 2, 2),
  ('EVT-0003-E5F6', 'utilizado', 3, 1),
  ('EVT-0004-G7H8', 'utilizado', 4, 1),
  ('EVT-0005-I9J0', 'valido', 4, 1),
  ('EVT-0006-K1L2', 'utilizado', 5, 3),
  ('EVT-0007-M3N4', 'utilizado', 6, 4);

-- Compras 7 e 8: canceladas
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0008-O5P6', 'cancelado', 7, 5),
  ('EVT-0009-Q7R8', 'cancelado', 8, 6);

-- Compras 9 a 12: aprovados
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0010-S9T0', 'utilizado', 9, 7),
  ('EVT-0011-U1V2', 'utilizado', 10, 8),
  ('EVT-0012-W3X4', 'utilizado', 11, 9),
  ('EVT-0013-Y5Z6', 'utilizado', 12, 10);

-- Compra 13: cancelada
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0014-A7B8', 'cancelado', 13, 1);

-- Compras 14 a 19: aprovados
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0015-C9D0', 'valido', 14, 2),
  ('EVT-0016-E1F2', 'utilizado', 15, 3),
  ('EVT-0017-G3H4', 'utilizado', 16, 4),
  ('EVT-0018-I5J6', 'utilizado', 17, 1),
  ('EVT-0019-K7L8', 'valido', 18, 2),
  ('EVT-0020-M9N0', 'utilizado', 19, 9);

-- Compra 20: estornada
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0021-O1P2', 'cancelado', 20, 10);

-- Compras 21 a 24: aprovados
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0022-Q3R4', 'valido', 21, 7),
  ('EVT-0023-S5T6', 'valido', 22, 8),
  ('EVT-0024-U7V8', 'valido', 23, 3),
  ('EVT-0025-W9X0', 'utilizado', 24, 4);

-- Compras 25 e 26: canceladas
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0026-Y1Z2', 'cancelado', 25, 9),
  ('EVT-0027-A3B4', 'cancelado', 26, 10);

-- Compras 27 (cancelada) e 28 (aprovada)
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0028-C5D6', 'cancelado', 27, 5),
  ('EVT-0029-E7F8', 'valido', 28, 6);

-- Compras 29 e 30: aprovados
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0030-G9H0', 'valido', 29, 7),
  ('EVT-0031-I1J2', 'valido', 30, 8);

-- Compras 31 e 32: canceladas
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0032-K3L4', 'cancelado', 31, 5),
  ('EVT-0033-M5N6', 'cancelado', 32, 6);

-- Compras 33 a 42: eventos publicados
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0034-O7P8', 'valido', 33, 11),
  ('EVT-0035-Q9R0', 'valido', 34, 12),
  ('EVT-0036-S1T2', 'valido', 35, 13),
  ('EVT-0037-U3V4', 'valido', 36, 14),
  ('EVT-0038-W5X6', 'valido', 37, 15),
  ('EVT-0039-Y7Z8', 'valido', 38, 16),
  ('EVT-0040-A9B0', 'valido', 39, 19),
  ('EVT-0041-C1D2', 'valido', 40, 20),
  ('EVT-0042-E3F4', 'cancelado', 41, 11),
  ('EVT-0043-G5H6', 'cancelado', 42, 13);

-- Compras 43 a 80: ingressos restantes
insert into
  ingresso (codigo, status, compra_id, lote_id)
values
  ('EVT-0044-I7J8', 'valido', 43, 14),
  ('EVT-0045-K9L0', 'valido', 44, 13),
  ('EVT-0046-M1N2', 'valido', 45, 11),
  ('EVT-0047-O3P4', 'valido', 46, 12),
  ('EVT-0048-Q5R6', 'valido', 47, 15),
  ('EVT-0049-S7T8', 'valido', 48, 16),
  ('EVT-0050-U9V0', 'valido', 49, 13),
  ('EVT-0051-W1X2', 'valido', 50, 14),
  ('EVT-0052-Y3Z4', 'valido', 51, 15),
  ('EVT-0053-A5B6', 'valido', 52, 16),
  ('EVT-0054-C7D8', 'valido', 53, 11),
  ('EVT-0055-E9F0', 'valido', 54, 12),
  ('EVT-0056-G1H2', 'valido', 55, 19),
  ('EVT-0057-I3J4', 'valido', 56, 20),
  ('EVT-0058-K5L6', 'valido', 57, 15),
  ('EVT-0059-M7N8', 'valido', 58, 16),
  ('EVT-0060-O9P0', 'valido', 59, 13),
  ('EVT-0061-Q1R2', 'valido', 59, 14),
  ('EVT-0062-S3T4', 'valido', 60, 13),
  ('EVT-0063-U5V6', 'valido', 60, 14),
  ('EVT-0064-W7X8', 'valido', 61, 11),
  ('EVT-0065-Y9Z0', 'valido', 62, 12),
  ('EVT-0066-A1B2', 'valido', 63, 15),
  ('EVT-0067-C3D4', 'valido', 64, 16),
  ('EVT-0068-E5F6', 'valido', 65, 19),
  ('EVT-0069-G7H8', 'valido', 66, 20),
  ('EVT-0070-I9J0', 'valido', 67, 11),
  ('EVT-0071-K1L2', 'valido', 68, 12),
  ('EVT-0072-M3N4', 'cancelado', 69, 13),
  ('EVT-0073-O5P6', 'valido', 70, 14),
  ('EVT-0074-Q7R8', 'valido', 71, 15),
  ('EVT-0075-S9T0', 'valido', 72, 16),
  ('EVT-0076-U1V2', 'valido', 73, 19),
  ('EVT-0077-W3X4', 'valido', 74, 20),
  ('EVT-0078-Y5Z6', 'valido', 75, 11),
  ('EVT-0079-A7B8', 'cancelado', 76, 13),
  ('EVT-0080-C9D0', 'valido', 77, 14),
  ('EVT-0081-E1F2', 'valido', 78, 13),
  ('EVT-0082-G3H4', 'valido', 79, 14),
  ('EVT-0083-I5J6', 'valido', 80, 14);

-- 8. CHECKIN (30 check-ins em eventos encerrados)
-- Evento 1: Rock na Praça (10 check-ins) - lotes 1 e 2
-- Ingressos disponíveis deste evento: 1,2,3,4,5,18,17
insert into
  checkin (data_entrada, responsavel, ingresso_id)
values
  ('2026-07-15 19:30:00-03', 'Portaria A', 1),
  ('2026-07-15 19:45:00-03', 'Portaria A', 2),
  ('2026-07-15 20:00:00-03', 'Portaria B', 3),
  ('2026-07-15 20:10:00-03', 'Portaria A', 4),
  ('2026-07-15 20:15:00-03', 'Portaria B', 5),
  ('2026-07-15 20:20:00-03', 'Portaria A', 18),
  ('2026-07-15 20:30:00-03', 'Portaria B', 17),
  ('2026-07-15 20:45:00-03', 'Portaria A', 6),
  ('2026-07-15 21:00:00-03', 'Portaria B', 7),
  ('2026-07-15 21:15:00-03', 'Portaria A', 8);

-- Evento 2: Festival de Inverno (8 check-ins) - lotes 3 e 4
-- Ingressos disponíveis deste evento: 16,24,25,15,23
insert into
  checkin (data_entrada, responsavel, ingresso_id)
values
  ('2026-07-20 09:30:00-03', 'Portão Único', 16),
  ('2026-07-20 09:45:00-03', 'Portão Único', 24),
  ('2026-07-20 10:00:00-03', 'Portão Único', 25),
  ('2026-07-20 10:15:00-03', 'Portão Único', 15),
  ('2026-07-20 10:30:00-03', 'Portão Único', 23),
  ('2026-07-20 10:45:00-03', 'Portão Único', 9),
  ('2026-07-20 11:00:00-03', 'Portão Único', 10),
  ('2026-07-20 11:15:00-03', 'Portão Único', 11);

-- Evento 4: Palestra IA (7 check-ins) - lotes 7 e 8
-- Ingressos disponíveis deste evento: 19,20,21,22,23,24,25,30,31
insert into
  checkin (data_entrada, responsavel, ingresso_id)
values
  ('2026-07-28 18:30:00-03', 'Recepção', 19),
  ('2026-07-28 18:35:00-03', 'Recepção', 20),
  ('2026-07-28 18:40:00-03', 'Recepção', 21),
  ('2026-07-28 18:45:00-03', 'Recepção', 22),
  ('2026-07-28 18:50:00-03', 'Recepção', 30),
  ('2026-07-28 18:55:00-03', 'Recepção', 31),
  ('2026-07-28 19:00:00-03', 'Recepção', 12);

-- Evento 5: Teatro Comédia (5 check-ins) - lotes 9 e 10
-- Ingressos disponíveis deste evento: 19,11,12
insert into
  checkin (data_entrada, responsavel, ingresso_id)
values
  ('2026-07-30 19:30:00-03', 'Bilheteria', 13),
  ('2026-07-30 19:35:00-03', 'Bilheteria', 14),
  ('2026-07-30 19:40:00-03', 'Bilheteria', 26),
  ('2026-07-30 19:50:00-03', 'Bilheteria', 27),
  ('2026-07-30 20:00:00-03', 'Bilheteria', 28);
