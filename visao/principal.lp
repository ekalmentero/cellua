<%
	dofile("../controle/projeto_beans.lua");
	
	cgilua.enablesession();
		
	if (cgilua.session.data["ID_USUARIO"] == nil) then
		cgilua.redirect("http://139.82.24.188:8080/cel/visao/index.html")
	end	
		
	local id_usuario = cgilua.session.data["ID_USUARIO"];	
	local id_sessao = string.sub(cgilua.mkurlpath(cgilua.mkabsoluteurl("principal.lp")), 63);
	
%>
<html>
<!--
@Titulo: Exibir p�gina principal 
@Objetivo: Exibir p�gina inicial para o usu�rio.
@Contexto: o usu�rio acessa a p�gina principal index.html
@Atores: browser e usu�rio
@Recursos: scripts.js e menu.css
-->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1>
	<meta content="cen�rios,l�xicos,engenharia de software,software,transparencia,engenharia de requisitos,l�xico extendido da linguagem" name=keywords>
	<meta content="C&L - Cen�rios e L�xicos" name=description>
		
	<meta content=http://transparencia.les.inf.puc-rio.br/ name=author>
	<meta content=http://transparencia.les.inf.puc-rio.br/ name=copyright>
	<meta content=http://transparencia.les.inf.puc-rio.br/ name=identifier-url>
	<meta content=transparencia@les.inf.puc-rio.br name=publisher-email>
		
	<meta content=index,follow name=robots>
	<meta content=all name=Googlebot>
	<meta content=all name=robots>
	<meta content="2 days" name=revisit>
	
	<meta content=Portuguese name=Language>
	<meta content=portuguese name=content-language>

	<meta content=pt-br name=language>

	<link rel="stylesheet" type="text/css" href="css/menu.css" />
	<script src="js/ajax.js" type="text/javascript"></script>
	<script src="js/menu.js" type="text/javascript"></script>
	<title>C&L - Cen�rios e L�xicos em Lua</title>
</head>
<body width="100%" height="100%" onload="recarregar_pagina('<%=id_sessao%>'); menuDropDown(1);">

<table bottomMargin=0 leftMargin=0 topMargin=0 rightMargin=0 marginwidth="0" border=0 cellspacing=0 cellpadding=0 width="100%" height="100%">
	<tr height="170">
		<td align=left width="200" background="imagens/menusuperior.jpg"></td>
		<td align=right valign="bottom" background="imagens/menusuperiorpixel.jpg">
			<table border=0 cellpadding=5 cellspacing=5>
				<tr>
					<td colspan=7 align=right>
						<span class="menuLateralTexto">Projeto:</span>
						<select name="menu_projetos" id="menu_projetos" size="1" onChange="mudar_projeto('<%=id_sessao%>')">
							<option value="0" selected> -- Selecione um projeto -- </option>
<!--
@ Epis�dio 1: Montar menu de projetos
-->
							<%= carregar_projetos(id_usuario) %>
						</select>
						
					</td>
				</tr>
				<tr>
					<td colspan=7> &nbsp; <td>
				</tr>
				<tr class="menu_superior">
					<td>
						<ul id="menu_dropdown" class="menubar">
						
						
							  <li class="submenu"><a href="#">Cadastros</a>
								  <ul class="menu">   
									  <li class="item"><a href="#">Par&acirc;metros</a></li>
									  <li class="item"><a href="#">Bancos</a></li>
									  <li class="item"><a href="#">Plano de Contas</a></li>               
									  <li class="item"><a href="#">Hist&oacute;ricos</a></li>                              
									  <li class="item"><a href="#">Bens Patrimoniais</a></li>                                             
									  <li class="item"><a href="#">Licita&ccedil;&otilde;es</a></li>                                                       
									  <li class="item"><a href="#">Ve&iacute;culos</a></li>                                                       
								  </ul>
							  </li>
							   <li class="submenu"><a href="#">Planejamento</a>
								  <ul class="menu">
									<li class="item"><a href="#">PPA</a></li>
									<li class="item"><a href="#">LDO</a></li>        
									<li class="item"><a href="#">LOA</a></li>
								  </ul>
							  </li>
							   <li class="submenu"><a href="#">Receitas</a>
								  <ul class="menu">
									<li class="item"><a href="#">Receita Or&ccedil;ament&aacute;ria</a></li>
									<li class="item"><a href="#">Receita Extra-Or&ccedil;ament&aacute;ria</a></li>        
									<li class="item"><a href="#">Lan&ccedil;amento da Receita</a></li>
									<li class="item"><a href="#">Receita Corrente L&iacute;quida</a></li>        
								  </ul>
							  </li>
						 
						</ul>					
					</td>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td class="textonormal" width=230>
			<table class="tableestilo" width=100% height=100% border=0 cellpadding=6>
				<tr>	
					<td valign=top>
					<br />
<!--
@ Epis�dio 2: Montar menu lateral
-->							
							<div id="menuLateralScroll">
								<table border=0 cellpadding=0 cellspacing=0>
								<tr>
									<th class=menuLateralTh><span class="menuLateralTexto">Cen�rios</span></th>
									<td>
									</td>
								</tr>
								</table>
								<ul id="cenario">
									<li><span class="menuTextoSimples">&nbsp;&nbsp;Selecione um projeto</span></li>									
								</ul>	
								<br />
								<table border=0 cellpadding=0 cellspacing=0>
								<tr>
									<th class=menuLateralTh><span class="menuLateralTexto">L�xicos</span></th>
									<td>
									</td>
								</tr>
								</table>							
								<ul id="lexico">
									<li><span class="menuTextoSimples">&nbsp;&nbsp;Selecione um projeto</span></li>
								</ul>
							</div>	
						
					</td>
				</tr>
			</table>	
		</td>
		
		<td align=right>
			<table class="tableestilo" width=100% height=100% border=0>
				<tr>	
					<td>
						<iframe id="conteudo" name="conteudo" src="inicial_conteudo.lp" scrolling="auto" width="100%" height="100%">
	
						</iframe>
					</td>
				</tr>
			</table>	
		</td>
		
		
	</tr>
</table>
<body>
</html>
