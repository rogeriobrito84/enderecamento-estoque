package util;

import java.util.ArrayList;
import java.util.List;

public class Utils {
	//Atributos
	private static List<String> mensagens;
	private static List<String> erros;
	
	//Métodos
	public static List<String> getMensagens() {
		if(mensagens == null){
			mensagens = new ArrayList<String>();
		}
		return mensagens;
	}
	public static List<String> getErros() {
		if(erros == null){
			erros = new ArrayList<String>();
		}
		return erros;
	}
	
	
	public static int parseInt(String valor) throws Exception{
		int numero = 0;
		try {
			numero = Integer.parseInt(valor);
			return numero;
		} catch (NumberFormatException e) {
			throw new Exception("Erro ao converte uma string para inteiro!");
		}
	}
	
	public static boolean parseBoolean(String valor) throws Exception{
		boolean retorno = false;
		try {
			retorno = Boolean.parseBoolean(valor);
			return retorno;
		} catch (NumberFormatException e) {
			throw new Exception("Erro ao converte uma string para booleano!");
		}
	}
	
	public static void lancarError(Exception e, String msg) throws Exception{
		if(msg == null || "".equals(msg)){
			if(e != null){
				msg = e.getMessage();	
				e.printStackTrace();
			}else{
				msg = "Erro desconhecido!";
			}
		}else if(e != null){
			msg = e.getMessage();
			e.printStackTrace();
		}
		if(!msg.trim().isEmpty()){
			throw new Exception(msg); 
		}
	}
	
	
	
}