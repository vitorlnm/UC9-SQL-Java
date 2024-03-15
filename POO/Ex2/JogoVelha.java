package Ex2;

import java.util.Scanner;

public class JogoVelha {
    private EstadoCasa[][] grade;
    private int jogadorAtual;

    public JogoVelha() {
        grade = new EstadoCasa[3][3];
        jogadorAtual = 1;
        zerarGrade();
    }

    private void zerarGrade() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                grade[i][j] = EstadoCasa.VAGO;
            }
        }
    }

    public void exibirGrade() {
        System.out.println("  0 1 2");
        for (int i = 0; i < 3; i++) {
            System.out.print(i + " ");
            for (int j = 0; j < 3; j++) {
                if (grade[i][j] == EstadoCasa.PLAYER1) {
                    System.out.print("X ");
                } else if (grade[i][j] == EstadoCasa.PLAYER2) {
                    System.out.print("O ");
                } else {
                    System.out.print("  ");
                }
            }
            System.out.println();
        }
    }

    public boolean jogar(int linha, int coluna) {
        if (grade[linha][coluna] != EstadoCasa.VAGO) {
            System.out.println("Casa ocupada! Escolha outra");
            return false;
        }
        grade[linha][coluna] = jogadorAtual == 1 ? EstadoCasa.PLAYER1 : EstadoCasa.PLAYER2;
        jogadorAtual = jogadorAtual == 1 ? 2 : 1;
        return true;
    }

    public boolean verificarVitoria() {
        for (int i = 0; i < 3; i++) {
            if (grade[i][0] != EstadoCasa.VAGO && grade[i][0] == grade[i][1] && grade[i][0] == grade[i][2]) {
                return true;
            }
            if (grade[0][i] != EstadoCasa.VAGO && grade[0][i] == grade[1][i] && grade[0][i] == grade[2][i]) {
                return true;
            }
        }
        if (grade[0][0] != EstadoCasa.VAGO && grade[0][0] == grade[1][1] && grade[0][0] == grade[2][2]) {
            return true;
        }
        if (grade[0][2] != EstadoCasa.VAGO && grade[0][2] == grade[1][1] && grade[0][2] == grade[2][0]) {
            return true;
        }
        return false;
    }

    public boolean verificarEmpate() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (grade[i][j] == EstadoCasa.VAGO) {
                    return false;
                }
            }
        }
        return true;
    }

    public static void main(String[] args) {
        JogoVelha jogo = new JogoVelha();
        Scanner scanner = new Scanner(System.in);
        boolean vitoria = false;
        boolean empate = false;
        while (!vitoria && !empate) {
            jogo.exibirGrade();
            System.out.println("Vez de Jogador " + jogo.jogadorAtual + ". Escolha uma casa (Linha - e depois coluna |):");
            int linha = scanner.nextInt();
            int coluna = scanner.nextInt();
            if (jogo.jogar(linha, coluna)) {
                vitoria = jogo.verificarVitoria();
                empate = jogo.verificarEmpate();
            }
        }
        if (vitoria) {
            System.out.println("Fim de jogo! " + jogo.jogadorAtual + " Venceu!!!");
        } else {
            System.out.println("Fim de jogo! Empate.");
        }
        scanner.close();
    }
}