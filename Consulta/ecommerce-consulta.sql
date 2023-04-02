select * from cliente;

select * from pedido;

select * from cupom;
-- 1) Listar todos os cliente que tem o nome 'ANA'.> Dica: Buscar sobre função Like

select * from 
	cliente where nome like '%Ana%';

-- 2) Pedidos feitos em 2023

select * from pedido where 
	data_criacao >= '2023-01-01' and data_criacao <= '2023-12-31';

-- 3) Pedidos feitos em Janeiro de qualquer ano

	 SELECT * from pedido where 
		extract(month from data_criacao) = 1;

-- 4) Itens de pedido com valor entre R$2 e R$5
	
select * from item_pedido where
	valor between 2 and 5;

-- 5) Trazer o Item mais caro comprado em um pedido

select id_pedido, id_produto, quantidade, valor from item_pedido where 
	valor = (SELECT MAX(valor) FROM item_pedido);

-- 6) Listar todos os status diferentes de pedidos;

select distinct status 
	from pedido;

-- 7) Listar o maior, menor e valor médio dos produtos disponíveis.

select MAX(valor) as maior_preco, MIN(valor) as menor_preco, AVG(valor) as media_preco 
	from produto;

-- 8) Listar fornecedores com os dados: nome, cnpj, logradouro, numero, cidade e uf de todos os fornecedores;

select f.nome, f.cnpj, e.logradouro, e.numero, e.cidade, e.uf 
	from fornecedor f 
	inner join endereco e on f.id_endereco = e.id;

-- 9) Informações de produtos em estoque com os dados: id do estoque, descrição do produto, quantidade do produto no estoque, logradouro, numero, cidade e uf do estoque;

select e.id as id_estoque, p.descricao as descricao_produto, ie.quantidade as quantidade_em_estoque, en.logradouro as logradouro_estoque, 
en.numero as numero_estoque, en.cidade as cidade_estoque, en.uf as uf_estoque 
	from estoque e
	join item_estoque ie on ie.id_estoque = e.id
	join produto p on p.id = ie.id_produto
	join endereco en on en.id = e.id_endereco;

-- 10) Informações sumarizadas de estoque de produtos com os dados: descrição do produto, código de barras, quantidade total do produto em todos os estoques;

select p.descricao as "Descrição do Produto", p.codigo_barras as "Código de Barras", SUM(ie.quantidade) as "Quantidade Total em Estoque" 
	from produto p
	join item_estoque ie ON p.id = ie.id_produto 
    group by p.id, p.descricao, p.codigo_barras 
    order by p.descricao;
	
-- 11) Informações do carrinho de um cliente específico (cliente com cpf '26382080861') com os dados: descrição do produto, quantidade no carrinho, valor do produto.
   
select p.descricao as produto, ic.quantidade as quantidade_carrinho, p.valor as valor_produto from item_carrinho ic
	join produto p on ic.id_produto = p.id
	join cliente c on ic.id_cliente = c.id
	where c.cpf = '26382080861';

-- 12) Relatório de quantos produtos diferentes cada cliente tem no carrinho ordenado pelo cliente que tem mais produtos no carrinho para o que tem menos, com os dados: 
--     id do cliente, nome, cpf e quantidade de produtos diferentes no carrinho.

select c.id as id_cliente, c.nome, c.cpf, COUNT(distinct ic.id_produto) as qtd_produtos_carrinho 
from cliente c 
  join item_carrinho ic on c.id = ic.id_cliente 
  group by c.id, c.nome, c.cpf 
  order by qtd_produtos_carrinho desc;
 
 -- 13) Relatório com os produtos que estão em um carrinho a mais de 10 meses, ordenados pelo inserido a mais tempo, com os dados: 
 --     id do produto, descrição do produto, data de inserção no carrinho, id do cliente e nome do cliente;
 
 select ic.id_produto, p.descricao, ic.data_insercao, c.id, c.nome from
 item_carrinho ic 
	join cliente c on ic.id_cliente = c.id 
	join produto p on ic.id_produto = p.id 
	where ic.data_insercao < (CURRENT_DATE - INTERVAL '10 months') 
	order by ic.data_insercao asc;

-- 14) Relatório de clientes por estado, com os dados: uf (unidade federativa) e quantidade de clientes no estado;

select endereco.uf, COUNT(cliente.id) as quantidade_clientes 
from cliente
	join endereco on cliente.id_endereco = endereco.id
	group by endereco.uf
	order by quantidade_clientes desc;

