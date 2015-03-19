package br.com.gwsistemas.enderecamento;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DAO;
import util.Utils;

/**
 * 
 * @author klebson lou
 * @author Rogerio Brito
 *  
 *  repositorio do endereçamento
 */
public class EnderecamentoDAO extends DAO{

	public List<Enderecamento> listarNivelSuperiorNull(int idFilial) throws Exception {
		List<Enderecamento> listaEnderecamento = null;
		Enderecamento enderecamento = null;
		sql = "select distinct on  (substr(ende.descricao, 0, strpos(ende.descricao, '.'))) substr(ende.descricao, 0, strpos(ende.descricao, '.')) as descricao, " 
				+ "estru.imagem as imagem, ende.is_ocupado as is_ocupado, estru.orientacao as orientacao, "
				+ " estru.quantidade_coluna as quantidade_coluna, estru.quantidade_linha as quantidade_linha, "
				+ "ende.posicao_x as posicao_x, ende.posicao_y as posicao_y,"
				+ "(select count(*) from enderecamento_estoque ende_inter where ende_inter.descricao like substr(ende.descricao, 0, strpos(ende.descricao, '.')) || '%' and ende_inter.is_ocupado = false) as qtd_disponivel, "
				+ "(select count(*) from enderecamento_estoque ende_inter where ende_inter.descricao like substr(ende.descricao, 0, strpos(ende.descricao, '.')) || '%' and ende_inter.is_ocupado = true) as qtd_ocupado, "
				+ "(case (select max(ordem) from estrutura_enderecamento) when  get_ordem_enderecamento('') then true else false end) as is_ultimo_nivel "
				+ "from enderecamento_estoque  ende, estrutura_enderecamento estru where estru.ordem = get_ordem_enderecamento('') and estru.filial_id = " + idFilial + " order by descricao";
		try {
			iniciarConexao();
			rs = conexao.createStatement().executeQuery(sql);
			if(existeRegristo(rs)){
				listaEnderecamento = new ArrayList<Enderecamento>();
				while(rs.next()){
					enderecamento = new Enderecamento();
					enderecamento.setDescricao(rs.getString("descricao"));
					enderecamento.setOcupado(rs.getBoolean("is_ocupado"));
					enderecamento.setQuantidadeDisponivel(rs.getInt("qtd_disponivel"));
					enderecamento.setImagem(rs.getString("imagem"));
					enderecamento.setQuantidadeOcupado(rs.getInt("qtd_ocupado"));
					enderecamento.setOrientacao(rs.getInt("orientacao"));
					enderecamento.setQuantidadeColunas(rs.getInt("quantidade_coluna"));
					enderecamento.setQuantidadeLinhas(rs.getInt("quantidade_linha"));
					enderecamento.setUltimoNivel(rs.getBoolean("is_ultimo_nivel"));
					enderecamento.setPosicao_x(rs.getInt("posicao_x"));
					enderecamento.setPosicao_y(rs.getInt("posicao_y"));
					listaEnderecamento.add(enderecamento);
				}
			}
		} catch (SQLException e) {
			Utils.lancarError(e, "Erro ao executar: " + sql);
		}catch (Exception e) {
			Utils.lancarError(e, null);
		}finally{
			fecharConexao();
		}
		return listaEnderecamento;
	}
	
	public List<Enderecamento> listarPorNivelSuperior(String descricao, int idFilial) throws Exception {
		List<Enderecamento> listaEnderecamento = null;
		Enderecamento enderecamento = null;
		sql = "select distinct on (get_enderecos_por_nivel(ende.descricao,'" + descricao + "')) get_enderecos_por_nivel(ende.descricao,'" + descricao + "') as descricao, "
				+ "estru.imagem as imagem, ende.is_ocupado as is_ocupado, "
				+ "ende.posicao_x as posicao_x, ende.posicao_y as posicao_y, (select distinct count(ende_x.posicao_x) from enderecamento_estoque ende_x where ende_x.descricao like substr(ende.descricao, 0, strpos(ende.descricao, '.')) || '%') as qtd_x, "
				+ "(select count(*) from enderecamento_estoque ende_inter where ende_inter.descricao like get_enderecos_por_nivel(ende.descricao,'" + descricao + "') || '%' and ende_inter.is_ocupado = false) as qtd_disponivel,"
				+ "(select count(*) from enderecamento_estoque ende_inter where ende_inter.descricao like get_enderecos_por_nivel(ende.descricao,'" + descricao + "') || '%' and ende_inter.is_ocupado = true) as qtd_ocupado, "
				+ "(case (select max(ordem) from estrutura_enderecamento) when  get_ordem_enderecamento(get_enderecos_por_nivel(ende.descricao,'" + descricao + "'))  then true else false end) as is_ultimo_nivel "
				+ "from enderecamento_estoque  ende, estrutura_enderecamento estru where estru.ordem = get_ordem_enderecamento('" + descricao + "') " 
				+ "and get_enderecos_por_nivel(ende.descricao,'" + descricao + "') != '' and estru.filial_id = " + idFilial + " order by descricao";
		
		try {
			iniciarConexao();
			rs = conexao.createStatement().executeQuery(sql);
			if(existeRegristo(rs)){
				listaEnderecamento = new ArrayList<Enderecamento>();
				while(rs.next()){
					enderecamento = new Enderecamento();
					enderecamento.setDescricao(rs.getString("descricao"));
					enderecamento.setOcupado(rs.getBoolean("is_ocupado"));
					enderecamento.setUltimoNivel(rs.getBoolean("is_ultimo_nivel"));
					enderecamento.setQuantidadeDisponivel(rs.getInt("qtd_disponivel"));
					enderecamento.setQuantidadeOcupado(rs.getInt("qtd_ocupado"));
					enderecamento.setImagem(rs.getString("imagem"));
					enderecamento.setPosicao_x(rs.getInt("posicao_x"));
					enderecamento.setPosicao_y(rs.getInt("posicao_y"));
					
					listaEnderecamento.add(enderecamento);
				}
			}
		} catch (SQLException e) {
			Utils.lancarError(e, "Erro ao executar: " + sql);
		}catch (Exception e) {
			Utils.lancarError(e, null);
		}finally{
			fecharConexao();
		}
		return listaEnderecamento;
	}

	
	
