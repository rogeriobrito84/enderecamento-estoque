package br.com.gwsistemas.enderecamento;

import java.util.ArrayList;
import java.util.List;

public class Enderecamento {
	private int id;
	private String descricao;
	private boolean ocupado;
	private int estruturaId;
	//Não pesistentes
	private List<Enderecamento> enderecamentoNivel;
	private List<Enderecamento> enderecamentos;
	private String nivelSuperior;
	private int quantidadeColunas;
	private int quantidadeLinhas;
	private Enderecamento proximo;
	private Enderecamento anterior;
	private int quantidadeOcupado;
	private int quantidadeDisponivel;
	private int orientacao;
	private String imagem;
	private boolean ultimoNivel;
	private int posicao_x;
	private int posicao_y;
	//Constante
	private final String SEM_IMAGEM = "sem_imagem.png";
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	public String getNivelSuperior() {
		return nivelSuperior;
	}
	public void setNivelSuperior(String nivelSuperior) {
		this.nivelSuperior = nivelSuperior;
	}
	public boolean isOcupado() {
		return ocupado;
	}
	public void setOcupado(boolean ocupado) {
		this.ocupado = ocupado;
	}
	
	public int getEstruturaId() {
		return estruturaId;
	}
	public void setEstruturaId(int estruturaId) {
		this.estruturaId = estruturaId;
	}
	
	public List<Enderecamento> getEnderecamentoNivel() {
		if(enderecamentoNivel == null){
			enderecamentoNivel = new ArrayList<Enderecamento>();
		}
		return enderecamentoNivel;
	}
	public void setEnderecamentoNivel(List<Enderecamento> enderecamentoNivel) {
		this.enderecamentoNivel = enderecamentoNivel;
	}
	public List<Enderecamento> getEnderecamentos() {
		if(enderecamentos == null){
			enderecamentos = new ArrayList<Enderecamento>();
		}
		return enderecamentos;
	}
	public void setEnderecamentos(List<Enderecamento> enderecamentos) {
		this.enderecamentos = enderecamentos;
	}
	public int getQuantidadeColunas() {
		return quantidadeColunas;
	}
	public void setQuantidadeColunas(int quantidadeColunas) {
		this.quantidadeColunas = quantidadeColunas;
	}
	public int getQuantidadeLinhas() {
		return quantidadeLinhas;
	}
	public void setQuantidadeLinhas(int quantidadeLinhas) {
		this.quantidadeLinhas = quantidadeLinhas;
	}
	public Enderecamento getProximo() {
		if(proximo == null){
			proximo = new Enderecamento();
		}
		return proximo;
	}
	public void setProximo(Enderecamento proximo) {
		this.proximo = proximo;
	}
	public Enderecamento getAnterior() {
		if(anterior == null){
			anterior = new Enderecamento();
		}
		return anterior;
	}
	public void setAnterior(Enderecamento anterior) {
		this.anterior = anterior;
	}
	public int getQuantidadeOcupado() {
		return quantidadeOcupado;
	}
	public void setQuantidadeOcupado(int quantidadeOcupado) {
		this.quantidadeOcupado = quantidadeOcupado;
	}
	public int getQuantidadeDisponivel() {
		return quantidadeDisponivel;
	}
	public void setQuantidadeDisponivel(int quantidadeDisponivel) {
		this.quantidadeDisponivel = quantidadeDisponivel;
	}
	
	public int getOrientacao() {
		return orientacao;
	}
	public void setOrientacao(int orientacao) {
		this.orientacao = orientacao;
	}
	public String getImagem() {
		if(imagem == null || imagem.trim().isEmpty()){
			imagem = SEM_IMAGEM;
		}
		return imagem;
	}
	public void setImagem(String imagem) {
		this.imagem = imagem;
	}
	public boolean isUltimoNivel() {
		return ultimoNivel;
	}
	public void setUltimoNivel(boolean ultimoNivel) {
		this.ultimoNivel = ultimoNivel;
	}
	public int getPosicao_x() {
		return posicao_x;
	}
	public void setPosicao_x(int posicao_x) {
		this.posicao_x = posicao_x;
	}
	public int getPosicao_y() {
		return posicao_y;
	}
	public void setPosicao_y(int posicao_y) {
		this.posicao_y = posicao_y;
	}
	
}
