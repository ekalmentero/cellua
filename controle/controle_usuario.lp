<?lua
--[[
@Titulo: Controle usu�rio.
@Objetivo: Intermediar a comunica��o entre a camda de vis�o e controle do
m�dulo usu�rio.
@Contexto: cadastrar_usuario.html, alterar_dados.lp, lembrar_senha.html,
index.html, principal.lp.
@Atores: CHECAR LOGIN, CADASTRAR_USUARIO, CHECAR_USUARIO, LEMBRAR_SENHA.
@Recursos: dados do usu�rio.
]]--
	dofile("../modelo/modelo_usuario.lua")
	cgilua.enablesession();
?>
<html>
<head>
</head>
<body>
<?lua
	if (cgilua.POST.comando == "cadastrar") then
	
--@Epis�dio 2: Se o comando for cadastrar CHECAR LOGIN	.
		local ha_usuario = checar_login_usuario(cgilua.POST.login);
		if(ha_usuario) then 
			cgilua.put("Login j� existente, por favor escolha outro login!");
		else
--@Epis�dio 3: Se o login n�o se encontra no banco de dados ent�o CADASTRAR_USUARIO. Restri��o CHECAR LOGIN. 
			local id_usuario = cadastrar_usuario(cgilua.POST.nome, cgilua.POST.sobrenome, cgilua.POST.email, cgilua.POST.instituicao, cgilua.POST.login, cgilua.POST.senha);

--@Epis�dio 4: Cria uma sess�o e salva o id do usu�rio nela.
			cgilua.enablesession();
			cgilua.session.data = {["ID_USUARIO"] = id_usuario}
			
--@Epis�dio 5: Monta o link passando as informa��es referentes a sess�o e redireciona para a p�gina principal
			link_principal = cgilua.mkurlpath(cgilua.mkabsoluteurl("cel/visao/principal.lp"));
			link_principal = string.sub(link_principal, 35);
			cgilua.redirect(link_principal);
		end
	elseif (cgilua.POST.comando == "logar") then
		
--@Epis�dio 6: Se o comando for logar ent�o CHECAR_USUARIO.
		usuario_valido, id_usuario = checar_usuario(cgilua.POST.login, cgilua.POST.senha);

--@Epis�dio 7: Se o login e a senha fornecidos estiverem corretos,  o sistema cria uma sess�o e salva o id do usu�rio nela.
		if (usuario_valido) then
			cgilua.enablesession();
			cgilua.session.data = {["ID_USUARIO"] = id_usuario}
			
--@Epis�dio 8: Monta o link passando as informa��es referentes a sess�o e redireciona para a p�gina principal
			link_principal = cgilua.mkurlpath(cgilua.mkabsoluteurl("cel/visao/principal.lp"));
			link_principal = string.sub(link_principal, 35);
			cgilua.redirect(link_principal);
			
		
		else
--@Epis�dio 9: Se o login e a senha fornecidos forem inv�lidos exibe uma mensagem de erro na tela.
			cgilua.put("Login ou/e senha errado(s), por favor tente novamente!");
		end	
	end
?>
</body>
</html>
