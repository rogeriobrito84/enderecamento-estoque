package br.com.gwsistemas.enderecamento;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

public class EnderecamentoBO {
	
	private EnderecamentoDAO enderecamentoDAO = null;
	private boolean valido;
	
	//Métodos
	private EnderecamentoDAO getDao(){
		if(enderecamentoDAO == null){
			enderecamentoDAO = new EnderecamentoDAO();
		}
		return enderecamentoDAO;
	}
	
	public Enderecamento consultarEnderecamentoNivelSubNivel(String descricao, int idFilial) throws Exception{
		Enderecamento enderecamento = null;
		if(descricao == null || descricao.isEmpty()){
			enderecamento = new Enderecamento();
			enderecamento.setDescricao("Lista de Endereçamentos");
			enderecamento.setEnderecamentos(getDao().listarNivelSuperiorNull(idFilial));
			if(!enderecamento.getEnderecamentos().isEmpty()){
				enderecamento.setOrientacao(enderecamento.getEnderecamentos().get(0).getOrientacao());
				enderecamento.setQuantidadeColunas(enderecamento.getEnderecamentos().get(0).getQuantidadeColunas());
				enderecamento.setQuantidadeLinhas(enderecamento.getEnderecamentos().get(0).getQuantidadeLinhas());
				enderecamento.setImagem(enderecamento.getEnderecamentos().get(0).getImagem());
			}
			
		}else{
			enderecamento = getDao().consultarEnderecamentosNivelSubNivel(descricao, idFilial);
			if(enderecamento.getEnderecamentoNivel().size() > 0){
				setAnteriorProximoEmLista(enderecamento);
			}
		}
		
		if(enderecamento.getEnderecamentos().size() > 0){
			ordenarSetColunasSetLinhas(enderecamento);
			enderecamento.setUltimoNivel(enderecamento.getEnderecamentos().get(0).isUltimoNivel());
		}
		return enderecamento;
	}
	
	public void ordenarSetColunasSetLinhas(Enderecamento enderecamento) {
		
		if(!enderecamento.getEnderecamentos().get(0).isUltimoNivel()){
			List<Enderecamento> lista = new ArrayList<Enderecamento>();
			lista = completaLista(enderecamento, enderecamento.getEnderecamentos());
			
			switch (enderecamento.getOrientacao()) {
				case 1:
					enderecamento.setEnderecamentos(verificaTamanhoLista(enderecamento));
					break;
				case 2:
					enderecamento.setEnderecamentos(ordenamentoHorizontalAscDireita(enderecamento, lista));
					break;
				case 3:
					enderecamento.setEnderecamentos(ordenamentoHorizontalDescEsquerda(enderecamento, lista));
					break;
				case 4:
					List<Enderecamento> listaRev = verificaTamanhoLista(enderecamento);
					Collections.reverse(listaRev);
					enderecamento.setEnderecamentos(listaRev);
					break;
				case 5:
					List<Enderecamento> listaInvertida = ordenamentoVerticalDescDireita(enderecamento, lista);
					Collections.reverse(listaInvertida);
					enderecamento.setEnderecamentos(lista);
					break;
				case 6:
					enderecamento.setEnderecamentos(ordenamentoVerticalAscDireita(enderecamento, lista));
					break;
				case 7:
					enderecamento.setEnderecamentos(ordenamentoVerticalDescEsquerda(enderecamento, lista));
					break;
				case 8:
					enderecamento.setEnderecamentos(ordenamentoVerticalDescDireita(enderecamento, lista));
					break;
				default:
					enderecamento.setEnderecamentos(lista);
			}
		}else{
			//Aqui é definido se o a diretriz X vai ser ASC ou Des(de cima pra baixo ou de baixo pra cima) 
			ordenarXY(enderecamento, false);
		}
	}
	
