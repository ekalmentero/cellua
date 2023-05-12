dofile("../dao/usuario_dao.lua");
require("md5.core");
--[[
@Titulo: Cadastrar usuário.
@Objetivo: Cadastrar os dados informados pelo usuário.
@Contexto: Exibir página de cadastro de novo usuário.
@Atores: inserir_usuario_bd, selecionar_usuario_bd.
@Recursos: banco de dados, dados do usuário (nome, sobrenome, instituição, 
login, senha).
]]--

function cadastrar_usuario (nome, sobrenome, email, instituicao, login, senha)
	
--@Episódio 1: Criptografa a senha fornecida no formulário do usuário.
	senha_criptografada = md5.sum(senha);

--@Episódio 2: INSERIR USUÁRIO NO BANCO DE DADOS.
	inserir_usuario_bd(nome, sobrenome, email, instituicao, login, senha_criptografada);

--@Episódio 3: SELECIONAR USUARIO NO BANCO DE DADOS.	
	usuarios = selecionar_usuario_bd (login);
	
--@Episódio 4: Recupera o id do usuário que acabou de ser inserido e o retorna.
	for index, usuario in pairs(usuarios) do
		id_usuario = usuario["ID_USUARIO"];
		return id_usuario;
	end

	
end 

--[[
@Titulo: Checar login usuário
@Objetivo: Verificar se o login escolhido pelo novo usuário já está cadastrado no banco de dados
@Contexto: Usuário preenche o formulário de cadastro e o submete.
@Atores: usuário.
@Recursos:  usuario_dao.lua
]]--

function checar_login_usuario(login)

--@Episódio 1: SELECIONAR USUARIO NO BANCO DE DADOS.
	usuarios = selecionar_usuario_bd(login);

--@Episódio 2: Se a consulta retornou resultado retorna true, senão retorna false.
	if (#usuarios > 0) then
		return true;
	else
		return false;

	end
end	

--[[
@Titulo: Checar usuário
@Objetivo: Checar se o usuário forneceu os dados login e senha corretos.
@Contexto: Usuário deseja se logar no sistema
@Atores: usuário.
@Recursos: md5.core, usuario_dao.lua
]]--
function checar_usuario (login, senha)

--@Episódio 1: SELECIONAR USUARIO NO BANCO DE DADOS.
	usuarios = selecionar_usuario_bd(login);
	local id_usuario;
	
--@Episódio 2: Se a consulta não retornou nenhum usuário, retorna false.
	if(#usuarios == 0 )then
		return false;
	else	
--@Episódio 3: Se a consulta retornou um resultado, então o sistema armazena a senha e o id do usuário encontrado.
		senha_recuperada = "";
		for index, usuario in pairs(usuarios) do
			senha_recuperada = usuario["SENHA"];
			id_usuario = usuario["ID_USUARIO"];
		end 
		
--@Episódio 4: A senha informada no formulário de login é criptografada e comparada com a senha recuperada do banco de dados.		
		senha_criptografada = md5.sum(senha);

--@Episódio 5: Se as senhas forem iguais, então retorna o id do usuário e true.			
		if (senha_criptografada == senha_recuperada) then
			return true, id_usuario;
		else
--@Episódio 6: Se as senhas forem diferentes retorna false.
			return false;
		end
		
	end
end
