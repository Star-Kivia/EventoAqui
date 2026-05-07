-- 1. CATEGORIA_EVENTO (6 categorias)
INSERT INTO categoria_evento (nome) VALUES
('show'),
('festival'),
('workshop'),
('palestra'),
('teatro'),
('esporte');

-- 2. ORGANIZADOR (5 organizadores, 1 suspenso)
INSERT INTO organizador (nome, documento, contato, cidade, status) VALUES
('Arrocha Produções Artísticas', '12345678000199', 'contato@arrochaproducoes.com', 'Aracaju', 'ativo'),
('Axé Eventos Salvador', '98765432000188', 'comercial@axeeventos.com', 'Salvador', 'ativo'),
('Samba & Cia Paulista', '45678901000177', 'contato@sambaciapaulista.com', 'São Paulo', 'ativo'),
('Forró Tech Treinamentos', '78901234000166', 'eventos@forrotech.com', 'Campinas', 'ativo'),
('Camarote do Bloco Furado', '32109876000155', 'bloco@furado.com', 'Itabaiana', 'suspenso');

-- 3. EVENTO (10 eventos, status variados, datas em 2 meses diferentes)
-- Mês 1: Julho/2026 (encerrados e cancelados)
INSERT INTO evento (titulo, descricao, data_inicio, data_fim, local, cidade, status, organizador_id, categoria_id) VALUES
('Arraiá do Dev Aracajuano', 'Festa junina com muito forró, amendoim e git push na fogueira', '2026-07-15 20:00:00-03', '2026-07-16 02:00:00-03', 'Orla de Atalaia', 'Aracaju', 'encerrado', 1, 2),
('Slipknot no Pelourinho', 'Show de rock pesado no coração histórico de Salvador', '2026-07-20 21:00:00-03', '2026-07-20 23:30:00-03', 'Largo do Pelourinho', 'Salvador', 'encerrado', 2, 1),
('Como Virar Engenheiro de Prompt Comendo Amendoim', 'Workshop de IA generativa com degustação de amendoim torrado', '2026-07-25 14:00:00-03', '2026-07-25 18:00:00-03', 'Centro Cultural de Aracaju', 'Aracaju', 'cancelado', 1, 3),
('Debugging de Código e de Vida', 'Aprenda a achar bugs no seu sistema e na sua existência', '2026-07-28 19:00:00-03', '2026-07-28 21:00:00-03', 'Auditório Tech Paulista', 'São Paulo', 'encerrado', 3, 4),
('O Código Que Não Compilava', 'Peça teatral dramática sobre um programador e seu erro de sintaxe', '2026-07-30 20:00:00-03', '2026-07-30 22:30:00-03', 'Teatro Municipal de São Paulo', 'São Paulo', 'encerrado', 3, 5),
('Torneio de Dominó na Praça', 'Campeonato raiz de dominó com mesa na calçada e café no copo americano', '2026-07-05 09:00:00-03', '2026-07-05 18:00:00-03', 'Praça da Sé', 'São Paulo', 'encerrado', 4, 6),
('Djavan Cantando Forró', 'Djavan interpreta clássicos do forró em noite única', '2026-07-10 21:00:00-03', '2026-07-10 23:30:00-03', 'Arena Fonte Nova', 'Salvador', 'encerrado', 2, 1),
('Festival de Caranguejo e Código', 'Gastronomia sergipana com hackathon de 48 horas', '2026-07-12 10:00:00-03', '2026-07-14 22:00:00-03', 'Passarela do Caranguejo', 'Aracaju', 'encerrado', 1, 2),
('SQL Que Respeita Seu Tempo (e Seu Pix)', 'Aprenda queries eficientes e como receber pagamentos via pix', '2026-08-20 08:00:00-03', '2026-08-20 12:00:00-03', 'Hub de Inovação de Sergipe', 'Aracaju', 'publicado', 4, 3),
('Empreendedorismo com Pó de Café e Tapioca', 'Palestra motivacional com café forte e tapioca recheada', '2026-08-25 19:00:00-03', '2026-08-25 21:00:00-03', 'Auditório Central Paulista', 'São Paulo', 'publicado', 3, 4);

