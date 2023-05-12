dofile("../modelo/modelo_projeto.lua");

--[[
@Titulo: Montar menu de projetos.
@Objetivo: Fornecer uma lista com todos os projetos cadastrados para determinado usuário.
@Contexto: O menu de projetos da página principal é atualizado.
@Atores: browser e usuário.
@Recursos: modelo_projeto.lua.
]]--

function carregar_projetos(id_usuario)

--@Episódio 1: SELECIONAR PROJETOS.
	projetos = selecionar_projetos(id_usuario);

	
	lista_de_projetos = "";
--@Episódio 2: percorre a lista de projetos retornados da seleção, montando o menu e armazenando na variavel lista_de_projetos.		
	if(#projetos > 0) then
	
--@Episódio 3: Abrevia o nome da permissão para que não ocupem espaço na listbox.	
		for index, projeto in pairs(projetos) do
			local acesso;
			if (projeto["ACESSO"] == "Administrador") then
				acesso = "Adm";
			elseif (projeto["ACESSO"] == "Gerente") then
				acesso = "Ger";		
			elseif(projeto["ACESSO"] == "Usuário Ativo") then
				acesso = "U. Atv";
			elseif(projeto["ACESSO"] == "Usuário Passivo") then
				acesso = "U. Pas";
			end
			
			lista_de_projetos = lista_de_projetos.."<option value="..projeto["ID_PROJETO"]..">";
			lista_de_projetos = lista_de_projetos..projeto["NOME"].." -- ("..acesso..")";
			lista_de_projetos = lista_de_projetos.."</option>";
		end
	end
	
--@Episódio 4: retorna o menu montado.
	return lista_de_projetos;
end

function selecionar_nome_projeto(id_projeto)

--@Episódio 1: SELECIONAR PROJETOS.
	projeto = selecionar_projeto(id_projeto);
	return projeto[1]["NOME"];
end

function colocar_links_texto(id_projeto, texto, tipo)
	texto_com_links = colocar_atalhos(id_projeto, texto, tipo);
end 
