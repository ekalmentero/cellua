dofile("../dao/projeto_dao.lua");
dofile("../dao/cenario_dao.lua");
dofile("../dao/lexico_dao.lua");
require("md5.core");

--[[
@Titulo:  Cadastrar administrador.
@Objetivo: Incluir administrador do projeto cadastrado.
@Contexto: CADASTRAR PROJETO.
@Atores: inserir_administrador_bd
@Recursos: id do usu�rio, id do projeto.
]]--

function cadastrar_administrador(id_projeto, id_usuario)

--@Epis�dio 1: INSERIR ADMINISTRADOR NO BANCO DE DADOS
	resultado_insercao = inserir_administrador_bd(id_projeto, id_usuario);

--@Epis�dio 2: Retorna o resultado da inser��o.
	return resultado_insercao;

end


--[[
@Titulo:  Cadastrar colaborador.
@Objetivo: Incluir colaborador, com n�vel de permiss�o selecionado, no projeto.
@Contexto: 
@Atores: 
@Recursos: id do usu�rio, id do projeto, tipo de permiss�o.
]]--

--@Epis�dio 1:
function cadastrar_colaborador()


end

--[[
@Titulo:  Selecionar projeto.
@Objetivo: Obter as informa��es sobre um projeto espec�fico
@Contexto: A camada controle chama a fun��o selecionar_projeto.
@Atores: browser e usu�rio.
@Recursos: projeto_dao.lua.
]]--

function selecionar_projeto (id_projeto)

--@Epis�dio 1: SELECIONAR PROJETO DO BANCO DE DADOS.
	projeto = selecionar_projeto_bd(id_projeto);

--@Epis�dio 2: Retorna informa��es do projeto
	return projeto;

end


--[[
@Titulo:  Selecionar projetos.
@Objetivo: Selecionar todos os projetos de um determinado usu�rio.
@Contexto: A camada controle chama a fun��o selecionar_projetos.
@Atores: browser e usu�rio.
@Recursos: projeto_dao.lua.
]]--


function selecionar_projetos (id_usuario)

--@Epis�dio 1: SELECIONAR PROJETOS DO BANCO DE DADOS.
	projetos = selecionar_projetos_bd (id_usuario);

--@Epis�dio 2: Retorna a lista de projetos.
	return projetos;

end

--[[
@Titulo: Cadastrar projeto.
@Objetivo: Cadastrar o projeto no sistema
@Contexto: O usu�rio submete o formul�rio de cadastro de projeto.
@Atores: usu�rio.
@Recursos:  projeto_dao.lua
]]--

function cadastrar_projeto(nome, descricao, id_usuario)

--@Epis�dio 1: Obt�m do sistema a data em que esta sendo feito o cadastro.
	data = os.date("%Y-%m-%d %H:%M:%S"); 
	
--@Epis�dio 2: INSERIR PROJETO NO BANCO DE DADOS
	local id_projeto_inserido = inserir_projeto_bd(nome, descricao, data, id_usuario);
	
--@Epis�dio 3: Retorna id do projeto inserido
	return id_projeto_inserido;	

end 

--[[
@Titulo: Contar palavras do texto.
@Objetivo: Contar o n�mero de palavras existentes em um texto.
@Contexto: 
@Atores: 
@Recursos: Texto em que as palavras ser�o contadas (texto)  
]]--
function conta_palavras(texto)

--@Epis�dio 1: Inicializa o contador de palavras com o valor 0.
	local contador_palavras = 0;

--@Epis�dio 2: Para cada caracter alfanumerico seguido de um ou mais caracteres 
	--alfan�mericos (%w+) o contador de palavras � incrementado de 1.	
	for palavra in string.gmatch(texto, "%w+") do
		contador_palavras = contador_palavras+1;
	end
	
--@Epis�dio 3: Retorna o n�mero de palavras encontrados
	return contador_palavras;
end

--[[
@Titulo: Particionar tabela.
@Objetivo: Organizar a tabela, escolher o piv� e particiona-la (partition do quicksort).
@Contexto: a fun��o particao � chamada
@Atores: usu�rio.
@Recursos:  
]]--

function particao( elementos, inicio, fim, tipo )
	
