<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
      <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">GW Sistemas</a>
    </div>
    
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	<!--     Botão voltar -->
	    <ul class="nav navbar-nav navbar-right">
	    	<li><a href="javascript: history.back();"> <i class="glyphicon glyphicon-arrow-left"></i> Voltar </a></li>
	    </ul>
    </div>

  </div><!-- /.container -->
</nav><!-- Fim do Menu -->

<div class="container">
	<div class="row">
		<div class="page-header">
			<h1>Página de erros.</h1>
		</div>
			<div class="col-sm-12">
				<c:if test="${erros.size() > 0}">
					<c:forEach items="${erros}" var="erro">
						<c:set var="erroTrim" value="${fn:trim(erro)}" />
						<c:if test="${erroTrim != ''}">
							<div class="alert alert-danger alert-dismissible fade in" role="alert">
			 					<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			 					<strong>${erro}</strong> 
						</div>
						</c:if>
					</c:forEach>
				</c:if>
				<c:if test="${mensagens.size() > 0}">
					<c:forEach items="${mensagens}" var="msg">
						<c:set var="msgTrim" value="${fn:trim(msg)}" />
						<c:if test="${msgTrim != ''}">
							<div class="alert alert-success alert-dismissible fade in" role="alert">
				 					<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				 					<strong>${msg}</strong> 
							</div>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
	</div>
</div>

   
</body>
<script type="text/javascript">
</script>

</html>