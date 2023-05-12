dofile("../dao/projeto_dao.lua");
dofile("../dao/cenario_dao.lua");
dofile("../dao/lexico_dao.lua");
require("md5.core");

--[[
@Titulo:  Cadastrar administrador.
@Objetivo: Incluir administrador do projeto cadastrado.
@Contexto: CADASTRAR PROJETO.
@Atores: inserir_administrador_bd
@Recursos: id do usuário, id do projeto.
]]--

function cadastrar_administrador(id_projeto, id_usuario)

--@Episódio 1: INSERIR ADMINISTRADOR NO BANCO DE DADOS
	resultado_insercao = inserir_administrador_bd(id_projeto, id_usuario);

--@Episódio 2: Retorna o resultado da inserção.
	return resultado_insercao;

end


--[[
@Titulo:  Cadastrar colaborador.
@Objetivo: Incluir colaborador, com nível de permissão selecionado, no projeto.
@Contexto: 
@Atores: 
@Recursos: id do usuário, id do projeto, tipo de permissão.
]]--

--@Episódio 1:
function cadastrar_colaborador()


end

--[[
@Titulo:  Selecionar projeto.
@Objetivo: Obter as informações sobre um projeto específico
@Contexto: A camada controle chama a função selecionar_projeto.
@Atores: browser e usuário.
@Recursos: projeto_dao.lua.
]]--

function selecionar_projeto (id_projeto)

--@Episódio 1: SELECIONAR PROJETO DO BANCO DE DADOS.
	projeto = selecionar_projeto_bd(id_projeto);

--@Episódio 2: Retorna informações do projeto
	return projeto;

end


--[[
@Titulo:  Selecionar projetos.
@Objetivo: Selecionar todos os projetos de um determinado usuário.
@Contexto: A camada controle chama a função selecionar_projetos.
@Atores: browser e usuário.
@Recursos: projeto_dao.lua.
]]--


function selecionar_projetos (id_usuario)

--@Episódio 1: SELECIONAR PROJETOS DO BANCO DE DADOS.
	projetos = selecionar_projetos_bd (id_usuario);

--@Episódio 2: Retorna a lista de projetos.
	return projetos;

end

--[[
@Titulo: Cadastrar projeto.
@Objetivo: Cadastrar o projeto no sistema
@Contexto: O usuário submete o formulário de cadastro de projeto.
@Atores: usuário.
@Recursos:  projeto_dao.lua
]]--

function cadastrar_projeto(nome, descricao, id_usuario)

--@Episódio 1: Obtém do sistema a data em que esta sendo feito o cadastro.
	data = os.date("%Y-%m-%d %H:%M:%S"); 
	
--@Episódio 2: INSERIR PROJETO NO BANCO DE DADOS
	local id_projeto_inserido = inserir_projeto_bd(nome, descricao, data, id_usuario);
	
--@Episódio 3: Retorna id do projeto inserido
	return id_projeto_inserido;	

end 

--[[
@Titulo: Contar palavras do texto.
@Objetivo: Contar o número de palavras existentes em um texto.
@Contexto: 
@Atores: 
@Recursos: Texto em que as palavras serão contadas (texto)  
]]--
function conta_palavras(texto)

--@Episódio 1: Inicializa o contador de palavras com o valor 0.
	local contador_palavras = 0;

--@Episódio 2: Para cada caracter alfanumerico seguido de um ou mais caracteres 
	--alfanúmericos (%w+) o contador de palavras é incrementado de 1.	
	for palavra in string.gmatch(texto, "%w+") do
		contador_palavras = contador_palavras+1;
	end
	
--@Episódio 3: Retorna o número de palavras encontrados
	return contador_palavras;
end

--[[
@Titulo: Particionar tabela.
@Objetivo: Organizar a tabela, escolher o pivô e particiona-la (partition do quicksort).
@Contexto: a função particao é chamada
@Atores: usuário.
@Recursos:  
]]--

function particao( elementos, inicio, fim, tipo )
	
--@Episódio 1: Inicializa as variáveis i, j e dir.
    i = inicio;
    j = fim;
    dir = 1;
    
    while( i < j ) do
	
--@Episódio 2: Enquanto i < j percorre a tabela elementos.
    	if(tipo == "cenario") then

--@Episódio 3: Se tipo igual a cenário, então se CONTA PALAVRAS do elemento na posição i for menor que CONTA PALAVRAS do elemento na posição j, então eles são trocados.
    		if( conta_palavras( elementos[i]["TITULO"] ) < conta_palavras( elementos[j]["TITULO"] ) ) then
	        
				temporario = elementos[i];
	            elementos[i] = elementos[j];
	            elementos[j] = temporario;
	            dir = dir -1;
	        end	
    	
		else
