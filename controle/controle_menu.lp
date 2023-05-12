<%
--[[
@Titulo: Montar XML do menu lateral
@Objetivo: Fornecer um XML com a lista de cenários e léxicos do projeto passado por parâmetro.
@Contexto: o sistema chama o arquivo controle_menu.lp.
@Atores: sistema. 
@Recursos: modelo_lexico.lua e modelo_cenario.lua.
]]--
	
--@Episódio 1: Incluir os arquivos modelo_lexico.lua e modelo_cenario.lua
dofile("../modelo/modelo_lexico.lua");
dofile("../modelo/modelo_cenario.lua");
	
--@Episódio 2: Armazenar o projeto passado por parâmetro na variável id_projeto.	
id_projeto = cgilua.QUERY.id_projeto;	
	
--@Episódio 3: SELECIONAR TODOS CENÁRIOS e SELECIONAR TODOS LÉXICOS do projeto.
cenarios = selecionar_todos_cenarios(id_projeto);
lexicos = selecionar_todos_lexicos(id_projeto);
	
--@Episódio 4: Montar o XML com o resultado obtido da consulta ao banco de dados. O XML é armazenado na variável xml.
	local xml = [[]];
	
	for index, cenario in pairs(cenarios) do
		xml = xml..[[<cenario>]];
		xml = xml..[[<titulo>]];
		xml = xml..cenario["TITULO"];
		xml = xml..[[</titulo>]];
		xml = xml..[[</cenario>]];
		
	end 

	for index, lexico in pairs(lexicos) do
		xml = xml..[[<lexico>]];
		xml = xml..[[<nome>]];
		xml = xml..lexico["NOME"];
		xml = xml..[[</nome>]];
		xml = xml..[[</lexico>]];
	end
		
--@Episódio 5: Retorna o XML com os cenários e léxicos.	 

cgilua.contentheader("application" , "xml; charset=iso-8859-1")
cgilua.put([[<projeto>]]);
cgilua.put(xml);
cgilua.put([[</projeto>]]);

%>


