<%	
	--sessao = cgilua.session.load("1")
	--if (sessao == nil) then
		--cgilua.redirect("http://139.82.24.94:8080/cel/visao/index.html target =_top");
		
	--end
%>
	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html> 
<!--
@Titulo: Exibir formul�rio para cadastro de cen�rio
@Objetivo: Exibir para o usu�rio um formul�rio de cadastro de cen�rio.
@Contexto: o usu�rio acessa a p�gina novo_cenario.lp
@Atores: browser e usu�rio
@Recursos: scripts.js e estilo.css
-->

    <head> 
		<script src="js/scripts.js" type="text/javascript"></script>
        <link rel="stylesheet" type="text/css" href="css/estilo.css" />
		<title>Novo Cen�rio</title> 
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
    </head> 
    <body> 
        <div align=center bgcolor="#ffffff">
<!--
@Epis�dio 1: O formul�rio de cadastro � exibido para o usu�rio
-->
		<form name="frmCadastroCenario" method="post" action="../controle/controle_cenario.lp" onSubmit="return verificar_formulario_cenario();"> 
		<table width=457>
			<tr>
				<td align="left"><span align="left" class="pes">C&L - Cen�rios e L�xicos</span></td>
			</tr>	
		</table>
		<table class="tableestilo" cellpadding="20" >
		<tr>
		<td>
			<table cellpadding="5"> 
	            <tr> 
	                <td class="labelestilo" colspan="4" align="center"><span class="titulo">Novo Cen�rio<br><br><br></span></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Projeto:</td><td colspan="3">
					<input disabled class="inputestilo" id="projeto" name="projeto" maxlength="100" size="80" type="text" value="<% =cgilua.QUERY.nome %>">
					<input id="id_projeto" name="id_projeto" maxlength="100" size="80" type="hidden" value="<% =cgilua.QUERY.id %>"></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">T�tulo:</td><td colspan="3">
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
	                <td class="labelestilo">Epis�dios:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="episodios" id="episodios" rows="6" WRAP="SOFT"></textarea></td> 
				</tr>
				<tr> 
	                <td class="labelestilo">Exce��o:</td><td>
						<textarea  class="inputestilo"cols="100" name="excecao" id="excecao " rows="3" WRAP="SOFT"></textarea>
						<input id="comando" name="comando" value="cadastrar" type="hidden">
					</td> 
				</tr>
	            <tr> 
	                <td align="center" colspan="4" height="40" valign="bottom">
<!--
@Epis�dio 2: Ao clicar no bot�o cadastrar o sistema ser� redirecionado para CONTROLE CENARIO
-->					<br>
					<br>
					<input name="cadastrar" type="submit" value="Cadastrar Cen�rio"></td> 
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