	public Enderecamento consultarEnderecamentosNivelSubNivel(String descricao, int idFilial) throws Exception {
		Enderecamento enderecamento = new Enderecamento();
		sql = "select distinct on (substr(ende.descricao, 1, length('" + descricao + "'))) substr(ende.descricao, 1, length('" + descricao + "')) as descricao, "
				+ " estru.quantidade_coluna as quantidade_coluna, estru.quantidade_linha as quantidade_linha, estru.orientacao as orientacao, "
				+ "estru.imagem as imagem, get_nivel_anterior('" + descricao + "') as nivel_anterior "
				+ "from enderecamento_estoque ende, estrutura_enderecamento estru "
				+ "where substr(ende.descricao, 1, length('" + descricao + "')) =  '" + descricao + "' "
				+ "and estru.ordem = get_ordem_enderecamento(get_enderecos_por_nivel(ende.descricao,'" + descricao +  "'))"
				+ " and estru.filial_id = " + idFilial + " order by descricao";
		try {
			iniciarConexao();
			rs = conexao.createStatement().executeQuery(sql);
			if(existeRegristo(rs)){
				while(rs.next()){
					enderecamento.setDescricao(rs.getString("descricao"));
					enderecamento.setOrientacao(rs.getInt("orientacao"));
					enderecamento.setQuantidadeColunas(rs.getInt("quantidade_coluna"));
					enderecamento.setQuantidadeLinhas(rs.getInt("quantidade_linha"));
					enderecamento.setImagem(rs.getString("imagem"));
					enderecamento.setNivelSuperior(rs.getString("nivel_anterior"));
				}
				enderecamento.setEnderecamentoNivel(listarNivelEnderecamento(descricao, idFilial));
				enderecamento.setEnderecamentos(listarPorNivelSuperior(descricao, idFilial));
			}
		} catch (SQLException e) {
			Utils.lancarError(e, "Erro ao executar: " + sql);
		}catch (Exception e) {
			Utils.lancarError(e, null);
		}finally{
			fecharConexao();
		}

		return enderecamento;
	}
	
	public List<Enderecamento> listarNivelEnderecamento(String descricao, int idFilial) throws Exception {
		List<Enderecamento> listaEnderecamento = null;
		Enderecamento enderecamento = null;
		sql = "select distinct on (substr(ende.descricao, 1, length('" + descricao + "'))) substr(ende.descricao, 1, length('" + descricao + "')) as descricao, "
				+"estru.quantidade_coluna as quantidade_coluna, estru.quantidade_linha as quantidade_linha, estru.orientacao as orientacao "
				+ "from enderecamento_estoque ende, estrutura_enderecamento estru "
				+ "where ende.descricao like get_nivel_anterior('" + descricao + "') || '%' "
				+ "and estru.ordem = get_ordem_enderecamento('" + descricao + "') and estru.filial_id = " + idFilial + " order by descricao"; 
		try {
			iniciarConexao();
			rs = conexao.createStatement().executeQuery(sql);
			if(existeRegristo(rs)){
				listaEnderecamento = new ArrayList<Enderecamento>();
				while(rs.next()){
					enderecamento = new Enderecamento();
					enderecamento.setDescricao(rs.getString("descricao"));
					enderecamento.setOrientacao(rs.getInt("orientacao"));
					enderecamento.setQuantidadeColunas(rs.getInt("quantidade_coluna"));
					enderecamento.setQuantidadeLinhas(rs.getInt("quantidade_linha"));
					listaEnderecamento.add(enderecamento);
				}
			}
		} catch (SQLException e) {
			Utils.lancarError(e, "Erro ao executar: " + sql);
		}catch (Exception e) {
			Utils.lancarError(e, null);
		}finally{
			fecharConexao();
		}
		return listaEnderecamento;
	}
}
