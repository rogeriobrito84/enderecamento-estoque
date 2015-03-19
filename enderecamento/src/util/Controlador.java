package util;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import com.sun.corba.se.impl.javax.rmi.CORBA.Util;

public class Controlador extends HttpServlet{
	//Atributos
	private String destino;
	protected String acao;
	protected String pagina;
	protected String pasta;
	protected String msg = "";
	private final String PAGINA_ERRO = "erro";
	protected RequestDispatcher dispatcher;
	private Map<String, String> parametros;
	private Map<String, Object> atributos;
	private final String EXTENSAO = ".jsp";

	//Métodos
	protected void despachar(HttpServletRequest request, HttpServletResponse response) throws Exception{
		try {
			destino = montarUrl();
			setMensagensErros(request);
			setAtributos(request);
			dispatcher = request.getRequestDispatcher(destino);
			dispatcher.forward(request, response);
		} catch (Exception e) {
			pasta = "";
			pagina = PAGINA_ERRO;
			Utils.getErros().add(e.getMessage());
			redirecionar(response, request);
			e.printStackTrace();
		}
	}
	
	protected void redirecionar(HttpServletResponse response, HttpServletRequest request) throws Exception{
		destino = montarUrl();
		setMensagensErros(request);
		response.sendRedirect(destino);
	}
	
	private void setMensagensErros(HttpServletRequest request){
		//Setando as mensagem e os erros
		HttpSession session =  request.getSession();
		session.setAttribute("mensagens", Utils.getMensagens());
		session.setAttribute("erros", Utils.getErros());
	}
	
	private void setAtributos(HttpServletRequest request){
		//Setando a lista de atributos no 
		for (String chave : getAtributos().keySet()) {
			request.setAttribute(chave, getAtributos().get(chave));
		}
	}

	private String setExtensao(String pagina){
		if(pagina != null && !pagina.trim().isEmpty()){
			if(!pagina.endsWith(EXTENSAO)){
				pagina = pagina + EXTENSAO;
			}
		}
		return pagina;
	}
	
	private String montarUrl() throws Exception{
		String url = null;
		if(pagina != null){
			url = setExtensao(pagina);
			
			if(getParametros().size() > 0){
				url = url + "?";
				for (String chave: getParametros().keySet()) {
					url = url + chave + "=" + getParametros().get(chave) + "&";
				}
			}
			if(pasta != null && !pasta.trim().isEmpty()){
				url = pasta + "/" + url;
			}
		}else{
			throw new Exception("Página não informada");
		}
		return url;
	}

	private Map<String, String> getParametros() {
		if(parametros == null){
			parametros = new HashMap<String, String>();
		}
		return parametros;
	}

	private Map<String, Object> getAtributos() {
		if(atributos == null){
			atributos = new HashMap<String, Object>();
		}
		return atributos;
	}
	
	protected void addParametro(String nome, String valor){
		getParametros().put(nome, valor);
	}

	protected void addAtributo(String nome, Object objeto){
		getAtributos().put(nome, objeto);
	}
	
	protected String getAcao(HttpServletRequest request){
		String retorno = "";
		String parametroAcao = request.getParameter("acao");
		if(parametroAcao != null && !parametroAcao.trim().isEmpty()){
			retorno = parametroAcao;
		}
		return retorno;
	}
	
	protected String getParametroString(String parametro, HttpServletRequest request){
		parametro = request.getParameter(parametro);
		if(parametro == null){
			parametro = "";
		}
		return parametro;
	}
	
	protected int getParametroInteger(String parametro, HttpServletRequest request){
		int retorno = 0;
		try{
			parametro = request.getParameter(parametro);
			retorno = Integer.parseInt(parametro);
		}catch(NumberFormatException e){}
		return retorno;
	}
	
	protected boolean getParametroBoolean(String parametro, HttpServletRequest request) throws Exception{
		parametro = request.getParameter(parametro);
		return Utils.parseBoolean(parametro);
	}
	
	protected void setPaginaErro(Exception e, HttpServletRequest request, HttpServletResponse response){
		pasta = "";
		pagina = PAGINA_ERRO;
		if(e != null){
			Utils.getErros().add(e.getMessage());
		}
	}
	
	protected void limparMensagenErrosAtributos(){
		Utils.getMensagens().clear();
		Utils.getErros().clear();
		getParametros().clear();
	}
	
	
}