-- 4. LOTE_INGRESSO (2 lotes por evento = 20 lotes)
-- Evento 1: Arraiá do Dev Aracajuano
INSERT INTO lote_ingresso (nome, preco, capacidade_maxima, status, evento_id) VALUES
('Inteira', 30.00, 200, 'encerrado', 1),
('Meia-entrada', 15.00, 100, 'encerrado', 1);

-- Evento 2: Slipknot no Pelourinho
INSERT INTO lote_ingresso (nome, preco, capacidade_maxima, status, evento_id) VALUES
('Inteira', 180.00, 300, 'encerrado', 2),
('VIP', 350.00, 80, 'encerrado', 2);

-- Evento 3: Engenheiro de Prompt (cancelado)
INSERT INTO lote_ingresso (nome, preco, capacidade_maxima, status, evento_id) VALUES
('Inteira', 50.00, 40, 'encerrado', 3),
('Meia-entrada', 25.00, 20, 'encerrado', 3);

-- Evento 4: Debugging
INSERT INTO lote_ingresso (nome, preco, capacidade_maxima, status, evento_id) VALUES
('Inteira', 40.00, 150, 'encerrado', 4),
('Meia-entrada', 20.00, 80, 'encerrado', 4);

-- Evento 5: Código Que Não Compilava
INSERT INTO lote_ingresso (nome, preco, capacidade_maxima, status, evento_id) VALUES
('Inteira', 60.00, 120, 'encerrado', 5),
('VIP', 100.00, 40, 'encerrado', 5);

-- Evento 6: Dominó na Praça
INSERT INTO lote_ingresso (nome, preco, capacidade_maxima, status, evento_id) VALUES
('Inteira', 10.00, 100, 'encerrado', 6),
('Meia-entrada', 5.00, 50, 'encerrado', 6);

-- Evento 7: Djavan Cantando Forró
INSERT INTO lote_ingresso (nome, preco, capacidade_maxima, status, evento_id) VALUES
('Inteira', 150.00, 400, 'encerrado', 7),
('VIP', 280.00, 100, 'encerrado', 7);

-- Evento 8: Caranguejo e Código
INSERT INTO lote_ingresso (nome, preco, capacidade_maxima, status, evento_id) VALUES
('Inteira', 80.00, 250, 'encerrado', 8),
('Meia-entrada', 40.00, 150, 'encerrado', 8);

-- Evento 9: SQL Que Respeita Seu Tempo (publicado)
INSERT INTO lote_ingresso (nome, preco, capacidade_maxima, status, evento_id) VALUES
('Inteira', 120.00, 50, 'disponivel', 9),
('Meia-entrada', 60.00, 30, 'disponivel', 9);

-- Evento 10: Empreendedorismo (publicado)
INSERT INTO lote_ingresso (nome, preco, capacidade_maxima, status, evento_id) VALUES
('Inteira', 45.00, 100, 'disponivel', 10),
('VIP', 80.00, 50, 'disponivel', 10);

-- Tornar um lote esgotado para a query 5
UPDATE lote_ingresso SET status = 'esgotado' WHERE id = 2;

