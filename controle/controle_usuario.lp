<?lua
--[[
@Titulo: Controle usuário.
@Objetivo: Intermediar a comunicação entre a camda de visão e controle do
módulo usuário.
@Contexto: cadastrar_usuario.html, alterar_dados.lp, lembrar_senha.html,
index.html, principal.lp.
@Atores: CHECAR LOGIN, CADASTRAR_USUARIO, CHECAR_USUARIO, LEMBRAR_SENHA.
@Recursos: dados do usuário.
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
	
--@Episódio 2: Se o comando for cadastrar CHECAR LOGIN	.
		local ha_usuario = checar_login_usuario(cgilua.POST.login);
		if(ha_usuario) then 
			cgilua.put("Login já existente, por favor escolha outro login!");
		else
--@Episódio 3: Se o login não se encontra no banco de dados então CADASTRAR_USUARIO. Restrição CHECAR LOGIN. 
			local id_usuario = cadastrar_usuario(cgilua.POST.nome, cgilua.POST.sobrenome, cgilua.POST.email, cgilua.POST.instituicao, cgilua.POST.login, cgilua.POST.senha);

--@Episódio 4: Cria uma sessão e salva o id do usuário nela.
			cgilua.enablesession();
			cgilua.session.data = {["ID_USUARIO"] = id_usuario}
			
--@Episódio 5: Monta o link passando as informações referentes a sessão e redireciona para a página principal
			link_principal = cgilua.mkurlpath(cgilua.mkabsoluteurl("cel/visao/principal.lp"));
			link_principal = string.sub(link_principal, 35);
			cgilua.redirect(link_principal);
		end
	elseif (cgilua.POST.comando == "logar") then
		
--@Episódio 6: Se o comando for logar então CHECAR_USUARIO.
		usuario_valido, id_usuario = checar_usuario(cgilua.POST.login, cgilua.POST.senha);

--@Episódio 7: Se o login e a senha fornecidos estiverem corretos,  o sistema cria uma sessão e salva o id do usuário nela.
		if (usuario_valido) then
			cgilua.enablesession();
			cgilua.session.data = {["ID_USUARIO"] = id_usuario}
			
--@Episódio 8: Monta o link passando as informações referentes a sessão e redireciona para a página principal
			link_principal = cgilua.mkurlpath(cgilua.mkabsoluteurl("cel/visao/principal.lp"));
			link_principal = string.sub(link_principal, 35);
			cgilua.redirect(link_principal);
			
		
		else
--@Episódio 9: Se o login e a senha fornecidos forem inválidos exibe uma mensagem de erro na tela.
			cgilua.put("Login ou/e senha errado(s), por favor tente novamente!");
		end	
	end
?>
</body>
</html>
