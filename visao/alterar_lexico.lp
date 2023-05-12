<%	
	dofile("../controle/lexico_beans.lua");
	dofile("../controle/projeto_beans.lua");
	--sessao = cgilua.session.load("1")
	--if (sessao == nil) then
	--	cgilua.redirect("http://139.82.24.94:8080/cel/visao/index.html target=_top");
	--end
%>	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html> 
<!--
@Titulo: Exibir léxico para edição
@Objetivo: Exibir um formulário com informações do léxico e permitir que o usuário as altere.
@Contexto: Usuário seleciona a opção alterar léxico.
@Atores: browser e usuário
@Recursos: scripts.js e estilo.css
-->

    <head> 
		<script src="js/scripts.js" type="text/javascript"></script>
        <link rel="stylesheet" type="text/css" href="css/estilo.css" />
		<title>Novo Símbolo do Léxico</title> 
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
    </head> 
    <body> 

<!--
@Episódio 1: RECUPERAR DADOS DO LÉXICO
-->
<%
	lexico_selecionado, lista_sinonimos = selecionar_dados_lexico(cgilua.POST.nome, cgilua.POST.id_projeto, false);
%>

		<div align=center bgcolor="#ffffff">
		<form name="frmLexico" method="post" action="../controle/controle_lexico.lp" onSubmit="return(verificar_formulario_lexico());"> 
		<table width=457>
			<tr>
				<td align="left"><span align="left" class="pes">C&L - Cenários e Léxicos</span></td>
			</tr>	
		</table>
		<table class="tableestilo" cellpadding="20" >
		<tr>
		<td>
			<table cellpadding="5"> 
	            <tr> 
	                <td class="labelestilo" colspan="4" align="center"><span class="titulo">Alterando Símbolo do Léxico<br><br><br></span></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Projeto:</td><td colspan="3">
					<input disabled class="inputestilo" id="projeto" name="projeto" maxlength="100" size="80" type="text" value="<% = selecionar_nome_projeto(cgilua.POST.id_projeto) %>">
					
					<input id="id_projeto" name="id_projeto" maxlength="100" size="80" type="hidden" value="<% = cgilua.POST.id_projeto %>"></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Nome:</td><td colspan="3">
					<input class="inputestilo" name="nome" id="nome" maxlength="100" size="80" type="hidden" value = "<% = lexico_selecionado[1]["NOME"] %>">
					<input disabled class="inputestilo" name="shownome" id="shownome" maxlength="100" size="80" type="text" value = "<% = lexico_selecionado[1]["NOME"] %>">
					</td> 
	            </tr>
				<tr> 
					<td class="labelestilo" valign="center">Sinônimo(s):</td>
					<td colspan="3">
					<input class="inputestilo" name="sinonimo" id="sinonimo" maxlength="500" size="40" type="text">
					<input class="buttonestilo" name="adc_sinonimo" id="adc_sinonimo" value="Adicionar" type="button" onclick="adicionar_sinonimo();">
					<input class="buttonestilo" name="rmv_sinonimo" id="rmv_sinonimo" value="Remover" type="button" onclick="remover_sinonimo();">
					
					</td>
					
	            </tr>
				<tr>
					<td></td>
					<td colspan="3">
					<select class="inputestilo" multiple name="lista_de_sinonimos"  style="width: 400px;"  size="3">
					<% 
						lista_de_sinonimos = listar_sinonimos_lexico(cgilua.POST.id_projeto, cgilua.POST.nome);
						for index, sinonimo in pairs(lista_de_sinonimos) do
							cgilua.put("<option value="..sinonimo["NOME"]..">");
							cgilua.put(sinonimo["NOME"]);
							cgilua.put("</option>");							
						end
					%>
					</select>
					</td> 
				</tr>	
	            <tr> 
	                <td class="labelestilo">Noção:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="nocao" id="nocao" rows="4" WRAP="SOFT"><% = lexico_selecionado[1]["NOCAO"]  %></textarea></td> 
				</tr>
				<tr> 
	                <td class="labelestilo">Impacto:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="impacto" id="impacto" rows="4" WRAP="SOFT"><% = lexico_selecionado[1]["IMPACTO"] %></textarea></td> 
	            </tr>				
				<tr> 
	                <td class="labelestilo">Classificação:</td><td colspan="3">
						<SELECT class="inputestilo" id='classificacao' name='classificacao' size=1 width="300"> 
							<OPTION value='sujeito'<? if (lexico_selecionado[1]["CLASSIFICACAO"] == "sujeito") then cgilua.put("selected") end ?>> Sujeito</OPTION> 
							<OPTION value='objeto'<? if (lexico_selecionado[1]["CLASSIFICACAO"] == "objeto") then cgilua.put("selected") end ?>>Objeto</OPTION> 
							<OPTION value='verbo'<? if (lexico_selecionado[1]["CLASSIFICACAO"] == "verbo") then cgilua.put("selected") end ?>>Verbo</OPTION> 
							<OPTION value='estado'<? if (lexico_selecionado[1]["CLASSIFICACAO"] == "estado") then cgilua.put("selected") end ?>>Estado</OPTION> 
	                    </SELECT> 
					</td> 
					<input id="comando" name="comando" value="alterar" type="hidden">
				</tr>
				
				<tr> 
	                <td align="center" colspan="4" height="40" valign="bottom">
<!--
@Episódio 2: Ao submeter o formulário, CONTROLE LÉXICO
-->					<br>
					<br>
					<input name="cadastrar" type="submit" value="Alterar Símbolo"></td> 
	            </tr> 
	        </table>
		</td>	
		</tr>
		</table>
        </form> 
        </div>
    </body> 
</html> 

<?php 
} 
?> 

