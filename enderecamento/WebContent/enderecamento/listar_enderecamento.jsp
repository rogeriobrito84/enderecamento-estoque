<!DOCTYPE html>
<html lang="pt-br">
<head>
	<%@ include file="/layout/cabecalho.jsp" %>
<title>GW Sistemas</title>
</head>
<body>
<!-- Definindo a largura da página e dos itens -->
<fmt:formatNumber var="larguraTela" value="${(enderecamento.quantidadeColunas * 10) + 4}" pattern="#####0"/> 

<nav class="navbar navbar-inverse" style="min-width: ${larguraTela}em"><!-- Menu  -->
  <div class="container-fluid" >
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${path}/index.jsp">GW Sistemas</a>
    </div>
    
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	<!--     Botão voltar -->
	    <ul class="nav navbar-nav navbar-right">
	    	<li><a href="javascript: history.back();"> <i class="glyphicon glyphicon-arrow-left"></i> Voltar </a></li>
	    </ul>
    </div>

  </div><!-- /.container -->
</nav><!-- Fim do Menu -->
<!-- Fim do Menu -->

<div class="container" style="min-width: ${larguraTela}em">
	<div class="row" >
			<div class="col-sm-12 form-group text-center">
				<div class="col-sm-10 col-sm-offset-2  btn-group text-center">
					<button class="btn btn-default  col-sm-2" ${enderecamento.anterior.descricao == null || enderecamento.anterior.descricao == '' ? "disabled" : ""} 
						onclick="carregarEnderecamento('${enderecamento.anterior.descricao}');">
						<i class="glyphicon glyphicon-step-backward"></i> Anterior
					</button>
					<button class="btn btn-default  col-sm-1" ${enderecamento.nivelSuperior ==  null ? "disabled" : ""}
							onclick="carregarEnderecamento('${enderecamento.nivelSuperior}');" >
						<i class="glyphicon glyphicon-arrow-up"></i>&nbsp;
					</button>
					<button class="btn  col-sm-5 btn-central" >
						<b>${enderecamento.descricao}</b>
					</button>
					<button class="btn btn-default  col-sm-2" ${enderecamento.proximo.descricao == null || enderecamento.proximo.descricao == '' ? "disabled" : ""} 
						onclick="carregarEnderecamento('${enderecamento.proximo.descricao}');">
						Próximo <i class="glyphicon glyphicon-step-forward"></i>
					</button>
				</div>
			</div>
		<c:if test="${enderecamento.enderecamentos.size() == 0}">
			<div class="col-sm-12 text-center ">
				<h2>Não existe nenhum enderaçamento cadastrado!</h2>
			</div>
		</c:if>
	</div>
<!-- 	Definindo a largura que dos endereçamentos -->
	<fmt:formatNumber var="coluna" value="${0}" pattern="#####0"/> <!-- Contador de colunas --> 
	
	 
<%-- 	Páginas: <c:out value="${enderecamento.quantidadePaginas}"></c:out><br> --%>
<%-- 	Colunas:  <c:out value="${enderecamento.quantidadeColunas}"></c:out><br> --%>
<%-- 	Linhas: <c:out value="${enderecamento.quantidadeLinhas}"></c:out><br> --%>
<%-- 	Registros: <c:out value="${enderecamento.enderecamentos.size()}"></c:out><br> --%>
	<c:forEach var="end" items="${enderecamento.enderecamentos}" varStatus="index">
		<c:set var="tipoPanel" value="${end.ultimoNivel ? (end.ocupado ? 'panel-danger' : 'panel-success')
										: (end.quantidadeDisponivel le 0 ? 'panel-danger' : 'panel-success')}"></c:set>
		<c:set var="funcaoCarregar" value="carregarEnderecamento('${end.descricao}');"></c:set><!-- Função java script ao clicar no enderecamento se não for ultimo nível -->
		<c:set var="funcaoMostrar" value="mostrar('${end.descricao}', '${path}/img/${end.ocupado  ? 'pallet.png' : 'pallet_disponivel.png'}');"></c:set><!-- Função java script ao clicar no enderecamento se não for ultimo nível -->
		<c:set var="onclick" value="${end.ultimoNivel ? funcaoMostrar : funcaoCarregar}"></c:set><!-- Verificando se a ultima estrutura para inseirir a funçao javascript -->
		<!-- Se estiver começando uma nova linha a coluna é igual a zero -->
		<c:if test="${coluna == 0}">
			<div class="row " style="padding: 0em 2em 0em 2em;" >
				<div >
		</c:if>
			  <c:if test="${end.descricao == null or end.descricao == ''}"> <!-- Se endereçamento da lista for apenas para completar a ordenação mostrar um espaço vázio -->
				<div style="min-width: 9em;max-width: 9em; float:left; margin-right: 1em;min-height: 8em;">
