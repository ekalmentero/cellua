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
@Titulo: Exbibir página fale conosco.
@Objetivo: Exibir para o usuário uma imagem com o endereço de e-mail do administrador do C&L.
@Contexto: O usuário seleciona a opção "Fale conosco" do menu superior
@Atores: browser e usuário
@Recursos: scripts.js e estilo.css
-->
<head>
	<link rel="stylesheet" type="text/css" href="css/estilo.css" />
	<title>C&L - Cenários e Léxicos</title> 
</head>

<body>

<div align=left>
<!--
@Episódio 1: Exibir o nome do projeto, a data da criação e sua descrição.
-->
<br />
<span class="titulomedio">
<p>Obrigado por utilizar o C&L!</p>
<p>Qualquer dúvida, sugestão ou notificação de bug envie um email para:</p>
<img src="imagens/emailmanutencaocel.bmp" alt="Email" />
<br />
<br />
<p>Obrigado!</p>
</span>
</div>
<body>
</html>