	private List<Enderecamento> ordenamentoPorPosicao(Enderecamento enderecamento, List<Enderecamento> list) {
		
		Object[] arryLista = new Object[list.size()];
		arryLista = list.toArray();
		List<Enderecamento> listaCompleta = new ArrayList<Enderecamento>();
		List<Integer> listaX = new ArrayList<Integer>();
		for (Enderecamento listEnderecamento : list) {
			if(!listaX.contains(listEnderecamento.getPosicao_x())){
				listaX.add(listEnderecamento.getPosicao_x());
			}
		}
		Collections.sort(listaX);
		for (Integer integer : listaX) {
			int p = 0;
			p = sizePosicaoX(list, integer);
			for(int i = 0; i < p; i++){
				List<Enderecamento> lista = new ArrayList<Enderecamento>();
				for(int j = 0; j < arryLista.length; j++){
					valido = false;
					Enderecamento enderecamentoPosicao = getEnderecamentoPosicao(integer,j,list);
					if(valido){
						lista.add(enderecamentoPosicao);
					}
				}
				listaCompleta.addAll(completaListaPosicao(enderecamento, lista));
				break;
			}
		}
		
		return listaCompleta;
	}
	
	private int sizePosicaoX(List<Enderecamento> list,  int posicao){
		int count = 0;
		for (Enderecamento enderecamento : list) {
			if(enderecamento.getPosicao_x() == posicao){
				count = count + 1;
			}
		}
		return count;
	}
	
	private Enderecamento getEnderecamentoPosicao(int posicaoX, int posicaoY, List<Enderecamento> list){
		Object[] arryLista = new Object[list.size()];
		arryLista = list.toArray();
	
		Enderecamento ende = new Enderecamento();
		for(int j = 0; j < arryLista.length; j++){
			if(((Enderecamento) arryLista[j]).getPosicao_x() == posicaoX && ((Enderecamento) arryLista[j]).getPosicao_y() == posicaoY){
				ende = ((Enderecamento) arryLista[j]);
				valido = true;
				return ende;
			}else{
				valido = false;
			}
		}
		
		return ende;
	}
	
	private List<Enderecamento> completaListaPosicao(Enderecamento enderecamento, List<Enderecamento> lista) {
		int numeroColunas = enderecamento.getQuantidadeColunas();
		int diferenca = 0;
		if ( numeroColunas > lista.size()) {
			diferenca = (int) ( numeroColunas - lista.size());
		}
		while (diferenca > 0) {
			Enderecamento end = new Enderecamento();
			lista.add(end);
			diferenca--;
		}
		if (numeroColunas < lista.size()){
			Object[] arryLista = new Object[lista.size()];
			arryLista = lista.toArray();
			List<Enderecamento> listaTruncada = new ArrayList<Enderecamento>();
			for(int i = 0; i < numeroColunas; i++){
				listaTruncada.add((Enderecamento) arryLista[i]);
			}
			return listaTruncada;
		}
		return lista;
	}
	
	private List<Enderecamento> verificaTamanhoLista(Enderecamento enderecamento){
		int numeroLinhas = enderecamento.getQuantidadeLinhas();
		int numeroColunas = enderecamento.getQuantidadeColunas();
		List<Enderecamento> lista = new ArrayList<Enderecamento>();
		lista = enderecamento.getEnderecamentos();
		if((numeroColunas * numeroLinhas) < enderecamento.getEnderecamentos().size()){
			lista = new ArrayList<Enderecamento>();
			Object[] ende = new Object[numeroColunas * numeroLinhas];
			ende = enderecamento.getEnderecamentos().toArray();
			for(int i = 0; i<numeroColunas * numeroLinhas; i++){
				lista.add((Enderecamento) ende[i]);
			}
		}
		enderecamento.setEnderecamentos(lista);
		return lista;
	}

	/**
	 * Verifica se a lista está com o mesmo tamanho do numero de linhas X colunas.
	 * Caso esteja menor completa a lista.
	 * 
	 * @param lista
	 * @param numeroLinhas
	 * @param numeroColunas
	 * @return ArrayList de Enderecamento atualizado
	 */
	private List<Enderecamento> completaLista(Enderecamento enderecamento, List<Enderecamento> lista) {
		int numeroLinhas = enderecamento.getQuantidadeLinhas();
		int numeroColunas = enderecamento.getQuantidadeColunas();
		int diferenca = 0;
		if ((numeroLinhas * numeroColunas) > lista.size()) {
			diferenca = (int) ((numeroLinhas * numeroColunas) - lista.size());
		}
		while (diferenca > 0) {
			Enderecamento end = new Enderecamento();
			lista.add(end);
			diferenca--;
		}
		return lista;
	}