--@Epis�dio 1: Inicializa as vari�veis i, j e dir.
    i = inicio;
    j = fim;
    dir = 1;
    
    while( i < j ) do
	
--@Epis�dio 2: Enquanto i < j percorre a tabela elementos.
    	if(tipo == "cenario") then

--@Epis�dio 3: Se tipo igual a cen�rio, ent�o se CONTA PALAVRAS do elemento na posi��o i for menor que CONTA PALAVRAS do elemento na posi��o j, ent�o eles s�o trocados.
    		if( conta_palavras( elementos[i]["TITULO"] ) < conta_palavras( elementos[j]["TITULO"] ) ) then
	        
				temporario = elementos[i];
	            elementos[i] = elementos[j];
	            elementos[j] = temporario;
	            dir = dir -1;
	        end	
    	
		else
--@Epis�dio 4: Se tipo igual a lexico, ent�o se CONTA PALAVRAS do elemento na posi��o i for menor que CONTA PALAVRAS do elemento na posi��o j, ent�o eles s�o trocados.	    
			if( conta_palavras( elementos[i]["NOME"] ) < conta_palavras( elementos[j]["NOME"] ) ) then
	        
				temporario = elementos[i];
	            elementos[i] = elementos[j];
	            elementos[j] = temporario;
	            dir = dir - 1;
			end	
				
	  	end
--@Epis�dio 5: Se n�o houve nenhuma troca, isto �, se dir diferente igual a 1, ent�o a vari�vel j � decrementada de 1, sen�o a vari�vel i � incrementada de 1.
        if( dir == 1 ) then
            j = j - 1;
        else
            i = i + 1;
		end	
    end
--@Epis�dio 6: Retorna o valor da vari�vel i.
    return i;
	
end

--[[
@Titulo: Ordenar a tabela.
@Objetivo: Ordena a tabela colocando as palavras compostas de mais palavras na frente.
@Contexto: a fun��o ordena_tabela � chamada
@Atores: usu�rio.
@Recursos:  
]]--


function ordena_tabela(tabela, inicio, fim, tipo )

    
	if( inicio < fim ) then
--@Epis�dio 1:  Se inicio < fim, ent�o PARTICIONAR TABELA
        pivo = particao(tabela, inicio, fim, tipo );
		
--@Epis�dio 2: Chama recursivamente a funcao ordena_tabela para a primeira  metade da tabela.
	    ordena_tabela( tabela, inicio, pivo-1, tipo );
		
--@Epis�dio 3: Chama recursivamente a funcao ordena_tabela para a segunda  metade da tabela.
        ordena_tabela( tabela, pivo+1, fim, tipo );
    
	end
	
--@Epis�dio 4: retorna a tabela ordenada
	return tabela;
	
end	

--[[
@Titulo: Colocar atalhos no texto
@Objetivo: Substituir a ocorr�ncia de nomes de termos do l�xico e seus sin�nimos ou de t�tulos de cen�rios, j� castrados no projeto, por um atalho que leve para defini��o 
do termo ou para descri��o do cen�rio. Para tanto, cada elemento cadastrado no projeto (termos do l�xico e cen�rios) � procurado no texto, caso alguma ocorr�ncia seja encontrada
 � criado um atalho no texto para defini��o deste elemento.
@Contexto: O usu�rio deve possuir um projeto com pelo menos um elemento cadastrado.
@Atores: Usu�rio.
@Recursos: Identificador do projeto (par�metro id_projeto), texto em que os elementos ser�o procurados (par�metro texto), tipo de elemento que foi selecionado pelo usu�rio: 
termo do l�xico ou cen�rio (par�metro tipo) e banco de dados.   
]]--

	
function colocar_atalhos (id_projeto, texto, tipo)

--@Epis�dio 1: SELECIONAR TODOS OS LEXICOS DO BANCO DE DADOS
	local lexicos = selecionar_todos_lexicos_bd(id_projeto);
	
--@Epis�dio 2: SELECIONAR TODOS OS SIN�NIMOS DO BANCO DE DADOS
	local sinonimos = selecionar_sinonimos_projeto_bd(id_projeto);

