dofile("../bd/conexao_bd.lua");

--[[
@Titulo: Inserir cenário no banco de dados.
@Objetivo:Inserir os dados do cenário no banco de dados.
@Contexto: A camada modelo chama a função inserir_cenario_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function inserir_cenario_bd(titulo, objetivo, contexto, atores, recursos, episodios, excecao, data, projeto)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Episódio 2: Montar query de inserção com os valores passados por parâmetro.
	local stmt = ("insert into cenario values (\""..titulo.."\",\""..objetivo.."\",\""..contexto.."\",\""
	..atores.."\",\""..recursos.."\",\""..episodios.."\",\""..excecao.."\",\""..data.."\",\""..projeto.."\")");
	
--@Episódio 3: Executar a query.
	local cursor, erro = conexao:execute (stmt)
	
--@Episódio 4: Tratamento de eventuais erros.
	if not cursor then
	        error (erro.." SQL = [=["..stmt.."]=]")
	end
--@Episódio 5: Fechar a conexão
	conexao:close();  
end

--[[
@Titulo: Remover cenário do banco de dados.
@Objetivo:Remover os dados do cenário do banco de dados.
@Contexto: A camada modelo chama a função remover_cenario_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function remover_cenario_bd(id_projeto, titulo)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Episódio 2: Montar query de remoção com os valores passados por parâmetro.
	local stmt = ("delete from cenario where titulo = \""..titulo.."\" and projeto = \""..id_projeto.."\"");
	
--@Episódio 3: Executar a query.
	local cursor, erro = conexao:execute (stmt)
	
--@Episódio 4: Tratamento de eventuais erros.
	if not cursor then
	    error (erro.." SQL = [=["..stmt.."]=]")
	end
--@Episódio 5: Fechar a conexão	
	conexao:close();  
	
	return true;

end

--[[
@Titulo: Selecionar cenário do banco de dados
@Objetivo:Selecionar um cenário do banco de dados.
@Contexto: A camada modelo chama a função selecionar_cenario_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function selecionar_cenario_bd(id_projeto, titulo)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Episódio 2: Montar query de seleção com os valores passados por parâmetro.
	local stmt = ("select * from cenario where titulo = \""..titulo.."\" and projeto = \""..id_projeto.."\"");
	
--@Episódio 3: Executar a query.
	local cursor, erro = conexao:execute (stmt)
	
--@Episódio 4: Tratamento de eventuais erros.
	if not cursor then
		error (erro.." SQL = [=["..stmt.."]=]")
	end
--@Episódio 5: Armazena os resultados da seleção em uma tabela.
	linha = cursor:fetch ({}, "a");
	tabela = {};
	while linha do
		table.insert(tabela,linha);
		linha = cursor:fetch ({}, "a");
	end
	
--@Episódio 6: Fecha a conexão	
	conexao:close(); 

--@Episódio 7: Retorna tabela com o resultado.
	return tabela;
end

--[[
@Titulo: Selecionar todos os cenário do banco de dados.
@Objetivo: Selecionar todos os cenário de um determinado projeto.
@Contexto: A camada modelo chama a função selecionar_todos_cenarios_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function selecionar_todos_cenarios_bd(id_projeto)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Episódio 2: Montar query de seleção com os valores passados por parâmetro.
	local stmt = ("select * from cenario where projeto = \""..id_projeto.."\"");
	
--@Episódio 3: Executar a query.
	local cursor, erro = conexao:execute (stmt)
	
--@Episódio 4: Tratamento de eventuais erros	
	if not cursor then
		error (erro.." SQL = [=["..stmt.."]=]")
	end
--@Episódio 5: Armazena os resultados da seleção em uma tabela	
	linha = cursor:fetch ({}, "a");
	tabela = {};
	while linha do
		table.insert(tabela,linha);
		linha = cursor:fetch ({}, "a");
	end
	
--@Episódio 6: Fechar a conexão	
	conexao:close(); 

--@Episódio 7: Retornar tabela com o resultado	
	return tabela;
end
