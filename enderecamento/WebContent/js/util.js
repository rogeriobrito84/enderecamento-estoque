
//Ap�s carregar a p�gina 
function inicial(){
}
$(document).ready(function() {
	inicial();
});


function showMsg(msg, titulo, tipo){
	var titulo;
	if(titulo == null || titulo == undefined){
		titulo = "Mensagem";
	}
	if(tipo == null || tipo == undefined){
		tipo = 'type-default';
	}else{
		switch(tipo){
			case "padrao": tipo = 'type-default';
			break;
			case "informacao": tipo = 'type-info';
			break;
			case "primario": tipo = 'type-primary';
			break;
			case "sucesso": tipo = 'type-success';
			break;
			case "atencao": tipo = 'type-warning';
			break;
			case "erro": tipo = 'type-danger';
			break;
			default: tipo = 'type-default';
		}
	}
	BootstrapDialog.show({
		title: titulo,
		message: msg,
		type: tipo,
	    draggable: true,
	    buttons: [{
	        icon: 'glyphicon glyphicon-check',       
	        label: 'OK',
	        cssClass: 'btn-primary', 
	        autospin: false,
	        action: function(dialogRef){    
	            dialogRef.close();
	        }
	    }]
	});
}

function showAguarde(){
	BootstrapDialog.show({
		title: "Aguarde...",
		message: "<div style='margin:0 auto;text-align: center; width: 20em;'><button class='btn btn-default  btn-carregando'></button></div>",
		draggable: true,
		closable: false
	 });
}

function showModal(texto , titulo){
	if(texto == undefined || texto == null){
		texto = "Mensagem Modal";
	}
	if(titulo == undefined || titulo == null){
		titulo = "Mensagem";
	}
	 BootstrapDialog.show({
		title: titulo,
		message: texto,
		draggable: true
	 });
}

function limparAlerts(){
	$(" .alert").slideUp("500");
}

