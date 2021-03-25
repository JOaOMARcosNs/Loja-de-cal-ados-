-- João Marcos Neves da Silva
-- OBS: todas as datas do meu sistema usa a data atual, entao todas as vezes que roda o banco ele pegar as datas atuais
CREATE TABLE funcionario (
	idFuncionario serial NOT NULL PRIMARY KEY,
	nomeCompletoFuncionario VARCHAR ( 90 ),
	data_nacimento DATE,
	cpf VARCHAR ( 14 ),
	sexo VARCHAR ( 20 ),
	admicaoDataFuncionario DATE,
	numeroCarteiraTrabalhoFuncionario VARCHAR ( 14 ),
	funcao VARCHAR ( 50 ),
	salario NUMERIC ( 7, 2 ) 
);
CREATE TABLE enderecoFuncionario (
	idEndereco serial NOT NULL PRIMARY KEY,
	idfuncionario INT NOT NULL,
	cep VARCHAR ( 10 ),
	logradouro VARCHAR ( 100 ),
	numero INT,
	complemento VARCHAR ( 100 ),
	bairro VARCHAR ( 90 ),
	municipio VARCHAR ( 50 ),
	UF CHAR ( 2 ),
	FOREIGN KEY ( idfuncionario ) REFERENCES funcionario ( idfuncionario ) 
);
CREATE TABLE contatosFuncionario (
	idContatos serial NOT NULL PRIMARY KEY,
	idfuncionario INT NOT NULL,
	telefone VARCHAR ( 16 ),
	eMail VARCHAR ( 90 ),
	whatsapp VARCHAR ( 16 ),
	FOREIGN KEY ( idfuncionario ) REFERENCES funcionario ( idfuncionario ) 
);
-----------------------------------------
CREATE TABLE gerente (
	idGerente serial NOT NULL PRIMARY KEY,
	nomeCompletoGerente VARCHAR ( 90 ),
	dataNacimento DATE,
	cpf VARCHAR ( 14 ),
	sexo VARCHAR ( 20 ),
	admicaoDataGerente DATE,
	numeroCarteiraTrabalhoGerente VARCHAR ( 14 ),
	setor VARCHAR ( 100 ),
	salario NUMERIC ( 7, 2 ) 
);
CREATE TABLE enderecoGerente (
	idEndereco serial NOT NULL PRIMARY KEY,
	idGerente INT NOT NULL,
	cep VARCHAR ( 10 ),
	logradouro VARCHAR ( 100 ),
	numero INT,
	complemento VARCHAR ( 100 ),
	bairro VARCHAR ( 90 ),
	municipio VARCHAR ( 30 ),
	UF CHAR ( 2 ),
	FOREIGN KEY ( idGerente ) REFERENCES gerente ( idGerente ) 
);
CREATE TABLE contatosGerente (
	idContatos serial NOT NULL PRIMARY KEY,
	idGerente INT NOT NULL,
	telefone VARCHAR ( 16 ),
	eMail VARCHAR ( 100 ),
	whatsapp VARCHAR ( 16 ),
	FOREIGN KEY ( idGerente ) REFERENCES gerente ( idGerente ) 
);
---------------------------------------------------
CREATE TABLE clientePf (
	idClientePf serial NOT NULL PRIMARY KEY,
	nomeCompletoCliente VARCHAR ( 90 ),
	cpf VARCHAR ( 14 ),
	rg VARCHAR ( 12 ),
	sexo VARCHAR ( 20 ),
	data_nacimento DATE,
	dateDECadastro DATE 
);
CREATE TABLE enderecoClientePf (
	idEndereco serial NOT NULL PRIMARY KEY,
	idClientePf INT NOT NULL,
	cep VARCHAR ( 10 ),
	logradouro VARCHAR ( 100 ),
	numero INT,
	complemento VARCHAR ( 100 ),
	bairro VARCHAR ( 90 ),
	municipio VARCHAR ( 50 ),
	UF CHAR ( 2 ),
	FOREIGN KEY ( idClientePf ) REFERENCES clientePf ( idClientePf ) 
);
CREATE TABLE contatosClientePf (
	idContatos serial NOT NULL PRIMARY KEY,
	idClientePf INT NOT NULL,
	telefone VARCHAR ( 16 ),
	eMail VARCHAR ( 100 ),
	whatsapp VARCHAR ( 16 ),
	FOREIGN KEY ( idClientePf ) REFERENCES clientePf ( idClientePf ) 
);
-----------------------------------------------------------------
CREATE TABLE fornecedor (
	idFornecedor serial NOT NULL PRIMARY KEY,
	cnpj VARCHAR ( 20 ),
	razaoSocial VARCHAR ( 200 ),
	nomeFantasia VARCHAR ( 200 ),
	dataAbertura DATE,
	tipo VARCHAR ( 50 ),
	sitaucao VARCHAR ( 50 ),
	naturezaJuridica VARCHAR ( 255 ),
	capitalJuridico NUMERIC ( 30, 2 ) 
);
CREATE TABLE enderecoFornecedor (
	idEndereco serial NOT NULL PRIMARY KEY,
	idfornecedor INT,
	cep VARCHAR ( 10 ),
	logradouro VARCHAR ( 255 ),
	numero INT,
	complemento VARCHAR ( 255 ),
	bairro VARCHAR ( 255 ),
	municipio VARCHAR ( 50 ),
	UF CHAR ( 2 ),
	FOREIGN KEY ( idfornecedor ) REFERENCES fornecedor ( idfornecedor ) 
);
CREATE TABLE contatosFornecedor (
	idContatos serial NOT NULL PRIMARY KEY,
	idFornecedor INT,
	telefone VARCHAR ( 16 ),
	eMail VARCHAR ( 255 ),
	whatsapp VARCHAR ( 16 ),
	FOREIGN KEY ( idFornecedor ) REFERENCES fornecedor ( idFornecedor ) 
);
--------------------------------------------------------------------
CREATE TABLE compra (
	idCompra serial NOT NULL PRIMARY KEY,
	idFonecedor INT,
	idGerente INT,
	dataCompra DATE,
	valorTotalNota NUMERIC ( 10, 2 ) DEFAULT 0,
	FOREIGN KEY ( idFonecedor ) REFERENCES fornecedor ( idFornecedor ),
	FOREIGN KEY ( idGerente ) REFERENCES gerente ( idGerente ) 
);
CREATE TABLE tipo ( idTipo serial NOT NULL PRIMARY KEY, tipo VARCHAR ( 60 ) );
CREATE TABLE marca ( idMarca serial NOT NULL PRIMARY KEY, marca VARCHAR ( 60 ) );
CREATE TABLE genero ( idGenero serial NOT NULL PRIMARY KEY, Genero VARCHAR ( 60 ) );
CREATE TABLE calcados (
	idCalcados serial NOT NULL PRIMARY KEY,
	nomeCalcado VARCHAR ( 70 ),
	idTipo INT,
	idMarca INT,
	idGenero INT,
	corPredominante VARCHAR ( 20 ),
	numeracao INT DEFAULT 0,
	icms NUMERIC ( 7, 2 ) DEFAULT 0,
	ipi NUMERIC ( 7, 2 ) DEFAULT 0,
	frete NUMERIC ( 7, 2 ) DEFAULT 0,
	valorFabrica NUMERIC ( 7, 2 ) DEFAULT 0,
	valorDeCompra NUMERIC ( 7, 2 ) DEFAULT 0,
	valorVenda NUMERIC ( 7, 2 ) DEFAULT 0,
	quantidade INT DEFAULT 0,
	FOREIGN KEY ( idGenero ) REFERENCES genero ( idGenero ),
	FOREIGN KEY ( idTipo ) REFERENCES tipo ( idTipo ),
	FOREIGN KEY ( idMarca ) REFERENCES marca ( idMarca ) 
);
CREATE TABLE itensCompra (
	idItensCompra serial NOT NULL PRIMARY KEY,
	idCompra INT,
	idCalcados INT,
	numeracao INT DEFAULT 0,
	precoCompra NUMERIC ( 7, 2 ) DEFAULT 0,
	icms NUMERIC ( 7, 2 ) DEFAULT 0,
	ipi NUMERIC ( 7, 2 ) DEFAULT 0,
	frete NUMERIC ( 7, 2 ) DEFAULT 0,
	quantidade INT DEFAULT 0,
	FOREIGN KEY ( idCompra ) REFERENCES compra ( idCompra ),
	FOREIGN KEY ( idCalcados ) REFERENCES calcados ( idCalcados ) 
);
CREATE TABLE formapagamento ( idFormapagamento serial NOT NULL PRIMARY KEY, formapagamento VARCHAR ( 10 ) );
CREATE TABLE venda (
	idVenda serial NOT NULL PRIMARY KEY,
	idFuncionario INT,
	idClientePf INT,
	idFormapagamento INT,
	valorTotal NUMERIC ( 7, 2 ) DEFAULT 0,
	dataVenda DATE,
	valorVenda NUMERIC ( 7, 2 ) DEFAULT 0,
	numeroParcelas INT,
	status CHAR ( 2 ),
	lucro NUMERIC ( 7, 2 ) DEFAULT 0,
	quantidadeVenda INT DEFAULT 0,
	desconto NUMERIC ( 7, 2 ) DEFAULT 0,
	FOREIGN KEY ( idFormapagamento ) REFERENCES formapagamento ( idFormapagamento ),
	FOREIGN KEY ( idFuncionario ) REFERENCES funcionario ( idFuncionario ),
	FOREIGN KEY ( idClientePf ) REFERENCES clientePf ( idClientePf ) 
);
CREATE TABLE itensVenda (
	idItensVenda serial NOT NULL PRIMARY KEY,
	idVenda INT,
	idCalcados INT,
	quantidade INT,
	desconto NUMERIC ( 7, 2 ) DEFAULT 1,
	FOREIGN KEY ( idVenda ) REFERENCES venda ( idVenda ),
	FOREIGN KEY ( idCalcados ) REFERENCES calcados ( idCalcados ) 
);
CREATE TABLE parcelas (
	idParcelas serial NOT NULL PRIMARY KEY,
	idVenda INT,
	valorParcela NUMERIC ( 7, 2 ) DEFAULT 0,
	numeroParcelas INT DEFAULT 0,
	status CHAR ( 2 ),
	previsaoDepagamento DATE,
	dataPagamento DATE,
	FOREIGN KEY ( idVenda ) REFERENCES venda ( idVenda ) 
);
CREATE TABLE itensDevolucao (
	idItensDevolucao serial NOT NULL PRIMARY KEY,
	idItensVenda INT,
	idCalcados INT,
	motivo VARCHAR ( 200 ),
	quantidadeDevolucao INT,
	dataDevolucao DATE,
	FOREIGN KEY ( idItensVenda ) REFERENCES itensVenda ( idItensVenda ),
	FOREIGN KEY ( idCalcados ) REFERENCES calcados ( idCalcados ) 
);
------------------------------TRIGGER`S
------------------------------setarProduto------------------------------
CREATE 
	OR REPLACE FUNCTION setarProduto ( ) RETURNS TRIGGER AS $$ DECLARE
	gastosTotais NUMERIC ( 7, 2 ) := ( 0.4 );
BEGIN
		UPDATE calcados 
		SET numeracao = numeracao + NEW.numeracao,
		icms = icms + NEW.icms,
		ipi = ipi + NEW.ipi,
		frete = frete + NEW.frete,
		valorFabrica = valorFabrica + NEW.precoCompra,
		valorDeCompra = valorDeCompra + ( NEW.precoCompra * ( NEW.ipi + NEW.frete + NEW.icms ) ),
		quantidade = quantidade + NEW.quantidade,
		valorVenda = valorVenda + ( NEW.precoCompra * ( NEW.ipi + NEW.frete + NEW.icms ) ) + ( ( NEW.precoCompra * ( NEW.ipi + NEW.frete + NEW.icms + gastosTotais ) ) ) -- colocar despesas
		
	WHERE
		idCalcados = NEW.idCalcados;
	UPDATE compra 
	SET valorTotalNota = valorTotalNota + (
		NEW.quantidade * ( NEW.precoCompra + ( NEW.precoCompra * ( NEW.icms + NEW.ipi + NEW.frete ) ) ) 
	),
	dataCompra = now( ) 
	WHERE
		idCompra = NEW.idCompra;
	RETURN NULL;
	
END $$ LANGUAGE plpgsql;
CREATE TRIGGER setarProduto AFTER INSERT ON itensCompra FOR EACH ROW
EXECUTE PROCEDURE setarProduto ( );
------------------------------atualizarProduto------------------------------
CREATE 
	OR REPLACE FUNCTION atualizarProduto ( ) RETURNS TRIGGER AS $$ DECLARE
	gastosTotais NUMERIC ( 7, 2 ) := ( 0.4 );
BEGIN
		UPDATE calcados 
		SET icms = icms - ( OLD.icms - NEW.icms ),
		ipi = ipi - ( OLD.ipi - NEW.ipi ),
		frete = frete - ( OLD.frete - NEW.frete ),
		valorFabrica = valorFabrica - ( NEW.precoCompra - OLD.precoCompra ),
		valorDeCompra = valorDeCompra + ( NEW.precoCompra + ( NEW.precoCompra * ( NEW.icms + NEW.ipi + NEW.frete ) ) ) - ( OLD.precoCompra + ( OLD.precoCompra * ( OLD.icms + OLD.ipi + OLD.frete ) ) ),
		quantidade = quantidade - ( OLD.quantidade - NEW.quantidade ),
		valorVenda = valorVenda + ( NEW.precoCompra + ( NEW.precoCompra * ( NEW.ipi + NEW.icms + NEW.frete + gastosTotais ) ) ) - ( OLD.precoCompra + ( OLD.precoCompra * ( OLD.ipi + OLD.icms + OLD.frete + gastosTotais ) ) ) 
	WHERE
		idCalcados = NEW.idCalcados;
	UPDATE compra 
	SET valorTotalNota = valorTotalNota - (
		NEW.quantidade * ( NEW.precoCompra + ( NEW.precoCompra * ( NEW.icms + NEW.ipi + NEW.frete ) ) ) 
		) - (
		OLD.quantidade * ( OLD.precoCompra + ( OLD.precoCompra * ( OLD.icms + OLD.ipi + OLD.frete ) ) ) 
	) 
	WHERE
		idCompra = NEW.idCompra;
	RETURN NULL;
	
END $$ LANGUAGE plpgsql;
CREATE TRIGGER atualizarProduto AFTER UPDATE ON itensCompra FOR EACH ROW
EXECUTE PROCEDURE atualizarProduto ( );
------------------------------deletarItensCompra------------------------------
CREATE 
	OR REPLACE FUNCTION deletarItensCompra ( ) RETURNS TRIGGER AS $$ BEGIN
		UPDATE calcados 
		SET quantidade = quantidade - OLD.quantidade 
	WHERE
		idCalcados = OLD.idCalcados;
	UPDATE compra 
	SET valorTotalNota = valorTotalNota - (
		OLD.quantidade * ( OLD.precoCompra + ( OLD.precoCompra * ( OLD.icms + OLD.ipi + OLD.frete ) ) ) 
	) 
	WHERE
		idCompra = OLD.idcompra;
	RETURN NULL;
	
END $$ LANGUAGE plpgsql;
CREATE TRIGGER deletarItensCompra AFTER DELETE ON itensCompra FOR EACH ROW
EXECUTE PROCEDURE deletarItensCompra ( );
------------------------------InserVendas------------------------------
CREATE 
	OR REPLACE FUNCTION setVenda ( ) RETURNS TRIGGER AS $$ DECLARE
	quantidadeCalcados INT;
DECLARE
	valorVendaCalcados NUMERIC ( 7, 2 );
DECLARE
	valorCompraCalcados NUMERIC ( 7, 2 );
BEGIN
		quantidadeCalcados := ( SELECT quantidade FROM calcados WHERE idcalcados = NEW.idcalcados );
	valorVendaCalcados := ( SELECT valorvenda FROM calcados WHERE idcalcados = NEW.idcalcados );
	valorCompraCalcados := ( SELECT valordecompra FROM calcados WHERE idcalcados = NEW.idcalcados );
	IF
		( quantidadeCalcados >= NEW.quantidade AND NEW.quantidade > 0 ) THEN
			UPDATE calcados 
			SET quantidade = quantidade - NEW.quantidade 
		WHERE
			idCalcados = NEW.idCalcados;
		UPDATE venda 
		SET desconto = desconto + NEW.desconto,
		quantidadeVenda = quantidadeVenda + NEW.quantidade,
		valorvenda = valorvenda + valorVendaCalcados,
		valortotal = valortotal + ( ( ( NEW.quantidade * valorVendaCalcados ) * NEW.desconto ) ),
		lucro = lucro + ( ( NEW.quantidade * ( valorVendaCalcados - valorCompraCalcados ) ) * NEW.desconto ),
		datavenda = now( ) 
		WHERE
			idVenda = NEW.idVenda;
		RETURN NULL;
		
	END IF;
	
END $$ LANGUAGE plpgsql;
CREATE TRIGGER setVenda AFTER INSERT ON itensvenda FOR EACH ROW
EXECUTE PROCEDURE setVenda ( );
------------------------------UpdateVendas------------------------------
CREATE 
	OR REPLACE FUNCTION updateVenda ( ) RETURNS TRIGGER AS $$ DECLARE
	quantidadeCalcados INT;
DECLARE
	valorVendaCalcados NUMERIC ( 7, 2 );
DECLARE
	valorCompraCalcados NUMERIC ( 7, 2 );
BEGIN
		quantidadeCalcados := ( SELECT quantidade FROM calcados WHERE idcalcados = NEW.idcalcados );
	valorVendaCalcados := ( SELECT valorvenda FROM calcados WHERE idcalcados = NEW.idcalcados );
	valorCompraCalcados := ( SELECT valordecompra FROM calcados WHERE idcalcados = NEW.idcalcados );
	IF
		( quantidadeCalcados >= NEW.quantidade AND NEW.quantidade > 0 ) THEN
			UPDATE calcados 
			SET quantidade = quantidade - ( NEW.quantidade - OLD.quantidade ) 
		WHERE
			idCalcados = NEW.idCalcados;
		UPDATE venda 
		SET desconto = desconto + ( NEW.desconto - OLD.desconto ),
		quantidadeVenda = quantidadeVenda + ( NEW.quantidade - OLD.quantidade ),
		valortotal = valortotal + (
			( ( ( NEW.quantidade * valorVendaCalcados ) * NEW.desconto ) ) - ( ( ( OLD.quantidade * valorVendaCalcados ) * OLD.desconto ) ) 
		),
		lucro = lucro + (
			( ( ( NEW.quantidade * ( valorVendaCalcados - valorCompraCalcados ) ) * NEW.desconto ) ) - ( ( ( OLD.quantidade * ( valorVendaCalcados - valorCompraCalcados ) ) * OLD.desconto ) ) 
		) 
		WHERE
			idVenda = NEW.idVenda;
		RETURN NULL;
		
	END IF;
	
END $$ LANGUAGE plpgsql;
CREATE TRIGGER updateVenda AFTER UPDATE ON itensvenda FOR EACH ROW
EXECUTE PROCEDURE updateVenda ( );
------------------------------deleteVenda------------------------------
CREATE 
	OR REPLACE FUNCTION deleteVenda ( ) RETURNS TRIGGER AS $$ DECLARE
	quantidadeCalcados INT;
DECLARE
	valorVendaCalcados NUMERIC ( 7, 2 );
DECLARE
	valorCompraCalcados NUMERIC ( 7, 2 );
BEGIN
		quantidadeCalcados := ( SELECT quantidade FROM calcados WHERE idcalcados = OLD.idcalcados );
	valorVendaCalcados := ( SELECT valorvenda FROM calcados WHERE idcalcados = OLD.idcalcados );
	valorCompraCalcados := ( SELECT valordecompra FROM calcados WHERE idcalcados = OLD.idcalcados );
	UPDATE calcados 
	SET quantidade = quantidade + OLD.quantidade 
	WHERE
		idCalcados = OLD.idCalcados;
	UPDATE venda 
	SET desconto = desconto - OLD.desconto,
	quantidadeVenda = quantidadeVenda - OLD.quantidade,
	valortotal = valortotal - ( ( ( OLD.quantidade * valorVendaCalcados ) * OLD.desconto ) ),
	lucro = lucro - ( ( OLD.quantidade * ( valorVendaCalcados - valorCompraCalcados ) ) * OLD.desconto ) 
	WHERE
		idVenda = OLD.idVenda;
	RETURN NULL;
	
END $$ LANGUAGE plpgsql;
CREATE TRIGGER deleteVenda AFTER DELETE ON itensvenda FOR EACH ROW
EXECUTE PROCEDURE deleteVenda ( );
---------------------------setDevolucao---------------------------------
CREATE 
	OR REPLACE FUNCTION setDevolucao ( ) RETURNS TRIGGER AS $$ DECLARE
	valorVendaCalcados NUMERIC ( 7, 2 );
DECLARE
	quantidadeItemvendas INT;
BEGIN
		quantidadeItemvendas := ( SELECT quantidade FROM itensvenda WHERE iditensvenda = 1 );
	valorVendaCalcados := ( SELECT valorvenda FROM calcados WHERE idcalcados = NEW.idcalcados );
	UPDATE itensvenda 
	SET quantidade = quantidade - NEW.quantidadeDevolucao 
	WHERE
		iditensvenda = NEW.iditensvenda;
	RETURN NULL;
	
END $$ LANGUAGE plpgsql;
CREATE TRIGGER setDevolucao AFTER INSERT ON itensDevolucao FOR EACH ROW
EXECUTE PROCEDURE setDevolucao ( );
---------------------------setParcelas---------------------------------
CREATE 
	OR REPLACE FUNCTION setParcelas ( ) RETURNS TRIGGER AS $$ DECLARE
	dataParcela INT := 30;
DECLARE
	valortotalVenda NUMERIC ( 7, 2 );
DECLARE
	parcela INT := 1;
DECLARE
	numeroDaParcela INT;
BEGIN
		valortotalVenda := ( SELECT valortotal FROM venda WHERE idvenda = NEW.idvenda );
	numeroDaParcela := ( SELECT numeroparcelas FROM venda WHERE idvenda = NEW.idvenda );
	while
	parcela <= numeroDaParcela
	loop
	INSERT INTO parcelas ( idVenda, numeroparcelas, valorparcela, previsaoDepagamento, status )
	VALUES
		( NEW.idvenda, parcela, ( valortotalVenda / numeroDaParcela ), ( CURRENT_DATE + dataParcela ), 'NP' );
	parcela := parcela + 1;
	dataParcela := dataParcela + 30;
	
END loop;
RETURN NULL;

END $$ LANGUAGE plpgsql;
CREATE TRIGGER setParcelas AFTER INSERT ON venda FOR EACH ROW
EXECUTE PROCEDURE setParcelas ( );
---------------------------updateParcela---------------------------------
CREATE 
	OR REPLACE FUNCTION updateParcela ( ) RETURNS TRIGGER AS $$ DECLARE
	dataParcela INT := 30;
DECLARE
	valortotalVenda NUMERIC ( 7, 2 );
DECLARE
	parcela INT := 1;
DECLARE
	numeroDaParcela INT;
BEGIN
	DELETE 
	FROM
		parcelas 
	WHERE
		idvenda = OLD.idvenda;
	valortotalVenda := ( SELECT valortotal FROM venda WHERE idvenda = NEW.idvenda );
	numeroDaParcela := ( SELECT numeroparcelas FROM venda WHERE idvenda = NEW.idvenda );
	while
	parcela <= numeroDaParcela
	loop
	INSERT INTO parcelas ( idVenda, numeroparcelas, valorparcela, previsaoDepagamento, status )
	VALUES
		( NEW.idvenda, parcela, ( valortotalVenda / numeroDaParcela ), ( CURRENT_DATE + dataParcela ), 'NP' );
	parcela := parcela + 1;
	dataParcela := dataParcela + 30;
	
END loop;
RETURN NULL;

END $$ LANGUAGE plpgsql;
CREATE TRIGGER updateParcela AFTER UPDATE ON venda FOR EACH ROW
EXECUTE PROCEDURE updateParcela ( );
--------------------------DeleteParcela----------------------------------
CREATE 
	OR REPLACE FUNCTION DeleteParcela ( ) RETURNS TRIGGER AS $$ DECLARE
	statusVenda VARCHAR ( 2 );
BEGIN
		statusVenda := ( SELECT status FROM venda WHERE idvenda = NEW.idVenda );
	IF
		( statusVenda <> 'NP' ) THEN
		DELETE 
		FROM
			parcelas 
		WHERE
			idvenda = OLD.idvenda;
		
	END IF;
	RETURN NULL;
	
END $$ LANGUAGE plpgsql;
CREATE TRIGGER DeleteParcela AFTER DELETE ON venda FOR EACH ROW
EXECUTE PROCEDURE DeleteParcela ( );
-----------------------------------FUNCTION
---------------------------------prodmaisvendcategoria---------------------------
CREATE 
	OR REPLACE FUNCTION prodmaisvendcategoria ( INT, DATE ) RETURNS TABLE ( tipo VARCHAR, nomecalcado VARCHAR, datas DATE ) AS $$ BEGIN
		RETURN QUERY SELECT
		tipo.tipo,
		calcados.nomecalcado,
		venda.datavenda 
	FROM
		venda,
		itensvenda,
		calcados,
		tipo 
	WHERE
		tipo.idtipo = calcados.idtipo 
		AND venda.idvenda = itensvenda.idvenda 
		AND tipo.idtipo = $1 
		AND venda.datavenda = $2 
	GROUP BY
		venda.datavenda,
		tipo.idtipo,
		calcados.nomecalcado;
	
END $$ LANGUAGE plpgsql;
-------------------------------selecionaclientes---------------------------
CREATE 
	OR REPLACE FUNCTION selecionaclientes ( ) RETURNS TABLE ( nome VARCHAR, valor NUMERIC ( 7, 0 ) ) AS $$ BEGIN
		RETURN query SELECT
		clientepf.nomecompletocliente,
		venda.valortotal 
	FROM
		clientepf,
		venda 
	WHERE
		clientepf.idclientepf = venda.idclientepf 
	GROUP BY
		clientepf.nomecompletocliente,
		venda.valortotal;
	
END $$ LANGUAGE plpgsql;
---------------------------------selecionaclientes---------------------------
CREATE 
	OR REPLACE FUNCTION MelhoresClientes ( NUMERIC ( 15, 2 ) ) RETURNS SETOF clientepf AS $$ BEGIN
		RETURN query SELECT
		* 
	FROM
		clientepf 
	WHERE
		idclientepf IN (
		SELECT
			clientepf.idclientepf 
		FROM
			clientepf
			INNER JOIN venda ON venda.idclientepf = clientepf.idclientepf
			INNER JOIN itensvenda ON itensvenda.idvenda = venda.idvenda 
		GROUP BY
			clientepf.idclientepf 
		HAVING
			SUM ( venda.valortotal ) >= $1 
		);
	
END $$ LANGUAGE plpgsql;
---------------------------------maiorLucroProduto---------------------------
CREATE 
	OR REPLACE FUNCTION produtosMaisLucrativos ( CHAR ( 2 ), NUMERIC ( 7, 2 ) ) RETURNS TABLE ( nomecalcado VARCHAR, lucro NUMERIC ( 7, 2 ), datavenda DATE ) AS $$ BEGIN
		RETURN query SELECT
		calcados.nomecalcado,
		venda.lucro,
		venda.datavenda 
	FROM
		calcados,
		venda,
		itensvenda 
	WHERE
		calcados.idcalcados = itensvenda.idvenda 
		AND itensvenda.idvenda = venda.idvenda 
		AND to_char( venda.datavenda, 'MM' ) = $1 
		AND venda.lucro > $2 
	GROUP BY
		calcados.nomecalcado,
		venda.lucro,
		venda.datavenda;
	
END $$ LANGUAGE plpgsql;
-----------------------------------maiorLucroCalcadosDatadeinicio---------------------------------------------------
CREATE 
	OR REPLACE FUNCTION maiorLucroCalcadosDatadeinicio ( INT, DATE, DATE ) RETURNS TABLE ( nomeTipo VARCHAR, nomecalcados VARCHAR, datainicio DATE, datafinal DATE ) AS $$ BEGIN
		RETURN QUERY SELECT
		tipo.tipo,
		calcados.nomecalcado,
		venda.datavenda,
		compra.datacompra 
	FROM
		venda,
		compra,
		itensvenda,
		itenscompra,
		calcados,
		tipo 
	WHERE
		tipo.idtipo = calcados.idtipo 
		AND compra.idcompra = itenscompra.idcompra 
		AND venda.idvenda = itensvenda.idvenda 
		AND tipo.idtipo = $1 
		AND venda.datavenda = $2 
		AND compra.datacompra = $3 
	GROUP BY
		compra.datacompra,
		venda.datavenda,
		tipo.idtipo,
		calcados.nomecalcado;
	
END $$ LANGUAGE plpgsql;
---------------------------------maiorLucroProduto---------------------------
CREATE 
	OR REPLACE FUNCTION vendasMaisLucroDoMes ( CHAR ( 2 ), NUMERIC ( 7, 2 ) ) RETURNS TABLE ( idvendas INT, lucros NUMERIC ( 7, 2 ), datavendas DATE ) AS $$ BEGIN
		RETURN query SELECT
		idvenda,
		lucro,
		datavenda 
	FROM
		venda 
	WHERE
		to_char( datavenda, 'MM' ) = $1 
		AND lucro > $2 
	ORDER BY
		lucro DESC;
	
END $$ LANGUAGE plpgsql;
---------------------------------CLIPARVENCER---------------------------
CREATE 
	OR REPLACE FUNCTION CLIPARVENCER ( DATE ) RETURNS TABLE ( nomecliente VARCHAR, datavencimento DATE, numerodaparcela INT ) AS $$ BEGIN
		RETURN QUERY SELECT
		clientepf.nomecompletocliente,
		parcelas.previsaodepagamento,
		parcelas.numeroparcelas 
	FROM
		clientepf,
		parcelas,
		venda 
	WHERE
		clientepf.idclientepf = venda.idclientepf 
		AND venda.idvenda = parcelas.idvenda 
		AND parcelas.previsaodepagamento = $1 
	GROUP BY
		clientepf.nomecompletocliente,
		parcelas.previsaodepagamento,
		parcelas.numeroparcelas;
	
END $$ LANGUAGE plpgsql;
---------------------------------compora Por mes---------------------------
CREATE 
	OR REPLACE FUNCTION compraPorMes ( CHAR ( 2 ) ) RETURNS TABLE ( iddacompra INT, nomefantasias VARCHAR, nomedogerente VARCHAR, valortotaldacompra NUMERIC, datadacompra DATE ) AS $$ BEGIN
		RETURN QUERY SELECT
		compra.idcompra,
		fornecedor.nomefantasia,
		gerente.nomecompletogerente,
		compra.valortotalnota,
		compra.datacompra 
	FROM
		compra,
		fornecedor,
		gerente 
	WHERE
		fornecedor.idfornecedor = compra.idfonecedor 
		AND gerente.idgerente = compra.idgerente 
		AND to_char( compra.datacompra, 'MM' ) = $1 
	GROUP BY
		compra.idcompra,
		fornecedor.nomefantasia,
		gerente.nomecompletogerente,
		compra.valortotalnota,
		compra.datacompra;
	
END $$ LANGUAGE plpgsql;
---------------------------------compraPorMesPorValor---------------------------
CREATE 
	OR REPLACE FUNCTION compraPorMesPorValor ( CHAR ( 2 ), NUMERIC ) RETURNS TABLE ( iddacompra INT, nomefantasias VARCHAR, nomedogerente VARCHAR, valortotaldacompra NUMERIC, datadacompra DATE ) AS $$ BEGIN
		RETURN QUERY SELECT
		compra.idcompra,
		fornecedor.nomefantasia,
		gerente.nomecompletogerente,
		compra.valortotalnota,
		compra.datacompra 
	FROM
		compra,
		fornecedor,
		gerente 
	WHERE
		fornecedor.idfornecedor = compra.idfonecedor 
		AND gerente.idgerente = compra.idgerente 
		AND to_char( compra.datacompra, 'MM' ) = $1 
		AND compra.valortotalnota >= $2 
	GROUP BY
		compra.idcompra,
		fornecedor.nomefantasia,
		gerente.nomecompletogerente,
		compra.valortotalnota,
		compra.datacompra;
	
END $$ LANGUAGE plpgsql;
---------------------------------compraPorMesPorValor---------------------------
CREATE 
	OR REPLACE FUNCTION aumentarValorDeVenda ( NUMERIC ( 7, 2 ), INT ) RETURNS TABLE ( valordavenda NUMERIC ) AS $$ BEGIN
		UPDATE calcados 
		SET valorvenda = valorvenda + ( valorvenda * $1 ) 
	WHERE
		idcalcados = $2;
	RETURN QUERY SELECT
	valorvenda 
	FROM
		calcados 
	WHERE
		idcalcados = $2;
	
END $$ LANGUAGE plpgsql;
---------------------------------MostrarTotalVendadoMes---------------------------
CREATE 
	OR REPLACE FUNCTION MostrarTotalVendadoMes ( CHAR ( 2 ) ) RETURNS TABLE ( valortotalVenda NUMERIC, datadavenda DATE ) AS $$ BEGIN
		RETURN QUERY SELECT SUM
		( valortotal ),
		datavenda 
	FROM
		venda 
	WHERE
		to_char( datavenda, 'MM' ) = $1 
	GROUP BY
		datavenda;
	
END $$ LANGUAGE plpgsql;
---------------------------------aumentarValorDeVendaPorTipo---------------------------
CREATE 
	OR REPLACE FUNCTION aumentarValorDeVendaPorTipo ( NUMERIC ( 7, 2 ), INT ) RETURNS TABLE ( nomedocalcado VARCHAR, valordavenda NUMERIC, nometipo VARCHAR ) AS $$ BEGIN
		UPDATE calcados 
		SET valorvenda = valorvenda + ( valorvenda * $1 ) 
	WHERE
		idtipo = $2;
	RETURN QUERY SELECT
	calcados.nomecalcado,
	calcados.valorvenda,
	tipo.tipo 
	FROM
		calcados,
		tipo 
	WHERE
		tipo.idtipo = calcados.idtipo 
		AND tipo.idtipo = $2;
	
END $$ LANGUAGE plpgsql;
--------------------------------------calcadosAbaixoDoEstoque----------------------------
CREATE 
	OR REPLACE FUNCTION calcadosAbaixoDoEstoque ( INT ) RETURNS TABLE ( nomedocaldado VARCHAR, tipodocalcado VARCHAR, marcadocalcado VARCHAR, valordevendacalcado NUMERIC, quantidadedocaldado INT ) AS $$ BEGIN
		RETURN QUERY SELECT
		calcados.nomecalcado,
		tipo.tipo,
		marca.marca,
		calcados.valorvenda,
		calcados.quantidade 
	FROM
		calcados,
		tipo,
		marca 
	WHERE
		tipo.idtipo = calcados.idtipo 
		AND marca.idmarca = calcados.idmarca 
		AND calcados.quantidade < $1;
	
END $$ LANGUAGE plpgsql;
---------------------------------------------------gerentes-------------------------------------------------------------------------------
INSERT INTO gerente ( nomeCompletoGerente, dataNacimento, cpf, sexo, admicaoDataGerente, numeroCarteiraTrabalhoGerente, setor, salario )
VALUES
	( 'João Marcos', '2000/12/23', '00000-00', 'Masculino', '2010/12/23', '00000000-Y', 'Vendas', 2000 );
INSERT INTO gerente ( nomeCompletoGerente, dataNacimento, cpf, sexo, admicaoDataGerente, numeroCarteiraTrabalhoGerente, setor, salario )
VALUES
	( 'Isabella', '2001/10/20', '00000-11', 'Feminina', '2011/12/23', '0000000Y-Y', 'Estoque', 1900 );
INSERT INTO gerente ( nomeCompletoGerente, dataNacimento, cpf, sexo, admicaoDataGerente, numeroCarteiraTrabalhoGerente, setor, salario )
VALUES
	( 'Isabela', '2000/07/20', '00000-22', 'Feminina', '2009/01/10', '000000YY-Y', 'Estoque', 1950 );
INSERT INTO gerente ( nomeCompletoGerente, dataNacimento, cpf, sexo, admicaoDataGerente, numeroCarteiraTrabalhoGerente, setor, salario )
VALUES
	( 'Zeca', '2000/07/20', '00000-22', 'Feminina', '2009/01/10', '000000YY-Y', 'Estoque', 1950 );
INSERT INTO gerente ( nomeCompletoGerente, dataNacimento, cpf, sexo, admicaoDataGerente, numeroCarteiraTrabalhoGerente, setor, salario )
VALUES
	( 'Ana', '2000/07/20', '00000-22', 'Feminina', '2009/01/10', '000000YY-Y', 'Estoque', 1950 );
INSERT INTO gerente ( nomeCompletoGerente, dataNacimento, cpf, sexo, admicaoDataGerente, numeroCarteiraTrabalhoGerente, setor, salario )
VALUES
	( 'Pedro', '2000/07/20', '00000-22', 'Feminina', '2009/01/10', '000000YY-Y', 'Estoque', 1950 );
INSERT INTO gerente ( nomeCompletoGerente, dataNacimento, cpf, sexo, admicaoDataGerente, numeroCarteiraTrabalhoGerente, setor, salario )
VALUES
	( 'Alberto', '2000/07/20', '00000-22', 'Feminina', '2009/01/10', '000000YY-Y', 'Estoque', 1950 );
INSERT INTO gerente ( nomeCompletoGerente, dataNacimento, cpf, sexo, admicaoDataGerente, numeroCarteiraTrabalhoGerente, setor, salario )
VALUES
	( 'douglas', '2000/07/20', '00000-22', 'Feminina', '2009/01/10', '000000YY-Y', 'Estoque', 1950 );
---------------------------------------------------enderecogerente-------------------------------------------------------------------------------
INSERT INTO enderecoGerente ( idgerente, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 3, '46.490-000', 'AV A', 585, 'Andar 1', 'Praca do feijao', 'Guanambi', 'BA' );
INSERT INTO enderecoGerente ( idgerente, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 1, '46.490-000', 'AV X', 58, 'Casa', 'centro', 'Guanambi', 'BA' );
INSERT INTO enderecoGerente ( idgerente, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 2, '46.490-000', 'AV Y', 55, 'Casa', 'Alto caisara', 'Guanambi', 'BA' );
INSERT INTO enderecoGerente ( idgerente, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 4, '46.490-000', 'AV Y', 55, 'Casa', 'Alto caisara', 'Guanambi', 'BA' );
INSERT INTO enderecoGerente ( idgerente, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 5, '46.490-000', 'AV Y', 55, 'Casa', 'Alto caisara', 'Guanambi', 'BA' );
INSERT INTO enderecoGerente ( idgerente, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 6, '46.490-000', 'AV Y', 55, 'Casa', 'X', 'V', 'BA' );
INSERT INTO enderecoGerente ( idgerente, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 7, '46.490-000', 'AV Y', 55, 'Casa', 'A', 'Q', 'BA' );
INSERT INTO enderecoGerente ( idgerente, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 8, '46.490-000', 'AV Y', 55, 'Casa', 'C', 'W', 'BA' );
---------------------------------------------------contatosgerente-------------------------------------------------------------------------------
INSERT INTO contatosGerente ( idgerente, telefone, eMail, whatsapp )
VALUES
	( 1, '(77)99111-2967', 'C.@email.com', '(77) 99111-2967' );
INSERT INTO contatosGerente ( idgerente, telefone, eMail, whatsapp )
VALUES
	( 2, '(77) 99101-6453', 'D.@email.com', 'não tem' );
INSERT INTO contatosGerente ( idgerente, telefone, eMail, whatsapp )
VALUES
	( 3, '(77) 99196-6424', 'A.@email.com', '(77) 99196-6424' );
INSERT INTO contatosGerente ( idgerente, telefone, eMail, whatsapp )
VALUES
	( 4, '(77) 9900-6424', 'A.@email.com', '(77) 99196-6424' );
INSERT INTO contatosGerente ( idgerente, telefone, eMail, whatsapp )
VALUES
	( 5, '(77) 99106-6424', 'A.@email.com', '(77) 99196-6424' );
INSERT INTO contatosGerente ( idgerente, telefone, eMail, whatsapp )
VALUES
	( 6, '(77) 99100-6404', 'A.@email.com', '(77) 99196-6424' );
INSERT INTO contatosGerente ( idgerente, telefone, eMail, whatsapp )
VALUES
	( 7, '(77) 99096-6024', 'A.@email.com', '(77) 99196-6424' );
INSERT INTO contatosGerente ( idgerente, telefone, eMail, whatsapp )
VALUES
	( 8, '(77) 99296-6420', 'A.@email.com', '(77) 99196-6424' );
-------------------------------------------------fornecedor-------------------------------------------
INSERT INTO fornecedor ( cnpj, razaoSocial, nomeFantasia, dataAbertura, tipo, sitaucao, naturezaJuridica, capitalJuridico )
VALUES
	( '05.406.034/0001-02', 'Puma Sports LTDA', 'Puma', '2002-10-30', 'MATRIZ', 'ATIVA', '206-2 - Sociedade Empresária Limitada', 162557900.00 );
INSERT INTO fornecedor ( cnpj, razaoSocial, nomeFantasia, dataAbertura, tipo, sitaucao, naturezaJuridica, capitalJuridico )
VALUES
	( '59.546.515/0002-15', 'Nike do Brasil Comercio e Participacoes LTDA', 'Nike', '1997-01-16', 'FILIAL', 'ATIVA', '206-2 - Sociedade Empresária Limitada', 0.00 );
INSERT INTO fornecedor ( cnpj, razaoSocial, nomeFantasia, dataAbertura, tipo, sitaucao, naturezaJuridica, capitalJuridico )
VALUES
	( '42.274.696/0001-94', 'Adidas do Brasil LTDA', 'Adidas', '1973-08-24', 'MATRIZ', 'ATIVA', '206-2 - Sociedade Empresária Limitada', 448142448.00 );
---------------------------------------------------enderecofornecedor-------------------------------------------------------------------------------
INSERT INTO enderecofornecedor ( idfornecedor, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 3, '06.454-000', 'AL Rio Negro', 585, 'Andar 8 Conj 81 e 82 Andar 9 Conj 91 Andar 10 Conj 101 e 102-parte', 'Alphaville Centro Industrial e Empresarial/alphavi', 'Barueri', 'SP' );
INSERT INTO enderecofornecedor ( idfornecedor, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 1, '05.319-000', 'AV Queiroz Filho', 1700, 'Andar 6 Edif VL Lobos Office Park', 'Vila Hamburguesa', 'Sao Paulo', 'SP' );
INSERT INTO enderecofornecedor ( idfornecedor, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 2, '22.783-000', 'AV Luiz Carlos Prestes', 350, 'Sl. 319', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ' );
---------------------------------------------------contatosfornecedor-------------------------------------------------------------------------------
INSERT INTO contatosFornecedor ( idFornecedor, telefone, eMail, whatsapp )
VALUES
	( 1, '(11) 4862-2967', 'fiscal.brasil@puma.com', 'não tem' );
INSERT INTO contatosFornecedor ( idFornecedor, telefone, eMail, whatsapp )
VALUES
	( 2, '(11) 2739-6453', 'bra.saopaulo.fiscal@nike.com', 'não tem' );
INSERT INTO contatosFornecedor ( idFornecedor, telefone, eMail, whatsapp )
VALUES
	( 3, '(11) 2196-6424', 'AMANDA.LUZ@ADIDAS-GROUP.COM', 'não tem' );
-------------------------------------------------compra-------------------------------------------
INSERT INTO compra ( idFonecedor, idGerente, dataCompra )
VALUES
	( 3, 1, '2021-01-01' );
INSERT INTO compra ( idFonecedor, idGerente, dataCompra )
VALUES
	( 2, 2, '2021-01-01' );
INSERT INTO compra ( idFonecedor, idGerente, dataCompra )
VALUES
	( 1, 3, '2021-01-01' );
INSERT INTO compra ( idFonecedor, idGerente, dataCompra )
VALUES
	( 3, 4, '2021-01-01' );
INSERT INTO compra ( idFonecedor, idGerente, dataCompra )
VALUES
	( 2, 5, '2021-01-01' );
INSERT INTO compra ( idFonecedor, idGerente, dataCompra )
VALUES
	( 1, 6, '2021-01-01' );
INSERT INTO compra ( idFonecedor, idGerente, dataCompra )
VALUES
	( 2, 7, '2021-01-01' );
INSERT INTO compra ( idFonecedor, idGerente, dataCompra )
VALUES
	( 1, 8, '2021-01-01' );
-------------------------------------------------Genero-------------------------------------------
INSERT INTO genero ( Genero )
VALUES
	( 'Masculino' );
INSERT INTO genero ( Genero )
VALUES
	( 'Feminino' );
INSERT INTO genero ( Genero )
VALUES
	( 'Infantil' );
INSERT INTO genero ( Genero )
VALUES
	( 'Unisex' );
-------------------------------------------------Marca-------------------------------------------
INSERT INTO marca ( marca )
VALUES
	( 'Nike' );
INSERT INTO marca ( marca )
VALUES
	( 'Adidas' );
INSERT INTO marca ( marca )
VALUES
	( 'Puma' );
-------------------------------------------------tipo-------------------------------------------
INSERT INTO tipo ( tipo )
VALUES
	( 'Botas' );
INSERT INTO tipo ( tipo )
VALUES
	( 'Tênis' );
INSERT INTO tipo ( tipo )
VALUES
	( 'Chinelo' );
-------------------------------------------------calcados-------------------------------------------
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Jordan', 2, 1, 1, 'Preto' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Carina Bdp', 1, 2, 2, 'Azul' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Runfalcon', 3, 2, 3, 'Vermelho' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Air', 2, 1, 1, 'Preto' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Bdp', 1, 2, 2, 'Azul' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'A', 3, 2, 3, 'Vermelho' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Sb', 2, 1, 1, 'Cinza' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Catr', 1, 2, 2, 'Verde' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Runfalconnas', 3, 2, 3, 'azul' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Air Max', 2, 1, 1, 'Preto' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Pico', 2, 1, 1, 'Preto' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Lunar', 2, 1, 1, 'Preto' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Free', 2, 1, 1, 'Preto' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'BMW Motorsport Future Cat Ultra ', 3, 3, 3, 'Vermelho' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Hybrid Rocket Runner ', 3, 3, 3, 'Vermelho' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( ' Smash V2', 3, 3, 3, 'Vermelho' );
INSERT INTO calcados ( nomeCalcado, idTipo, idMarca, idGenero, corPredominante )
VALUES
	( 'Disc Cell Aether', 3, 3, 3, 'Vermelho' );
-------------------------------------------------itensCompra-------------------------------------------
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 1, 1, 40, 2, 0.10, 0.10, 10, 40 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 3, 3, 39, 120, 0.20, 0.30, 10, 50 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 2, 2, 42, 150, 0.30, 0.20, 15, 100 );
-----------
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 3, 4, 40, 2, 0.10, 0.10, 10, 40 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 4, 8, 39, 120, 0.20, 0.30, 10, 50 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 5, 6, 42, 150, 0.30, 0.20, 15, 100 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 6, 7, 40, 2, 0.10, 0.10, 10, 40 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 8, 39, 120, 0.20, 0.30, 10, 50 );
----
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 10, 39, 120, 0.20, 0.30, 10, 200 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 11, 39, 120, 0.20, 0.30, 10, 200 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 12, 39, 120, 0.20, 0.30, 10, 1000 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 13, 39, 120, 0.20, 0.30, 10, 1000 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 5, 43, 230, 0.40, 0.20, 30, 1000 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 9, 43, 230, 0.40, 0.20, 30, 1000 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 14, 43, 230, 0.40, 0.20, 30, 30 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 15, 43, 100, 0.40, 0.20, 30, 30 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 16, 43, 100, 0.20, 0.10, 30, 30 );
INSERT INTO itensCompra ( idCompra, idCalcados, numeracao, precoCompra, icms, ipi, frete, quantidade )
VALUES
	( 7, 16, 43, 100, 0.40, 0.20, 30, 30 );
-------------------------------------------------clientePf-------------------------------------------
INSERT INTO clientePf ( nomeCompletoCliente, cpf, rg, sexo, data_nacimento, dateDECadastro )
VALUES
	( 'João Marcos', '000.000.00-00', '000.000-00', 'Masculino', '2000-12-23', '2020-10-02' );
INSERT INTO clientePf ( nomeCompletoCliente, cpf, rg, sexo, data_nacimento, dateDECadastro )
VALUES
	( 'XXXXXX', '000.000.00-11', '000.000-11', 'Masculino', '2001-11-20', '2020-01-02' );
INSERT INTO clientePf ( nomeCompletoCliente, cpf, rg, sexo, data_nacimento, dateDECadastro )
VALUES
	( 'YYYYYY', '000.000.00-22', '000.000-22', 'Masculino', '2002-02-12', '2020-01-01' );
---------------------------------------------------enderecogerente-------------------------------------------------------------------------------
INSERT INTO enderecoClientePf ( idClientePf, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 3, '46.490-000', 'AV A', 585, 'Andar 1', 'Praca do feijao', 'Guanambi', 'BA' );
INSERT INTO enderecoClientePf ( idClientePf, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 1, '46.490-000', 'AV X', 58, 'Casa', 'centro', 'Macaubas', 'BA' );
INSERT INTO enderecoClientePf ( idClientePf, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 2, '46.490-000', 'AV Y', 55, 'Casa', 'Alto caisara', 'Guanambi', 'BA' );
---------------------------------------------------contatosgerente-------------------------------------------------------------------------------
INSERT INTO contatosClientePf ( idClientePf, telefone, eMail, whatsapp )
VALUES
	( 1, '(77) 99111-0000', 'COO.@email.com', '(77) 99111-2967' );
INSERT INTO contatosClientePf ( idClientePf, telefone, eMail, whatsapp )
VALUES
	( 2, '(77) 99100-6453', 'DXX.@email.com', 'não tem' );
INSERT INTO contatosClientePf ( idClientePf, telefone, eMail, whatsapp )
VALUES
	( 3, '(77) 99196-4624', 'CX.@email.com', '(77) 99196-6424' );
----------------------------------------------funcionarios-----------------------------------------
INSERT INTO funcionario ( nomecompletofuncionario, data_nacimento, cpf, sexo, admicaodatafuncionario, numerocarteiratrabalhofuncionario, funcao, salario )
VALUES
	( 'Bruno dos Santos Silva', '1997-10-22', '123.234-11', 'Masculino', '2020-02-03', '931.89247.01-0', 'Atendente', 1000.0 );
INSERT INTO funcionario ( nomecompletofuncionario, data_nacimento, cpf, sexo, admicaodatafuncionario, numerocarteiratrabalhofuncionario, funcao, salario )
VALUES
	( 'Marta Oliveira Rocha', '1991-04-02', '111.224-12', 'Feminino', '2019-04-11', '802.69416.62-3', 'Estoquista', 1100.0 );
INSERT INTO funcionario ( nomecompletofuncionario, data_nacimento, cpf, sexo, admicaodatafuncionario, numerocarteiratrabalhofuncionario, funcao, salario )
VALUES
	( 'João Silva', '1993-09-17', '122.455-45', 'Masculino', '2020-03-03', '988.80442.03-5', 'Faxineiro', 1000.0 );
---------------------------------------------------enderecogerente-------------------------------------------------------------------------------
INSERT INTO enderecoFuncionario ( idfuncionario, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 3, '46.490-000', 'AV A', 585, 'Andar 1', 'Praca do feijao', 'Guanambi', 'BA' );
INSERT INTO enderecoFuncionario ( idfuncionario, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 1, '46.490-000', 'AV X', 58, 'Casa', 'centro', 'Macaubas', 'BA' );
INSERT INTO enderecoFuncionario ( idfuncionario, cep, logradouro, numero, complemento, bairro, municipio, UF )
VALUES
	( 2, '46.490-000', 'AV Y', 55, 'Casa', 'Alto caisara', 'Guanambi', 'BA' );
---------------------------------------------------contatosgerente-------------------------------------------------------------------------------
INSERT INTO contatosFuncionario ( idfuncionario, telefone, eMail, whatsapp )
VALUES
	( 1, '(77) 99111-0000', 'COO.@email.com', '(77) 99111-2967' );
INSERT INTO contatosFuncionario ( idfuncionario, telefone, eMail, whatsapp )
VALUES
	( 2, '(77) 99100-6453', 'DXX.@email.com', 'não tem' );
INSERT INTO contatosFuncionario ( idfuncionario, telefone, eMail, whatsapp )
VALUES
	( 3, '(77) 99196-4624', 'CX.@email.com', '(77) 99196-6424' );
------------------------------------------------Formapagamento----------------------------------------------
INSERT INTO formapagamento ( formapagamento )
VALUES
	( 'Boleto' );
INSERT INTO formapagamento ( formapagamento )
VALUES
	( 'Credito' );
INSERT INTO formapagamento ( formapagamento )
VALUES
	( 'Débito' );
------------------------------------------------venda----------------------------------------------
INSERT INTO venda ( idfuncionario, idclientepf, idFormapagamento, numeroparcelas, status )
VALUES
	( 1, 1, 1, 5, 'NP' );
INSERT INTO venda ( idfuncionario, idclientepf, idFormapagamento, numeroparcelas, status )
VALUES
	( 2, 2, 2, 5, 'NP' );
INSERT INTO venda ( idfuncionario, idclientepf, idFormapagamento, numeroparcelas, status )
VALUES
	( 3, 3, 3, 3, 'NP' );
INSERT INTO venda ( idfuncionario, idclientepf, idFormapagamento, numeroparcelas, status )
VALUES
	( 1, 1, 1, 5, 'NP' );
INSERT INTO venda ( idfuncionario, idclientepf, idFormapagamento, numeroparcelas, status )
VALUES
	( 2, 2, 2, 5, 'NP' );
INSERT INTO venda ( idfuncionario, idclientepf, idFormapagamento, numeroparcelas, status )
VALUES
	( 3, 3, 3, 3, 'NP' );
-------------------------------------itensvenda---------------------------------------------------
INSERT INTO itensvenda ( idvenda, idcalcados, quantidade, desconto )
VALUES
	( 1, 1, 2, 10 );
INSERT INTO itensvenda ( idvenda, idcalcados, quantidade )
VALUES
	( 2, 2, 3 );
INSERT INTO itensvenda ( idvenda, idcalcados, quantidade, desconto )
VALUES
	( 3, 6, 1, 20 );
INSERT INTO itensvenda ( idvenda, idcalcados, quantidade )
VALUES
	( 6, 8, 3 );
----------------------------------itensdevolucao-----------------------------------------------------
INSERT INTO itensdevolucao ( iditensvenda, idcalcados, motivo, quantidadedevolucao, datadevolucao )
VALUES
	( 1, 1, 'Qualquer', 1, '2021-03-11' );
INSERT INTO itensdevolucao ( iditensvenda, idcalcados, motivo, quantidadedevolucao, datadevolucao )
VALUES
	( 2, 3, 'Qualquer', 1, '2021-03-11' );
-----------------------------------------------------------------------------------------------------
-- SELECT * FROM prodmaisvendcategoria(3,'2021-03-24');
-- SELECT * FROM selecionaclientes();
-- SELECT * FROM produtosMaisLucrativos('03',30);
-- SELECT idclientepf, nomecompletocliente, cpf FROM melhoresClientes(10);
-- SELECT * FROM maiorLucroCalcadosDatadeinicio(2,'2021-03-24','2021-03-24');
-- SELECT * FROM vendasMaisLucroDoMes('03', 212);
-- SELECT * FROM CLIPARVENCER('2021-04-23')
-- SELECT * from compraPorMes('03')
-- SELECT * from compraPorMesPorValor('03',1)
-- SELECT * from aumentarValorDeVenda(0.10, 1)
-- SELECT * from MostrarTotalVendadoMes('03')
-- SELECT * from aumentarValorDeVendaPorTipo(0.10, 1);
-- SELECT * from calcadosAbaixoDoEstoque(40)
-- OBS: todas as datas do meu sistema usa a data atual, entao todas as vezes que roda o banco ele pegar as datas atuais