-- 5. PARTICIPANTE (50 participantes, 1 banido)
INSERT INTO participante (nome, email, cpf, data_nascimento, status) VALUES
('Creuza Maria dos Santos', 'creuza.santos@email.com', '11122233344', '1985-03-15', 'ativo'),
('Josenildo Oliveira', 'josenildo.oliveira@email.com', '22233344455', '1990-07-20', 'ativo'),
('Valdirene Souza', 'valdirene.souza@email.com', '33344455566', '1988-12-01', 'ativo'),
('Ribamar Albuquerque', 'ribamar.albuquerque@email.com', '44455566677', '1992-01-25', 'ativo'),
('Cleide Rocha', 'cleide.rocha@email.com', '55566677788', '1993-05-30', 'ativo'),
('Jurandir Silva', 'jurandir.silva@email.com', '66677788899', '1987-09-10', 'ativo'),
('Janaina Almeida', 'janaina.almeida@email.com', '77788899900', '1995-11-22', 'ativo'),
('Raimundo Nonato', 'raimundo.nonato@email.com', '88899900011', '1983-04-17', 'ativo'),
('Edileuza Santos', 'edileuza.santos@email.com', '99900011122', '1987-06-08', 'ativo'),
('Cosme Damião', 'cosme.damiao@email.com', '00011122233', '1992-08-14', 'ativo'),
('Jurema Ferreira', 'jurema.ferreira@email.com', '12121212121', '1994-02-28', 'ativo'),
('Ubirajara Gomes', 'ubirajara.gomes@email.com', '13131313131', '1986-10-05', 'ativo'),
('Luciene Barbosa', 'luciene.barbosa@email.com', '14141414141', '1994-07-12', 'ativo'),
('Astrogildo Pereira', 'astrogildo.pereira@email.com', '15151515151', '1991-03-19', 'ativo'),
('Marinete Lima', 'marinete.lima@email.com', '16161616161', '1997-12-25', 'ativo'),
('Sebastião da Silva', 'sebastiao.silva@email.com', '17171717171', '1989-01-30', 'banido'),
('Terezinha Andrade', 'terezinha.andrade@email.com', '18181818181', '1984-06-14', 'ativo'),
('Rafael Torres', 'rafael.torres@email.com', '19191919191', '2001-09-03', 'ativo'),
('Magnólia Castro', 'magnolia.castro@email.com', '20202020202', '1990-11-08', 'ativo'),
('Jocelino Nunes', 'jocelino.nunes@email.com', '21212121212', '1983-04-21', 'ativo'),
('Doraci Menezes', 'doraci.menezes@email.com', '22222222222', '1996-08-17', 'ativo'),
('Genivaldo Cardoso', 'genivaldo.cardoso@email.com', '23232323232', '1988-02-10', 'ativo'),
('Quitéria Freitas', 'quiteria.freitas@email.com', '24242424242', '1993-07-05', 'ativo'),
('Xisto Lopes', 'xisto.lopes@email.com', '25252525252', '1987-12-29', 'ativo'),
('Yeda Barbosa', 'yeda.barbosa@email.com', '26262626262', '1995-05-16', 'ativo'),
('Zacarias Moura', 'zacarias.moura@email.com', '27272727272', '1992-10-11', 'ativo'),
('Aristides Ramos', 'aristides.ramos@email.com', '28282828282', '1986-03-07', 'ativo'),
('Benvinda Cruz', 'benvinda.cruz@email.com', '29292929292', '1998-01-13', 'ativo'),
('Cipriano Teixeira', 'cipriano.teixeira@email.com', '30303030303', '1991-06-22', 'ativo'),
('Dolores Pires', 'dolores.pires@email.com', '31313131313', '1989-09-18', 'ativo'),
('Eriberto Macedo', 'eriberto.macedo@email.com', '32323232323', '1997-04-25', 'ativo'),
('Florisbela Santana', 'florisbela.santana@email.com', '33333333333', '1994-08-09', 'ativo'),
('Gumercindo Campos', 'gumercindo.campos@email.com', '34343434343', '1985-12-03', 'ativo'),
('Hermenegildo Barros', 'hermenegildo.barros@email.com', '35353535353', '2000-07-27', 'ativo'),
('Iracema Cavalcanti', 'iracema.cavalcanti@email.com', '36363636363', '1993-02-14', 'ativo'),
('Jacinto Carvalho', 'jacinto.carvalho@email.com', '37373737373', '1988-05-19', 'ativo'),
('Luzinete Gomes', 'luzinete.gomes@email.com', '38383838383', '1996-11-02', 'ativo'),
('Malaquias Vinicius', 'malaquias.vinicius@email.com', '39393939393', '1990-04-06', 'ativo'),
('Nair Farias', 'nair.farias@email.com', '40404040404', '1987-09-30', 'ativo'),
('Otacília Ribeiro', 'otacilia.ribeiro@email.com', '41414141414', '1999-06-11', 'ativo'),
('Petrúcio Neves', 'petrucio.neves@email.com', '42424242424', '1984-01-26', 'ativo'),
('Querubina Duarte', 'querubina.duarte@email.com', '43434343434', '1992-12-08', 'ativo'),
('Raimunda Azevedo', 'raimunda.azevedo@email.com', '44444444444', '1995-07-22', 'ativo'),
('Salustiano Marques', 'salustiano.marques@email.com', '45454545454', '1986-10-31', 'ativo'),
('Tibúrcio Franco', 'tiburcio.franco@email.com', '46464646464', '1998-03-17', 'ativo'),
('Ubaldina Dantas', 'ubaldina.dantas@email.com', '47474747474', '1991-08-04', 'ativo'),
('Venâncio Rangel', 'venancio.rangel@email.com', '48484848484', '1989-12-20', 'ativo'),
('Zuleica Peixoto', 'zuleica.peixoto@email.com', '49494949494', '2001-05-09', 'ativo'),
('Zózimo Correia', 'zozimo.correia@email.com', '50505050505', '1994-02-28', 'ativo'),
('Abelardo Lemos', 'abelardo.lemos@email.com', '51515151515', '1987-07-15', 'ativo');

