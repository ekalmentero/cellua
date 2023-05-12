dofile("../modelo/modelo_cenario.lua");

--[[
@Titulo: Exibir dados de um cenário
@Objetivo: Fornecer uma lista com todos os sinoônimos de um determinado léxico.
@Contexto: O usuário escolhe um léxico do menu lateral e clica na opção alterar léxico.
@Atores: browser e usuário.
@Recursos: modelo_lexico.lua.
]]--

function selecionar_dados_cenario(titulo, id_projeto, formatado)

--Episódio 1: SELECIONAR CENÁRIO
	cenario_selecionado = selecionar_cenario(id_projeto, titulo);
	
--Episódio 2: Se formatado é verdadeiro. O texto do cenário selecionado é formatado. As ocorrências de "\n" são substituidas por "<br>" para que as quebras de linha sejam visualizadas pelo usuário.
if (formatado) then
	cenario_selecionado[1]["TITULO"] = string.gsub(cenario_selecionado[1]["TITULO"],"\n","<br>");
	cenario_selecionado[1]["OBJETIVO"] = string.gsub(cenario_selecionado[1]["OBJETIVO"],"\n","<br>");
	cenario_selecionado[1]["CONTEXTO"] = string.gsub(cenario_selecionado[1]["CONTEXTO"],"\n","<br>");
	cenario_selecionado[1]["ATORES"] = string.gsub(cenario_selecionado[1]["ATORES"],"\n","<br>");
	cenario_selecionado[1]["RECURSOS"] = string.gsub(cenario_selecionado[1]["RECURSOS"],"\n","<br>");
	cenario_selecionado[1]["EPISODIOS"] = string.gsub(cenario_selecionado[1]["EPISODIOS"],"\n","<br>");
	cenario_selecionado[1]["EXCECAO"] = string.gsub(cenario_selecionado[1]["EXCECAO"],"\n","<br>");
end
--Episódio3: Retorna os dados do cenário selecionado	
	return cenario_selecionado;


end


