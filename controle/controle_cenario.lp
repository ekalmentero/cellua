<%
--[[
@Titulo: Controle cen�rio.
@Objetivo: Selecionar a a��o que ser� executada no m�dulo cen�rio.
@Contexto: o usu�rio deseja realizar uma a��o no modulo cen�rio.
@Atores: browser e usu�rio.
@Recursos: modelo_cen�rio.lua.
]]--
--@Epis�dio 1: Importa o arquivo modelo_cenario.lua.
	dofile("../modelo/modelo_cenario.lua")
%>
<html>
<head>
</head>
<body>
<?lua
        if (cgilua.POST.comando == "cadastrar") then
		
--@Epis�dio 2: Se o comando for cadastrar ent�o CHECAR CENARIO
		ha_cenario = checar_cenario(cgilua.POST.id_projeto, cgilua.POST.titulo);
		
				
		if (ha_cenario) then
--@Epis�dio 3: Se j� houver algum cen�rio com o nome informado ent�o retona uma mensagem de erro.
			cgilua.put("J� existe cen�rio com este nome");
		else
--@Epis�dio 4: Se n�o houver nenhum cen�rio cadastrado com o nome informado ent�o CADASTRAR CEN�RIO.
			cadastrado = cadastrar_cenario(cgilua.POST.titulo, cgilua.POST.objetivo, cgilua.POST.contexto, cgilua.POST.atores, 
			cgilua.POST.recursos, cgilua.POST.episodios, cgilua.POST.excecao, cgilua.POST.id_projeto);
		end
		cgilua.redirect(cgilua.mkabsoluteurl("cel/visao/sucesso_cenario.lp"), {acao = "cadastrado"});
		
	elseif (cgilua.POST.comando == "remover") then
	
--@Epis�dio 5: Se o comando for remover, ent�o REMOVER CEN�RIO.
		removido = remover_cenario(cgilua.POST.id_projeto, cgilua.POST.titulo);
		
--@Epis�dio 6: Redireciona para a p�gina de sucesso.
		cgilua.redirect(cgilua.mkabsoluteurl("cel/visao/sucesso_cenario.lp"), {acao = "removido"});
		
	elseif (cgilua.POST.comando == "alterar") then
		cgilua.put("alterando");
		cgilua.put(cgilua.POST.titulo);
--@Epis�dio 9: Se o comando for alterar, ent�o REMOVER CEN�RIO.
		removido = remover_cenario(cgilua.POST.id_projeto, cgilua.POST.titulo);

--@Epis�dio 10:  CADASTRAR CEN�RIO.
		cadastrado = cadastrar_cenario(cgilua.POST.titulo, cgilua.POST.objetivo, cgilua.POST.contexto, cgilua.POST.atores, 
			cgilua.POST.recursos, cgilua.POST.episodios, cgilua.POST.excecao, cgilua.POST.id_projeto);
			
		cgilua.redirect(cgilua.mkabsoluteurl("cel/visao/sucesso_cenario.lp"), {acao = "alterado"});	
	end
?>

</body>
</html>