<!-- 					<div class="panel panel-default"> -->
<!-- 						<div class="panel-heading text-center"> -->
<!-- 						<label class="control-label"> -->
<!-- 							Vázio -->
<!-- 						</label> -->
<!-- 						</div> -->
<!-- 						<div class="panel-body text-left"> -->
<!-- 						</div> -->
<!-- 					</div> -->
					&nbsp;
				</div>
			  </c:if>
			  <c:if test="${end.descricao != null and end.descricao != ''}"><!-- Se o endereçamento realmente existir -->
				<div style="min-width: 9em;max-width: 9em; float:left; margin-right: 1em;">
						<div class="panel ${tipoPanel}" onclick="${onclick}"><!-- Informando o a função a ser chamada. -->
						<div class="panel-heading text-center">
						<label class="control-label" style="font-size: 0.8em;color: black;">
							${end.descricao}
						</label>
						</div>
						<div class="panel-body text-left">
							<c:if test="${not end.ultimoNivel}"><!-- Se o endereçamento não for a ultima estrutura -->
								<img alt="" src="${path}/img/${enderecamento.imagem}" class="img-responsive img-rounded">
							<label style="font-size: 0.9em;margin-top:1em;"><b>Disponíveis:</b> ${end.quantidadeDisponivel}</label><br>
							<label style="font-size: 0.9em;"><b>Ocupados:</b> ${end.quantidadeOcupado}</label>
							</c:if>
							<c:if test="${end.ultimoNivel}"><!-- Se o endereçamento  for a ultima estrutura -->
								<c:if test="${end.ocupado}">
									<img alt="" src="${path}/img/pallet.png" class="img-responsive img-rounded">
								</c:if>
								<c:if test="${not end.ocupado}">
									<img alt="" src="${path}/img/pallet_disponivel.png" class="img-responsive img-rounded">
								</c:if>
								
							</c:if>
							
						</div>
					</div>
				</div>
			  </c:if>
				<fmt:formatNumber var="coluna" value="${coluna + 1}" pattern="#####0"/> 
		<c:if test="${coluna == enderecamento.quantidadeColunas}">
			</div> <!--Fechar a div a coluna 12 -->
			</div> <!--Fechar a div row -->
			<fmt:formatNumber var="coluna" value="${0}" pattern="#####0"/> 
			<fmt:formatNumber var="linha" value="${linha + 1}" pattern="#####0"/> 
		</c:if>
	</c:forEach>
	<c:if test="${coluna < enderecamento.quantidadeColunas}"><!-- Se o número de colunas não for exato fechar as divs -->
		</div> <!--  Fechar a div coluna 12 caso a quantidade de colunas chegue ao limite -->
		</div> <!--Fechar a div row  a quantidade de colunas chegue ao limite -->
	</c:if>
</div>
<input type="hidden" id="id_filial" value="${idFilial}" >

   
</body>
<script type="text/javascript">
	
	$(document).ready(function(){
	    var classe;
	    $(".panel").hover(function(){
	    	classe = "";
	    	if($(this).hasClass("panel-danger")){
	    		classe = "panel-danger";
	    		$(this).removeClass(classe);
	    	}
	    	$(this).addClass("panel-info");
	    }, function(){
	    	$(this).removeClass("panel-info");
	    	$(this).addClass(classe);
	    });
	    
	    $(".btn-group .btn").hover(function(){
	    	$(this).addClass("btn-info");
	    }, function(){
	    	$(this).removeClass("btn-info");
	    });
		
	});
	
	function carregarEnderecamento(descricao){
		showAguarde();
		$(location).attr("href", "EnderecamentoControlador?acao=listarEnderecamentos&descricao=" + descricao + "&id_filial=" + $("#id_filial").val());
	}
	
	function mostrar(descricao, imagem){
		showMsg("<div class='row' style='padding: 20px;'><img src='" + imagem + "' class='col-sm-6 img-responsive img-rounde'></div>", descricao, "primario");
	}
	
</script>

<style>
.panel{
	cursor: pointer;
}

.panel{
	 margin-bottom: 5px;
}
.panel-body {
  padding: 3px 15px 0px 15px;
}
.panel-heading {
  padding: 0px 5px 0px 5px;
}
.navbar {
  margin-bottom: 0px;
}

.form-group {
  margin-bottom: 7px;
}
.btn-central{
	color:black;
	font-size:1em;
	cursor: not-allowed;
	background: white;
	border: 1px solid #ccc;
}
.btn-central:hover{
	color:black;
	cursor: not-allowed;
	background: white;
	border: 1px solid #ccc
}
</style>
</html>