<%	
	dofile("../controle/projeto_beans.lua")
	dofile("../controle/lexico_beans.lua")
%>	
<html>
<!--
@Titulo: Exibir as informa��es do l�xico
@Objetivo: Exibir para o usu�rio as informa��es do l�xico selecionado
@Contexto: o usu�rio seleciona um l�xico do menu lateral.
@Atores: browser e usu�rio
@Recursos: scripts.js e estilo.css
-->
<head>
	<script src="js/scripts.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="css/estilo.css" />
	<title>Novo S�mbolo do L�xico</title> 
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
</head>

<body>
<!--
@Epis�dio 1: RECUPERAR DADOS DO L�XICO
-->
<%
	lexico_selecionado, lista_sinonimos = selecionar_dados_lexico(cgilua.QUERY.nome, cgilua.QUERY.id_projeto, true);
%>

<table border=0>
	<tr>
		<td>
			<span class=titulomedio> Informa��es sobre o s�mbolo</span>
			<br />
			<hr>
			<br />
		</td>
	</tr>
	<tr>
		<td>
			<table class=tableestilocenario cellpadding=5 width=100%>
				<tr>
					<th class=thcenario><span class=thtextocenario>Nome</span></th >
					<td>
						<input name="nome" id="nome" type="hidden" value="<% cgilua.put(cgilua.QUERY.nome) %>">
						<span class=textonormal>
							<% cgilua.put(cgilua.QUERY.nome) %>
						</span>
					</td>
				</tr>
				<tr>
					<th class=thcenario><span class=thtextocenario>No��o</span></th>
					<td>
						<span class=textonormal>
							<% = colocar_links_texto(cgilua.QUERY.id_projeto, lexico_selecionado[1]["NOCAO"], "lexico") %> &nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th  class=thcenario><span class=thtextocenario>Classifica��o</span></th>
					<td>
						<span class=textonormal>
							<% = lexico_selecionado[1]["CLASSIFICACAO"] %> &nbsp;
						</span>
					</td>
				</tr>
				<tr>
					<th  class=thcenario><span class=thtextocenario>Impacto(s)</span></th>
					<td>
						<span class=textonormal>
							<% = colocar_links_texto(cgilua.QUERY.id_projeto, lexico_selecionado[1]["IMPACTO"], "lexico") %> &nbsp;
						</span>
					</td>
					
				</tr>
				<tr>
					<th  class=thcenario><span class=thtextocenario>Sin�nimo(s)</span></th>
					<td>
						<span class=textonormal>
							<% = lista_sinonimos %> &nbsp;
						</span>
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<br />
			<div align="center">
			
			<form name="dadosLexico" method="POST">
				<input id="nome" name="nome" type="hidden" value="<% = cgilua.put(cgilua.QUERY.nome) %>">
				<input id="id_projeto" name="id_projeto" type="hidden" value="<% = cgilua.put(cgilua.QUERY.id_projeto) %>">
				<input id="comando" name="comando" type="hidden" value="teste">
			</form>
			
			<input class="buttonalterarremoverestilo" name="alt_cenario" id="alt_cenario" value="Alterar S�mbolo" type="button" onClick="submeter_formulario_lexico('alterar');">
			&nbsp; &nbsp; &nbsp; &nbsp;        
			<input class="buttonalterarremoverestilo" name="rmv_cenario" id="rmv_cenario" value="Remover S�mbolo" type="button" onClick="submeter_formulario_lexico('remover');">
			</div>
		</td>
	</tr>
</table>

<body>
</html>