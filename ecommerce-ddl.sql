-- DDL -- data definition language


create schema ecommerce926;

create table produto(
	id serial,
	descricao varchar(1000) not null,
	codigo_barras varchar(44) not null,
	valor numeric not null
);

alter table produto add constraint pk_produto primary key(id);

alter table produto add constraint 
	uk_produto_codigo_barras unique(codigo_barras);


drop table endereco;

create table endereco(
	id serial,
	cep char(8) not null,
	logradouro varchar(1000) not null,
	numero varchar(30) not null,
	cidade varchar(200) not null,
	uf char(2) not null,
	constraint pk_id_endereco primary key(id)
);

create table cliente(
	id serial primary key,
	nome varchar(895) not null,
	cpf char(11) unique not null,
	id_endereco int not null
);

--alter table cliente
--	add column cpf char(11) unique; Inserindo dados na tabela caso eu esquecesse de inserir na hora da criação.

--alter table cliente
--	add UNIQUE(id_endereco); 
	
--alter table cliente
--	add column id_endereco set not null unique;


alter table cliente
	add constraint uk_cliente_id_endereco unique(id_endereco);

alter table cliente 
	add foreign key (id_endereco) references endereco(id);

create table pedido (
    id serial primary key,
    previsao_entrega date not null,
    meio_pagamento varchar(200) not null,
    status varchar(100) not null,
    id_cliente int not null,
    data_criacao timestamp not null,
    foreign key(id_cliente) references cliente
);

create table item_pedido(
    id_pedido int not null,
    id_produto int not null,
    quantidade int not null,
    valor numeric not null,
    primary key(id_pedido, id_produto),
    foreign key(id_pedido) references pedido(id),
    foreign key(id_produto) references produto
);

create TABLE cupom ( 
	id serial not null,
	data_inicio timestamp not null,
	data_expiracao timestamp not null,
	valor numeric not null,
	descricao varchar(1000) not null,
	CONSTRAINT pk_cupom PRIMARY KEY (id)
 );

CREATE TABLE fornecedor ( 
	id serial not null,
	nome varchar(895) not null,
	cnpj char(14) not null,
	id_endereco integer not null,
	CONSTRAINT pk_fornecedor PRIMARY KEY (id),
	CONSTRAINT unq_fornecedor_cpnj UNIQUE (cnpj) ,
	CONSTRAINT unq_fornecedor_id_endereco UNIQUE (id_endereco) 
 );

ALTER TABLE fornecedor ADD CONSTRAINT fk_fornecedor_endereco FOREIGN KEY ( id_endereco ) REFERENCES endereco( id );

CREATE TABLE estoque ( 
	id serial not null,
	id_endereco integer not null,
	CONSTRAINT pk_estoque PRIMARY KEY (id),
	CONSTRAINT idx_estoque UNIQUE (id_endereco) 
 );

ALTER TABLE estoque ADD CONSTRAINT fk_estoque_endereco FOREIGN KEY (id_endereco) REFERENCES endereco(id);

CREATE TABLE produto_estoque ( 
	id_estoque integer  NOT NULL  ,
	id_produto integer  NOT NULL  ,
	quantidade integer  NOT NULL  ,
	CONSTRAINT pk_produto_estoque PRIMARY KEY (id_estoque, id_produto)
 );

ALTER TABLE produto_estoque ADD CONSTRAINT fk_produto_estoque_estoque FOREIGN KEY (id_estoque) REFERENCES estoque(id);

ALTER TABLE produto_estoque ADD CONSTRAINT fk_produto_estoque_produto FOREIGN KEY (id_produto) REFERENCES produto(id);












