-- DDL -- data definition language

create schema ecommerce926;

set search_path to ecommerce926;

create table produto(
	id serial,
	descricao varchar(1000) not null,
	codigo_barras varchar(44) not null,
	valor numeric not null
);

alter table produto add constraint pk_produto primary key(id);

alter table produto add constraint 
	uk_produto_codigo_barras unique(codigo_barras);

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

create table cupom ( 
	id serial not null,
	data_inicio timestamp not null,
	data_expiracao timestamp not null,
	valor numeric not null,
	descricao varchar(1000) not null,
	constraint pk_cupom primary key (id)
 );

create table fornecedor ( 
	id serial not null,
	nome varchar(895) not null,
	cnpj char(14) not null,
	id_endereco integer not null,
	constraint pk_fornecedor primary key (id),
	constraint unq_fornecedor_cpnj unique (cnpj) ,
	constraint unq_fornecedor_id_endereco unique (id_endereco) 
 );

alter table fornecedor add constraint fk_fornecedor_endereco foreign key (id_endereco) references endereco(id);

create table estoque ( 
	id serial not null,
	id_endereco integer not null,
	constraint pk_estoque primary key (id),
	constraint idx_estoque unique (id_endereco) 
 );

alter table estoque add constraint fk_estoque_endereco foreign key (id_endereco) references endereco(id);

CREATE TABLE produto_estoque ( 
	id_estoque integer not null,
	id_produto integer not null,
	quantidade integer not null,
	constraint pk_produto_estoque primary key (id_estoque, id_produto)
 );

alter table produto_estoque add constraint fk_produto_estoque_estoque foreign key (id_estoque) references estoque(id);

alter table produto_estoque add constraint fk_produto_estoque_produto foreign key (id_produto) references produto(id);












