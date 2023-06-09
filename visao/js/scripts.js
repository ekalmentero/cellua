// Remove os espa�os em branco a esquerda da palavra
String.prototype.ltrim = function() {
    return this.replace(/^\s+/,"");
}
// Validar formul�rio de cadastro de l�xicos


function verificar_formulario_lexico() {
	
	formulario = document.frmLexico;

	//Verifica se o campo nome do l�xico est� vazio
	if (formulario.nome.value.ltrim() == ""){
	   alert("O campo " + formulario.nome.name + " deve ser preenchido!");
	   formulario.nome.focus();
	   return false;
	}
	
	//verifica se j� existe s�mbolo do l�xico com o nome informado
	
	//function ajax(id_projeto, eh_iframe) {
	
	// comando --> cadastrar
	// nome_lexico --> 
	// id_projeto --> 
	
	
/*@Epis�dio 1: Criar uma requisi��o http dependendo do browser que o usu�rio est� utilizando. Emite uma mensagem de alerta caso o browser n�o possua recursos para o uso do ajax.*/
	
	
	
	
	//Verifica se o campo no��o do l�xico est� vazio
	if (formulario.nocao.value.ltrim() == ""){
	   alert("O campo " + formulario.nocao.name + " deve ser preenchido!");
	   formulario.nocao.focus();
	   return false;
	}
	
	//Verifica se o campo impacto do l�xico est� vazio
	//if (formulario.impacto.value.ltrim() == ""){
	//   alert("O campo " + formulario.impacto.name + " deve ser preenchido!");
	//   formulario.impacto.focus();
	//   return false;
	//}
	
    //Seta a propriedade selected de cada item do campo sin�nimos para true. Dessa forma ele ir� passar todos os sin�nimos ao submeter o formul�rio.
	
	lista_de_sinonimos = document.forms[0].elements['lista_de_sinonimos']; 

	for(var i = 0; i < lista_de_sinonimos.length; i++) 
		lista_de_sinonimos.options[i].selected = true;
	
		
}

//Validar formul�rio de cadastro de cen�rios

function verificar_formulario_cenario()
{
	formulario = document.frmCadastroCenario;
	
	//Verifica se o campo titulo do cen�rio est� vazio.
	if (formulario.titulo.value.ltrim() == ""){
	   alert("O campo " + formulario.titulo.name + " deve ser preenchido!");
	   formulario.titulo.focus();
	   return false;
	}
	
	//Verifica se o campo objetivo do cen�rio esta preenchido
	if (formulario.objetivo.value.ltrim() == ""){
	   alert("O campo " + formulario.objetivo.name + " deve ser preenchido!");
	   formulario.objetivo.focus();
	   return false;
	}
	
	//Verifica se o campo contexto do cen�rio est� preenchido
	if (formulario.contexto.value.ltrim() == ""){
	   alert("O campo " + formulario.contexto.name + " deve ser preenchido!");
	   formulario.contexto.focus();
	   return false;
	}
	
	//Verifica se o campo atores do cen�rio est� vazio
	if (formulario.atores.value.ltrim() == ""){
	   alert("O campo " + formulario.atores.name + " deve ser preenchido!");
	   formulario.atores.focus();
	   return false;
	}
	
	//Verifica se o campo recursos do cen�rio est� vazio
	if (formulario.recursos.value.ltrim() == ""){
	   alert("O campo " + formulario.recursos.name + " deve ser preenchido!");
	   formulario.recursos.focus();
	   return false;
	}
	
	//Verifica se o campo episodios do cen�rio est� vazio
	if (formulario.episodios.value.ltrim() == ""){
	   alert("O campo " + formulario.episodios.name + " deve ser preenchido!");
	   formulario.episodios.focus();
	   return false;
	}
	return true;
}

// Validar formul�rio de cadastro de projetos

function verificar_formulario_projeto()
{
	formulario = document.form_projeto;
	
	//Verifica se o campo nome do projeto est� vazio
	if (formulario.nome.value.ltrim() == ""){
	   alert("O campo " + formulario.nome.name + " deve ser preenchido!");
	   formulario.nome.focus();
	   return false;
	}
	
	//Verifica se o campo sobrenome est� vazio
	if (formulario.descricao.value.ltrim() == ""){
	   alert("O campo " + formulario.descricao.name + " deve ser preenchido!");
	   formulario.descricao.focus();
	   return false;
	}
	//Verifica se o campo id_usuario esta vazio
	if (formulario.id_usuario.value.ltrim() == ""){
	   alert ("O campo " +formulario.id_usuario.name + " n�o foi preenchido corretamente. Este � um erro do sistema. Por favor, entre em contato com o administrador."); 
	   return false;
	}	   


	return true;
}


