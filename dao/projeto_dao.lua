dofile("../bd/conexao_bd.lua");

--[[
@Titulo: Inserir administrador no banco de dados.
@Objetivo:Inserir o relacionamento de administrador no banco de dados.
@Contexto: CADASTRAR ADMINISTRADOR.
@Atores: conexao_bd.
@Recursos: id do usu�rio, id do projeto.
]]--

function inserir_administrador_bd (id_projeto, id_usuario)

--@Epis�dio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Epis�dio 2: Montar query de inser��o com os valores passados por par�metro.
	local stmt = ("insert into participa (ID_PROJETO, ID_USUARIO, ACESSO)" 
		.."values ("..id_projeto..","..id_usuario..",\"Administrador\")");
	cgilua.put(stmt);
--@Epis�dio 3: Executar a query.
	local cursor, erro = conexao:execute (stmt)

--@Epis�dio 4: Tratamento de eventuais erros.
	if not cursor then
	    error (erro.." SQL = [=["..stmt.."]=]")
	end

--@Epis�dio 5: Fechar a conex�o
	conexao:close(); 
	return true;
end


--[[
@Titulo: Inserir projeto no banco de dados.
@Objetivo:Inserir os dados do projeto no banco de dados.
@Contexto: A camada modelo chama a fun��o inserir_projeto_bd.
@Atores: conexao_bd.
@Recursos: nome do projeto, descricao do projeto, data de cria��o do projeto
	id do usu�rio.
]]--


function inserir_projeto_bd(nome, descricao, data, id_usuario)

--@Epis�dio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Epis�dio 2: Montar query de inser��o com os valores passados por par�metro.
	local stmt = ("insert into projeto (nome, descricao, data_criacao, usuario)" 
		.."values (\""..nome.."\",\""..descricao.."\",\""..data.."\",\""..id_usuario.."\")");
		
--@Epis�dio 3: Montar query para selecionar o id do projeto inserido anteriormente.		
	local stmt_ult_id = ("SELECT LAST_INSERT_ID();")
	
--@Epis�dio 4: Executar a query para inserir projeto.
	local cursor, erro = conexao:execute (stmt)
	
--@Epis�dio 5: Tratamento de eventuais erros na execu��o da query anterior.	
	if not cursor then
	    error (erro.." SQL = [=["..stmt.."]=]")
	end
	
--@Epis�dio 6: Executar a query para selecionar id do projeto inserido.
	local cursor_ult_id, erro_ult_id = conexao:execute (stmt_ult_id);
	
--@Epis�dio 7: Tratamento de eventuais erros na execu��o das query anterior.
	if not cursor_ult_id then
	    error (erro_ult_id.." SQL = [=["..stmt_ult_id.."]=]")
	end
	
--@Epis�dio 8: Recupera o resultado retornado pela query anterior e o armazena na tabela ult_resultado.	
	linha = cursor_ult_id:fetch ({}, "a");
	local ult_resultado = {};
	while linha do
		table.insert(ult_resultado,linha);
		linha = cursor_ult_id:fetch ({}, "a");
	end
	
--@Epis�dio 9: Recupera o valor do id do �ltimo projeto inserido e o armazena na vari�vel ult_id.	
	local ult_id;
	for index, linha in pairs(ult_resultado) do
		ult_id = linha["LAST_INSERT_ID()"];
	end
		
--@Epis�dio 10: Fechar a conex�o com banco de dados.
	conexao:close(); 
	
--@Epis�dio 11: Retorna o valor do id do projeto inserido
	return ult_id;
	
end

--[[
@Titulo: Remover projeto do banco de dados.
@Objetivo:Remover os dados do projeto do banco de dados.
@Contexto: A camada modelo chama a fun��o remover_projeto.
@Atores: usu�rio.
@Recursos: conexao_bd.lua.
]]--

function remover_projeto(id_projeto)

--@Epis�dio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Epis�dio 2: Montar query de remo��o com os valores passados por par�metro.
	local stmt = ("delete from projeto where id_projeto = \""..id_projeto.."\"");
	
--@Epis�dio 3: Executar a query.
	local cursor, erro = conexao:execute (stmt)
	
--@Epis�dio 4: Tratamento de eventuais erros.
	if not cursor then
	        error (erro.." SQL = [=["..stmt.."]=]")
	end

--@Epis�dio 5: Fechar a conex�o
	conexao:close(); 	
	return true;

end

--[[
@Titulo: Selecionar  projeto do banco de dados pelo id do projeto.
@Objetivo:Recuperar os dados de um determinado projeto do banco de dados usando o id do projeto
@Contexto: A camada modelo chama a fun��o selecionar_projeto_bd.
@Atores: usu�rio.
@Recursos: conexao_bd.lua.
]]--

function selecionar_projeto_bd(id_projeto)

--@Epis�dio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Epis�dio 2: Montar query de sele��o utilizando o id do projeto.
	local stmt = ("select * from projeto where id_projeto = \""..id_projeto.."\"");
	
--@Epis�dio 3: Executar a query.
	local cursor, erro = conexao:execute (stmt)
	
--@Epis�dio 4: Tratamento de eventuais erros.
	if not cursor then
		error (erro.." SQL = [=["..stmt.."]=]")
	end
	
--@Epis�dio 5: Armazenar o resultado da consulta em uma tabela.
	linha = cursor:fetch ({}, "a");
	tabela = {};
	while linha do
		table.insert(tabela,linha);
		linha = cursor:fetch ({}, "a");
	end
	
--@Epis�dio 6: Fechar a conex�o
	conexao:close(); 	
--@Epis�dio 7: Retornar tabela com os resultados	
	return tabela;	
	
end



--[[
@Titulo: Selecionar  projetos do banco de dados.
@Objetivo:Selecionar todos os projetos pertencentes a um determinado usu�rio do banco de dados
@Contexto: A camada modelo chama a fun��o selecionar_projetos_bd.
@Atores: usu�rio.
@Recursos: conexao_bd.lua.
]]--

function selecionar_projetos_bd (id_usuario)

--@Epis�dio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Epis�dio 2: Montar query de sele��o com os valores passados por par�metro.
	local stmt = ("select pr.ID_PROJETO, pr.NOME, pa.ACESSO"..
		" from projeto pr, participa pa "..
		"where pa.id_usuario= "..id_usuario.." and pa.id_projeto = pr.id_projeto"..
		" order by pr.nome");

--@Epis�dio 3: Executar a query.
	local cursor, erro = conexao:execute (stmt)
	
--@Epis�dio 4: Tratamento de eventuais erros.
	if not cursor then
		error (erro.." SQL = [=["..stmt.."]=]")
	end
	
--@Epis�dio 5: Armazenar o resultado da consulta em uma tabela.
	linha = cursor:fetch ({}, "a");
	tabela = {};
	while linha do
		table.insert(tabela,linha);
		linha = cursor:fetch ({}, "a");
	end
	
--@Epis�dio 6: Fechar a conex�o
	conexao:close(); 	
--@Epis�dio 7: Retornar tabela com os resultados	
	return tabela;	

end