	/**
	 * Ordena o ArrayList de Enderecamento caso a opção de ordenação seja "2"
	 * 
	 * @param list
	 * @param NumeroColunas
	 * @param numeroLinhas
	 * 
	 * @return ArrayList de Enderecamento ordenado 
	 */
	private List<Enderecamento> ordenamentoHorizontalAscDireita(Enderecamento enderecamento, List<Enderecamento> list) {
		List<Enderecamento> lista = new ArrayList<Enderecamento>();
		Object[] arryOrdenado = new Object[list.size()];
		arryOrdenado = list.toArray();

		int numeroLinhas = enderecamento.getQuantidadeLinhas();
		int numeroColunas = enderecamento.getQuantidadeColunas();
		int numeroTemp = numeroColunas;
		int numeroTemp2 = numeroColunas - numeroTemp;
		int j = 1;
		while (numeroLinhas > 0) {
			for (int i = 0; i < arryOrdenado.length; i++) {
				while (numeroTemp > numeroTemp2) {
					lista.add((Enderecamento) arryOrdenado[numeroTemp - 1]);
					System.out.println(((Enderecamento) arryOrdenado[numeroTemp - 1]).getDescricao());
					numeroTemp--;
				}
			}
			j++;
			numeroTemp2 = numeroColunas * j - numeroColunas;
			numeroTemp = numeroColunas * j;
			numeroLinhas--;
		}
		return lista;
	}

	/**
	 * Ordena o ArrayList de Enderecamento caso a opção de ordenação seja "3"
	 * 
	 * @param list
	 * @param NumeroColunas
	 * @param numeroLinhas
	 * 
	 * @return ArrayList de Enderecamento ordenado 
	 */
	private List<Enderecamento> ordenamentoHorizontalDescEsquerda(Enderecamento enderecamento, List<Enderecamento> list) {
		List<Enderecamento> lista = new ArrayList<Enderecamento>();
		Object[] arryOrdenado = new Object[list.size()];
		arryOrdenado = list.toArray();
		int numeroLinhas = enderecamento.getQuantidadeLinhas();
		int numeroColunas = enderecamento.getQuantidadeColunas();
		int p = 1;
		int numeroTemp = numeroColunas;
		while (numeroLinhas > 0) {
			for (int i = 0; i < arryOrdenado.length; i++) {
				while (numeroTemp > 0) {
					lista.add((Enderecamento) arryOrdenado[((numeroColunas * numeroLinhas) - (numeroColunas - p)) - 1]);
					System.out.println(((Enderecamento) arryOrdenado[((numeroColunas * numeroLinhas) - (numeroColunas - p)) - 1]).getDescricao());
					numeroTemp--;
					p++;
				}
				numeroTemp = numeroColunas;
				p = 1;
				numeroLinhas--;
				if (numeroLinhas == 0) {
					break;
				}
			}
		}
		return lista;
	}

	/**
	 * Ordena o ArrayList de Enderecamento caso a opção de ordenação seja "6"
	 * 
	 * @param list
	 * @param NumeroColunas
	 * @param numeroLinhas
	 * 
	 * @return ArrayList de Enderecamento ordenado 
	 */
	private List<Enderecamento> ordenamentoVerticalAscDireita(Enderecamento enderecamento, List<Enderecamento> list) {
		List<Enderecamento> lista = new ArrayList<Enderecamento>();
		Object[] arryOrdenado = new Object[list.size()];
		arryOrdenado = list.toArray();
		int numeroLinhas = enderecamento.getQuantidadeLinhas();
		int numeroColunas = enderecamento.getQuantidadeColunas();
		int x = 0;
		int p = 0;
		int numeroTemp = numeroColunas;
		int numeroLinhaTemp = numeroLinhas;
		while (numeroLinhas > 0) {
			for (int i = 0; i < arryOrdenado.length; i++) {
				while (numeroTemp > 0) {
					lista.add((Enderecamento) arryOrdenado[((((numeroColunas * numeroLinhaTemp) - (numeroLinhaTemp - 1)) - (numeroLinhaTemp * x)) + p) - 1]);
					System.out.println(((Enderecamento) arryOrdenado[((((numeroColunas * numeroLinhaTemp) - (numeroLinhaTemp - 1)) - (numeroLinhaTemp * x)) + p) - 1]).getDescricao());
					numeroTemp--;
					x++;
				}
				numeroTemp = numeroColunas;
				p++;
				x = 0;
				numeroLinhas--;
				if (numeroLinhas == 0) {
					break;
				}
			}
		}
		return lista;
	}

