<%	
	dofile("../controle/projeto_beans.lua")
	dofile("../controle/cenario_beans.lua")
	sessao = cgilua.session.load("1")
	if (sessao == nil) then
		cgilua.redirect("http://139.82.24.94:8080/cel/visao/index.html");
	end
%>	

<html>
<!--
@Titulo: Oferecer outras op��es do projeto para o usu�rio.
@Objetivo: Exibir para o usu�rio links com outras funcionalidades do sistema para o projeto selecionado.
@Contexto: O usu�rio seleciona a op��o "Outras op��es" do menu superior
@Atores: browser e usu�rio
@Recursos: scripts.js e estilo.css
-->
<head>
	<script src="js/scripts.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="css/estilo.css" />
	<title>C&L - Cen�rios e L�xicos</title> 
</head>

<body>

<div align=left>
<!--
@Epis�dio 1: Exibir o nome do projeto, a data da cria��o e sua descri��o.
-->
<br />
<table class=tableestilocenario cellpadding=5>
	<tr>
		<th class=thprojeto><span class=thtextocenario>Nome do Projeto:</span></th >
		<td>
			<span class=textonormal>
				teste nome				
			</span>
		</td>
	</tr>
	<tr>	
		<th class=thprojeto><span class=thtextocenario>Data da cria��o:</span></th >
		<td>
			<span class=textonormal>
				teste cria��o				
			</span>
		</td>
	</tr>
	<tr>
		<th class=thprojeto><span class=thtextocenario>Descri��o:</span></th >
		<td>
			<span class=textonormal>
				teste descri��o				
			</span>
		</td>
	</tr>
	
</table>
<br/>
<br/>
<!--
@Epis�dio 2: Exibir as op��es do projeto para o usu�rio.
-->
<table class=tableestilocenario cellpadding=5 width=450>
	<tr>
		<th class=thcenario><span class=thtextocenario>Op��es do projeto:</span></th >
	</tr>
	<tr>
		<td>
			<span class=textonormal>
				Gerar XML deste projeto
			</span>
		</td>
	</tr>
	<tr>
		<td>
			<span class=textonormal>
				Gerar grafo deste projeto 	
			</span>
		</td>
	</tr>
</table>
<br \>
<table class=tableestilocenario cellpadding=5 width=450>
	<tr>
		<th class=thcenario><span class=thtextocenario>Op��es do usu�rio:</span></th >
	</tr>
	<tr>
		<td>
			<span class=textonormal>
				Alterar cadastro
			</span>
		</td>
	</tr>
</table>

</div>
<body>
</html>