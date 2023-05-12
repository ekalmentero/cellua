dofile("../modelo/modelo_lexico.lua");

--[[
@Titulo: Selecionar sinônimos do léxico.
@Objetivo: Fornecer uma lista com todos os sinoônimos de um determinado léxico.
@Contexto: O usuário escolhe um léxico do menu lateral e clica na opção alterar léxico.
@Atores: browser e usuário.
@Recursos: modelo_lexico.lua.
]]--

function listar_sinonimos_lexico(id_projeto, nome_lexico)

--@Episódio 1: SELECIONAR SINONIMOS LÉXICO
	lista_sinonimos, sinonimos = selecionar_sinonimos_lexico(id_projeto, nome_lexico)
	
--@Episódio 2: Retorna os sinônimos
	return sinonimos;
end

--[[
@Titulo: Recuperar dados do léxico
@Objetivo: Recuperar os dados de um léxico
@Contexto: A página alterar_lexico.lp  é acessada.
@Atores: browser e usuário.
@Recursos: modelo_lexico.lua.
]]--

function selecionar_dados_lexico(nome, id_projeto, formatado)
	
--Episódio 1: SELECIONAR LÉXICO
	lexico_selecionado = selecionar_lexico(id_projeto, nome);
	
--Episódio 2: SELECIONAR SINÔNIMOS LEXICO
	lista_sinonimos, sinonimos = selecionar_sinonimos_lexico(id_projeto, nome);	
		
--Episódio 2: Se formatado é verdadeiro. O texto do léxico selecionado é formatado. As ocorrências de "\n" são substituidas por "<br>" para que as quebras de linha sejam visualizadas pelo usuário.

if (formatado) then
	lexico_selecionado[1]["NOME"] = string.gsub(lexico_selecionado[1]["NOME"],"\n","<br>");
	lexico_selecionado[1]["NOCAO"] = string.gsub(lexico_selecionado[1]["NOCAO"],"\n","<br>");
	lexico_selecionado[1]["IMPACTO"] = string.gsub(lexico_selecionado[1]["IMPACTO"],"\n","<br>");
	lexico_selecionado[1]["CLASSIFICACAO"] = string.gsub(lexico_selecionado[1]["CLASSIFICACAO"],"\n","<br>");
end


--Episódio3: Retorna os dados do léxico selecionado	
	return lexico_selecionado, lista_sinonimos;


end


