dofile("../bd/conexao_bd.lua");

--[[
@Titulo: Inserir léxico no banco de dados.
@Objetivo:Inserir os dados do léxico no banco de dados.
@Contexto: A camada modelo chama a função inserir_lexico_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--


function inserir_lexico_bd (nome, nocao, impacto, classificacao, projeto)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Episódio 2: Montar query de inserção com os valores passados por parâmetro.
	local stmt = ("insert into lexico values (\""..nome.."\",\""..nocao.."\",\""..impacto.."\",\""
		..classificacao.."\",\""..projeto.."\")");

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
@Titulo: Remover léxico do banco de dados.
@Objetivo:Remover os dados do léxico do banco de dados.
@Contexto: A camada modelo chama a função remover_lexico_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--


function remover_lexico_bd(id_projeto, nome)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Episódio 2: Montar query de remoção com os valores passados por parâmetro.
	local stmt = ("delete from lexico where nome = \""..nome.."\" and projeto = \""..id_projeto.."\"");

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
@Titulo: Remover sinonimos do banco de dados.
@Objetivo:Remover os sinonimos de um determinado léxico do banco de dados.
@Contexto: A camada modelo chama a função remover_sinonimos_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function remover_sinonimos_bd(nome, id_projeto)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Episódio 2: Montar query de remoção com os valores passados por parâmetro.
	local stmt = ("delete from sinonimo where lexico = \""..nome.."\" and projeto = \""..id_projeto.."\"");
	
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
@Titulo: Inserir sinônimo no banco de dados.
@Objetivo:Inserir os dados do sinônimo no banco de dados.
@Contexto: A camada modelo chama a função inserir_sinonimo_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function inserir_sinonimo_bd (sinonimo, nome_lexico, id_projeto)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Episódio 2: Montar query de inserção com os valores passados por parâmetro.
	local stmt = ("insert into sinonimo values (\""..sinonimo.."\",\""..nome_lexico.."\",\""..id_projeto.."\")");

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
@Titulo: Selecionar léxico do banco de dados
@Objetivo:Selecionar um léxico do banco de dados.
@Contexto: A camada modelo chama a função selecionar_lexico_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--


function selecionar_lexico_bd(id_projeto, nome_lexico)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();

--@Episódio 2: Montar query de seleção com os valores passados por parâmetro.
	local stmt = ("select * from lexico where nome = \""..nome_lexico.."\" and projeto = \""..id_projeto.."\"");

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
--@Episódio 6: Fecha a conexão.	
	conexao:close(); 
	
--@Episódio 7: Retornar tabela com o resultado.
	return tabela;
end

--[[
@Titulo: Selecionar todos os léxicos do banco de dados
@Objetivo:Selecionar todos os léxicos pertencentes a um projeto
@Contexto: A camada modelo chama a função selecionar_todos_lexicos_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function selecionar_todos_lexicos_bd(id_projeto)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();
	
--@Episódio 2: Montar query de seleção com os valores passados por parâmetro.
	local stmt = ("select * from lexico where projeto = \""..id_projeto.."\"");
	
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
--@Episódio 5: Fecha a conexão.
	conexao:close(); 

--@Episódio 7: Retornar tabela com o resultado.
	return tabela;
end

--[[
@Titulo: Selecionar sinônimo do banco de dados
@Objetivo:Selecionar um sinônimo do banco de dados
@Contexto: A camada modelo chama a função selecionar_sinonimo_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function selecionar_sinonimos_bd(nome_lexico, id_projeto)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();

--@Episódio 2: Montar query de seleção com os valores passados por parâmetro.
	local stmt = ("select * from sinonimo where nome = \""..nome_lexico.."\" and projeto = \""..id_projeto.."\"");
			
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

--@Episódio 5: Fecha a conexão.
	conexao:close(); 
	
--@Episódio 7: Retornar tabela com o resultado.
	return tabela;

end

--[[
@Titulo: Selecionar sinônimos do léxico do banco de dados
@Objetivo:Selecionar os sinônimos de um léxico especifico do banco de dados
@Contexto: A camada modelo chama a função selecionar_sinonimos_lexico_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function selecionar_sinonimos_lexico_bd(nome_lexico, id_projeto)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();

--@Episódio 2: Montar query de seleção com os valores passados por parâmetro.
	local stmt = ("select * from sinonimo where lexico = \""..nome_lexico.."\" and projeto = \""..id_projeto.."\"");
	
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
	
--@Episódio 5: Fecha a conexão.
	conexao:close(); 

--@Episódio 7: Retornar tabela com o resultado.
	return tabela;

end


--[[
@Titulo: Selecionar sinônimos de um projeto do banco de dados
@Objetivo:Selecionar os sinônimos dos léxicos de um projeto especifico do banco de dados
@Contexto: A camada modelo chama a função selecionar_sinonimos_projeto_bd.
@Atores: usuário.
@Recursos: conexao_bd.lua.
]]--

function selecionar_sinonimos_projeto_bd(id_projeto)

--@Episódio 1: CONECTAR AO BANCO DE DADOS.
	local conexao = conectar_bd();

--@Episódio 2: Montar query de seleção com os valores passados por parâmetro.
	local stmt = ("select * from sinonimo where projeto = "..id_projeto);
	
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
	
--@Episódio 5: Fecha a conexão.
	conexao:close(); 

--@Episódio 7: Retornar tabela com o resultado.
	return tabela;

end



