--password: computacao@raiz psql -U postgres < script.sql

--Arthur_Giacomin
--Turma CC1MD


--CRIA O BANCO DE DADOS:
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS arthur;
CREATE USER arthur WITH CREATEDB INHERIT login password '234';

CREATE DATABASE uvv
OWNER arthur
TEMPLATE template0
ENCODING 'UTF8'
LC_COLLATE 'pt_BR.UTF-8'
LC_CTYPE 'pt_BR.UTF-8'
ALLOW_CONNECTIONS TRUE;

--Usar o banco de dados
\c 'dbname=uvv user=arthur password=234';

--Conexão com o banco de dados:
SET ROLE arthur;

--Cria o esquema lojas:
CREATE SCHEMA lojas AUTHORIZATION arthur;

--Alteração do search_path para o usuário que foi criado:
ALTER USER arthur
SET SEARCH_PATH TO lojas, "$user", public;
--CRIA A TABELA PRODUTOS:
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

--COMENTÁRIOS DAS TABELAS E COLUNAS "PRODUTOS":
COMMENT ON TABLE lojas.produtos IS 'cadastro produtos';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Identificador único do produto.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Nome do produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço unitário do produto.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Dados detalhados do produto em formato binário.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem do produto em formato binário';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Tipo MIME da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Nome do arquivo da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Conjunto de caracteres da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Data da última atualização da imagem do produto.';


--CRIA A TABELA LOJAS:
CREATE TABLE lojas.lojas (
loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

--COMENTÁRIOS DAS TABELAS E COLUNAS "LOJAS":
COMMENT ON TABLE lojas.lojas IS 'cadastro lojas';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Identificador único da loja.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Nome da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Endereço web da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Endereço físico da loja.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Latitude geográfica da localização da loja.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Longitude geográfica da localização da loja.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Logotipo da loja em formato binário.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Tipo MIME do logotipo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Nome do arquivo do logotipo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Conjunto de caracteres do logotipo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data da última atualização do logotipo da loja.';
--CRIA A TABELA ESTOQUES:
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

--COMENTÁRIOS DAS TABELAS E COLUNAS "ESTOQUES":
COMMENT ON TABLE lojas.estoques IS 'cadastro estoques';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Identificador único do estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Identificador único da loja relacionada ao estoque.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Identificador único do produto relacionado ao estoque.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade do produto disponível no estoque.';


--CRIA A TABELA CLIENTES:
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

--COMENTÁRIOS DAS TABELAS E COLUNAS "CLIENTES":
COMMENT ON TABLE lojas.clientes IS 'cadastro clientes';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Identificador único do cliente.';
COMMENT ON COLUMN lojas.clientes.email IS 'Endereço de e-mail do cliente.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Nome do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Primeiro número de telefone do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Segundo número de telefone do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Terceiro número de telefone do cliente.';


--CRIA A TABELA ENVIOS:
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

--COMENTÁRIOS DAS TABELAS E COLUNAS "ENVIOS":
COMMENT ON TABLE lojas.envios IS 'cadastro pedidos';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Identificador único do envio.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Identificador único da loja relacionada ao envio.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Identificador único do cliente relacionado ao envio.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço de entrega do envio.';
COMMENT ON COLUMN lojas.envios.status IS 'Status do envio.';


--CRIA A TABELA PEDIDOS:
CREATE TABLE lojas.pedidos (
pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

--COMENTÁRIOS DAS TABELAS E COLUNAS "PEDIDOS":
COMMENT ON TABLE lojas.pedidos IS 'cadastro pedidos';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Identificador único do pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Data e hora do pedido.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Identificador único do cliente relacionado ao pedido.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Status do pedido.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Identificador único da loja relacionada ao pedido.';


--CRIA A TABELA ITENS:
CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

--COMENTÁRIOS DAS TABELAS E COLUNAS "ITENS":
COMMENT ON TABLE lojas.pedidos_itens IS 'cadastro pedido_itens';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Identificador único do pedido relacionado ao item.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Identificador único do produto relacionado ao item.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Número da linha do item no pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço unitário do item.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade do item.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Identificador único do envio relacionado ao item.';

--preço unitário do produto não pode ser negativo:
ALTER TABLE lojas.produtos ADD CONSTRAINT ck_preco_unitario
CHECK (preco_unitario > 0);

--quantidades não podem ser negativas:
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT ck_pi_quantidade
CHECK (quantidade > 0);

--O “status” dos pedidos só pode aceitar os seguintes valores:
ALTER TABLE lojas.pedidos ADD CONSTRAINT ck_pedidos_status
CHECK (status in ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO'));

--O “status” dos envios só pode aceitar os seguintes valores:
ALTER TABLE lojas.envios ADD CONSTRAINT ck_envios_status
CHECK (status in ('CRIADO','ENVIADO','TRANSITO','ENTREGUE'));

--restrição que garante que pelo menos uma das colunas de endereço (web ou físico) estejam preenchidas:
ALTER TABLE lojas.lojas ADD CONSTRAINT ck_endfis_endweb
CHECK (endereco_fisico is not null or endereco_web is not null);

--CRIA UMA FK NA TABELA ESTOQUE QUE TEM COMO REFERENCIA A TABELA PRODUTOS:
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIA UMA FK NA TABELA PEDIDOS_ITENS QUE TEM COMO REFERENCIA A TABELA PRODUTOS:
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIA UMA FK NA TABELA PEDIDOS QUE TEM COMO REFERENCIA A TABELA LOJAS:
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIA UMA FK NA TABELA ENVIOS QUE TEM COMO REFERENCIA A TABELA LOJAS:
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIA UMA FK NA TABELA ESTOQUES QUE TEM COMO REFERENCIA A TABELA LOJAS:
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIA UMA CHAVE ESTRANGEIRA NA TABELA PEDIDOS QUE TEM COMO REFERENCIA A TABELA CLIENTES:
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIA UMA FK NA TABELA ENVIOS QUE TEM COMO REFERENCIA A TABELA CLIENTES:
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIA UMA FK NA TABELA PEDIDOS_ITENS QUE TEM COMO REFERENCIA A TABELA ENVIOS:
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIA UMA FK NA TABELA PEDIDOS_ITENS QUE TEM COMO REFERENCIA A TABELA PEDIDOS:
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