/*
@T�tulo: Validar formul�rio de cadastro de usu�rio.
@Objetivo: Assegurar que o formul�rio de cadastro de usu�rio seja preenchido
da maneira correta.	
@Contexto: O formul�rio de cdastro � preenchido	e submetido pelo usu�rio.
@Atores: cadastro_usuario.html
@Recursos: dados do usu�rio (nome, sobrenome, e-mail, institui��o, login,
senha e	confirmar senha)	
*/
function verificar_formulario_usuario()
{
	formulario = document.frmCadastro;
	
/*
@Epis�dio 1: Verificar se o campo nome est� vazio ou 
cont�m apenas espa�os em branco. Se o campo estiver 
vazio, emite alerta para o usu�rio e p�e o foco do
cursor nele.
*/
	if (formulario.nome.value.ltrim() == ""){
	   alert("O campo " + formulario.nome.name + " deve ser preenchido!");
	   formulario.nome.focus();
	   return false;
	}
	
/*
@Epis�dio 2: Verificar se o campo sobrenome est� vazio
ou se cont�m apenas espa�os em branco. Se o campo 
estiver vazio emite um alerta para o usu�rio e p�e
o foco do cursor nele.
*/
	if (formulario.sobrenome.value.ltrim() == ""){
	   alert("O campo " + formulario.sobrenome.name + " deve ser preenchido!");
	   formulario.sobrenome.focus();
	   return false;
	}

	//Verifica se o campo email est� vazio 
	if (formulario.email.value.ltrim() == ""){
	   alert("O campo " + formulario.email.name + " deve ser preenchido!");
	   formulario.email.focus();
	   return false;
	}

	// Verifica se o campo institui��o
	if (formulario.instituicao.value.ltrim() == ""){
	   alert("O campo " + formulario.instituicao.name + " deve ser preenchido!");
	   formulario.instituicao.focus();
	   return false;
	}

	// Verifica se o campo login est� vazio
	if (formulario.login.value.ltrim() == ""){
	   alert("O campo " + formulario.login.name + " deve ser preenchido!");
	   formulario.login.focus();
	   return false;
	}

	//Verifica se o campo senha est� vazio
	if (formulario.senha.value.ltrim() == ""){
	   alert("O campo " + formulario.senha.name + " deve ser preenchido!");
	   formulario.senha.focus();
	   return false;
	}

	// Verifica se o conteudo do campo senha � igual ao do campo verificar senha
	if (formulario.senha.value != formulario.confirmarsenha.value){
	   alert("O campo " + formulario.confirmarsenha.name + " deve conter a mesma senha digitada no campo senha!");
	   formulario.confirmarsenha.focus();
	   return false;
	}
	return true;
}



//Adicionar sin�nimo na lista de sin�nimos
function adicionar_sinonimo()
{
	lista_de_sinonimos = document.forms[0].elements['lista_de_sinonimos'];

	if(document.forms[0].sinonimo.value == "")
	    return;

	sinonimo = document.forms[0].sinonimo.value;
	padrao = /[\\\/\?"<>:|]/;
	nOK = padrao.exec(sinonimo);
	if (nOK)
	{
	    window.alert ("O sin�nimo do l�xico n�o pode conter nenhum dos seguintes caracteres:   / \\ : ? \" < > |");
	    document.forms[0].sinonimo.focus();
	    return;
	}

	//verifica se ja existe algum sin�nimo na lista com o mesmo nome do que est� sendo inserido
	
	for (i=0; i < lista_de_sinonimos.length; i++)
    {
		if(sinonimo == lista_de_sinonimos.options[i].text)
		{
			alert("Voce j� adicionou um sin�nimo com o nome "+sinonimo+"!");
			return;
		}
    }
	
	lista_de_sinonimos.options[lista_de_sinonimos.length] = new Option(document.forms[0].sinonimo.value, document.forms[0].sinonimo.value);

	document.forms[0].sinonimo.value = "";

	document.forms[0].sinonimo.focus();

}


// Remover sin�nimo da lista de sinonimos
function remover_sinonimo()
{
	lista_de_sinonimos = document.forms[0].elements['lista_de_sinonimos'];

	if(lista_de_sinonimos.selectedIndex == -1)
		return;
	else
		lista_de_sinonimos.options[lista_de_sinonimos.selectedIndex] = null;
	
	remover_sinonimo();

}

// submete o formulario de lexico
function submeter_formulario_lexico(acao){
		
	if (acao == "remover"){
	
		var resposta = confirm("Deseja remover o s�mbolo \""+document.getElementById("nome").value+"\"?")
		if (resposta){
			document.dadosLexico.action = "../controle/controle_lexico.lp";
			document.getElementById("comando").value = "remover";
			document.dadosLexico.submit();
		}
				
	} else if (acao == "alterar"){
		document.dadosLexico.action = "alterar_lexico.lp";
		document.dadosLexico.submit();
	}

	
}

// submete o formul�rio de cen�rios
function submeter_formulario_cenario(acao){
		
	if (acao == "remover"){

		var resposta = confirm("Deseja remover o cen�rio \""+document.getElementById("titulo").value+"\" ?")
		if(resposta){	
			document.dadosCenario.action = "../controle/controle_cenario.lp";
			document.getElementById("comando").value = "remover";
			document.dadosCenario.submit;
		}	
	
	} else if (acao == "alterar"){
		document.dadosCenario.action = "alterar_cenario.lp";
		document.dadosCenario.submit();
	}
	
	
}




 
