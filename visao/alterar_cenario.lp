<%	
	dofile("../controle/projeto_beans.lua");
	dofile("../controle/cenario_beans.lua");
	
	--cgilua.enablesession();
	--if (cgilua.session.data["ID_USUARIO"] == nil) then
	--	cgilua.redirect(cgilua.mkabsoluteurl("cel/visao/index.html"))
	--end
%>	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html> 
<!--
@Titulo: Exibir cen�rio para edi��o
@Objetivo: Exibir um formul�rio com informa��es do cen�rio e permitir que o usu�rio as altere.
@Contexto: Usu�rio seleciona a op��o alterar cen�rio.
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
@Epis�dio 1: RECUPERAR DADOS DO CEN�RIO
-->
<%
	cenario_selecionado = selecionar_dados_cenario(cgilua.POST.titulo, cgilua.POST.id_projeto, false);
%>		
<!--
@Epis�dio 2: Sistema exibe as informa��es do cen�rio.
-->
		<form name="frmAlteracaoCenario" method="post" action="../controle/controle_cenario.lp"> 
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
	                <td class="labelestilo" colspan="4" align="center"><span class="titulo">Alterando Cen�rio<br><br><br></span></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Projeto:</td><td colspan="3">
					<input disabled class="inputestilo" id="projeto" name="projeto" maxlength="100" size="80" type="text" value="<% = selecionar_nome_projeto(cgilua.POST.id_projeto) %>">
					<input id="id_projeto" name="id_projeto" maxlength="100" size="80" type="hidden" value="<% = cgilua.POST.id_projeto %>"></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">T�tulo:</td><td colspan="3">
					<input disabled class="inputestilo" name="showtitulo" id="showtitulo" maxlength="100" size="80" type="text" value="<% = cgilua.POST.titulo %>">
					<input class="inputestilo" name="titulo" id="titulo" maxlength="100" size="80" type="hidden" value="<% = cgilua.POST.titulo %>"></td> 
					</td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Objetivo:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="objetivo" id= "objetivo" rows="3" WRAP="SOFT"><% = cenario_selecionado[1]["OBJETIVO"] %></textarea></td> 
	            </tr> 
	            <tr> 
	                <td class="labelestilo">Contexto:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="contexto" id="contexto" rows="3" WRAP="SOFT"><% = cenario_selecionado[1]["CONTEXTO"] %></textarea></td> 
				</tr>
				<tr> 
	                <td class="labelestilo">Atores:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="atores" id="atores" rows="3" WRAP="SOFT"><% = cenario_selecionado[1]["ATORES"] %></textarea></td> 
	            </tr>				
				<tr> 
	                <td class="labelestilo">Recursos:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="recursos" id="recursos" rows="3" WRAP="SOFT"><% = cenario_selecionado[1]["RECURSOS"] %></textarea></td> 
				</tr>
				<tr> 
	                <td class="labelestilo">Epis�dios:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="episodios" id="episodios" rows="6" WRAP="SOFT"><% = cenario_selecionado[1]["EPISODIOS"] %></textarea></td> 
				</tr>
				<tr> 
	                <td class="labelestilo">Exce��o:</td><td>
						<textarea  class="inputestilo"cols="100" name="excecao" id="excecao " rows="3" WRAP="SOFT"><% = cenario_selecionado[1]["EXCECAO"] %></textarea>
						<input id="comando" name="comando" value="alterar" type="hidden">
					</td> 
				</tr>
	            <tr> 
	                <td align="center" colspan="4" height="40" valign="bottom">
<!--
@Epis�dio 3: CONTROLE CEN�RIO
-->					<br>
					<br>
					<input name="alterar" type="submit" value="Alterar Cen�rio"></td> 
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

