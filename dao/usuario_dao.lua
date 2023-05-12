dofile("../bd/conexao_bd.lua");
--[[
@Titulo: Inserir usuário no banco de dados.
@Objetivo:Inserir os dados do usuário no banco de dados do sistema.
@Contexto: Cadastrar usuário.
@Atores: Conectar ao banco de dados.
@Recursos: dados do usuário.
]]--
function inserir_usuario_bd (nome, sobrenome, email, instituicao, login, senha)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Episódio 2: Montar query de inserção de usuário no banco de dados,
-- com os valores passados por parâmetro.
	local stmt = ("insert into usuario (nome, sobrenome, email, instituicao, login, senha)" 
		.."values (\""..nome.."\",\""..sobrenome.."\",\""..email.."\",\""..instituicao.."\",\""..login.."\",\""..senha.."\")");

--@Episódio 3: Executar a query para inserção de usuário no banco de dados.
	local cursor, erro = conexao:execute (stmt)

--@Episódio 4: Tratamento de eventuais erros que possam ocorrer com a conexão.
	if not cursor then
	        error (erro.." SQL = [=["..stmt.."]=]")
	end
--@Episódio 5: Fechar a conexão com o banco de dados.
	conexao:close(); 	
end 

--[[
@Titulo: Selecionar usuário no banco de dados.
@Objetivo:Dado o login, recuperar os dados do usuário do banco de dados
@Contexto: A camada modelo chama a função selecionar_usuario_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--
function selecionar_usuario_bd (login)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();

--@Episódio 2: Montar query de seleção com os valores passados por parâmetro.
	local stmt = ("select * from usuario where login = \""..login.."\"");
	
--@Episódio 3: Executar a query.
	local cursor, erro = conexao:execute (stmt)
	
--@Episódio 4: Tratamento de eventuais erros.	
	if not cursor then
		error (erro.." SQL = [=["..stmt.."]=]")
	end
--@Episódio 5: Armazenar o resultado da consulta em uma tabela.
	linha = cursor:fetch ({}, "a");
	tabela = {};
	while linha do
		table.insert(tabela,linha);
		linha = cursor:fetch ({}, "a");
	end

--@Episódio 6: Fechar a conexão
	conexao:close(); 

--@Episódio 7: Retornar tabela com os resultados	
	return tabela;
	
end

--[[
@Titulo: Remover usuario do banco de dados.
@Objetivo:Dado o login, remover os dados do usuário do banco de dados.
@Contexto: A camada modelo chama a função remover_usuario_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function remover_usuario_bd (id_usuario)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_db();
	
--@Episódio 2: Montar query de exclusão com os valores passados por parâmetro.
	local stmt = ("delete from usuario where id = \""..id_usuario.."\"");

--@Episódio 3: Executar a query.
	local cursor, erro = conexao:execute (stmt)
	
--@Episódio 4: Tratamento de eventuais erros.
	if not cursor then
	        error (erro.." SQL = [=["..stmt.."]=]")
	end
--@Episódio 7: Fechar a conexão
	conexao:close(); 
end

 