	/**
	 * Ordena o ArrayList de Enderecamento caso a opção de ordenação seja "7"
	 * 
	 * @param list
	 * @param NumeroColunas
	 * @param numeroLinhas
	 * 
	 * @return ArrayList de Enderecamento ordenado 
	 */
	private List<Enderecamento> ordenamentoVerticalDescEsquerda(Enderecamento enderecamento, List<Enderecamento> list) {
		List<Enderecamento> lista = new ArrayList<Enderecamento>();
		Object[] arryOrdenado = new Object[list.size()];
		arryOrdenado = list.toArray();
		int numeroLinhas = enderecamento.getQuantidadeLinhas();
		int numeroColunas = enderecamento.getQuantidadeColunas();
		int x = 1;
		int p = 0;
		int numeroTemp = numeroColunas;
		int numeroLinhaTemp = numeroLinhas;
		while (numeroLinhas > 0) {
			for (int i = 0; i < arryOrdenado.length; i++) {
				while (numeroTemp > 0) {
					lista.add((Enderecamento) arryOrdenado[((((numeroColunas * numeroLinhaTemp) - (numeroLinhaTemp * (numeroColunas - 1))) * x) - p) - 1]);
					System.out.println(((Enderecamento) arryOrdenado[((((numeroColunas * numeroLinhaTemp) - (numeroLinhaTemp * (numeroColunas - 1))) * x) - p) - 1]).getDescricao());
					numeroTemp--;
					x++;
				}
				numeroTemp = numeroColunas;
				p++;
				x = 1;
				numeroLinhas--;
				if (numeroLinhas == 0) {
					break;
				}
			}
		}
		return lista;
	}

