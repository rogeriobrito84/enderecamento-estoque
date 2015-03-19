
CREATE TABLE enderecamento_estoque(

  id serial NOT NULL,

  descricao character varying(20) NOT NULL,

  peso_suportado numeric(10,3) DEFAULT 0,

  cubagem_suportada numeric(10,3) DEFAULT 0,

  created_at date NOT NULL,

  created_by integer NOT NULL,

  updated_at date,

  updated_by integer,

  tipo_mercadoria_id integer,

  filial_id integer,

  is_blocagem boolean DEFAULT false,

  is_ativo boolean DEFAULT true,

  is_ocupado boolean default false,
  
  posicao_x integer not null,
  
  posicao_y integer not null,

  CONSTRAINT enderecamento_estoque_pkey PRIMARY KEY (id),

  CONSTRAINT unk_descricao_filial UNIQUE (descricao, filial_id)
);

CREATE TABLE estrutura_enderecamento(
  id serial NOT NULL,
  descricao character varying(15) NOT NULL,
  tamanho integer,
  restricoes character(1),
  ordem integer NOT NULL,
  filial_id integer,
  orientacao integer,
  imagem character varying(30),
  quantidade_coluna integer not null,
  quantidade_linha integer not null,
  CONSTRAINT estrutura_enderecamento_pkey PRIMARY KEY (id)
);

create or replace function get_ordem_enderecamento(varchar) returns integer as $$
declare
	descricao varchar := $1;
	ordem integer := 1;
	index integer;
begin
	loop
		index = strpos(descricao, '.');
		if(index > 0) then
			descricao := substr(descricao, (index +1), length(descricao));
			ordem := ordem +1;
		else 
			exit;
		end if;
	end loop;
	return ordem;
end; $$ language plpgsql; 



create or replace function get_enderecos_por_nivel(varchar, varchar) returns varchar as $$
declare
	descricao varchar := $1;
	descricao_atual varchar := $2 || '.';
	retorno varchar;
	index integer;
begin
	retorno := substr(descricao,1, length(descricao_atual));
	if descricao_atual = retorno then
		index  := strpos(substr(descricao, (length(retorno) + 1)), '.');
		if index > 0 then
			retorno  := substr(descricao, 1, length(descricao_atual) + (index-1));
		else 
			retorno := descricao;
		end if;
	else
		retorno := null;
	end if;
	return retorno;
end; $$ language plpgsql; 

create or replace function get_nivel_anterior(varchar) returns varchar as $$
declare
	descricao varchar := $1;
	retorno varchar;
	index integer := 0;
	count integer := 0;
begin
	retorno := descricao;
	loop
		index := strpos(retorno, '.');
		if index > 0 then
		   count := count + index;
		   retorno := substr(retorno, index + 1, length(retorno));
		else
		   if count = 0 then
			retorno := '';
		   else 
			   retorno := substr(descricao, 1, count -1);
		   end if;
		   exit;
		end if;
	end loop;
	return retorno;
end; $$ language plpgsql; 


