<%	
	dofile("../controle/projeto_beans.lua")
	dofile("../controle/cenario_beans.lua")
%>	

<html>
<!--
@Titulo: Exibir as informações do cenário
@Objetivo: Exibir para o usuário as informações do cenário selecionado
@Contexto: o usuário seleciona um cenário do menu lateral.
@Atores: browser e usuário
@Recursos: scripts.js e estilo.css
-->
<head>
	<script src="js/scripts.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="css/estilo.css" />
	<title>C&L - Cenários e Léxicos</title> 
</head>

<body>
<!--
@Episódio 1: RECUPERAR DADOS DO CENÁRIO
-->
<%
	cenario_selecionado = selecionar_dados_cenario(cgilua.QUERY.titulo, cgilua.QUERY.id_projeto, true);
%>

<!--
@Episódio 2: Sistema exibe os dados do cenário.
-->
<table border=0>
	<tr>
		<td>
			<span class=titulomedio> Informações sobre o cenário</span>
			<br />
			<hr>
			<br />
		</td>
	</tr>
	<tr>
		<td>
			<table class=tableestilocenario cellpadding=5 width=100%>
				<tr>
					<th class=thcenario><span class=thtextocenario>Título</span></th >
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
					<th  class=thcenario><span class=thtextocenario>Exceção</span></th>
					<td>
						<span class=textonormal>
							<% colocar_links_texto(cgilua.QUERY.id_projeto, cenario_selecionado[1]["EXCECAO"], "cenario") %> 
						</span>
					</td>
				</tr>
				<tr>
					<th  class=thcenario><span class=thtextocenario>Episódios</span></th>
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
			
			<input class="buttonalterarremoverestilo" name="alt_cenario" id="alt_cenario" value="Alterar Cenário" type="button" onClick="submeter_formulario_cenario('alterar')">
			&nbsp; &nbsp; &nbsp; &nbsp;        
			<input class="buttonalterarremoverestilo" name="rmv_cenario" id="rmv_cenario" value="Remover Cenário" type="button" onClick="submeter_formulario_cenario('remover')">
<!--
@Episódio 2: CONTROLE CENÁRIO.
-->
			</div>
		</td>
	</tr>
</table>

<body>
</html>