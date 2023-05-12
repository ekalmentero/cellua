dofile("../dao/cenario_dao.lua");
require("md5.core");

--[[
@Titulo: Cadastrar cenário.
@Objetivo: Cadastrar cenário no sistema.
@Contexto: A camada controle chama a função cadastrar_cenario.
@Atores: browser e usuário.
@Recursos: cenario_dao.lua.
]]--

function cadastrar_cenario(titulo, objetivo, contexto, atores, recursos, episodios, excecao, projeto)

--@Episódio 1: Obtém do sistema a data em que esta sendo feito o cadastro.
	data = os.date("%Y-%m-%d %H:%M:%S"); 
	
--@Episódio 2: INSERIR CENÁRIO NO BANCO DE DADOS
	resultado = inserir_cenario_bd(titulo, objetivo, contexto, atores, recursos, episodios, excecao, data, projeto);
	
--@Episódio 2: Retornar o resultado da inserção.
	return resultado;

end

--[[
@Titulo: Remover cenário.
@Objetivo: Remover cenário do sistema.
@Contexto: A camada controle chama a função remover_cenario.
@Atores: browser e usuário.
@Recursos: cenario_dao.lua.
]]--


function remover_cenario(id_projeto, titulo)

--@Episódio 1: REMOVER CENARIO DO BANCO DE DADOS .
	removido = remover_cenario_bd(id_projeto, titulo);
	
--@Episódio 2: Retorna resultado da remoção.
	return removido;

end

--[[
@Titulo: Checar cenário.
@Objetivo: Verificar se um cenário já esta cadastrado no banco de dados.
@Contexto: A camada controle chama a função checar_cenario.
@Atores: browser e usuário.
@Recursos: cenario_dao.lua.
]]--



function checar_cenario(id_projeto, titulo)

--@Episódio 1: SELECIONAR CENÁRIO DO BANCO DE DADOS 
	cenarios = selecionar_cenario_bd(id_projeto, titulo);

--@Episódio 2: Se nenhum cenário for enontrado retorna false, senão retorna true.	
	if (#cenarios == 0) then
		return false;
	else 	
		return true;
	end
	
	return false;
		
end

--[[
@Titulo:  Selecionar todos os cenários
@Objetivo: Selecionar todos os cenários de um determinado projeto.
@Contexto: A camada controle chama a função selecionar_todos_cenarios.
@Atores: browser e usuário.
@Recursos: cenario_dao.lua.
]]--


function selecionar_todos_cenarios (id_projeto)

--@Episódio 1:  SELECIONAR TODOS OS CENÁRIOS DO BANCO DE DADOS.
	cenarios = selecionar_todos_cenarios_bd(id_projeto);
--@Episódio 2: Os cenários obtidos são retonados.
	return cenarios;
	
end

--[[
@Titulo:  Selecionar cenário.
@Objetivo: Obter todas as informações de um determinado cenário, identificado pelo id do projeto e pelo título.
@Contexto: A camada controle chama a função selecionar_cenário.
@Atores: browser e usuário.
@Recursos: cenario_dao.lua.
]]--

function selecionar_cenario (id_projeto, titulo)

--@Episódio 1: SELECIONAR CENÁRIO DO BANCO DE DADOS.
	cenario = selecionar_cenario_bd(id_projeto, titulo);
--@Episódio 2: As informações obtidas são retornadas.
	return cenario;
end


