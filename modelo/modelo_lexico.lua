dofile("../dao/lexico_dao.lua");

require("md5.core");


--[[
@Titulo: Cadastrar l�xico.
@Objetivo: Cadastrar o l�xico no sistema
@Contexto: O usu�rio submeteu o formul�rio de cadastro de l�xico.
@Atores: usu�rio.
@Recursos: md5.core, lexico_dao.lua
]]--


function cadastrar_lexico(nome, lista_de_sinonimos,nocao, impacto, classificacao, projeto)
	
--@Epis�dio 1: INSERIR L�XICO NO BANCO DE DADOS.
	local resultado_lexico = inserir_lexico_bd(nome, nocao, impacto, classificacao, projeto);
	
--@Epis�dio 2: Se houver sin�nimos, armazena a lista de sinonimos em uma nova tabela, chamada "sinonimos".
	if (lista_de_sinonimos ~= nil) then
		local sinonimos = {}
		sinonimos = lista_de_sinonimos;
		if (#sinonimos > 0) then	
			for index, sinonimo in pairs(sinonimos) do
				
--@Epis�dio 3: para cada sin�nimo, INSERIR SIN�NIMO NO BANCO DE DADOS.	
				local resultado_sinonimo = inserir_sinonimo_bd(sinonimo, nome, projeto);
			end
		end--if
	end--if	
	return true;
end

--[[
@Titulo: Remover l�xico.
@Objetivo: Remover l�xico do sistema.
@Contexto: A camada controle chama a fun��o remover_lexico.
@Atores: browser e usu�rio.
@Recursos: lexico_dao.lua.
]]--

function remover_lexico(id_projeto, nome)

--@Epis�dio 1: REMOVER SIN�NIMOS DO BANCO DE DADOS .
	remover_sinonimos_bd(nome, id_projeto);
	
--@Epis�dio 2: REMOVER L�XICO DO BANCO DE DADOS .	
	remover_lexico_bd(id_projeto, nome);
		
end

--[[
@Titulo: Checar l�xico.
@Objetivo: Verificar se um l�xico j� esta cadastrado no banco de dados.
@Contexto: A camada controle chama a fun��o checar_lexico.
@Atores: browser e usu�rio.
@Recursos: lexico_dao.lua.
]]--


function checar_lexico (id_projeto, nome_lexico)

	local ha_lexico;
	local nome_repetido;
	
--@Epis�dio 1: SELECIONAR L�XICO DO BANCO DE DADOS 	
	lexicos = selecionar_lexico_bd(id_projeto, nome_lexico);
		
--@Epis�dio 2: Se nenhum l�xico for enontrado a variavel ha _lexico recebe o valor  false
	if (#lexicos == 0) then
		ha_lexico = false;
	else

--@Epis�dio 3: Se um l�xico foi encontrado ent�o a vari�vel nome_repetido recebe o nome do lexico econtrado e a vari�vel ha_lexico recebe true. 	
		for index, lexico in pairs(lexicos) do
			nome_repetido = lexico["NOME"];
		end	--for
		ha_lexico = true;
	end--if
	
--@Epis�dio 4: SELECIONAR SIN�NIMOS DO BANCO DE DADOS 		
	sinonimos = selecionar_sinonimos_bd(nome_lexico, id_projeto);
	if (ha_lexico == false) then
--@Epis�dio 5: Se nenhum l�xico foi encontrado ent�o, se nenhum sin�nimo for enontrado a variavel ha_lexico recebe o valor false.
		if (#sinonimos == 0) then
			ha_lexico = false;
		else 
		
--@Epis�dio 6: Se um sin�nimo foi encontrado ent�o a vari�vel nome_repetido recebe o nome do sin�nimo econtrado e a vari�vel ha_lexico recebe true. 		
			for index, sinonimo in pairs(sinonimos) do
				nome_repetido = sinonimo["NOME"];
			end	--for
			ha_lexico = true;
		end--if	
	end--if	
--@Epis�dio 7: Retorna as vari�veis ha_lexico e nome_repetido.
	return ha_lexico, nome_repetido;

end--checar_lexico

--[[
@Titulo: Checar sin�nimos.
@Objetivo: Verificar se os sin�nimos j� est�o cadastrados no sistema
@Contexto: A camada controle chama a fun��o checar_sinonimos.
@Atores: browser e usu�rio.
@Recursos: lexico_dao.lua.
]]--

function checar_sinonimos (lista_de_sinonimos, id_projeto)
	
	
--@Epis�dio 1: A tabela sinonimos recebe a lista de sin�nimos
	local sinonimos = {}
	sinonimos = lista_de_sinonimos;
	local nome_invalido = false;
	for index, sinonimo in pairs(sinonimos) do
--@Epis�dio 2: Para cada sinonino da lista, SELECIONAR SIN�NIMO DO BANCO DE DADOS.
		sinonimos = selecionar_sinonimos_bd(sinonimo, id_projeto);

--@Epis�dio 3: Se a consulta retornar algum resultado ent�o nome_invalido recebe true.
		if (#sinonimos ~= 0) then
			nome_invalido = true;	
			break;
		end
		
--@Epis�dio 4: Para cada sin�nimo SELECIONAR L�XICO DO BANCO DE DADOS
		lexicos = selecionar_lexico_bd(id_projeto, sinonimo);

--@Epis�dio 5: Se a consulta retornar algum resultado ent�o nome_invalido recebe true
		if (#lexicos ~= 0) then
			nome_invalido = true;	
			break;
		end
	
	end
	
--@Epis�dio 6: Retorna o conte�do de nome inv�lido
	return nome_invalido;
	
end

--[[
@Titulo: Selecionar todos os l�xicos.
@Objetivo: Selecionar todos os l�xicos de um determinado projeto.
@Contexto: A camada controle chama a fun��o selecionar_todos_lexicos.
@Atores: browser e usu�rio.
@Recursos: lexico_dao.lua.
]]--


function selecionar_todos_lexicos (id_projeto)

--@Epis�dio 1:  SELECIONAR TODOS OS L�XICOS DO BANCO DE DADOS.
	lexicos = selecionar_todos_lexicos_bd(id_projeto);
	
--@Epis�dio 2: Os l�xicos obtidos s�o retornados.
	return lexicos;

end

--[[
@Titulo:  Selecionar l�xico.
@Objetivo: Obter todas as informa��es de um determinado l�xico, identificado pelo id do projeto e pelo nome.
@Contexto: A camada controle chama a fun��o selecionar_lexico.
@Atores: browser e usu�rio.
@Recursos: lexico_dao.lua.
]]--


function selecionar_lexico(id_projeto, nome_lexico)

--@Epis�dio 1: SELECIONAR L�XICO DO BANCO DE DADOS.
	lexico = selecionar_lexico_bd(id_projeto, nome_lexico);

--@Epis�dio 2: As informa��es obtidas s�o retornadas.	
	return lexico;

end

--[[
@Titulo: Selecionar sin�nimos l�xico.
@Objetivo: Selecionar todos os sin�nimos de um determinado l�xico.
@Contexto: A camada controle chama a fun��o selecionar_sinonimos_lexico.
@Atores: browser e usu�rio.
@Recursos: lexico_dao.lua.
]]--


function selecionar_sinonimos_lexico(id_projeto, nome_lexico)

	lista_sinonimos = "";
	
--@Epis�dio 1: SELECIONAR SIN�NIMOS DO L�XICO DO BANCO DE DADOS
	sinonimos = selecionar_sinonimos_lexico_bd(nome_lexico, id_projeto );
	
	
	controle = 0;
	
	if (#sinonimos > 0) then
		for index, sinonimo in pairs(sinonimos) do

--@Epis�dio 2: Percorre a lista de sin�nimos encontrados criando uma lista onde os sin�nimos s�o separados por virgula.
			if (controle ~= 0) then
				lista_sinonimos = lista_sinonimos..', '..sinonimo["NOME"]; 
			else
				lista_sinonimos = lista_sinonimos..sinonimo["NOME"]; 
			end	
			controle = controle+1;
		end
		lista_sinonimos = lista_sinonimos..".";
	end
	
--@Epis�dio 3: Retorna a lista criada.
	return lista_sinonimos, sinonimos ;

end
