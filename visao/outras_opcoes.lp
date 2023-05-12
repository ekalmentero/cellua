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
@Titulo: Oferecer outras opções do projeto para o usuário.
@Objetivo: Exibir para o usuário links com outras funcionalidades do sistema para o projeto selecionado.
@Contexto: O usuário seleciona a opção "Outras opções" do menu superior
@Atores: browser e usuário
@Recursos: scripts.js e estilo.css
-->
<head>
	<script src="js/scripts.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="css/estilo.css" />
	<title>C&L - Cenários e Léxicos</title> 
</head>

<body>

<div align=left>
<!--
@Episódio 1: Exibir o nome do projeto, a data da criação e sua descrição.
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
		<th class=thprojeto><span class=thtextocenario>Data da criação:</span></th >
		<td>
			<span class=textonormal>
				teste criação				
			</span>
		</td>
	</tr>
	<tr>
		<th class=thprojeto><span class=thtextocenario>Descrição:</span></th >
		<td>
			<span class=textonormal>
				teste descrição				
			</span>
		</td>
	</tr>
	
</table>
<br/>
<br/>
<!--
@Episódio 2: Exibir as opções do projeto para o usuário.
-->
<table class=tableestilocenario cellpadding=5 width=450>
	<tr>
		<th class=thcenario><span class=thtextocenario>Opções do projeto:</span></th >
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
		<th class=thcenario><span class=thtextocenario>Opções do usuário:</span></th >
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