--@Epis�dio 3: SELECIONAR TODOS OS CEN�RIOs DO BANCO DE DADOS
	local cenarios = selecionar_todos_cenarios_bd(id_projeto);
	
--@Epis�dio 4: Criar uma tabela �nica, contendo nome dos termos do l�xico e seus si�nimos.
	for index, sinonimo in pairs(sinonimos) do
		table.insert(lexicos, sinonimo);
	end 
	local lexicos_e_sinonimos = lexicos;
	
--@Epis�dio 5: ORDENAR TABELA sinonimos.
	sinonimos = ordena_tabela(sinonimos, 1, table.maxn(sinonimos) ,"lexico" )
	
--@Epis�dio 6: ORDENAR TABELA cen�rios
	cenarios =  ordena_tabela(cenarios, 1, table.maxn(cenarios) ,"cenario" )
	
--@Epis�dio 7: ORDENAR TABELA lexicos_e_sinonimos.	
	lexicos_e_sinonimos = ordena_tabela(lexicos_e_sinonimos, 1, table.maxn(lexicos_e_sinonimos),"lexico" )
	
--@Epis�dio 8: Obter o tamanho da tabela lexicos_e_sinonimos, da tabela cen�rios e o total que corresponde a soma dos tamanhos das duas tabelas.
	local tam_lexicos_e_sinonimos = #lexicos_e_sinonimos;
	local tam_cenarios = #cenarios;
	local tam_total = tam_lexicos_e_sinonimos + tam_cenarios ;
	
--@Epis�dio 9: Criar tabelas que ir�o armazenar os links criados para termos do l�xico e para cen�rios.	
	local tabela_links_lexico = {};
	local tabela_links_cenario = {};
	
	if ((tipo == "lexico") or (tam_cenarios == 0)) then
--@Epis�dio 10: Se n�o h� cen�rios cadastrados no projeto ent�o apenas a lista de lexicos e sin�nimos ser� percorrida.
		for index, lexico in pairs(lexicos_e_sinonimos) do

--@Epis�dio 11: A vari�vel nome_lexico recebe o nome do termo do l�xico ou sin�nimo que est� sendo verificado no momento.
			local nome_lexico = lexico["NOME"];
			
--@Epis�dio 12: Uma express�o regular � montada com o nome do termo do l�xico ou sin�nimo. Esta express�o regular evita erros devido a pontua��o e espa�os em branco na hora
	--da busca.			
			local expressao_regular = "([%p%s])"..nome_lexico.."([%p%s])";

			if (string.find(texto, expressao_regular) ~= nil) then
			
				local nome_lexico_link = "";
--@Epis�dio 13: Se alguma ocorr�ncia da express�o regular for encontrada no texto, ent�o est� express�o � substituida pelo c�digo (wzzxk*kxy), onde o * ser� substituido
	-- por um n�mero que identificar� a posi��o do termo do l�xico ou sin�nimo na tabela l�xicos e sin�nimos.
				texto = string.gsub(texto, expressao_regular, "%1".."wzzxk"..index.."kxy".."%2");

--@Epis�dio 14: Verifica se a express�o encontrada � realmente um termo do l�xico ou � um sin�nimo de um termo do l�xico. 
				if (lexico["LEXICO"] ~= nil) then
				
--@Epis�dio 15: Se a express�o encontrada for um sin�nimo ent�o o nome_lexico_link deve armazenar o nome do termo do l�xico a que pertence o sin�nimo. Isto � feito para que
	-- possamos criar um atalho para o termo do l�xico a que o sin�nimo corresponde.
					nome_lexico_link = lexico["LEXICO"]
				else
				
--@Epis�dio 16: Se a express�o encontrada for um termo do l�xico ent�o o nome_lexico_link deve armazenar o nome do termo do l�xico.
					nome_lexico_link = nome_lexico;
				end	
--@Epis�dio 17:  Criar o atalho para a express�o encontrada no texto.
				link = "<a title=\"L�xico\" href=\"../visao/exibe_lexico.lp?id_projeto="..id_projeto.."&nome="..nome_lexico_link.."\">"..nome_lexico.."</a>";

