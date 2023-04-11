create database seguradora;
use seguradora;

create table loja(
	id bigint (20), 
    cnpj VARCHAR(255),
    razao_social VARCHAR(255),
    usuario VARCHAR(255),
    senha VARCHAR(255)
    );
    alter table loja add primary key (id);
    insert into loja (id, cnpj, razao_social, usuario, senha)
    values(1, '001', 'explosao', 'raphael', '0101');
    insert into loja (id, cnpj, razao_social, usuario, senha)
    values(2, '202', 'porto', 'julieta', '0202');
    insert into loja (id, cnpj, razao_social, usuario, senha)
    values(3, '303', 'euro', 'carlos', DEFAULT);
    insert into loja (id, cnpj, razao_social, usuario, senha)
    values(4, '404', 'zulu', 'joana', '0404');
    insert into loja (id, cnpj, razao_social, usuario, senha)
    values(5, '505', 'placebo', 'arthur', '0505');
    
create table segurado(
	id bigint (20),
    cpf VARCHAR(255),
    data_nascimento DATE,
    estado_civil VARCHAR(255),
    nome VARCHAR(255)
    );
    alter table segurado add primary key (id);
    insert into segurado (id, cpf, data_nascimento, estado_civil, nome)
    values(1, '001', '2001-03-29', 'casado', 'jeferson');
    insert into segurado (id, cpf, data_nascimento, estado_civil, nome)
    values(2, '002', '2002-02-22', 'casado', 'jose');
    insert into segurado (id, cpf, data_nascimento, estado_civil, nome)
    values(3, '003', '2001-03-23', 'solteiro', 'daniel');
    insert into segurado (id, cpf, data_nascimento, estado_civil, nome)
    values(4, '004', '2004-04-12', 'viuva', 'mariana');
    insert into segurado (id, cpf, data_nascimento, estado_civil, nome)
    values(5, '005', '2005-05-25', DEFAULT, 'rafaela');
    
    create table produto(
	id bigint(20),
    nome VARCHAR(255),
    valor DOUBLE,
    loja_id bigint (20) 
    );
    alter table produto add primary key (id);
    alter table produto add foreign key (id) references loja(id);
	insert into produto (id, nome, valor, loja_id)
    values(1, 'blindagem', '18.000',1);
    insert into produto (id, nome, valor, loja_id)
    values(2, 'anti-incêncendio', '300.00',2);
    insert into produto (id, nome, valor, loja_id)
    values(3, 'furto', '2000.00',3);
    insert into produto (id, nome, valor, loja_id)
    values(4, 'guincho', '275.00',4);
    insert into produto (id, nome, valor, loja_id)
    values(5, 'reparo', '1500.00',5);
    
    create table contrato(
	id bigint(20),
    data_criacao datetime,
    fim_vigencia datetime,
    forma_pagamento VARCHAR(255),
    inicio_vigencia DATETIME,
    numero VARCHAR(255),
    loja_id bigint (20), 
    produto_id bigint (20),
    segurado_id bigint (20),
    status VARCHAR(255)
    );
    
    
    insert into contrato (id, data_criacao, fim_vigencia, forma_pagamento, inicio_vigencia, numero, loja_id,  produto_id, segurado_id)
    values(1,'2022-12-25', '2001-10-17',  'Débito', '2000-09-20', '7', 1, '1', '1');
    insert into contrato (id, data_criacao, fim_vigencia, forma_pagamento, inicio_vigencia, numero, loja_id,  produto_id, segurado_id)
    values(2,'2023-01-15', '2023-06-30', 'Cartão de crédito', '2023-02-01', '3', 2, '2', '2');
    insert into contrato (id, data_criacao, fim_vigencia, forma_pagamento, inicio_vigencia, numero, loja_id,  produto_id, segurado_id)
    values(3,'2022-11-01', '2023-12-31', 'Boleto bancário', '2023-01-01', '2', 3, '3', '3');
    insert into contrato (id, data_criacao, fim_vigencia, forma_pagamento, inicio_vigencia, numero, loja_id,  produto_id, segurado_id)
    values(4,'2023-03-10', '2023-09-30', 'Transferência bancária', '2023-04-01', '9', 4, '4', '4');
    insert into contrato (id, data_criacao, fim_vigencia, forma_pagamento, inicio_vigencia, numero, loja_id,  produto_id, segurado_id)
    values(5,'2022-12-15', '2023-07-31', 'PayPal', '2023-01-01', '6', 5, '5', '5');
    
    alter table contrato add primary key (id);
    alter table contrato add foreign key (id) references loja(id);
    alter table contrato add foreign key (id) references segurado(id);
    alter table contrato add foreign key (id) references produto(id);
    
    
    
    /* 	1.Extraia a informação dos segurados e os produtos relacionados.
		2.Extraia o todos os contratos de seguro por loja   
		3.Exiba quais produtos que são mais assegurados    
		4.Exiba as lojas que não tem nenhum produto assegurado 
    */ 
    
    
    -- 1. Extraia a informação dos segurados e os produtos relacionados.
    SELECT * FROM segurado JOIN produto ON segurado.id = produto.id;


    -- 2.Extraia o todos os contratos de seguro por loja
    SELECT loja.razao_social, COUNT(*) as total_contratos
	FROM loja
	JOIN segurado ON segurado.id = loja.id
	JOIN produto ON produto.id = segurado.id
	GROUP BY loja.id;
    
    
    -- 3.Exiba quais produtos que são mais assegurados
    SELECT produto.nome, COUNT(segurado.id) as quantidade_de_seguros 
	FROM produto
	JOIN segurado ON segurado.id = produto.id
	GROUP BY produto.id
	ORDER BY quantidade_de_seguros DESC;
    
    
    -- 4.Exiba as lojas que não tem nenhum produto assegurado
    SELECT * FROM loja WHERE id NOT IN (SELECT loja_id FROM produto);


