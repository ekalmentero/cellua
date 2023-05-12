<%	
	--sessao = cgilua.session.load("1")
	--if (sessao == nil) then
		--cgilua.redirect("http://139.82.24.94:8080/cel/visao/index.html target =_top");
		
	--end
%>
	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html> 
<!--
@Titulo: Exibir formulário para cadastro de cenário
@Objetivo: Exibir para o usuário um formulário de cadastro de cenário.
@Contexto: o usuário acessa a página novo_cenario.lp
@Atores: browser e usuário
@Recursos: scripts.js e estilo.css
-->

    <head> 
		<script src="js/scripts.js" type="text/javascript"></script>
        <link rel="stylesheet" type="text/css" href="css/estilo.css" />
		<title>Novo Cenário</title> 
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
    </head> 
    <body> 
        <div align=center bgcolor="#ffffff">
<!--
@Episódio 1: O formulário de cadastro é exibido para o usuário
-->
		<form name="frmCadastroCenario" method="post" action="../controle/controle_cenario.lp" onSubmit="return verificar_formulario_cenario();"> 
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
	                <td class="labelestilo" colspan="4" align="center"><span class="titulo">Novo Cenário<br><br><br></span></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Projeto:</td><td colspan="3">
					<input disabled class="inputestilo" id="projeto" name="projeto" maxlength="100" size="80" type="text" value="<% =cgilua.QUERY.nome %>">
					<input id="id_projeto" name="id_projeto" maxlength="100" size="80" type="hidden" value="<% =cgilua.QUERY.id %>"></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Título:</td><td colspan="3">
					<input class="inputestilo" name="titulo" id="titulo" maxlength="100" size="80" type="text"></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Objetivo:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="objetivo" id= "objetivo" rows="3" WRAP="SOFT"></textarea></td> 
	            </tr> 
	            <tr> 
	                <td class="labelestilo">Contexto:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="contexto" id="contexto" rows="3" WRAP="SOFT"></textarea></td> 
				</tr>
				<tr> 
	                <td class="labelestilo">Atores:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="atores" id="atores" rows="3" WRAP="SOFT"></textarea></td> 
	            </tr>				
				<tr> 
	                <td class="labelestilo">Recursos:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="recursos" id="recursos" rows="3" WRAP="SOFT"></textarea></td> 
				</tr>
				<tr> 
	                <td class="labelestilo">Episódios:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="episodios" id="episodios" rows="6" WRAP="SOFT"></textarea></td> 
				</tr>
				<tr> 
	                <td class="labelestilo">Exceção:</td><td>
						<textarea  class="inputestilo"cols="100" name="excecao" id="excecao " rows="3" WRAP="SOFT"></textarea>
						<input id="comando" name="comando" value="cadastrar" type="hidden">
					</td> 
				</tr>
	            <tr> 
	                <td align="center" colspan="4" height="40" valign="bottom">
<!--
@Episódio 2: Ao clicar no botão cadastrar o sistema será redirecionado para CONTROLE CENARIO
-->					<br>
					<br>
					<input name="cadastrar" type="submit" value="Cadastrar Cenário"></td> 
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