INSERT INTO enderecamento_estoque VALUES (57, 'REC.B.027', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 0);
INSERT INTO enderecamento_estoque VALUES (58, 'REC.B.028', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (59, 'BPV.B.029', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 2);
INSERT INTO enderecamento_estoque VALUES (60, 'BPV.B.030', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 3);
INSERT INTO enderecamento_estoque VALUES (61, 'REC.C.001', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 0, 0);
INSERT INTO enderecamento_estoque VALUES (62, 'REC.C.002', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (63, 'REC.C.003', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 0, 2);
INSERT INTO enderecamento_estoque VALUES (64, 'REC.C.004', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 0, 3);
INSERT INTO enderecamento_estoque VALUES (65, 'REC.C.005', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, false, 0, 4);
INSERT INTO enderecamento_estoque VALUES (66, 'REC.C.006', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 0, 5);
INSERT INTO enderecamento_estoque VALUES (67, 'REC.C.007', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 0, 6);
INSERT INTO enderecamento_estoque VALUES (68, 'REC.C.008', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 0, 7);
INSERT INTO enderecamento_estoque VALUES (69, 'REC.C.009', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, false, 0, 8);
INSERT INTO enderecamento_estoque VALUES (18, 'REC.A.018', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 0);
INSERT INTO enderecamento_estoque VALUES (71, 'BPV.C.011', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 1, 0);
INSERT INTO enderecamento_estoque VALUES (72, 'BPV.C.012', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 1, 1);
INSERT INTO enderecamento_estoque VALUES (73, 'BPV.C.013', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 1, 2);
INSERT INTO enderecamento_estoque VALUES (74, 'BPV.C.014', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, false, 1, 3);
INSERT INTO enderecamento_estoque VALUES (75, 'BPV.C.015', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 1, 4);
INSERT INTO enderecamento_estoque VALUES (76, 'BPV.C.016', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 1, 5);
INSERT INTO enderecamento_estoque VALUES (77, 'BPV.C.017', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 1, 6);
INSERT INTO enderecamento_estoque VALUES (78, 'REC.C.018', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, false, 1, 7);
INSERT INTO enderecamento_estoque VALUES (79, 'REC.C.019', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, false, 1, 8);
INSERT INTO enderecamento_estoque VALUES (80, 'REC.C.020', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 2, 0);
INSERT INTO enderecamento_estoque VALUES (81, 'REC.C.021', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 2, 1);
INSERT INTO enderecamento_estoque VALUES (82, 'REC.C.022', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 2, 2);
INSERT INTO enderecamento_estoque VALUES (83, 'REC.C.023', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 2, 3);
INSERT INTO enderecamento_estoque VALUES (84, 'REC.C.024', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 2, 4);
INSERT INTO enderecamento_estoque VALUES (85, 'REC.C.025', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 2, 5);
INSERT INTO enderecamento_estoque VALUES (86, 'REC.C.026', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 2, 6);
INSERT INTO enderecamento_estoque VALUES (87, 'REC.C.027', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 2, 7);
INSERT INTO enderecamento_estoque VALUES (88, 'REC.C.028', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 2, 8);
INSERT INTO enderecamento_estoque VALUES (89, 'REC.C.029', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 2, 9);
INSERT INTO enderecamento_estoque VALUES (90, 'REC.C.030', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 3, 1, false, true, true, 1, 9);
INSERT INTO enderecamento_estoque VALUES (91, 'REC.D.001', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 0);
INSERT INTO enderecamento_estoque VALUES (92, 'REC.D.002', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (93, 'REC.D.003', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (94, 'REC.D.004', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (95, 'REC.D.005', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (96, 'REC.D.006', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (97, 'REC.D.007', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (98, 'REC.D.008', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (99, 'REC.D.009', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (100, 'REC.D.010', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (101, 'REC.D.011', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (102, 'REC.D.012', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (103, 'REC.D.013', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (104, 'REC.D.014', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (105, 'REC.D.015', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (106, 'REC.D.016', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (107, 'REC.D.017', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (108, 'BPV.D.018', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (109, 'BPV.D.019', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (110, 'BPV.D.020', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (111, 'BPV.D.021', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (112, 'BPV.D.022', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (113, 'BPV.D.023', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (114, 'BPV.D.024', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (115, 'BPV.D.025', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (116, 'BPV.D.026', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (117, 'BPV.D.027', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (118, 'BPV.D.028', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (119, 'BPV.D.029', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (120, 'BPV.D.030', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 2, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (121, 'BPV.F.001', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (2, 'REC.A.002', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (3, 'REC.A.003', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (4, 'REC.A.004', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (5, 'REC.A.005', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (6, 'REC.A.006', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (7, 'REC.A.007', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (8, 'REC.A.008', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (9, 'REC.A.009', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (10, 'REC.A.010', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (11, 'REC.A.011', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (12, 'REC.A.012', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (13, 'REC.A.013', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (14, 'REC.A.014', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (15, 'REC.A.015', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (16, 'REC.A.016', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (17, 'BPV.A.017', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (151, 'REC.G.001', 10000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (19, 'BPV.A.019', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (20, 'BPV.A.020', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (21, 'BPV.A.021', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (22, 'BPV.A.022', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (23, 'BPV.A.023', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (24, 'BPV.A.024', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (25, 'BPV.A.025', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (26, 'BPV.A.026', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (27, 'BPV.A.027', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (28, 'BPV.A.028', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (29, 'BPV.A.029', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (30, 'BPV.A.030', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (31, 'BPV.B.001', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (32, 'BPV.B.002', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (33, 'BPV.B.003', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (34, 'BPV.B.004', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (35, 'BPV.B.005', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (36, 'BPV.B.006', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (37, 'BPV.B.007', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (38, 'BPV.B.008', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (39, 'BPV.B.009', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (40, 'BPV.B.010', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (41, 'REC.B.011', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (42, 'REC.B.012', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (43, 'REC.B.013', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (44, 'REC.B.014', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (45, 'REC.B.015', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (46, 'REC.B.016', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (47, 'REC.B.017', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (48, 'REC.B.018', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (49, 'REC.B.019', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (50, 'REC.B.020', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (51, 'BPV.B.021', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (52, 'BPV.B.022', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (53, 'BPV.B.023', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (54, 'BPV.B.024', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (55, 'BPV.B.025', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (56, 'BPV.B.026', 1000.000, 2.000, '2009-01-10', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (70, 'BPV.C.010', 1000.000, 2.000, '2009-01-10', 1, '2009-03-25', 1, 3, 1, true, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (122, 'REC.F.002', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (123, 'REC.F.003', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (124, 'REC.F.004', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (125, 'REC.F.005', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (126, 'REC.F.006', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (127, 'REC.F.007', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (128, 'REC.F.008', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (129, 'REC.F.009', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (130, 'REC.F.010', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (131, 'REC.F.011', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (132, 'REC.F.012', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (133, 'REC.F.013', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (134, 'REC.F.014', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (135, 'REC.F.015', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (136, 'REC.F.016', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (137, 'REC.F.017', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (138, 'REC.F.018', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (139, 'REC.F.019', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (140, 'BPV.F.020', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (141, 'BPV.F.021', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (142, 'BPV.F.022', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (143, 'BPV.F.023', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (144, 'BPV.F.024', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (145, 'BPV.F.025', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (146, 'BPV.F.026', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (147, 'BPV.F.027', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (148, 'BPV.F.028', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (149, 'BPV.F.029', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (150, 'BPV.F.030', 2000.000, 2.000, '2009-04-08', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (1, 'BPV.A.001', 1000.000, 2.000, '2009-01-10', 1, '2009-05-21', 1, 4, 1, true, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (152, 'REC.G.002', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (153, 'REC.G.003', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (154, 'REC.G.004', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (155, 'REC.G.005', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (156, 'REC.G.006', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (157, 'REC.G.007', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (158, 'REC.G.008', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (159, 'REC.G.009', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (160, 'REC.G.010', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (161, 'REC.G.011', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (162, 'REC.G.012', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (163, 'REC.G.013', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (164, 'REC.G.014', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (165, 'REC.G.015', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (166, 'REC.G.016', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (167, 'REC.G.017', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (168, 'REC.G.018', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (169, 'REC.G.019', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (170, 'REC.G.020', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (171, 'BPV.G.021', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (172, 'BPV.G.022', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (173, 'BPV.G.023', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (174, 'BPV.G.024', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (175, 'BPV.G.025', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (176, 'BPV.G.026', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (177, 'BPV.G.027', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (178, 'BPV.G.028', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (179, 'BPV.G.029', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (180, 'BPV.G.030', 3000.000, 3.000, '2009-10-01', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (182, 'REC.Z.001', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (183, 'REC.Z.002', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (184, 'REC.Z.003', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (185, 'REC.Z.004', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (186, 'REC.Z.005', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (187, 'REC.Z.006', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (188, 'REC.Z.007', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (189, 'REC.Z.008', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (190, 'REC.Z.009', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (191, 'REC.Z.010', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (192, 'REC.Z.011', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (193, 'REC.Z.012', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (194, 'REC.Z.013', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (195, 'REC.Z.014', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (196, 'REC.Z.015', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (197, 'REC.Z.016', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (198, 'REC.Z.017', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (199, 'REC.Z.018', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (200, 'REC.Z.019', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (201, 'REC.Z.020', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (202, 'BPV.Z.021', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (203, 'BPV.Z.022', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (204, 'BPV.Z.023', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (205, 'BPV.Z.024', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (206, 'BPV.Z.025', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (207, 'BPV.Z.026', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (208, 'BPV.Z.027', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (209, 'BPV.Z.028', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (210, 'BPV.Z.029', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (211, 'BPV.Z.030', 0.000, 0.000, '2012-11-28', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (212, 'REC.J.001', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (213, 'REC.J.002', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (214, 'REC.J.003', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (215, 'REC.J.004', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (216, 'REC.J.005', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (217, 'REC.J.006', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (218, 'REC.J.007', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (219, 'REC.J.008', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (220, 'REC.J.009', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (221, 'REC.J.010', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (222, 'REC.J.011', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (223, 'REC.J.012', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (224, 'REC.J.013', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (225, 'REC.J.014', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (226, 'REC.J.015', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (227, 'REC.J.016', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (228, 'REC.J.017', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (229, 'REC.J.018', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (230, 'BPV.J.019', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (231, 'BPV.J.020', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (232, 'BPV.J.021', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (233, 'BPV.J.022', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (234, 'BPV.J.023', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (235, 'BPV.J.024', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (236, 'BPV.J.025', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (237, 'BPV.J.026', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (238, 'BPV.J.027', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (239, 'BPV.J.028', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (240, 'BPV.J.029', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (241, 'BPV.J.030', 0.000, 0.000, '2013-03-08', 1, NULL, NULL, 1, 1, false, true, true, 0, 1);

INSERT INTO enderecamento_estoque VALUES (243, 'REC.Q.001', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 0, 0);
INSERT INTO enderecamento_estoque VALUES (244, 'REC.Q.002', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (245, 'REC.Q.003', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 0, 2);
INSERT INTO enderecamento_estoque VALUES (246, 'REC.Q.004', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 0, 3);
INSERT INTO enderecamento_estoque VALUES (247, 'REC.Q.005', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 0, 4);
INSERT INTO enderecamento_estoque VALUES (248, 'REC.Q.006', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 0, 6);
INSERT INTO enderecamento_estoque VALUES (249, 'REC.Q.007', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 0, 7);
INSERT INTO enderecamento_estoque VALUES (250, 'REC.Q.008', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 0, 8);
INSERT INTO enderecamento_estoque VALUES (251, 'REC.Q.009', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 1, 0);
INSERT INTO enderecamento_estoque VALUES (252, 'REC.Q.010', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 1, 1);
INSERT INTO enderecamento_estoque VALUES (253, 'REC.Q.011', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 1, 2);
INSERT INTO enderecamento_estoque VALUES (254, 'REC.Q.012', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 1, 3);
INSERT INTO enderecamento_estoque VALUES (255, 'REC.Q.013', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 1, 4);
INSERT INTO enderecamento_estoque VALUES (256, 'REC.Q.014', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 1, 5);
INSERT INTO enderecamento_estoque VALUES (257, 'REC.Q.015', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 2, 0);
INSERT INTO enderecamento_estoque VALUES (258, 'REC.Q.016', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 2, 1);
INSERT INTO enderecamento_estoque VALUES (259, 'REC.Q.017', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 2, 2);
INSERT INTO enderecamento_estoque VALUES (260, 'REC.Q.018', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 2, 3);
INSERT INTO enderecamento_estoque VALUES (261, 'REC.Q.019', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 2, 4);
INSERT INTO enderecamento_estoque VALUES (262, 'REC.Q.020', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 2, 5);
INSERT INTO enderecamento_estoque VALUES (263, 'REC.Q.021', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 2, 6);
INSERT INTO enderecamento_estoque VALUES (264, 'REC.Q.022', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 2, 7);
INSERT INTO enderecamento_estoque VALUES (265, 'REC.Q.023', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 3, 0);
INSERT INTO enderecamento_estoque VALUES (266, 'REC.Q.024', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 3, 1);
INSERT INTO enderecamento_estoque VALUES (267, 'REC.Q.025', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 3, 2);
INSERT INTO enderecamento_estoque VALUES (268, 'REC.Q.026', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 3, 3);
INSERT INTO enderecamento_estoque VALUES (269, 'REC.Q.027', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 3, 4);
INSERT INTO enderecamento_estoque VALUES (270, 'REC.Q.028', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 3, 5);
INSERT INTO enderecamento_estoque VALUES (271, 'REC.Q.029', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 3, 6);
INSERT INTO enderecamento_estoque VALUES (272, 'REC.Q.030', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 3, 7);
INSERT INTO enderecamento_estoque VALUES (273, 'REC.Q.031', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 3, 8);
INSERT INTO enderecamento_estoque VALUES (274, 'REC.Q.032', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 3, 9);
INSERT INTO enderecamento_estoque VALUES (275, 'REC.Q.033', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, false, 4, 0);
INSERT INTO enderecamento_estoque VALUES (310, 'REC.Q.068', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 4, 6);
INSERT INTO enderecamento_estoque VALUES (311, 'REC.Q.069', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 4, 7);
INSERT INTO enderecamento_estoque VALUES (312, 'REC.Q.070', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 0);
INSERT INTO enderecamento_estoque VALUES (313, 'REC.Q.071', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 1);
INSERT INTO enderecamento_estoque VALUES (314, 'REC.Q.072', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 7);
INSERT INTO enderecamento_estoque VALUES (315, 'REC.Q.073', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 6, 1);
INSERT INTO enderecamento_estoque VALUES (316, 'REC.Q.074', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 6, 9);
INSERT INTO enderecamento_estoque VALUES (317, 'REC.Q.075', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 0);
INSERT INTO enderecamento_estoque VALUES (318, 'REC.Q.076', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 1);
INSERT INTO enderecamento_estoque VALUES (319, 'REC.Q.077', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 4);
INSERT INTO enderecamento_estoque VALUES (320, 'REC.Q.078', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 6);
INSERT INTO enderecamento_estoque VALUES (321, 'REC.Q.079', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 8);
INSERT INTO enderecamento_estoque VALUES (322, 'REC.Q.080', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 9);

INSERT INTO enderecamento_estoque VALUES (276, 'BPV.Q.034', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 4, 1);
INSERT INTO enderecamento_estoque VALUES (277, 'BPV.Q.035', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 4, 2);
INSERT INTO enderecamento_estoque VALUES (278, 'BPV.Q.036', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 4, 3);
INSERT INTO enderecamento_estoque VALUES (279, 'BPV.Q.037', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 4, 4);
INSERT INTO enderecamento_estoque VALUES (280, 'BPV.Q.038', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 4, 5);
INSERT INTO enderecamento_estoque VALUES (281, 'BPV.Q.039', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 4, 6);
INSERT INTO enderecamento_estoque VALUES (282, 'BPV.Q.040', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 4, 7);
INSERT INTO enderecamento_estoque VALUES (283, 'BPV.Q.041', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 0);
INSERT INTO enderecamento_estoque VALUES (284, 'BPV.Q.042', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 1);
INSERT INTO enderecamento_estoque VALUES (285, 'BPV.Q.043', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 2);
INSERT INTO enderecamento_estoque VALUES (286, 'BPV.Q.044', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 3);
INSERT INTO enderecamento_estoque VALUES (287, 'BPV.Q.045', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 4);
INSERT INTO enderecamento_estoque VALUES (288, 'BPV.Q.046', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 5);
INSERT INTO enderecamento_estoque VALUES (289, 'BPV.Q.047', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 6);
INSERT INTO enderecamento_estoque VALUES (290, 'BPV.Q.048', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 7);
INSERT INTO enderecamento_estoque VALUES (291, 'BPV.Q.049', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 8);
INSERT INTO enderecamento_estoque VALUES (292, 'BPV.Q.050', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 5, 9);
INSERT INTO enderecamento_estoque VALUES (293, 'BPV.Q.051', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 6, 1);
INSERT INTO enderecamento_estoque VALUES (294, 'BPV.Q.052', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 6, 1);
INSERT INTO enderecamento_estoque VALUES (295, 'BPV.Q.053', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 6, 1);
INSERT INTO enderecamento_estoque VALUES (296, 'BPV.Q.054', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 6, 1);
INSERT INTO enderecamento_estoque VALUES (297, 'BPV.Q.055', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 6, 1);
INSERT INTO enderecamento_estoque VALUES (298, 'BPV.Q.056', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 6, 1);
INSERT INTO enderecamento_estoque VALUES (299, 'BPV.Q.057', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 1);
INSERT INTO enderecamento_estoque VALUES (300, 'BPV.Q.058', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 1);
INSERT INTO enderecamento_estoque VALUES (301, 'BPV.Q.059', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 1);
INSERT INTO enderecamento_estoque VALUES (302, 'BPV.Q.060', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 1);
INSERT INTO enderecamento_estoque VALUES (303, 'BPV.Q.061', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 1);
INSERT INTO enderecamento_estoque VALUES (304, 'BPV.Q.062', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 1);
INSERT INTO enderecamento_estoque VALUES (305, 'BPV.Q.063', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 1);
INSERT INTO enderecamento_estoque VALUES (306, 'BPV.Q.064', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 7, 1);
INSERT INTO enderecamento_estoque VALUES (307, 'BPV.Q.065', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (308, 'BPV.Q.066', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);
INSERT INTO enderecamento_estoque VALUES (309, 'BPV.Q.067', 0.000, 0.000, '2014-11-27', 1, NULL, NULL, 4, 1, false, true, true, 0, 1);




insert into estrutura_enderecamento (descricao, tamanho, restricoes, ordem, filial_id, orientacao, imagem, quantidade_coluna, quantidade_linha)
values ('Galpão', 3, 'l', 1, 1, 2, 'galpao.png', 3, 1);

insert into estrutura_enderecamento (descricao, tamanho, restricoes, ordem, filial_id, orientacao, imagem, quantidade_coluna, quantidade_linha)
values ('RUA', 1, 'n', 2, 1, 4, 'rua.png', 6, 2);

insert into estrutura_enderecamento (descricao, tamanho, restricoes, ordem, filial_id, orientacao, imagem, quantidade_coluna, quantidade_linha)
values ('APTO', 3, 'n', 3, 1, 7, 'pallet.png', 9, 7);