--@Episódio 4: Se tipo igual a lexico, então se CONTA PALAVRAS do elemento na posição i for menor que CONTA PALAVRAS do elemento na posição j, então eles são trocados.	    
			if( conta_palavras( elementos[i]["NOME"] ) < conta_palavras( elementos[j]["NOME"] ) ) then
	        
				temporario = elementos[i];
	            elementos[i] = elementos[j];
	            elementos[j] = temporario;
	            dir = dir - 1;
			end	
				
	  	end
--@Episódio 5: Se não houve nenhuma troca, isto é, se dir diferente igual a 1, então a variável j é decrementada de 1, senão a variável i é incrementada de 1.
        if( dir == 1 ) then
            j = j - 1;
        else
            i = i + 1;
		end	
    end
--@Episódio 6: Retorna o valor da variável i.
    return i;
	
end

--[[
@Titulo: Ordenar a tabela.
@Objetivo: Ordena a tabela colocando as palavras compostas de mais palavras na frente.
@Contexto: a função ordena_tabela é chamada
@Atores: usuário.
@Recursos:  
]]--


function ordena_tabela(tabela, inicio, fim, tipo )

    
	if( inicio < fim ) then
--@Episódio 1:  Se inicio < fim, então PARTICIONAR TABELA
        pivo = particao(tabela, inicio, fim, tipo );
		
--@Episódio 2: Chama recursivamente a funcao ordena_tabela para a primeira  metade da tabela.
	    ordena_tabela( tabela, inicio, pivo-1, tipo );
		
--@Episódio 3: Chama recursivamente a funcao ordena_tabela para a segunda  metade da tabela.
        ordena_tabela( tabela, pivo+1, fim, tipo );
    
	end
	
--@Episódio 4: retorna a tabela ordenada
	return tabela;
	
end	

--[[
@Titulo: Colocar atalhos no texto
@Objetivo: Substituir a ocorrência de nomes de termos do léxico e seus sinônimos ou de títulos de cenários, já castrados no projeto, por um atalho que leve para definição 
do termo ou para descrição do cenário. Para tanto, cada elemento cadastrado no projeto (termos do léxico e cenários) é procurado no texto, caso alguma ocorrência seja encontrada
 é criado um atalho no texto para definição deste elemento.
@Contexto: O usuário deve possuir um projeto com pelo menos um elemento cadastrado.
@Atores: Usuário.
@Recursos: Identificador do projeto (parâmetro id_projeto), texto em que os elementos serão procurados (parâmetro texto), tipo de elemento que foi selecionado pelo usuário: 
termo do léxico ou cenário (parâmetro tipo) e banco de dados.   
]]--

	
function colocar_atalhos (id_projeto, texto, tipo)

--@Episódio 1: SELECIONAR TODOS OS LEXICOS DO BANCO DE DADOS
	local lexicos = selecionar_todos_lexicos_bd(id_projeto);
	
--@Episódio 2: SELECIONAR TODOS OS SINÔNIMOS DO BANCO DE DADOS
	local sinonimos = selecionar_sinonimos_projeto_bd(id_projeto);

--@Episódio 3: SELECIONAR TODOS OS CENÁRIOs DO BANCO DE DADOS
	local cenarios = selecionar_todos_cenarios_bd(id_projeto);
	
--@Episódio 4: Criar uma tabela única, contendo nome dos termos do léxico e seus siônimos.
	for index, sinonimo in pairs(sinonimos) do
		table.insert(lexicos, sinonimo);
	end 
	local lexicos_e_sinonimos = lexicos;
	
--@Episódio 5: ORDENAR TABELA sinonimos.
	sinonimos = ordena_tabela(sinonimos, 1, table.maxn(sinonimos) ,"lexico" )
	
--@Episódio 6: ORDENAR TABELA cenários
	cenarios =  ordena_tabela(cenarios, 1, table.maxn(cenarios) ,"cenario" )
	
--@Episódio 7: ORDENAR TABELA lexicos_e_sinonimos.	
	lexicos_e_sinonimos = ordena_tabela(lexicos_e_sinonimos, 1, table.maxn(lexicos_e_sinonimos),"lexico" )
	
--@Episódio 8: Obter o tamanho da tabela lexicos_e_sinonimos, da tabela cenários e o total que corresponde a soma dos tamanhos das duas tabelas.
	local tam_lexicos_e_sinonimos = #lexicos_e_sinonimos;
	local tam_cenarios = #cenarios;
	local tam_total = tam_lexicos_e_sinonimos + tam_cenarios ;
	
