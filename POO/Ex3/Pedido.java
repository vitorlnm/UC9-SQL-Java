package Ex3;
import java.util.ArrayList;
import java.util.Date;

public class Pedido {
    private Date dataEmissao;
    private Date dataFinalizacao;
    private double preco;
    private Funcionario funcionarioResponsavel;
    private ArrayList<Produto> produtos;

    public Pedido(Date dataEmissao, Funcionario funcionarioResponsavel) {
        this.dataEmissao = dataEmissao;
        this.funcionarioResponsavel = funcionarioResponsavel;
        this.produtos = new ArrayList<Produto>();
        this.preco = 0.0;
    }

    public void adicionarProduto(Produto produto) {
        this.produtos.add(produto);
    }

    public void finalizarPedido(Date dataFinalizacao, double preco) {
        this.dataFinalizacao = dataFinalizacao;
        this.preco = preco;
    }

    public Date getDataEmissao() {
        return dataEmissao;
    }

    public Date getDataFinalizacao() {
        if (dataFinalizacao == null) {
            return null;
        }
        return dataFinalizacao;
    }

    public double getPreco() {
        if (dataFinalizacao == null) {
            return preco;
        }
        return preco * (dataFinalizacao.getTime() - dataEmissao.getTime()) / (double) (86400000 * 30);
    }

    public Funcionario getFuncionarioResponsavel() {
        return funcionarioResponsavel;
    }

    public ArrayList<Produto> getProdutos() {
        return produtos;
    }
}