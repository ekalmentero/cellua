<%	
	dofile("../controle/projeto_beans.lua")
	dofile("../controle/cenario_beans.lua")
%>	

<html>
<!--
@Titulo: Exibir as informa��es do cen�rio
@Objetivo: Exibir para o usu�rio as informa��es do cen�rio selecionado
@Contexto: o usu�rio seleciona um cen�rio do menu lateral.
@Atores: browser e usu�rio
@Recursos: scripts.js e estilo.css
-->
<head>
	<script src="js/scripts.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="css/estilo.css" />
	<title>C&L - Cen�rios e L�xicos</title> 
</head>

<body>
<!--
@Epis�dio 1: RECUPERAR DADOS DO CEN�RIO
-->
<%
	cenario_selecionado = selecionar_dados_cenario(cgilua.QUERY.titulo, cgilua.QUERY.id_projeto, true);
%>

<!--
@Epis�dio 2: Sistema exibe os dados do cen�rio.
-->
<table border=0>
	<tr>
		<td>
			<span class=titulomedio> Informa��es sobre o cen�rio</span>
			<br />
			<hr>
			<br />
		</td>
	</tr>
	<tr>
		<td>
			<table class=tableestilocenario cellpadding=5 width=100%>
				<tr>
					<th class=thcenario><span class=thtextocenario>T�tulo</span></th >
					<td>
						<span class=textonormal>
							<% = cenario_selecionado[1]["TITULO"] %> 
						</span>
					</td>
				</tr>
				<tr>
					<th class=thcenario><span class=thtextocenario>Objetivo</span></th>
					<td>
						<span class=textonormal>
							<% = cenario_selecionado[1]["OBJETIVO"] %> 
						</span>
					</td>
				</tr>
				<tr>
					<th  class=thcenario><span class=thtextocenario>Contexto</span></th>
					<td>
						<span class=textonormal>
							<% colocar_links_texto(cgilua.QUERY.id_projeto, cenario_selecionado[1]["CONTEXTO"], "cenario") %> 
						</span>
					</td>
				</tr>
				<tr>
					<th  class=thcenario><span class=thtextocenario>Atores</span></th>
					<td>
						<span class=textonormal>
							<% = cenario_selecionado[1]["ATORES"] %> 
						</span>
					</td>
					
				</tr>
				<tr>
					<th  class=thcenario><span class=thtextocenario>Recursos</span></th>
					<td>
						<span class=textonormal>
							<% = cenario_selecionado[1]["RECURSOS"] %> 
						</span>
					</td>
				</tr>
				<tr>
					<th  class=thcenario><span class=thtextocenario>Exce��o</span></th>
					<td>
						<span class=textonormal>
							<% colocar_links_texto(cgilua.QUERY.id_projeto, cenario_selecionado[1]["EXCECAO"], "cenario") %> 
						</span>
					</td>
				</tr>
				<tr>
					<th  class=thcenario><span class=thtextocenario>Epis�dios</span></th>
					<td>
						<span class=textonormal>
							<% colocar_links_texto(cgilua.QUERY.id_projeto, cenario_selecionado[1]["EPISODIOS"], "cenario") %> 
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
			<form name="dadosCenario" method="POST">
				<input id="titulo" name="titulo" type="hidden" value="<% = cgilua.put(cgilua.QUERY.titulo) %>">
				<input id="id_projeto" name="id_projeto" type="hidden" value="<% =cgilua.put(cgilua.QUERY.id_projeto) %>">
				<input id="comando" name="comando" type="hidden" value="">
			</form>
			
			<input class="buttonalterarremoverestilo" name="alt_cenario" id="alt_cenario" value="Alterar Cen�rio" type="button" onClick="submeter_formulario_cenario('alterar')">
			&nbsp; &nbsp; &nbsp; &nbsp;        
			<input class="buttonalterarremoverestilo" name="rmv_cenario" id="rmv_cenario" value="Remover Cen�rio" type="button" onClick="submeter_formulario_cenario('remover')">
<!--
@Epis�dio 2: CONTROLE CEN�RIO.
-->
			</div>
		</td>
	</tr>
</table>

<body>
</html>