--@Epis�dio 18: Inserir o atalho criado na tabela_links_lexico na mesma posi��o que o elemento encontrado ocupa na tabela lexicos_e_sinonimos. Isto permitir� que identifiquemos 
	-- a que c�digo (wzzxk*kxy) do texto este atalho corresponde.
				table.insert(tabela_links_lexico, index, link);
			end --if
				
	    end --for
	
	else	
	
		if (tam_lexicos_e_sinonimos == 0 and tam_cenarios > 0) then
		
--@Epis�dio 19: Se n�o h� l�xicos no projeto ent�o apenas a lista de cen�rios ser� percorrida
			for index, cenario in pairs(cenarios) do
			
--@Epis�dio 20: A vari�vel nome_cenario recebe o t�tulo do cen�rio que est� sendo verificado no momento.
		        nome_cenario = cenario["TITULO"];
				
--@Epis�dio 21: Uma express�o regular � montada como t�tulo do cen�rio. Esta express�o regular evita erros devido a pontua��o e espa�os em branco na hora da busca.
				expressao_regular = "([%p%s])"..nome_cenario.."([%p%s])";
							
				if (string.find(texto, expressao_regular) ~= nil) then
				
--Epis�dio 22: Se alguma ocorr�ncia de express�o regular for encontrada no texto, ent�o um atalho � montado com o nome do cen�rio.
					link = "<a title=\"Cen�rio\" href=\"../visao/exibe_cenario.lp?id_projeto="..id_projeto.."&titulo="..titulo_cenario.."&comando=exibir\">"..titulo_cenario.."</a>";
					
--Epis�dio 23: O atalho montado montado � inserido na tabela_links_)cenario na mesma posi��o que o t�tulo do cen�rio encontrado ocupa na tabela cenarios.
					table.insert(tabela_links_cenario, index, link);
					
--@Epis�dio 24:  A express�o � substituida pelo c�digo (wzczxk*kxyyc), onde o * ser� substituido por um n�mero que identificar� a posi��o do t�tulo do cen�rio na tabela cen�rios.
					texto = string.gsub(texto, expressao_regular, "%1".."wzczxk"..i.."kxyyc".."%2");
				end --if
				
		    end	-- for
		
		elseif (tam_total > 0) then
		
--@Epis�dio 25: Se h� l�xicos e cen�rios no projeto ent�o tanto a tabela cenarios quanto a lexicos_e_sinonimos ser�o percorridas.	
			i = 1;
			j = 1;
			contador = 1;
			while (contador <= tam_total) do
				
--@Epis�dio 26: Verifica se a tabela cenarios e a tabela lexicos_e_sinonimos j� foram percorridas.
				if ( ( i <= tam_lexicos_e_sinonimos ) and (j <= tam_cenarios) ) then
					
--@Epis�dio 27:  Se a tabela cenarios ainda n�o foi completamente percorrida e a tabela lexicos_e_sinonimos tamb�m n�o foi completamente percorrida
	--ent�o CONTAR PALAVRAS do t�tulo do cen�rio e CONTAR PALAVRAS do nome do l�xico ou sin�nimo.
					if ( conta_palavras(cenarios[j]["TITULO"]) <= conta_palavras(lexicos_e_sinonimos[i]["NOME"]) ) then
					    
--@Epis�dio 28:  Se o t�tulo do cen�rio atual possui um n�mero menor ou igual de palavras que o nome do termo do l�xico, ent�o procuraremos a ocorr�ncia deste l�xico no texto.
						nome_lexico = lexicos_e_sinonimos[i]["NOME"];
						
--@Epis�dio 29:  Uma express�o regular � criada com o nome do termo do l�xico atual. Esta express�o regular impede que erros sejam causados por causa da pontua��o e espa�os em branco.					
						expressao_regular = "([%p%s])"..nome_lexico.."([%p%s])";
						
						if( string.gfind(texto, expressao_regular) ~= nil ) then
						
--@Epis�dio 30:  Se uma ocorr�ncia da express�o regular � encontrada no texto ent�o a express�o � substituida pelo c�digo (wzzxk*kxy), onde o * ser� substituido por um n�mero
	-- que identificar� a posi��o do nome do termo do l�xico ou sin�nimo na tabela lexicos_e_sinonimos.
							texto = string.gsub(texto, expressao_regular, "%1".."wzzxk"..i.."kxy".."%2");
							
