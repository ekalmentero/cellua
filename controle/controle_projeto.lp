<?lua
--[[
@Titulo: Controle projeto.
@Objetivo: Selecionar a a��o que ser� executada no m�dulo projeto.
@Contexto: o usu�rio deseja realizar uma a��o no modulo projeto.
@Atores: browser e usu�rio.
@Recursos: modelo_projeto.lua.
]]--

--@Epis�dio 1: Importa o arquivo modelo_projeto.lua.
	dofile("../modelo/modelo_projeto.lua")
	
	if (cgilua.POST.comando == "cadastrar") then
	
--@Epis�dio 2: CADASTRAR PROJETO.		
		local id_projeto = cadastrar_projeto(cgilua.POST.nome, cgilua.POST.descricao, cgilua.POST.id_usuario);
		
--@Epis�dio 2: CADASTRAR ADMINISTRADOR.
		cadastrar_administrador(id_projeto, cgilua.POST.id_usuario);		
				
--@Epis�dio 3: Caso o cadastro tenha sido feito, redireciona para a p�gina de sucesso.
		cgilua.redirect(cgilua.mkabsoluteurl("/cel/visao/sucesso_projeto.lp"),{acao = "cadastrado"});
	
	end	
	
	
?>

