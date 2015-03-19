package util;

public class RegraNegocioException extends Exception {
	private static final long serialVersionUID = 1L;
	
	public RegraNegocioException(){
		super();
	}
	
	public RegraNegocioException(String msg){
		super(msg);
	}
}
