package util;

public class EnumEnderecamento {
	public enum Enderecamento {

		HOR_ASC_ESQ("hor_asc_esq", 1), 
		HOR_ASC_DIR("hor_asc_dir", 2), 
		HOR_DESC_ESQ("hor_desc_esq", 3), 
		HOR_DESC_DIR("hor_desc_dir", 4), 
		VER_ASC_ESQ("ver_asc_esq", 5), 
		VER_ASC_DIR("ver_asc_dir", 6), 
		VER_DESC_ESQ("ver_desc_esq", 7), 
		VER_DESC_DIR("ver_desc_dir", 8); 

		private final String nome;
		private final int ordem;

		Enderecamento(String nome, int ordem) {
			this.nome = nome;
			this.ordem = ordem;
		}

		public int getOrdem() {
			return ordem;
		}

		public String getNome() {
			return nome;
		}
	}
}