dofile("../dao/lexico_dao.lua");

require("md5.core");


--[[
@Titulo: Cadastrar léxico.
@Objetivo: Cadastrar o léxico no sistema
@Contexto: O usuário submeteu o formulário de cadastro de léxico.
@Atores: usuário.
@Recursos: md5.core, lexico_dao.lua
]]--


function cadastrar_lexico(nome, lista_de_sinonimos,nocao, impacto, classificacao, projeto)
	
--@Episódio 1: INSERIR LÉXICO NO BANCO DE DADOS.
	local resultado_lexico = inserir_lexico_bd(nome, nocao, impacto, classificacao, projeto);
	
--@Episódio 2: Se houver sinônimos, armazena a lista de sinonimos em uma nova tabela, chamada "sinonimos".
	if (lista_de_sinonimos ~= nil) then
		local sinonimos = {}
		sinonimos = lista_de_sinonimos;
		if (#sinonimos > 0) then	
			for index, sinonimo in pairs(sinonimos) do
				
--@Episódio 3: para cada sinônimo, INSERIR SINÔNIMO NO BANCO DE DADOS.	
				local resultado_sinonimo = inserir_sinonimo_bd(sinonimo, nome, projeto);
			end
		end--if
	end--if	
	return true;
end

--[[
@Titulo: Remover léxico.
@Objetivo: Remover léxico do sistema.
@Contexto: A camada controle chama a função remover_lexico.
@Atores: browser e usuário.
@Recursos: lexico_dao.lua.
]]--

function remover_lexico(id_projeto, nome)

--@Episódio 1: REMOVER SINÔNIMOS DO BANCO DE DADOS .
	remover_sinonimos_bd(nome, id_projeto);
	
--@Episódio 2: REMOVER LÉXICO DO BANCO DE DADOS .	
	remover_lexico_bd(id_projeto, nome);
		
end

--[[
@Titulo: Checar léxico.
@Objetivo: Verificar se um léxico já esta cadastrado no banco de dados.
@Contexto: A camada controle chama a função checar_lexico.
@Atores: browser e usuário.
@Recursos: lexico_dao.lua.
]]--


function checar_lexico (id_projeto, nome_lexico)

	local ha_lexico;
	local nome_repetido;
	
--@Episódio 1: SELECIONAR LÉXICO DO BANCO DE DADOS 	
	lexicos = selecionar_lexico_bd(id_projeto, nome_lexico);
		
--@Episódio 2: Se nenhum léxico for enontrado a variavel ha _lexico recebe o valor  false
	if (#lexicos == 0) then
		ha_lexico = false;
	else

--@Episódio 3: Se um léxico foi encontrado então a variável nome_repetido recebe o nome do lexico econtrado e a variável ha_lexico recebe true. 	
		for index, lexico in pairs(lexicos) do
			nome_repetido = lexico["NOME"];
		end	--for
		ha_lexico = true;
	end--if
	
--@Episódio 4: SELECIONAR SINÔNIMOS DO BANCO DE DADOS 		
	sinonimos = selecionar_sinonimos_bd(nome_lexico, id_projeto);
	if (ha_lexico == false) then
--@Episódio 5: Se nenhum léxico foi encontrado então, se nenhum sinônimo for enontrado a variavel ha_lexico recebe o valor false.
		if (#sinonimos == 0) then
			ha_lexico = false;
		else 
		
--@Episódio 6: Se um sinônimo foi encontrado então a variável nome_repetido recebe o nome do sinônimo econtrado e a variável ha_lexico recebe true. 		
			for index, sinonimo in pairs(sinonimos) do
				nome_repetido = sinonimo["NOME"];
			end	--for
			ha_lexico = true;
		end--if	
	end--if	
--@Episódio 7: Retorna as variáveis ha_lexico e nome_repetido.
	return ha_lexico, nome_repetido;

end--checar_lexico

--[[
@Titulo: Checar sinônimos.
@Objetivo: Verificar se os sinônimos já estão cadastrados no sistema
@Contexto: A camada controle chama a função checar_sinonimos.
@Atores: browser e usuário.
@Recursos: lexico_dao.lua.
]]--

function checar_sinonimos (lista_de_sinonimos, id_projeto)
	
	
--@Episódio 1: A tabela sinonimos recebe a lista de sinônimos
	local sinonimos = {}
	sinonimos = lista_de_sinonimos;
	local nome_invalido = false;
	for index, sinonimo in pairs(sinonimos) do
--@Episódio 2: Para cada sinonino da lista, SELECIONAR SINÔNIMO DO BANCO DE DADOS.
		sinonimos = selecionar_sinonimos_bd(sinonimo, id_projeto);

--@Episódio 3: Se a consulta retornar algum resultado então nome_invalido recebe true.
		if (#sinonimos ~= 0) then
			nome_invalido = true;	
			break;
		end
		
--@Episódio 4: Para cada sinônimo SELECIONAR LÉXICO DO BANCO DE DADOS
		lexicos = selecionar_lexico_bd(id_projeto, sinonimo);

--@Episódio 5: Se a consulta retornar algum resultado então nome_invalido recebe true
		if (#lexicos ~= 0) then
			nome_invalido = true;	
			break;
		end
	
	end
	
--@Episódio 6: Retorna o conteúdo de nome inválido
	return nome_invalido;
	
end

--[[
@Titulo: Selecionar todos os léxicos.
@Objetivo: Selecionar todos os léxicos de um determinado projeto.
@Contexto: A camada controle chama a função selecionar_todos_lexicos.
@Atores: browser e usuário.
@Recursos: lexico_dao.lua.
]]--


function selecionar_todos_lexicos (id_projeto)

--@Episódio 1:  SELECIONAR TODOS OS LÉXICOS DO BANCO DE DADOS.
	lexicos = selecionar_todos_lexicos_bd(id_projeto);
	
--@Episódio 2: Os léxicos obtidos são retornados.
	return lexicos;

end

--[[
@Titulo:  Selecionar léxico.
@Objetivo: Obter todas as informações de um determinado léxico, identificado pelo id do projeto e pelo nome.
@Contexto: A camada controle chama a função selecionar_lexico.
@Atores: browser e usuário.
@Recursos: lexico_dao.lua.
]]--


function selecionar_lexico(id_projeto, nome_lexico)

--@Episódio 1: SELECIONAR LÉXICO DO BANCO DE DADOS.
	lexico = selecionar_lexico_bd(id_projeto, nome_lexico);

--@Episódio 2: As informações obtidas são retornadas.	
	return lexico;

end

--[[
@Titulo: Selecionar sinônimos léxico.
@Objetivo: Selecionar todos os sinônimos de um determinado léxico.
@Contexto: A camada controle chama a função selecionar_sinonimos_lexico.
@Atores: browser e usuário.
@Recursos: lexico_dao.lua.
]]--


function selecionar_sinonimos_lexico(id_projeto, nome_lexico)

	lista_sinonimos = "";
	
--@Episódio 1: SELECIONAR SINÔNIMOS DO LÉXICO DO BANCO DE DADOS
	sinonimos = selecionar_sinonimos_lexico_bd(nome_lexico, id_projeto );
	
	
	controle = 0;
	
	if (#sinonimos > 0) then
		for index, sinonimo in pairs(sinonimos) do

--@Episódio 2: Percorre a lista de sinônimos encontrados criando uma lista onde os sinônimos são separados por virgula.
			if (controle ~= 0) then
				lista_sinonimos = lista_sinonimos..', '..sinonimo["NOME"]; 
			else
				lista_sinonimos = lista_sinonimos..sinonimo["NOME"]; 
			end	
			controle = controle+1;
		end
		lista_sinonimos = lista_sinonimos..".";
	end
	
--@Episódio 3: Retorna a lista criada.
	return lista_sinonimos, sinonimos ;

end