-- 15)Listar cidade com mais clientes e a quantidade de clientes na cidade;

select cidade, COUNT(*) as quantidade_clientes
from endereco
	group by cidade
	order by quantidade_clientes desc
	limit 1; 

-- 16) Exibir informações de um pedido específico, pedido com id 952, com os dados (não tem problema repetir dados em mais de uma linha): 
--     nome do cliente, id do pedido, previsão de entrega, status do pedido, descrição dos produtos comprados, quantidade comprada produto, valor total pago no produto;

select c.nome as nome_cliente, p.id ASas id_pedido, p.previsao_entrega, p.status,
       pr.descricao as descricao_produto, ip.quantidade as quantidade_produto,
       ip.valor as valor_total_produto
from pedido p
	join cliente c ON c.id = p.id_cliente
	join item_pedido ip ON ip.id_pedido = p.id
	join produto pr ON pr.id = ip.id_produto
	where p.id = 952;
	
-- 17) Relatório de clientes que realizaram algum pedido em 2022, com os dados: id_cliente, nome_cliente, data da última compra de 2022;

select c.id as id_cliente, c.nome as nome_cliente, 
       MAX(p.data_criacao) as data_ultima_compra 
from cliente c 
    inner join pedido p on c.id = p.id_cliente 
	where extract(year from p.data_criacao) = 2022 
	group by c.id 
	order by data_ultima_compra DESC;

-- 18) Relatório com os TOP 10 clientes que mais gastaram esse ano, com os dados: nome do cliente, valor total gasto;

select c.nome as nome_cliente, SUM(ip.valor * ip.quantidade) as valor_total_gasto
from cliente c
	join pedido p on c.id = p.id_cliente
	join item_pedido ip on p.id = ip.id_pedido
	where date_part('year', p.data_criacao) = 2023
	group by c.id
	order by valor_total_gasto desc
	limit 10;

-- 19) Relatório com os TOP 10 produtos vendidos esse ano, com os dados: descrição do produto, quantidade vendida, valor total das vendas desse produto;

select p.descricao as descricao_produto, 
  SUM(ip.quantidade) as quantidade_vendida, 
  SUM(ip.quantidade * p.valor) as valor_total_vendas 
 from item_pedido ip 
	join produto p on ip.id_produto = p.id 
	join pedido pe on ip.id_pedido = pe.id 
	where DATE_PART('year', pe.data_criacao) = 2023 
	group by p.descricao 
	order by valor_total_vendas DESC 
	limit 10;

-- 20) Exibir o ticket médio do nosso e-commerce, ou seja, a média dos valores totais gasto em pedidos com sucesso;

select AVG(ip.valor * ip.quantidade) as ticket_medio
from pedido p
	join item_pedido ip on p.id = ip.id_pedido
	where p.status = 'SUCESSO';

-- 21) Relatório dos clientes gastaram acima de R$ 10000 em um pedido, com os dados: id_cliente, nome do cliente, valor máximo gasto em um pedido;

select p.id_cliente, c.nome, max(ip.valor), sum(ip.valor * ip.quantidade) as valor_total from item_pedido ip 
inner join pedido p on p.id = ip.id_pedido 
inner join cliente c on c.id = p.id_cliente 
group by p.id, p.id_cliente, c.nome
having sum(ip.valor * ip.quantidade) > 10000
order by valor_total;


-- 22) Listar TOP 10 cupons mais utilizados e o total descontado por eles.

select c.descricao, p.id_cupom, count(p.id_cupom) qtd_utilizada, c.valor, sum(c.valor) total_descontado 
from pedido p, cupom c
	where p.id_cupom = c.id 
	group by p.id_cupom, c.descricao, c.valor
	order by qtd_utilizada desc 
	limit 10;

-- 23) Listar cupons que foram utilizados mais que seu limite

select c.descricao, p.id_cupom, count(p.id_cupom) qtd_utilizada, c.limite_maximo_usos 
from pedido p, cupom c
	where p.id_cupom = c.id 
	group by p.id_cupom, c.descricao, c.valor, c.limite_maximo_usos 
	having count(p.id_cupom) > c.limite_maximo_usos 
	order by p.id_cupom;

-- 24- Listar todos os ids dos pedidos que foram feitos por pessoas que moram em São Paulo (unidade federativa, uf, SP)
-- e compraram o produto com código de barras '97692630963921';

select distinct p.codigo_barras, p.descricao, pe.id, e.uf 
from produto p, pedido pe, endereco e 
	where p.codigo_barras = '97692630963921' and e.uf  = 'SP';