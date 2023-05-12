<%	
	
%>	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html> 
<!--
@Titulo: Exibir formulário para cadastro de léxico
@Objetivo: Exibir para o usuário um formulário de cadastro de léxico.
@Contexto: o usuário acessa a página novo_lexico.lp
@Atores: browser e usuário
@Recursos: scripts.js e estilo.css 
-->
    <head> 
		<script src="js/scripts.js" type="text/javascript"></script>
        <link rel="stylesheet" type="text/css" href="css/estilo.css" />
		<title>Novo Símbolo do Léxico</title> 
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
    </head> 
    <body> 
        <div align=center bgcolor="#ffffff">
		<form name="frmLexico" method="post" action="../controle/controle_lexico.lp" onSubmit="return(verificar_formulario_lexico());"> 
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
	                <td class="labelestilo" colspan="4" align="center"><span class="titulo">Novo Símbolo do Léxico<br><br><br></span></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Projeto:</td><td colspan="3">
					<input disabled class="inputestilo" id="projeto" name="projeto" maxlength="100" size="80" type="text" value="<% =cgilua.QUERY.nome %>">
					
					<input id="id_projeto" name="id_projeto" maxlength="100" size="80" type="hidden" value="<% =cgilua.QUERY.id %>"></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo">Nome:</td><td colspan="3">
					<input class="inputestilo" name="nome" id="nome" maxlength="100" size="80" type="text"></td> 
	            </tr>
				<tr> 
	                <td class="labelestilo" valign="center">Sinônimo(s):</td>
					<td colspan="3">
					<input class="inputestilo" name="sinonimo" id="sinonimo" maxlength="500" size="40" type="text">
					<input class="buttonestilo" name="adc_sinonimo" id="adc_sinonimo" value="Adicionar" type="button" onclick="adicionar_sinonimo();">
					<input class="buttonestilo" name="rmv_sinonimo" id="rmv_sinonimo" value="Remover" type="button" onclick="remover_sinonimo();">
					
					</td>
					
	            </tr>
				<tr>
					<td></td>
					<td colspan="3">
					<select class="inputestilo" multiple name="lista_de_sinonimos"  style="width: 400px;"  size="3">
					</select>
					</td> 
				</tr>	
	            <tr> 
	                <td class="labelestilo">Noção:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="nocao" id="nocao" rows="4" WRAP="SOFT"></textarea></td> 
				</tr>
				<tr> 
	                <td class="labelestilo">Impacto:</td><td colspan="3">
					<textarea  class="inputestilo"cols="100" name="impacto" id="impacto" rows="4" WRAP="SOFT"></textarea></td> 
	            </tr>				
				<tr> 
	                <td class="labelestilo">Classificação:</td><td colspan="3">
						<SELECT class="inputestilo" id='classificacao' name='classificacao' size=1 width="300"> 
							<OPTION value='sujeito' selected>Sujeito</OPTION> 
							<OPTION value='objeto'>Objeto</OPTION> 
							<OPTION value='verbo'>Verbo</OPTION> 
							<OPTION value='estado'>Estado</OPTION> 
	                    </SELECT> 
					</td> 
					<input id="comando" name="comando" value="cadastrar" type="hidden">
				</tr>
				
				<tr> 
	                <td align="center" colspan="4" height="40" valign="bottom">
<!--
@Episódio 2: CONTROLE LÉXICO
-->					<br>
					<br>
					<input name="cadastrar" type="submit" value="Cadastrar Símbolo"></td> 
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