-- 6. COMPRA (80 compras com status variados)
-- Bloco 1: compras de Julho/2026 (eventos encerrados)
INSERT INTO compra (data_compra, valor_total, metodo_pagamento, status, participante_id) VALUES
('2026-07-01 10:00:00-03', 30.00, 'pix', 'aprovado', 1),
('2026-07-02 11:00:00-03', 15.00, 'cartao', 'aprovado', 2),
('2026-07-03 14:00:00-03', 30.00, 'pix', 'aprovado', 3),
('2026-07-04 15:00:00-03', 60.00, 'cartao', 'aprovado', 4),
('2026-07-05 09:00:00-03', 180.00, 'pix', 'aprovado', 5),
('2026-07-06 10:00:00-03', 350.00, 'cartao', 'aprovado', 6),
('2026-07-07 14:00:00-03', 50.00, 'pix', 'cancelado', 7),
('2026-07-08 15:00:00-03', 25.00, 'cartao', 'cancelado', 8),
('2026-07-09 08:00:00-03', 40.00, 'pix', 'aprovado', 9),
('2026-07-10 09:00:00-03', 20.00, 'cartao', 'aprovado', 10);

-- Bloco 2: mais compras de Julho
INSERT INTO compra (data_compra, valor_total, metodo_pagamento, status, participante_id) VALUES
('2026-07-11 10:00:00-03', 60.00, 'pix', 'aprovado', 11),
('2026-07-12 11:00:00-03', 100.00, 'cartao', 'aprovado', 12),
('2026-07-13 14:00:00-03', 30.00, 'pix', 'cancelado', 13),
('2026-07-14 15:00:00-03', 15.00, 'cartao', 'aprovado', 14),
('2026-07-15 09:00:00-03', 180.00, 'pix', 'aprovado', 15),
('2026-07-16 10:00:00-03', 350.00, 'cartao', 'aprovado', 16),
('2026-07-17 14:00:00-03', 10.00, 'pix', 'aprovado', 17),
('2026-07-18 15:00:00-03', 5.00, 'cartao', 'aprovado', 18),
('2026-07-19 08:00:00-03', 150.00, 'pix', 'aprovado', 19),
('2026-07-20 09:00:00-03', 280.00, 'cartao', 'estornado', 20);

