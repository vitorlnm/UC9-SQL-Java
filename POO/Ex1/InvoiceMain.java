package Ex1;

import java.util.Scanner;
public class InvoiceMain {

	
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("Numero do item faturado: ");
		String numero = scanner.nextLine();
		
		System.out.println("Digite a descricao do item: ");
		String descrisao = scanner.nextLine();
		
		System.out.println("Quantidade comprada do item:  ");
		int quant = scanner.nextInt();
		
		System.out.println("Preco unitario do item: ");
		double valor = scanner.nextDouble();
		
		Invoice inv = new Invoice( quant, valor);
		
		inv.setNumero(numero);
		inv.setDescrisao(descrisao);
		
		System.out.println("Número: "+inv.getNumero()+
		"\nDescrição: "+inv.getDescricao()+
		"\nQuantidade: "+inv.getQuantidade()+
		"\nValor: "+inv.getPreco());
                
		System.out.println();
		
		System.out.println("O Valor total é "+inv.GetInvoiceAmount());
	}

}
