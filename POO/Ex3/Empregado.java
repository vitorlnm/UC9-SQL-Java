package Ex3;

public class Empregado extends Funcionario {
    private String funcao;

    public Empregado(String nome, String cpf, double salario, String funcao) {
        super(nome, cpf, salario);
        this.funcao = funcao;
    }

    @Override
    public void realizarTarefa() {
        System.out.println("Empregado " + getNome() + " realizando a função " + funcao);
    }
}