package Ex1;
public class Invoice {
	String numero;
	String descrisao;
	int quantidade;
	double preco;
	
	public Invoice(int iniciaQuantidade,double valor){
		
		if( iniciaQuantidade > 0){
			quantidade = iniciaQuantidade;
		} else {
			quantidade = 0;
		}
		
		if(valor > 0.0){
			preco  = valor;
		} else {
			preco = 0.0;
		}
		
	}
	
	public void setQuantidade(int quantidadeItem){
		quantidade = quantidadeItem;
	}
	
	public void setNumero(String numeroItem){
		numero = numeroItem;
	}
	public void setDescrisao(String descricaoItem){
		descrisao = descricaoItem;
	}
	public void setPreco(Double valorItem){
		preco = valorItem;
	}
	
	public int getQuantidade(){
		return quantidade;
	}
	public String getNumero(){
		return numero;
	}
	public String getDescricao(){
		return descrisao;
	}
	public double getPreco(){
		return preco;
	}
	
	public double GetInvoiceAmount(){
		
		double total = quantidade * preco;
		
		return total;
		
	}
}
 
   