--@Episódio 9: Criar tabelas que irão armazenar os links criados para termos do léxico e para cenários.	
	local tabela_links_lexico = {};
	local tabela_links_cenario = {};
	
	if ((tipo == "lexico") or (tam_cenarios == 0)) then
--@Episódio 10: Se não há cenários cadastrados no projeto então apenas a lista de lexicos e sinônimos será percorrida.
		for index, lexico in pairs(lexicos_e_sinonimos) do

--@Episódio 11: A variável nome_lexico recebe o nome do termo do léxico ou sinônimo que está sendo verificado no momento.
			local nome_lexico = lexico["NOME"];
			
--@Episódio 12: Uma expressão regular é montada com o nome do termo do léxico ou sinônimo. Esta expressão regular evita erros devido a pontuação e espaços em branco na hora
	--da busca.			
			local expressao_regular = "([%p%s])"..nome_lexico.."([%p%s])";

			if (string.find(texto, expressao_regular) ~= nil) then
			
				local nome_lexico_link = "";
--@Episódio 13: Se alguma ocorrência da expressão regular for encontrada no texto, então está expressão é substituida pelo código (wzzxk*kxy), onde o * será substituido
	-- por um número que identificará a posição do termo do léxico ou sinônimo na tabela léxicos e sinônimos.
				texto = string.gsub(texto, expressao_regular, "%1".."wzzxk"..index.."kxy".."%2");

--@Episódio 14: Verifica se a expressão encontrada é realmente um termo do léxico ou é um sinônimo de um termo do léxico. 
				if (lexico["LEXICO"] ~= nil) then
				
--@Episódio 15: Se a expressão encontrada for um sinônimo então o nome_lexico_link deve armazenar o nome do termo do léxico a que pertence o sinônimo. Isto é feito para que
	-- possamos criar um atalho para o termo do léxico a que o sinônimo corresponde.
					nome_lexico_link = lexico["LEXICO"]
				else
				
--@Episódio 16: Se a expressão encontrada for um termo do léxico então o nome_lexico_link deve armazenar o nome do termo do léxico.
					nome_lexico_link = nome_lexico;
				end	
--@Episódio 17:  Criar o atalho para a expressão encontrada no texto.
				link = "<a title=\"Léxico\" href=\"../visao/exibe_lexico.lp?id_projeto="..id_projeto.."&nome="..nome_lexico_link.."\">"..nome_lexico.."</a>";

--@Episódio 18: Inserir o atalho criado na tabela_links_lexico na mesma posição que o elemento encontrado ocupa na tabela lexicos_e_sinonimos. Isto permitirá que identifiquemos 
	-- a que código (wzzxk*kxy) do texto este atalho corresponde.
				table.insert(tabela_links_lexico, index, link);
			end --if
				
	    end --for
	
	else	
	
		if (tam_lexicos_e_sinonimos == 0 and tam_cenarios > 0) then
		
--@Episódio 19: Se não há léxicos no projeto então apenas a lista de cenários será percorrida
			for index, cenario in pairs(cenarios) do
			
--@Episódio 20: A variável nome_cenario recebe o título do cenário que está sendo verificado no momento.
		        nome_cenario = cenario["TITULO"];
				
--@Episódio 21: Uma expressão regular é montada como título do cenário. Esta expressão regular evita erros devido a pontuação e espaços em branco na hora da busca.
				expressao_regular = "([%p%s])"..nome_cenario.."([%p%s])";
							
				if (string.find(texto, expressao_regular) ~= nil) then
				
--Episódio 22: Se alguma ocorrência de expressão regular for encontrada no texto, então um atalho é montado com o nome do cenário.
					link = "<a title=\"Cenário\" href=\"../visao/exibe_cenario.lp?id_projeto="..id_projeto.."&titulo="..titulo_cenario.."&comando=exibir\">"..titulo_cenario.."</a>";
					
--Episódio 23: O atalho montado montado é inserido na tabela_links_)cenario na mesma posição que o título do cenário encontrado ocupa na tabela cenarios.
					table.insert(tabela_links_cenario, index, link);
					
--@Episódio 24:  A expressão é substituida pelo código (wzczxk*kxyyc), onde o * será substituido por um número que identificará a posição do título do cenário na tabela cenários.
					texto = string.gsub(texto, expressao_regular, "%1".."wzczxk"..i.."kxyyc".."%2");
				end --if
				
		    end	-- for
		
		elseif (tam_total > 0) then
		
--@Episódio 25: Se há léxicos e cenários no projeto então tanto a tabela cenarios quanto a lexicos_e_sinonimos serão percorridas.	
			i = 1;
			j = 1;
			contador = 1;
			while (contador <= tam_total) do
				
