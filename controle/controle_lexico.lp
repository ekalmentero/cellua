<%
	
--[[
@Titulo: Controle léxico.
@Objetivo: Selecionar a ação que será executada no módulo léxico.
@Contexto: o usuário deseja realizar uma ação no modulo léxico.
@Atores: browser e usuário.
@Recursos: modelo_lexico.lua.
]]--
--@Episódio 1: Importa o arquivo modelo_lexico.lua.
	dofile("../modelo/modelo_lexico.lua")
%>
<html>
<head>

</head>
<body>
<?lua   
	if (cgilua.POST.comando == "cadastrar") then
		
		
--@Episódio 2: Se o comando for cadastrar então CHECAR LEXICO.	
		local ha_lexico;
		local nome_repetido;
		local ha_sinonimo;
		ha_lexico, nome_repetido = checar_lexico(cgilua.POST.id_projeto, cgilua.POST.nome);
		
		if (ha_lexico) then
		
--@Episódio 3: Se  já há algum símbolo do léxico no mesmo projeto com o nome do símbolo que está sendo inserido emite mensagem de erro pro usuário. 
			cgilua.put("<br />Já existe símbolo do léxico ou sinônimo com o nome \""..nome_repetido.."\"!");
		end
		cgilua.put("<br />");

--@Episódio 4: Verificar o tipo de retorno de cgilua.POST.lista_de_sinonimos.Se o tipo for nil é porque não foi inserido nenhum sinônimo.
	--Se o tipo for string é porque apenas um sinônimo foi inserido. Se o tipo for table é porque mais de um sinônimo foi inserido.
				
		local lista_de_sinonimos = {}
		if (type(cgilua.POST.lista_de_sinonimos) == "string") then
			table.insert(lista_de_sinonimos,cgilua.POST.lista_de_sinonimos)
		else 
			lista_de_sinonimos = cgilua.POST.lista_de_sinonimos;
		end
		
--@Episódio 5: Se houver sinônimos então CHECAR SINÔNIMOS		
		if (lista_de_sinonimos ~= nil) then		
			ha_sinonimo = checar_sinonimos(lista_de_sinonimos, cgilua.POST.id_projeto);		
			if (ha_sinonimo == true) then
			
--@Episódio 6: Exibe mensagem de erro para o usuário se já tiver algum sinônimo com mesmo nome do símbolo que está sendo inserido.
				cgilua.put("<br />O símbolo do léxico não pôde ser incluido pois o nome de um de seus sinônimos".. 
				"é igual ao nome de um símbolo do léxico ou sinônimo pertencente ao mesmo projeto.");
			end--if
		else
			ha_sinonimo = false;
		end--if
						
--@Episódio 7: Se não há sinônimos nem léxicos com o nome do símbolo que está sendo cadastrado, então CADASTRAR LÉXICO
		if ((ha_lexico == false) and (ha_sinonimo == false)) then
			lexico_cadastrado = cadastrar_lexico(cgilua.POST.nome, lista_de_sinonimos, cgilua.POST.nocao, 
			cgilua.POST.impacto, cgilua.POST.classificacao, cgilua.POST.id_projeto);
			cgilua.redirect(cgilua.mkabsoluteurl("cel/visao/sucesso_lexico.lp"),{acao= "cadastrado"});	
		end
		
--@Episódio 8: Se cadastrado com sucesso redireciona para página de sucesso.

	elseif (cgilua.POST.comando == "remover") then

--@Episódio 9: Se comando é remover, então  REMOVER LÉXICO.
		
		remover_lexico(cgilua.POST.id_projeto, cgilua.POST.nome);
		
--@Episódio 10: Redireciona para página de sucesso.
		cgilua.redirect(cgilua.mkabsoluteurl("cel/visao/sucesso_lexico.lp"), {acao="removido"});
		
	elseif (cgilua.POST.comando == "alterar")then
	
--@Episódio 14: Se comando é alterar, então REMOVER LÉXICO
		remover_lexico(cgilua.POST.id_projeto, cgilua.POST.nome);
		
--@Episódio 15:  CADASTRAR LÉXICO 

		local lista_de_sinonimos = {}
		if (type(cgilua.POST.lista_de_sinonimos) ~= "nil") then
		
			if (type(cgilua.POST.lista_de_sinonimos) == "string") then
				table.insert(lista_de_sinonimos,cgilua.POST.lista_de_sinonimos)
			else 
				lista_de_sinonimos = cgilua.POST.lista_de_sinonimos;
			end
		end
		
		lexico_cadastrado = cadastrar_lexico(cgilua.POST.nome, lista_de_sinonimos, cgilua.POST.nocao, 
				cgilua.POST.impacto, cgilua.POST.classificacao, cgilua.POST.id_projeto);
		cgilua.redirect(cgilua.mkabsoluteurl("cel/visao/sucesso_lexico.lp"),{acao = "alterado"})
	end
?>

</body>
</html>
