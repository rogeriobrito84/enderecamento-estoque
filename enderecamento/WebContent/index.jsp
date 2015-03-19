
<!DOCTYPE html>
<html lang="pt-br">
<head>
	<%@ include file="/layout/cabecalho.jsp" %>
<title>GW Sistemas</title>
	 
</head>
<body>

<nav class="navbar navbar-inverse" ><!-- Menu  -->
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">GW Sistemas</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="#"  onclick="listarEnderecamentos();"><i class="glyphicon glyphicon-list"></i> Endereçamentos</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container -->
</nav><!-- Fim do Menu -->

<div class="container">
	<div class="row">
		<div class="col-sm-12">
<%-- 			<img alt="" src="${path}/img/logo-marca-gwsistemas.png" class="img-responsive img-rounded col-sm-12"> --%>
		</div>
	</div>
</div>
	
	
   
</body>
<script type="text/javascript">
	function listarEnderecamentos(){
		showAguarde();
		$(location).attr("href", "EnderecamentoControlador?acao=listarEnderecamentos&id_filial=1");
	}
</script>

</html>