--@Epis�dio 31: � feita um verifica�o para saber se o termo encontrado � um termo do l�xico ou um sin�nimo de um termo do l�xico. 
							if (lexicos_e_sinonimos[i]["LEXICO"] ~= nil) then

--@Epis�dio 32: Se o elemento encontrado for um sin�nimo ent�o o termo do l�xico a que este sin�nimo corresponde � armazenado na vari�vel nome_lexico_link. Caso contr�rio,
	-- se o elemento encontrado for um termo do l�xico, ent�o ele � armazenado na vari�vel nome_l�xico.
								nome_lexico_link = lexicos_e_sinonimos[i]["LEXICO"];
							else
								nome_lexico_link = nome_lexico;
							end	
							
--@Epis�dio 33:  Um atalho para o termo encontrado � criado  e colocado na tabela links_lexico, na mesma posi��o que o l�xico atual ocupa na tabela lexicos e sin�nimos.
	--Isto permitir� que identifiquemos a que c�digo (wzzxk*kxy) do texto este atalho corresponde.							
							link = "<a title=\"L�xico\" href=\"../visao/exibe_lexico.lp?id_projeto="..id_projeto.."&nome="..nome_lexico_link.."\">"..nome_lexico.."</a>";
							table.insert(tabela_links_lexico, i, link);
						end --if
						i = i + 1;
						
					else --if
--@Epis�dio 34:  Se o t�tulo do cen�rio atual possui um maior de palavras que o nome do l�xico atual, ent�o procuraremos a ocorr�ncia do t�tulo deste cen�rio no texto.
						titulo_cenario = cenarios[j]["TITULO"];

--@Epis�dio 35:  Uma express�o regular � criada com o t�tulo do cen�rio atual. Esta express�o regular impede que erros sejam causados por causa da pontua��o e espa�os em branco.								
						expressao_regular = "([%p%s])"..titulo_cenario.."([%p%s])";
												
						if( string.gfind(texto, expressao_regular) ~= nil ) then
						
--@Epis�dio 36:  Caso encontremos uma ocorr�ncia do cen�rio atual no texto, um atalho ser� criado e armazenado no tabela tabela_links_cenario, na mesma posi��o que o cen�rio atual
	-- ocupa na tabela cen�rios.
							link = "<a title=\"Cen�rio\" href=\"../visao/exibe_cenario.lp?id_projeto="..id_projeto.."&titulo="..titulo_cenario.."\">"..titulo_cenario.."</a>";
							table.insert(tabela_links_cenario, j, link);
							
--@Epis�dio 37:  A express�o � substituida pelo c�digo (wzczxk*kxyyc), onde o * ser� substituido por um n�mero que identificar� a posi��o do t�tulo do cen�rio na tabela cen�rios.							
							texto = string.gsub(texto, expressao_regular, "%1".."wzczxk"..j.."kxyyc".."%2");
										
						end --if
						j = j + 1;
					
					end --if
			
				elseif( tam_lexicos_e_sinonimos == i-1 ) then
				
--@Epis�dio 38:  Se a tabela de termos do l�xico chegou ao fim e a tabela de cen�rios ainda possui cen�rios que ainda n�o foram procurados, ent�o devemos continuar percorrendo
	-- apenas a tabela cen�rios.			 
					titulo_cenario = cenarios[j]["TITULO"];
			
--@Epis�dio 39:  Uma express�o regular � criada com o t�tulo do cen�rio atual. Esta express�o regular impede que erros sejam causados por causa da pontua��o e espa�os em branco.								
					expressao_regular = "([%p%s])"..titulo_cenario.."([%p%s])";
					
					if( string.gfind(texto, expressao_regular) ~= nil ) then
					
--@Epis�dio 40:   Caso seja encontrada uma ocorr�ncia do cen�rio atual no texto, um atalho ser� criado e armazenado no tabela tabela_links_cenario, na mesma posi��o que o cen�rio atual
	-- ocupa na tabela cen�rios. 	
						link = "<a title=\"Cen�rio\" href=\"../visao/exibe_cenario.lp?id_projeto="..id_projeto.."&titulo="..titulo_cenario.."\">"..titulo_cenario.."</a>";
						table.insert(tabela_links_cenario, j, link);
						