--@Episódio 26: Verifica se a tabela cenarios e a tabela lexicos_e_sinonimos já foram percorridas.
				if ( ( i <= tam_lexicos_e_sinonimos ) and (j <= tam_cenarios) ) then
					
--@Episódio 27:  Se a tabela cenarios ainda não foi completamente percorrida e a tabela lexicos_e_sinonimos também não foi completamente percorrida
	--então CONTAR PALAVRAS do título do cenário e CONTAR PALAVRAS do nome do léxico ou sinônimo.
					if ( conta_palavras(cenarios[j]["TITULO"]) <= conta_palavras(lexicos_e_sinonimos[i]["NOME"]) ) then
					    
--@Episódio 28:  Se o título do cenário atual possui um número menor ou igual de palavras que o nome do termo do léxico, então procuraremos a ocorrência deste léxico no texto.
						nome_lexico = lexicos_e_sinonimos[i]["NOME"];
						
--@Episódio 29:  Uma expressão regular é criada com o nome do termo do léxico atual. Esta expressão regular impede que erros sejam causados por causa da pontuação e espaços em branco.					
						expressao_regular = "([%p%s])"..nome_lexico.."([%p%s])";
						
						if( string.gfind(texto, expressao_regular) ~= nil ) then
						
--@Episódio 30:  Se uma ocorrência da expressão regular é encontrada no texto então a expressão é substituida pelo código (wzzxk*kxy), onde o * será substituido por um número
	-- que identificará a posição do nome do termo do léxico ou sinônimo na tabela lexicos_e_sinonimos.
							texto = string.gsub(texto, expressao_regular, "%1".."wzzxk"..i.."kxy".."%2");
							
--@Episódio 31: É feita um verificaão para saber se o termo encontrado é um termo do léxico ou um sinônimo de um termo do léxico. 
							if (lexicos_e_sinonimos[i]["LEXICO"] ~= nil) then

--@Episódio 32: Se o elemento encontrado for um sinônimo então o termo do léxico a que este sinônimo corresponde é armazenado na variável nome_lexico_link. Caso contrário,
	-- se o elemento encontrado for um termo do léxico, então ele é armazenado na variável nome_léxico.
								nome_lexico_link = lexicos_e_sinonimos[i]["LEXICO"];
							else
								nome_lexico_link = nome_lexico;
							end	
							
--@Episódio 33:  Um atalho para o termo encontrado é criado  e colocado na tabela links_lexico, na mesma posição que o léxico atual ocupa na tabela lexicos e sinônimos.
	--Isto permitirá que identifiquemos a que código (wzzxk*kxy) do texto este atalho corresponde.							
							link = "<a title=\"Léxico\" href=\"../visao/exibe_lexico.lp?id_projeto="..id_projeto.."&nome="..nome_lexico_link.."\">"..nome_lexico.."</a>";
							table.insert(tabela_links_lexico, i, link);
						end --if
						i = i + 1;
						
					else --if
--@Episódio 34:  Se o título do cenário atual possui um maior de palavras que o nome do léxico atual, então procuraremos a ocorrência do título deste cenário no texto.
						titulo_cenario = cenarios[j]["TITULO"];

--@Episódio 35:  Uma expressão regular é criada com o título do cenário atual. Esta expressão regular impede que erros sejam causados por causa da pontuação e espaços em branco.								
						expressao_regular = "([%p%s])"..titulo_cenario.."([%p%s])";
												
						if( string.gfind(texto, expressao_regular) ~= nil ) then
						
--@Episódio 36:  Caso encontremos uma ocorrência do cenário atual no texto, um atalho será criado e armazenado no tabela tabela_links_cenario, na mesma posição que o cenário atual
	-- ocupa na tabela cenários.
							link = "<a title=\"Cenário\" href=\"../visao/exibe_cenario.lp?id_projeto="..id_projeto.."&titulo="..titulo_cenario.."\">"..titulo_cenario.."</a>";
							table.insert(tabela_links_cenario, j, link);
							
--@Episódio 37:  A expressão é substituida pelo código (wzczxk*kxyyc), onde o * será substituido por um número que identificará a posição do título do cenário na tabela cenários.							
							texto = string.gsub(texto, expressao_regular, "%1".."wzczxk"..j.."kxyyc".."%2");
										
						end --if
						j = j + 1;
					
					end --if
			
				elseif( tam_lexicos_e_sinonimos == i-1 ) then
				
