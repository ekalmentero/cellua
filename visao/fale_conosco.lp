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
@Titulo: Exbibir p�gina fale conosco.
@Objetivo: Exibir para o usu�rio uma imagem com o endere�o de e-mail do administrador do C&L.
@Contexto: O usu�rio seleciona a op��o "Fale conosco" do menu superior
@Atores: browser e usu�rio
@Recursos: scripts.js e estilo.css
-->
<head>
	<link rel="stylesheet" type="text/css" href="css/estilo.css" />
	<title>C&L - Cen�rios e L�xicos</title> 
</head>

<body>

<div align=left>
<!--
@Epis�dio 1: Exibir o nome do projeto, a data da cria��o e sua descri��o.
-->
<br />
<span class="titulomedio">
<p>Obrigado por utilizar o C&L!</p>
<p>Qualquer d�vida, sugest�o ou notifica��o de bug envie um email para:</p>
<img src="imagens/emailmanutencaocel.bmp" alt="Email" />
<br />
<br />
<p>Obrigado!</p>
</span>
</div>
<body>
</html>