-- Bloco 3: compras de Junho/2026 (para query 10 - últimos 60 dias)
INSERT INTO compra (data_compra, valor_total, metodo_pagamento, status, participante_id) VALUES
('2026-06-01 15:30:00-03', 10.00, 'pix', 'aprovado', 21),
('2026-06-02 16:00:00-03', 5.00, 'cartao', 'aprovado', 22),
('2026-06-03 10:00:00-03', 150.00, 'pix', 'aprovado', 23),
('2026-06-04 14:00:00-03', 280.00, 'cartao', 'aprovado', 24),
('2026-06-05 09:00:00-03', 80.00, 'pix', 'aprovado', 25),
('2026-06-06 11:00:00-03', 40.00, 'cartao', 'cancelado', 26),
('2026-06-07 08:00:00-03', 80.00, 'pix', 'cancelado', 27),
('2026-06-08 12:00:00-03', 40.00, 'cartao', 'cancelado', 28),
('2026-06-09 14:00:00-03', 10.00, 'pix', 'aprovado', 29),
('2026-06-10 16:00:00-03', 5.00, 'cartao', 'aprovado', 30);

-- Bloco 4: compras PENDENTES com datas PASSADAS (query 11)
INSERT INTO compra (data_compra, valor_total, metodo_pagamento, status, participante_id) VALUES
('2026-05-01 10:00:00-03', 30.00, 'pix', 'pendente', 31),
('2026-05-02 11:00:00-03', 15.00, 'cartao', 'pendente', 32),
('2026-05-03 14:00:00-03', 180.00, 'pix', 'pendente', 33),
('2026-05-04 15:00:00-03', 350.00, 'cartao', 'pendente', 34);

-- Bloco 5: completar compras de Junho/Julho
INSERT INTO compra (data_compra, valor_total, metodo_pagamento, status, participante_id) VALUES
('2026-06-11 10:00:00-03', 150.00, 'pix', 'aprovado', 35),
('2026-06-12 11:00:00-03', 280.00, 'cartao', 'aprovado', 36),
('2026-06-13 14:00:00-03', 80.00, 'pix', 'aprovado', 37),
('2026-06-14 15:00:00-03', 40.00, 'cartao', 'aprovado', 38),
('2026-06-15 09:00:00-03', 10.00, 'pix', 'aprovado', 39),
('2026-06-16 10:00:00-03', 5.00, 'cartao', 'aprovado', 40),
('2026-06-17 14:00:00-03', 30.00, 'pix', 'cancelado', 41),
('2026-06-18 15:00:00-03', 15.00, 'cartao', 'cancelado', 42),
('2026-06-19 08:00:00-03', 180.00, 'pix', 'cancelado', 43),
('2026-06-20 09:00:00-03', 350.00, 'cartao', 'estornado', 44);

-- Bloco 6: compras de Agosto/2026 (eventos publicados futuros)
INSERT INTO compra (data_compra, valor_total, metodo_pagamento, status, participante_id) VALUES
('2026-08-01 10:00:00-03', 120.00, 'pix', 'aprovado', 45),
('2026-08-02 11:00:00-03', 60.00, 'cartao', 'aprovado', 46),
('2026-08-03 14:00:00-03', 45.00, 'pix', 'aprovado', 47),
('2026-08-04 15:00:00-03', 80.00, 'cartao', 'aprovado', 48);

-- Bloco 7: últimas compras para completar 80
INSERT INTO compra (data_compra, valor_total, metodo_pagamento, status, participante_id) VALUES
('2026-06-21 10:00:00-03', 40.00, 'pix', 'aprovado', 1),
('2026-06-22 11:00:00-03', 20.00, 'cartao', 'aprovado', 2),
('2026-06-23 14:00:00-03', 60.00, 'pix', 'aprovado', 3),
('2026-06-24 15:00:00-03', 100.00, 'cartao', 'aprovado', 4),
('2026-06-25 09:00:00-03', 30.00, 'pix', 'aprovado', 5),
('2026-06-26 10:00:00-03', 15.00, 'cartao', 'aprovado', 6),
('2026-06-27 14:00:00-03', 180.00, 'pix', 'cancelado', 7),
('2026-06-28 15:00:00-03', 350.00, 'cartao', 'cancelado', 8),
('2026-06-29 08:00:00-03', 10.00, 'pix', 'aprovado', 11),
('2026-06-30 09:00:00-03', 5.00, 'cartao', 'aprovado', 12),
('2026-07-01 10:00:00-03', 150.00, 'pix', 'aprovado', 13),
('2026-07-02 11:00:00-03', 280.00, 'cartao', 'aprovado', 14),
('2026-07-03 14:00:00-03', 80.00, 'pix', 'aprovado', 15),
('2026-07-04 15:00:00-03', 40.00, 'cartao', 'aprovado', 16),
('2026-07-05 09:00:00-03', 10.00, 'pix', 'cancelado', 17),
('2026-07-06 10:00:00-03', 5.00, 'cartao', 'cancelado', 18);

