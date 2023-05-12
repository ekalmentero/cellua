<%
--[[
@Titulo: Controle cenário.
@Objetivo: Selecionar a ação que será executada no módulo cenário.
@Contexto: o usuário deseja realizar uma ação no modulo cenário.
@Atores: browser e usuário.
@Recursos: modelo_cenário.lua.
]]--
--@Episódio 1: Importa o arquivo modelo_cenario.lua.
	dofile("../modelo/modelo_cenario.lua")
%>
<html>
<head>
</head>
<body>
<?lua
        if (cgilua.POST.comando == "cadastrar") then
		
--@Episódio 2: Se o comando for cadastrar então CHECAR CENARIO
		ha_cenario = checar_cenario(cgilua.POST.id_projeto, cgilua.POST.titulo);
		
				
		if (ha_cenario) then
--@Episódio 3: Se já houver algum cenário com o nome informado então retona uma mensagem de erro.
			cgilua.put("Já existe cenário com este nome");
		else
--@Episódio 4: Se não houver nenhum cenário cadastrado com o nome informado então CADASTRAR CENÁRIO.
			cadastrado = cadastrar_cenario(cgilua.POST.titulo, cgilua.POST.objetivo, cgilua.POST.contexto, cgilua.POST.atores, 
			cgilua.POST.recursos, cgilua.POST.episodios, cgilua.POST.excecao, cgilua.POST.id_projeto);
		end
		cgilua.redirect(cgilua.mkabsoluteurl("cel/visao/sucesso_cenario.lp"), {acao = "cadastrado"});
		
	elseif (cgilua.POST.comando == "remover") then
	
--@Episódio 5: Se o comando for remover, então REMOVER CENÁRIO.
		removido = remover_cenario(cgilua.POST.id_projeto, cgilua.POST.titulo);
		
--@Episódio 6: Redireciona para a página de sucesso.
		cgilua.redirect(cgilua.mkabsoluteurl("cel/visao/sucesso_cenario.lp"), {acao = "removido"});
		
	elseif (cgilua.POST.comando == "alterar") then
		cgilua.put("alterando");
		cgilua.put(cgilua.POST.titulo);
--@Episódio 9: Se o comando for alterar, então REMOVER CENÁRIO.
		removido = remover_cenario(cgilua.POST.id_projeto, cgilua.POST.titulo);

--@Episódio 10:  CADASTRAR CENÁRIO.
		cadastrado = cadastrar_cenario(cgilua.POST.titulo, cgilua.POST.objetivo, cgilua.POST.contexto, cgilua.POST.atores, 
			cgilua.POST.recursos, cgilua.POST.episodios, cgilua.POST.excecao, cgilua.POST.id_projeto);
			
		cgilua.redirect(cgilua.mkabsoluteurl("cel/visao/sucesso_cenario.lp"), {acao = "alterado"});	
	end
?>

</body>
</html>
