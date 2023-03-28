set search_path to ecommerce926;


insert into endereco(cep, logradouro, numero, cidade, uf)
values
('55296300','Rua rui barbosa','350','garanhuns','pe'),
('11122888','Rua julia brasileiro','192','caruaru','pe'),
('11122888','Rua julia roberto','100','caruaru','pe'),
('11122888','Rua afonso donato','111','caruaru','pe'),
('55555333','rua alto são josé','5','cumaru','pe');

-- 5 clientes
insert into cliente(nome, id_endereco, cpf) 
	values 
	('Guilherme jose', '1','11111111111'),
	('Joyce Ribeiro', '2','22222222222'),
	('Lucas Bassetto', '3','33333333333'),
	('Mariana', '4','44444444444'),
	('Ana Maria', '5','55555555555');
 
-- 2 fornecedores
 insert into fornecedor (nome, cnpj, id_endereco)
	 values
	 ('Ana paula', '89348538000103','1'),
	 ('João Dede', '26651103000105','2'),
	 ('Maria josefa','99712276000160','3'),
	 ('Antonia maria','12232127000115','4'),
	 ('Pirangaba','70599461000108','5');
	 

-- 5 produtos
 insert into produto (descricao, codigo_barras, valor, id_fornecedor)
	values
	('carrinho','ABC1237','100','1'),
	('motinha','TTT1111','122','2'),
	('caminhao','RRR999','200','3'),
	('bone','GGG456','852','4'),
	('camisa','SSS96933','256','5');
 
insert into  carrinho (id_cliente, id_produto, quantidade, data_insercao)
	values
	('1','1','10','2023-02-01'),
	('1','2','15','2023-02-03'),
	('1','3','20','2023-02-05'),
	('2','1','7','2023-02-02'),
	('2','2','11','2023-02-07'),
	('2','3','19','2023-02-08');

-- 6 pedidos
insert into pedido (previsao_entrega, meio_pagamento, status , data_criacao, id_cliente)
	values
	 ('2023-02-01', 'pix','entregue','2023-07-01','1'),
	 ('2023-02-02', 'pix','entregue','2023-07-01','2'),
	 ('2023-02-05', 'dinheiro','entregue','2023-07-01','3'),
	 ('2023-04-06', 'pix','entregue','2023-07-01','4'),
	 ('2023-04-02', 'pix','entregue','2023-07-01','5'),
	 ('2023-06-12', 'pix','entregue','2023-07-01','1'),
	 ('2023-06-09', 'pix','entregue','2023-07-01','2');


insert into item_pedido (id_pedido, id_produto, quantidade, valor)
	values
	('1','1','20','50'),
	('1','3','12','5'),
	('2','2','210','550'),
	('2','4','30','120'),
	('3','1','40','80'),
	('3','5','60','90'),
	('4','2','40','50'),
	('4','3','50','90'),
	('5','2','80','100'),
	('5','3','90','150'),
	('6','1','30','50'),
	('6','2','10','50');


-- 3 campanhas de cupons
-- 		2 pedidos que utilizaram cupons
insert into cupom (data_inicio, data_expiracao, valor, descricao)
	values
	('2023-02-23','2023-03-23','112','Cupom de 10 reais de desconto'),
	('2023-01-20','2023-02-20','120','Cupom de 15 reais de desconto'),
	('2023-03-20','2023-04-20','200','Cupom de 20 reais de desconto');

insert into pedido (previsao_entrega, meio_pagamento, status , data_criacao, id_cliente, id_cupom)
	values
	 ('2023-02-01', 'dinheiro','entregue','2023-07-01','1','1'),
	 ('2023-02-02', 'pix','entregue','2023-07-01','2','2');
	
insert into item_pedido (id_pedido, id_produto, quantidade, valor)
	values
	('8','1','20','50'),
	('9','3','12','5');

-- 2 estoques
insert into endereco(cep, logradouro, numero, cidade, uf)
	values
	('66566888','Rua dos galpões','600','Mogi','sp'),
	('99899777','Rua dos caminhões','850','Salvador','ba');

insert into estoque (id_endereco)
	values
	('6'),
	('7');

insert into produto_estoque (id_estoque, id_produto, quantidade)
	values
	('1','1','112'),
	('1','2','89'),
	('2','3','58'),
	('2','4','25'),
	('2','5','60');


-- deletar um cliente 
insert into endereco(cep, logradouro, numero, cidade, uf)
	values
	('88599456','Rua pereira','150','Cumaru','pe');

insert into cliente(nome, id_endereco, cpf) 
	values 
	('Rodrigo covas', '8','78963254123');

delete from cliente where id = '6';

-- atualizar descricao e valor de produto
update produto 
set descricao = 'Carrinho de controle remoto', 
valor = '124'
where id = 1;




 