-- Total de compras: 10+10+10+4+10+4+16 = 64... preciso de mais 16 para chegar a 80
INSERT INTO compra (data_compra, valor_total, metodo_pagamento, status, participante_id) VALUES
('2026-06-01 14:00:00-03', 80.00, 'pix', 'aprovado', 19),
('2026-06-02 15:00:00-03', 40.00, 'cartao', 'aprovado', 20),
('2026-06-03 08:00:00-03', 150.00, 'pix', 'aprovado', 21),
('2026-06-04 09:00:00-03', 280.00, 'cartao', 'aprovado', 22),
('2026-06-05 14:00:00-03', 10.00, 'pix', 'cancelado', 23),
('2026-06-06 15:00:00-03', 5.00, 'cartao', 'cancelado', 24),
('2026-06-07 08:00:00-03', 30.00, 'pix', 'aprovado', 25),
('2026-06-08 09:00:00-03', 15.00, 'cartao', 'aprovado', 26),
('2026-06-09 14:00:00-03', 180.00, 'pix', 'cancelado', 27),
('2026-06-10 15:00:00-03', 350.00, 'cartao', 'estornado', 28),
('2026-06-11 08:00:00-03', 40.00, 'pix', 'aprovado', 29),
('2026-06-12 09:00:00-03', 20.00, 'cartao', 'aprovado', 30),
('2026-06-13 14:00:00-03', 60.00, 'pix', 'cancelado', 31),
('2026-06-14 15:00:00-03', 100.00, 'cartao', 'cancelado', 32),
('2026-06-15 08:00:00-03', 30.00, 'pix', 'aprovado', 33),
('2026-06-16 09:00:00-03', 15.00, 'cartao', 'aprovado', 34);

-- AGORA SIM: 10+10+10+4+10+4+16+16 = 80 compras

-- 7. INGRESSO (cada compra gera 1 ingresso, algumas geram 2)
-- Ingressos das compras 1 a 10
INSERT INTO ingresso (codigo, status, compra_id, lote_id) VALUES
('EVT-A1-0001', 'utilizado', 1, 1),
('EVT-A1-0002', 'utilizado', 2, 2),
('EVT-A1-0003', 'utilizado', 3, 1),
('EVT-A1-0004', 'utilizado', 4, 1),
('EVT-A1-0005', 'valido', 4, 1),
('EVT-SP-0001', 'utilizado', 5, 3),
('EVT-SP-0002', 'utilizado', 6, 4),
('EVT-A1-0006', 'cancelado', 7, 5),
('EVT-A1-0007', 'cancelado', 8, 6),
('EVT-SP-0003', 'utilizado', 9, 7),
('EVT-SP-0004', 'utilizado', 10, 8);

-- Ingressos das compras 11 a 20
INSERT INTO ingresso (codigo, status, compra_id, lote_id) VALUES
('EVT-SP-0005', 'utilizado', 11, 9),
('EVT-SP-0006', 'utilizado', 12, 10),
('EVT-A1-0008', 'cancelado', 13, 1),
('EVT-A1-0009', 'valido', 14, 2),
('EVT-SP-0007', 'utilizado', 15, 3),
('EVT-SP-0008', 'utilizado', 16, 4),
('EVT-SP-0009', 'utilizado', 17, 11),
('EVT-SP-0010', 'utilizado', 18, 12),
('EVT-SA-0001', 'utilizado', 19, 13),
('EVT-SA-0002', 'cancelado', 20, 14);

