package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * 
 * @author klebson  lou
 * classe para pegar conexao com o banco
 */
public class Conexao {

	//singleton para conexao com banco	
	public static Connection getConexao() throws Exception{
		Connection con = null;
		String usuario = "postgres";
		String senha = "12345";
		String banco = "enderecamento_db";
		String url = "jdbc:postgresql://localhost:5432/";
		String classeConexao = "org.postgresql.Driver";
		try {
			Class.forName(classeConexao);
			con = DriverManager.getConnection(url + banco, usuario, senha);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			throw new Exception("Erro ao carregar a classe de conexão: " + classeConexao + "!");
		} catch (SQLException e) {
			e.printStackTrace();
			throw new Exception("Erro ao conectar ao banco de dados: " + banco + ", usuário: " 
								+ usuario +  " e a url: "+ url + "!");
		}
	    return con;
	}
	//fecha conexao com banco
}
