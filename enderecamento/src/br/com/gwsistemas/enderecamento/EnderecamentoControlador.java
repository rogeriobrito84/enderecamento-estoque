package br.com.gwsistemas.enderecamento;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.Controlador;


/**
 * Servlet implementation class EnderecamentoControlador
 */
public class EnderecamentoControlador extends Controlador {
	private static final long serialVersionUID = 1L;
    private EnderecamentoBO enderecamentoBO;
    private String imagem = "";
	//pastas
    private final String PASTA_ENDERECAMENTO = "enderecamento/";
    private final String PASTA_LAYOUT = "layout/";
    //Páginas
	private final String PAGINA_LISTAR_ENDERECAMENTO = "listar_enderecamento";
	//Ações
	private final String LISTAR_ENDERECAMENTOS = "listarEnderecamentos";
	
	private EnderecamentoBO getEnderecamentoBO(){
		if(enderecamentoBO == null){
			enderecamentoBO = new EnderecamentoBO();
		}
		return enderecamentoBO;
	}
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		limparMensagenErrosAtributos();
		acao = getAcao(request);
//		Listar Endereçamento
		if(acao.equalsIgnoreCase(LISTAR_ENDERECAMENTOS)){
			listarEnderecamento(request, response);
		}
		try {
			despachar(request, response);
		} catch (Exception e) {
			setPaginaErro(e, request, response);
			try {redirecionar(response, request);} catch (Exception e1) {e1.printStackTrace();}
		}
	}
	
	
	private void listarEnderecamento(HttpServletRequest request, HttpServletResponse response){
		pagina = PAGINA_LISTAR_ENDERECAMENTO;
		pasta = PASTA_ENDERECAMENTO;
		String descricao = getParametroString("descricao", request);
		int idFilial = getParametroInteger("id_filial", request);
		Enderecamento enderecamento = null;
		try {
			enderecamento = getEnderecamentoBO().consultarEnderecamentoNivelSubNivel(descricao, idFilial);
		} catch (Exception e) {
			setPaginaErro(e, request, response);
		}finally{
			addAtributo("enderecamento", enderecamento);
			addAtributo("idFilial", idFilial);
		}

	}
}