-- Compras 21 a 30
INSERT INTO ingresso (codigo, status, compra_id, lote_id) VALUES
('EVT-SP-0011', 'utilizado', 21, 11),
('EVT-SP-0012', 'utilizado', 22, 12),
('EVT-SA-0003', 'utilizado', 23, 13),
('EVT-SA-0004', 'utilizado', 24, 14),
('EVT-A1-0010', 'utilizado', 25, 15),
('EVT-A1-0011', 'cancelado', 26, 16),
('EVT-A1-0012', 'cancelado', 27, 15),
('EVT-A1-0013', 'cancelado', 28, 16),
('EVT-SP-0013', 'utilizado', 29, 11),
('EVT-SP-0014', 'utilizado', 30, 12);

-- Compras 31 a 34 (PENDENTES - ingressos válidos mas sem check-in para query 7)
INSERT INTO ingresso (codigo, status, compra_id, lote_id) VALUES
('EVT-PD-0001', 'valido', 31, 1),
('EVT-PD-0002', 'valido', 32, 2),
('EVT-PD-0003', 'valido', 33, 3),
('EVT-PD-0004', 'valido', 34, 4);

-- Compras 35 a 48
INSERT INTO ingresso (codigo, status, compra_id, lote_id) VALUES
('EVT-SA-0005', 'utilizado', 35, 13),
('EVT-SA-0006', 'utilizado', 36, 14),
('EVT-A1-0014', 'utilizado', 37, 15),
('EVT-A1-0015', 'utilizado', 38, 16),
('EVT-SP-0015', 'utilizado', 39, 11),
('EVT-SP-0016', 'utilizado', 40, 12),
('EVT-A1-0016', 'cancelado', 41, 1),
('EVT-A1-0017', 'cancelado', 42, 2),
('EVT-SP-0017', 'cancelado', 43, 3),
('EVT-SP-0018', 'cancelado', 44, 4),
('EVT-A1-0018', 'valido', 45, 17),
('EVT-A1-0019', 'valido', 46, 18),
('EVT-SP-0019', 'valido', 47, 19),
('EVT-SP-0020', 'valido', 48, 20);

-- Compras 49 a 64
INSERT INTO ingresso (codigo, status, compra_id, lote_id) VALUES
('EVT-A1-0020', 'utilizado', 49, 1),
('EVT-A1-0021', 'utilizado', 50, 2),
('EVT-SP-0021', 'utilizado', 51, 9),
('EVT-SP-0022', 'utilizado', 52, 10),
('EVT-A1-0022', 'valido', 53, 1),
('EVT-A1-0023', 'valido', 54, 2),
('EVT-SP-0023', 'utilizado', 55, 3),
('EVT-SP-0024', 'utilizado', 56, 4),
('EVT-A1-0024', 'cancelado', 57, 15),
('EVT-A1-0025', 'cancelado', 58, 16),
('EVT-SA-0007', 'utilizado', 59, 13),
('EVT-SA-0008', 'utilizado', 60, 14),
('EVT-SP-0025', 'valido', 61, 11),
('EVT-SP-0026', 'valido', 62, 12),
('EVT-A1-0026', 'cancelado', 63, 1),
('EVT-A1-0027', 'cancelado', 64, 2),
('EVT-SP-0027', 'cancelado', 65, 3),
('EVT-SP-0028', 'cancelado', 66, 4);