--@Episódio 38:  Se a tabela de termos do léxico chegou ao fim e a tabela de cenários ainda possui cenários que ainda não foram procurados, então devemos continuar percorrendo
	-- apenas a tabela cenários.			 
					titulo_cenario = cenarios[j]["TITULO"];
			
--@Episódio 39:  Uma expressão regular é criada com o título do cenário atual. Esta expressão regular impede que erros sejam causados por causa da pontuação e espaços em branco.								
					expressao_regular = "([%p%s])"..titulo_cenario.."([%p%s])";
					
					if( string.gfind(texto, expressao_regular) ~= nil ) then
					
--@Episódio 40:   Caso seja encontrada uma ocorrência do cenário atual no texto, um atalho será criado e armazenado no tabela tabela_links_cenario, na mesma posição que o cenário atual
	-- ocupa na tabela cenários. 	
						link = "<a title=\"Cenário\" href=\"../visao/exibe_cenario.lp?id_projeto="..id_projeto.."&titulo="..titulo_cenario.."\">"..titulo_cenario.."</a>";
						table.insert(tabela_links_cenario, j, link);
						
--@Episódio 41:  A expressão é substituida pelo código (wzczxk*kxyyc), onde o * será substituido por um número que identificará a posição do título do cenário na tabela cenários.						
						texto = string.gsub(texto, expressao_regular, "%1".."wzczxk"..j.."kxyyc".."%2"); 						
							
					end --if
					
				elseif( tam_cenarios == j-1 )	then

--@Episódio 42:  Se a tabela de cenários chegou ao fim e a tabela lexicos_e_sinonimos ainda possui elementos que ainda não foram procurados, então devemos continuar percorrendo
	--apenas a tabela lexicos_e _sinonimos.						
					nome_lexico = lexicos_e_sinonimos[i]["NOME"];

--@Episódio 43:  Uma expressão regular é criada com o termo do léxico atual. Esta expressão regular impede que erros sejam causados por causa da pontuação e espaços em branco.							
					expressao_regular = "([%p%s])"..nome_lexico.."([%p%s])";
					
					if( string.gfind(texto, expressao_regular) ~= nil ) then
					
--@Episódio 44:   Caso seja encontrada uma ocorrência do termo do léxico atual no texto, A expressão é substituida pelo código (wzzxk*kxy), onde o * será substituido por um número 
	--que identificará a posição do nome do termo do léxico na tabela léxicos.	
						texto = string.gsub(texto, expressao_regular, "%1".."wzzxk"..i.."kxy".."%2");
												
						if (lexicos_e_sinonimos[i]["LEXICO"] ~= nil) then
						
--@Episódio 45: Se o elemento encontrado for um sinônimo então o termo do léxico a que este sinônimo corresponde é armazenado na variável nome_lexico_link. Caso contrário,
	-- se o elemento encontrado for um termo do léxico, então ele é armazenado na variável nome_léxico.						
						nome_lexico_link = lexicos_e_sinonimos[i]["LEXICO"];
						else
							nome_lexico_link = nome_lexico;
						end	
						
--@Episódio 46: Um atalho para o termo do léxico encontrado é criado e armazenado no tabela tabela_links_lexico, na mesma posição que o léxico atual
						link = "<a title=\"Léxico\" href=\"../visao/exibe_lexico.lp?id_projeto="..id_projeto.."&nome="..nome_lexico_link.."\">"..nome_lexico.."</a>";
						table.insert(tabela_links_lexico, i, link); 
							
					end --if
					
					i = i + 1;
				
				end --if
				contador = contador + 1;
			
			end --while
			
		end --if
	end--if
	
	contador = 1;

--@Episódio 47:  A tabela links lexico é percorrida e os códigos inseridos anteriormente nos texto são substituidos pelos links armazenados na tabela. 
	--O número que se encontra no meio do código corresponde a posição na tabela de links que o atalho que será inserido se encontra.
	for i, link in pairs(tabela_links_lexico) do
		expressao_regular = ("([%p%s])".."wzzxk"..i.."kxy".."([%p%s])");
		texto = string.gsub(texto, expressao_regular, "%1"..link.."%2");
	end
--@Episódio 48:  A tabela links cenários é percorrida e os códigos inseridos anteriormente nos texto são substituidos pelos links armazenados na tabela. 
	--O número que está no meio do código corresponde a posição na tabela de links que o atalho que será inserido se encontra.
	for i, link in pairs(tabela_links_cenario) do
		expressao_regular = ("([%p%s])".."wzczxk"..i.."kxyyc".."([%p%s])");
		texto = string.gsub(texto, expressao_regular, "%1"..link.."%2");
	end
--@Episódio 49:  O texto com os links é exibido para o usuário.
	cgilua.put(texto);	
	
end	

	







