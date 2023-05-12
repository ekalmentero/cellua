<% 
	cgilua.enablesession();
		
	--if (cgilua.session.data["ID_USUARIO"] == nil) then
	--	cgilua.redirect("http://139.82.24.94:8080/cel/visao/index.html")
	--end	
	local id_usuario = cgilua.session.data["ID_USUARIO"];	
		
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html> 
<!--
@Titulo: Exibir formulário para cadastro de projeto
@Objetivo: Exibir para o usuário um formulário de cadastro de projeto.
@Contexto: o usuário acessa a página novo_projeto.lp
@Atores: browser e usuário
@Recursos: scripts.js e estilo.css
-->
    <head> 
		<script src="js/scripts.js" type="text/javascript"></script>
        <link rel="stylesheet" type="text/css" href="css/estilo.css" />
		<title>Novo Projeto</title> 
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
    </head> 
    <body> 
        <div align=center bgcolor="#ffffff">
		<form name="form_projeto" method="post" action="../controle/controle_projeto.lp" onSubmit="return verificar_formulario_projeto();"> 
		<table width=457>
			<tr>
				<td align="left"><span align="left" class="pes">C&L - Cenários e Léxicos</span></td>
			</tr>	
		</table>
		<table class="tableestilo" cellpadding="20">
		<tr>
		<td>
			<table cellpadding="5"> 
	            <tr> 
	                <td class="labelestilo" colspan="4" align="center"><span class="titulo">Novo Projeto<br><br><br></span></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Nome:</td>
					<td colspan="3"><input class="inputestilo" id="nome" name="nome" maxlength="60" size="40" type="text"></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Descrição:</td>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea class="inputestilo" id="descricao" name="descricao" cols="100" name="descricao" rows="4"></textarea>
						
						<input id="id_usuario" name="id_usuario" value="<%=  id_usuario %>" type="hidden">
						<input id="comando" name="comando" value="cadastrar" type="hidden">
					</td>
				</tr>	
	            <tr> 
	                <td align="center" colspan="4" height="40" valign="bottom">
<!--
@Episódio 2: CONTROLE PROJETO
-->					<br>
					<br>
					<input name="cadastrar" type="submit" value="Cadastrar"></td> 
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