-- Compras 67 a 80 (compras extras que adicionamos)
INSERT INTO ingresso (codigo, status, compra_id, lote_id) VALUES
('EVT-A1-0028', 'utilizado', 67, 15),
('EVT-A1-0029', 'utilizado', 68, 16),
('EVT-SA-0009', 'utilizado', 69, 13),
('EVT-SA-0010', 'utilizado', 70, 14),
('EVT-SP-0029', 'cancelado', 71, 11),
('EVT-SP-0030', 'cancelado', 72, 12),
('EVT-A1-0030', 'utilizado', 73, 1),
('EVT-A1-0031', 'utilizado', 74, 2),
('EVT-SP-0031', 'cancelado', 75, 3),
('EVT-SP-0032', 'cancelado', 76, 4),
('EVT-A1-0032', 'utilizado', 77, 1),
('EVT-A1-0033', 'utilizado', 78, 2),
('EVT-SP-0033', 'cancelado', 79, 15),
('EVT-SP-0034', 'cancelado', 80, 16);

-- 8. CHECKIN (30 check-ins em eventos encerrados)
-- Evento 1: Arraiá do Dev Aracajuano (10 check-ins)
INSERT INTO checkin (data_entrada, responsavel, ingresso_id) VALUES
('2026-07-15 19:30:00-03', 'Seu Zé da Roça', 1),
('2026-07-15 19:45:00-03', 'Seu Zé da Roça', 2),
('2026-07-15 20:00:00-03', 'Dona Maria Catraca', 3),
('2026-07-15 20:10:00-03', 'Seu Zé da Roça', 4),
('2026-07-15 20:20:00-03', 'Dona Maria Catraca', 49),
('2026-07-15 20:30:00-03', 'Seu Zé da Roça', 50),
('2026-07-15 20:45:00-03', 'Dona Maria Catraca', 53),
('2026-07-15 21:00:00-03', 'Seu Zé da Roça', 54),
('2026-07-15 21:15:00-03', 'Dona Maria Catraca', 73),
('2026-07-15 21:30:00-03', 'Seu Zé da Roça', 74);

-- Evento 2: Slipknot no Pelourinho (8 check-ins)
INSERT INTO checkin (data_entrada, responsavel, ingresso_id) VALUES
('2026-07-20 20:30:00-03', 'Dona Marlene do Acarajé', 5),
('2026-07-20 20:45:00-03', 'Dona Marlene do Acarajé', 6),
('2026-07-20 21:00:00-03', 'Seu Raimundo Capoeirista', 15),
('2026-07-20 21:15:00-03', 'Dona Marlene do Acarajé', 16),
('2026-07-20 21:30:00-03', 'Seu Raimundo Capoeirista', 55),
('2026-07-20 21:45:00-03', 'Dona Marlene do Acarajé', 56),
('2026-07-20 22:00:00-03', 'Seu Raimundo Capoeirista', 9),
('2026-07-20 22:15:00-03', 'Dona Marlene do Acarajé', 10);

-- Evento 4: Debugging de Código e de Vida (7 check-ins)
INSERT INTO checkin (data_entrada, responsavel, ingresso_id) VALUES
('2026-07-28 18:30:00-03', 'Dona Clotilde Recepção', 11),
('2026-07-28 18:35:00-03', 'Dona Clotilde Recepção', 12),
('2026-07-28 18:40:00-03', 'Seu Bartolomeu', 51),
('2026-07-28 18:45:00-03', 'Dona Clotilde Recepção', 52),
('2026-07-28 18:50:00-03', 'Seu Bartolomeu', 29),
('2026-07-28 18:55:00-03', 'Dona Clotilde Recepção', 30),
('2026-07-28 19:00:00-03', 'Seu Bartolomeu', 77);

-- Evento 5: O Código Que Não Compilava (5 check-ins)
INSERT INTO checkin (data_entrada, responsavel, ingresso_id) VALUES
('2026-07-30 19:30:00-03', 'Bilheteiro Tonhão', 13),
('2026-07-30 19:35:00-03', 'Bilheteiro Tonhão', 14),
('2026-07-30 19:40:00-03', 'Bilheteiro Tonhão', 67),
('2026-07-30 19:50:00-03', 'Dona Creusa Validadora', 68),
('2026-07-30 20:00:00-03', 'Bilheteiro Tonhão', 78);
