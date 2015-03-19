package util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.catalina.tribes.tipis.AbstractReplicatedMap.MapOwner;

import br.com.gwsistemas.enderecamento.Enderecamento;

public class Testes {

	public static void main(String[] args) {
		List<Enderecamento> lista = new ArrayList<Enderecamento>();
		Enderecamento e1 = new Enderecamento();
		e1.setDescricao("REC.B.001");
		e1.setPosicao_x(0);
		e1.setPosicao_y(0);
		
		Enderecamento e2 = new Enderecamento();
		e2.setDescricao("REC.B.002");
		e2.setPosicao_x(0);
		e2.setPosicao_y(1);
		
		Enderecamento e3 = new Enderecamento();
		e3.setDescricao("REC.B.003");
		e3.setPosicao_x(0);
		e3.setPosicao_y(2);
		
		Enderecamento e4 = new Enderecamento();
		e4.setDescricao("REC.B.004");
		e4.setPosicao_x(0);
		e4.setPosicao_y(3);
		
		Enderecamento e5 = new Enderecamento();
		e5.setDescricao("REC.B.005");
		e5.setPosicao_x(0);
		e5.setPosicao_y(4);
		
		Enderecamento e6 = new Enderecamento();
		e6.setDescricao("REC.B.006");
		e6.setPosicao_x(0);
		e6.setPosicao_y(6);
		
		Enderecamento e7 = new Enderecamento();
		e7.setDescricao("REC.B.009");
		e7.setPosicao_x(0);
		e7.setPosicao_y(7);
		
		Enderecamento e8 = new Enderecamento();
		e8.setDescricao("REC.C.001");
		e8.setPosicao_x(1);
		e8.setPosicao_y(0);
		
		Enderecamento e9 = new Enderecamento();
		e9.setDescricao("REC.C.002");
		e9.setPosicao_x(1);
		e9.setPosicao_y(1);
		
		Enderecamento e10 = new Enderecamento();
		e10.setDescricao("REC.C.003");
		e10.setPosicao_x(1);
		e10.setPosicao_y(2);
		
		Enderecamento e11 = new Enderecamento();
		e11.setDescricao("REC.C.004");
		e11.setPosicao_x(1);
		e11.setPosicao_y(3);
		
		Enderecamento e12 = new Enderecamento();
		e12.setDescricao("REC.C.005");
		e12.setPosicao_x(1);
		e12.setPosicao_y(4);
		
		Enderecamento e13 = new Enderecamento();
		e13.setDescricao("REC.C.006");
		e13.setPosicao_x(1);
		e13.setPosicao_y(5);
		
		Enderecamento e14 = new Enderecamento();
		e14.setDescricao("REC.C.007");
		e14.setPosicao_x(1);
		e14.setPosicao_y(6);
		
		Enderecamento e15 = new Enderecamento();
		e15.setDescricao("REC.A.001");
		e15.setPosicao_x(2);
		e15.setPosicao_y(0);
		
		Enderecamento e16 = new Enderecamento();
		e16.setDescricao("REC.A.002");
		e16.setPosicao_x(2);
		e16.setPosicao_y(1);
		
		Enderecamento e17 = new Enderecamento();
		e17.setDescricao("REC.A.003");
		e17.setPosicao_x(2);
		e17.setPosicao_y(2);
		
		Enderecamento e18 = new Enderecamento();
		e18.setDescricao("REC.A.004");
		e18.setPosicao_x(2);
		e18.setPosicao_y(3);
		
		Enderecamento e19 = new Enderecamento();
		e19.setDescricao("REC.A.005");
		e19.setPosicao_x(2);
		e19.setPosicao_y(4);

		Enderecamento e20 = new Enderecamento();
		e20.setDescricao("REC.A.006");
		e20.setPosicao_x(2);
		e20.setPosicao_y(5);
		
		Enderecamento e21 = new Enderecamento();
		e21.setDescricao("REC.A.007");
		e21.setPosicao_x(2);
		e21.setPosicao_y(6);
		
		lista.add(e2);
		lista.add(e21);
		lista.add(e4);
		lista.add(e10);
		lista.add(e6);
		lista.add(e17);
		lista.add(e9);
		lista.add(e13);
		lista.add(e15);
		lista.add(e14);
		lista.add(e16);
		lista.add(e7);
		lista.add(e8);
		lista.add(e5);
		lista.add(e19);
		lista.add(e3);
		lista.add(e20);
		lista.add(e1);
		lista.add(e11);
		lista.add(e18);
		lista.add(e12);
		
		ordenarXY(lista, 10);
		
		for (Enderecamento en : lista) {
			System.out.println("Descriação: " + en.getDescricao() + " X: " + en.getPosicao_x() + " Y: " + en.getPosicao_y());
			System.out.println("----------------------------------------------------------------------------------------------");
		}
	}
	
	public static void ordenarXY(List<Enderecamento> lista, int quantidadeColunas){
		HashMap<Integer, List<Enderecamento>> listaX = new LinkedHashMap<Integer, List<Enderecamento>>();
		List<Enderecamento> listaAux;
		List<Integer> chaves = new ArrayList<Integer>();
		for (Enderecamento end : lista) {
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
		Collections.sort(chaves);
		lista.clear();
		for (Integer chave : chaves) {
			listaAux = listaX.get(chave);
			ordenarY(listaAux);
			listaAux = completarLista(listaAux, quantidadeColunas);
			for (Enderecamento end : listaAux) {
				lista.add(end);
			}
		}
	}
	
	public static void ordenarY(List<Enderecamento> lista){
		Enderecamento endeAux;
		boolean isNaoOrdenado = true;
		int index = 0;
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
	}
	
	public static List<Enderecamento> completarLista(List<Enderecamento> lista, int quantidadeColunas){
		List<Enderecamento> listaAux = new ArrayList<Enderecamento>();
		Enderecamento endeAux;
		if(lista.size() > 0){
			for(int i = 0; i < lista.size(); i++){
				if(listaAux.size() <= quantidadeColunas){
					if(i < ( lista.size() -1)){
						if((lista.get(i).getPosicao_y() + 1) < lista.get(i + 1).getPosicao_y()){
							listaAux.add(lista.get(i));
							for(int y = (lista.get(i).getPosicao_y() + 1); y < lista.get(i + 1).getPosicao_y(); y++){
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
		}
		return listaAux;
	}
}