	/**
	 * Ordena o ArrayList de Enderecamento caso a opção de ordenação seja "8"
	 * 
	 * @param list
	 * @param NumeroColunas
	 * @param numeroLinhas
	 * 
	 * @return ArrayList de Enderecamento ordenado 
	 */
	private List<Enderecamento> ordenamentoVerticalDescDireita(Enderecamento enderecamento, List<Enderecamento> list) {
		List<Enderecamento> lista = new ArrayList<Enderecamento>();
		int tamanhoLista = list.size();
		Object[] arryOrdenado = new Object[tamanhoLista];
		arryOrdenado = list.toArray();
		int numeroLinhas = enderecamento.getQuantidadeLinhas();
		int numeroColunas = enderecamento.getQuantidadeColunas();
		int x = 0;
		int p = 0;
		int numeroTemp = numeroColunas;
		int numeroLinhaTemp = numeroLinhas;
		while (numeroLinhas > 0) {
			for (int i = 0; i < arryOrdenado.length; i++) {
				while (numeroTemp > 0) {
					lista.add((Enderecamento) arryOrdenado[(((numeroColunas * numeroLinhaTemp) - (numeroLinhaTemp * x)) - p) - 1]);
					System.out.println(((Enderecamento) arryOrdenado[(((numeroColunas * numeroLinhaTemp) - (numeroLinhaTemp * x)) - p) - 1]).getDescricao());
					numeroTemp--;
					x++;
				}
				numeroTemp = numeroColunas;
				p++;
				x = 0;
				numeroLinhas--;
				if (numeroLinhas == 0) {
					break;
				}
			}
		}
		return lista;
	}
	
//	public void setAnteriorProximo(List<Enderecamento> list){
//		List<Enderecamento> lista = new ArrayList<Enderecamento>();
//		Enderecamento enderecamento = new Enderecamento();
//		Enderecamento enderecamentoAnterior = new Enderecamento();
//		Enderecamento enderecamentoProximo = new Enderecamento();
//		
//		Object[] arryOrdenado = new Object[list.size()];
//		arryOrdenado = list.toArray();
//		for (int i = 0; i < arryOrdenado.length; i++) {
//			enderecamento = (Enderecamento) arryOrdenado[i];
//			if(i > 0){
//				enderecamentoAnterior = (Enderecamento) arryOrdenado[i-1];
//				try {
//					enderecamento.setAnterior(enderecamentoAnterior);
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			}
//			if(i < (arryOrdenado.length-1)){
//				enderecamentoProximo = (Enderecamento) arryOrdenado[i+1];
//				try {
//					enderecamento.setProximo(enderecamentoProximo);
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			}
//			lista.add(enderecamento);
//		}
//	}
	
	private List<Enderecamento> retirarVazios(List<Enderecamento> listaEnderecamentos){
		List<Enderecamento> lista = new ArrayList<Enderecamento>();
		for (Enderecamento ende : listaEnderecamentos) {
			if(ende.getDescricao() != null && !ende.getDescricao().isEmpty()){
				lista.add(ende);
			}
		}
		return lista;
		
	}
	
	private void setAnteriorProximoEmLista(Enderecamento enderecamento){
		Enderecamento enderecamentoAux = new Enderecamento();
		if(enderecamento.getEnderecamentoNivel().size() > 0){
			enderecamentoAux.setQuantidadeColunas(enderecamento.getEnderecamentoNivel().get(0).getQuantidadeColunas());
			enderecamentoAux.setQuantidadeLinhas(enderecamento.getEnderecamentoNivel().get(0).getQuantidadeLinhas());
			enderecamentoAux.setOrientacao(enderecamento.getEnderecamentoNivel().get(0).getOrientacao());
		}
		enderecamentoAux.setEnderecamentos(enderecamento.getEnderecamentoNivel());
		ordenarSetColunasSetLinhas(enderecamentoAux);
		enderecamento.setEnderecamentoNivel(enderecamentoAux.getEnderecamentos());
		enderecamento.setEnderecamentoNivel(retirarVazios(enderecamento.getEnderecamentoNivel())); 
		int index = getIndex(enderecamento.getDescricao(), enderecamento.getEnderecamentoNivel());
		if(index >= 0){
			if(index > 0){
				enderecamento.setAnterior(enderecamento.getEnderecamentoNivel().get(index-1));
			}
			if(index < (enderecamento.getEnderecamentoNivel().size() - 1)){
				enderecamento.setProximo(enderecamento.getEnderecamentoNivel().get(index + 1));
			}
		}
	}
	
	private int getIndex(String descricao, List<Enderecamento> listaNivel){
		int index = 0;
		for(int i = 0; i < listaNivel.size();i++){
			if(listaNivel.get(i).getDescricao().equals(descricao)){
				index = i;
				break;
			}
		}
		return index;
	}
	/**
	 * Função que ordena os endereçamentos de acordo com suas diretrizes X e Y.
	 * @param enderecamento - Endereço atual que contem uma lista de subendereçamentos
	 * @param asc - boolean se true a diretriz do eixo X fica de cima pra baixo se false fica de baixo pra cima.
	 */
	private  void ordenarXY(Enderecamento enderecamento, boolean asc){
		HashMap<Integer, List<Enderecamento>> listaX = new LinkedHashMap<Integer, List<Enderecamento>>();
		List<Enderecamento> listaAux;
		List<Integer> chaves = new ArrayList<Integer>();
		int quantidadeColunas = 0;
		int quantidadeLinhas = 0;
		int index = 0;
		for (Enderecamento end : enderecamento.getEnderecamentos()) {
			listaAux = listaX.get(end.getPosicao_x());
			if(listaAux == null){
				listaAux = new ArrayList<Enderecamento>();
				listaAux.add(end);
				listaX.put(end.getPosicao_x(), listaAux);
				chaves.add(end.getPosicao_x());
			}else{
				listaAux.add(end);
			}
		}
		Collections.reverse(chaves);
		quantidadeLinhas = Collections.max(chaves);
		enderecamento.getEnderecamentos().clear();
		for (Integer chave : chaves) {
			listaAux = listaX.get(chave);
			quantidadeColunas = ordenarY(listaAux);
			if(enderecamento.getQuantidadeColunas() < quantidadeColunas){
				enderecamento.setQuantidadeColunas(quantidadeColunas);
			}
		}
		
		if(asc){
			while(index <= quantidadeLinhas){
				listaAux = listaX.get(index);
				listaAux = completarLista(listaAux, enderecamento.getQuantidadeColunas());
				for (Enderecamento end : listaAux) {
					enderecamento.getEnderecamentos().add(end);
				}
				index++;
			}
		}else{
			index = quantidadeLinhas;
			while(0 <= index){
				listaAux = listaX.get(index);
				listaAux = completarLista(listaAux, enderecamento.getQuantidadeColunas());
				for (Enderecamento end : listaAux) {
					enderecamento.getEnderecamentos().add(end);
				}
				index--;
			}
		}
	}
	
	private int ordenarY(List<Enderecamento> lista){
		Enderecamento endeAux;
		boolean isNaoOrdenado = true;
		int index = 0;
		int maiorY = 0;
		while(isNaoOrdenado){
			if(lista.size() > 0 && (index < (lista.size() -1))){
				if(lista.get(index + 1).getPosicao_y() < lista.get(index).getPosicao_y()){
					endeAux = lista.get(index);
					lista.set(index, lista.get(index + 1));
					lista.set(index + 1, endeAux);
					if((index - 1) >= 0){
						index = index - 2;
					}
				}
				index++;
			}else{
				isNaoOrdenado = false;
			}
		}
		maiorY = (lista.get(lista.size()-1).getPosicao_y() + 1);
		return maiorY;
	}
	
	private  List<Enderecamento> completarLista(List<Enderecamento> lista, int quantidadeColunas){
		List<Enderecamento> listaAux = new ArrayList<Enderecamento>();
		Enderecamento endeAux;
		if(lista != null && lista.size() > 0){
			for(int i = 0; i < lista.size(); i++){
				if(listaAux.size() <= quantidadeColunas){
					if(i < ( lista.size() -1)){
						if(lista.get(i).getPosicao_y() > 0 && listaAux.size() < 1){
							for(int y = 0; y < lista.get(i).getPosicao_y();y++){
								endeAux = new Enderecamento();
								endeAux.setPosicao_x(lista.get(i).getPosicao_x());
								endeAux.setPosicao_y(y);
								listaAux.add(endeAux);
							}
						}
						if((lista.get(i).getPosicao_y() + 1) < lista.get(i + 1).getPosicao_y()){
							listaAux.add(lista.get(i));
							for(int y = (lista.get(i).getPosicao_y() + 1); y < lista.get(i + 1).getPosicao_y(); y++){
								if(listaAux.size() >= quantidadeColunas){
									break;
								}
								endeAux = new Enderecamento();
								endeAux.setPosicao_x(lista.get(i).getPosicao_x());
								endeAux.setPosicao_y(y);
								listaAux.add(endeAux);
							}
						}else{
							listaAux.add(lista.get(i));
						}
					}else{
						listaAux.add(lista.get(i));
					}
				}
			}
			if(listaAux.size() < quantidadeColunas){
				int yAtual = listaAux.get(listaAux.size() -1).getPosicao_y(); 
				for(int i = listaAux.size(); i < quantidadeColunas; i++){
					yAtual++;
					endeAux = new Enderecamento();
					endeAux.setPosicao_x(listaAux.get(i-1).getPosicao_x());
					endeAux.setPosicao_y(yAtual);
					listaAux.add(endeAux);
				}
			}
		}else{
			for(int i = 0; i < quantidadeColunas; i++){
				endeAux = new Enderecamento();
				listaAux.add(endeAux);
			}
		}
		return listaAux;
	}
}