--@Epis�dio 41:  A express�o � substituida pelo c�digo (wzczxk*kxyyc), onde o * ser� substituido por um n�mero que identificar� a posi��o do t�tulo do cen�rio na tabela cen�rios.						
						texto = string.gsub(texto, expressao_regular, "%1".."wzczxk"..j.."kxyyc".."%2"); 						
							
					end --if
					
				elseif( tam_cenarios == j-1 )	then

--@Epis�dio 42:  Se a tabela de cen�rios chegou ao fim e a tabela lexicos_e_sinonimos ainda possui elementos que ainda n�o foram procurados, ent�o devemos continuar percorrendo
	--apenas a tabela lexicos_e _sinonimos.						
					nome_lexico = lexicos_e_sinonimos[i]["NOME"];

--@Epis�dio 43:  Uma express�o regular � criada com o termo do l�xico atual. Esta express�o regular impede que erros sejam causados por causa da pontua��o e espa�os em branco.							
					expressao_regular = "([%p%s])"..nome_lexico.."([%p%s])";
					
					if( string.gfind(texto, expressao_regular) ~= nil ) then
					
--@Epis�dio 44:   Caso seja encontrada uma ocorr�ncia do termo do l�xico atual no texto, A express�o � substituida pelo c�digo (wzzxk*kxy), onde o * ser� substituido por um n�mero 
	--que identificar� a posi��o do nome do termo do l�xico na tabela l�xicos.	
						texto = string.gsub(texto, expressao_regular, "%1".."wzzxk"..i.."kxy".."%2");
												
						if (lexicos_e_sinonimos[i]["LEXICO"] ~= nil) then
						
--@Epis�dio 45: Se o elemento encontrado for um sin�nimo ent�o o termo do l�xico a que este sin�nimo corresponde � armazenado na vari�vel nome_lexico_link. Caso contr�rio,
	-- se o elemento encontrado for um termo do l�xico, ent�o ele � armazenado na vari�vel nome_l�xico.						
						nome_lexico_link = lexicos_e_sinonimos[i]["LEXICO"];
						else
							nome_lexico_link = nome_lexico;
						end	
						
--@Epis�dio 46: Um atalho para o termo do l�xico encontrado � criado e armazenado no tabela tabela_links_lexico, na mesma posi��o que o l�xico atual
						link = "<a title=\"L�xico\" href=\"../visao/exibe_lexico.lp?id_projeto="..id_projeto.."&nome="..nome_lexico_link.."\">"..nome_lexico.."</a>";
						table.insert(tabela_links_lexico, i, link); 
							
					end --if
					
					i = i + 1;
				
				end --if
				contador = contador + 1;
			
			end --while
			
		end --if
	end--if
	
	contador = 1;

--@Epis�dio 47:  A tabela links lexico � percorrida e os c�digos inseridos anteriormente nos texto s�o substituidos pelos links armazenados na tabela. 
	--O n�mero que se encontra no meio do c�digo corresponde a posi��o na tabela de links que o atalho que ser� inserido se encontra.
	for i, link in pairs(tabela_links_lexico) do
		expressao_regular = ("([%p%s])".."wzzxk"..i.."kxy".."([%p%s])");
		texto = string.gsub(texto, expressao_regular, "%1"..link.."%2");
	end
--@Epis�dio 48:  A tabela links cen�rios � percorrida e os c�digos inseridos anteriormente nos texto s�o substituidos pelos links armazenados na tabela. 
	--O n�mero que est� no meio do c�digo corresponde a posi��o na tabela de links que o atalho que ser� inserido se encontra.
	for i, link in pairs(tabela_links_cenario) do
		expressao_regular = ("([%p%s])".."wzczxk"..i.."kxyyc".."([%p%s])");
		texto = string.gsub(texto, expressao_regular, "%1"..link.."%2");
	end
--@Epis�dio 49:  O texto com os links � exibido para o usu�rio.
	cgilua.put(texto);	
	
end	

	







