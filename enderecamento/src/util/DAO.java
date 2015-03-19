package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DAO {
	protected String sql;
	protected String sqlAux;
	
	protected Connection conexao = null;
	protected Statement stmt = null;
	protected PreparedStatement pstmt = null;
	protected PreparedStatement pstmt2 = null;
	protected ResultSet rs;
	
	public void iniciarConexao() throws Exception{
		if(conexao == null || (conexao != null && conexao.isClosed())){
				conexao = Conexao.getConexao();
		}
	}
	
	public void fecharConexao() throws Exception{
		if(conexao != null){
			try {
				conexao.close();
				if(stmt != null && !stmt.isClosed()){
					stmt.close();
				}
				if(pstmt != null && !pstmt.isClosed()){
					pstmt.close();
				}
				if(pstmt2 != null && !pstmt2.isClosed()){
					pstmt2.close();
				}
			} catch (SQLException e) {
				throw new Exception("Erro ao fechar conexao");
			}
		}
	}
	
	
	protected boolean existeRegristo(ResultSet rs) throws SQLException{
		boolean retorno = false;
		if(rs != null){
			retorno = true;
		}
		return retorno;
	}
}
