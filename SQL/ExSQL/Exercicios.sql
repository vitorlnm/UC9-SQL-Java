CREATE DATABASE exercicio1;
USE exercicio1;

CREATE TABLE VENDEDOR(
nrVendedor TINYINT PRIMARY KEY,
nomeVendedor VARCHAR(50) NOT NULL,
idade TINYINT NOT NULL, 
salario DECIMAL (8, 2) NOT NULL
);

CREATE TABLE PEDIDO(
nr_pedido TINYINT PRIMARY KEY,
nrVendedor TINYINT NOT NULL,
nrCliente TINYINT NOT NULL,
quantidade_itens TINYINT NOT NULL,
valor_total DECIMAL (10, 2) NOT NULL,
FOREIGN KEY (nrVendedor) REFERENCES VENDEDOR (nrVendedor),
FOREIGN KEY (nrCliente) REFERENCES CLIENTE (nrCliente)
);

CREATE TABLE CLIENTE(
nrCliente TINYINT PRIMARY KEY,
nomeCliente VARCHAR(255) NOT NULL,
cidade VARCHAR(255),
tipo VARCHAR(255) NOT NULL
);

INSERT INTO VENDEDOR VALUES (1, 'João', 30, 5000.00);
INSERT INTO VENDEDOR VALUES (2, 'Maria', 25, 4500.00);
INSERT INTO VENDEDOR VALUES (3, 'Carlos', 35, 6000.00);

INSERT INTO CLIENTE VALUES (1, 'Cliente1', 'Cidade1', 'INDUSTRIA');
INSERT INTO CLIENTE VALUES (2, 'Cliente2', 'Cidade2', 'COMERCIO');

INSERT INTO PEDIDO VALUES (1, 1, 1, 5, 7000.00);
INSERT INTO PEDIDO VALUES (2, 2, 2, 3, 3000.00);
INSERT INTO PEDIDO VALUES (3, 3, 1, 2, 2000.00);

SELECT nomeVendedor FROM VENDEDOR;

SELECT DISTINCT nrVendedor FROM PEDIDO;

SELECT nrVendedor FROM VENDEDOR WHERE nrVendedor NOT IN (SELECT DISTINCT nrVendedor FROM PEDIDO);

SELECT DISTINCT V.nomeVendedor
FROM VENDEDOR V
JOIN PEDIDO P ON V.nrVendedor = P.nrVendedor
JOIN CLIENTE C ON P.nrCliente = C.nrCliente
WHERE C.tipo = 'INDUSTRIA';

SELECT DISTINCT C.tipo
FROM VENDEDOR V
JOIN PEDIDO P ON V.nrVendedor = P.nrVendedor
JOIN CLIENTE C ON P.nrCliente = C.nrCliente
WHERE V.nomeVendedor = 'João';

SELECT DISTINCT C.nomeCliente, C.tipo
FROM CLIENTE C
JOIN PEDIDO P ON C.nrCliente = P.nrCliente
WHERE P.valor_total > 5000;

UPDATE CLIENTE SET nomeCliente = 'Joao Carlos' WHERE nrCliente = 1;
UPDATE CLIENTE SET nomeCliente = 'Renan Bernardo' WHERE nrCliente = 2;

UPDATE CLIENTE SET cidade = 'Florianopolis' WHERE nrCliente = 1;
UPDATE CLIENTE SET cidade = 'Recife' WHERE nrCliente = 2;

-- -----------------------------------------------------------------------------------------------------------------
CREATE DATABASE exercicio2;
USE exercicio2;

CREATE TABLE ALUNO (
    aluno_id TINYINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    curso VARCHAR(50) NOT NULL,
    nivel VARCHAR(10),
    idade TINYINT NOT NULL
);

CREATE TABLE TURMA (
    turma_id TINYINT AUTO_INCREMENT PRIMARY KEY,
    nometurma VARCHAR(50) NOT NULL,
    sala VARCHAR(10),
    horario VARCHAR(20) NOT NULL
);

CREATE TABLE MATRICULA (
    matricula_id TINYINT AUTO_INCREMENT PRIMARY KEY,
    aluno_id TINYINT,
    turma_id TINYINT,
    nota_1 TINYINT,
    nota_2 TINYINT,
    nota_3 TINYINT,
    nota_final TINYINT,
    nr_faltas TINYINT,
    FOREIGN KEY (aluno_id) REFERENCES ALUNO(aluno_id),
    FOREIGN KEY (turma_id) REFERENCES turma(turma_id)
);

INSERT INTO ALUNO VALUES (1, 'Roger', 'Medicina', 'Graduação', 27);
INSERT INTO ALUNO VALUES (2, 'Jaques', 'Engenharia', 'Graduação', 23);
INSERT INTO ALUNO VALUES (3, 'Isabella', 'Administração', 'Mestrado', 21);

INSERT INTO TURMA VALUES (1, 'Turma A', 'Sala 101', '08:00');
INSERT INTO TURMA VALUES (2, 'Turma B', 'Sala 102', '14:00');

INSERT INTO MATRICULA VALUES (101, 1, 1, 8, 9, 7, NULL, 2);
INSERT INTO MATRICULA VALUES (102, 2, 1, 7, 8, 6, NULL, 3);
INSERT INTO MATRICULA VALUES (103, 1, 2, 9, 8, 9, NULL, 1);
INSERT INTO MATRICULA VALUES (104, 3, 2, 7, 8, 7, NULL, 4);

SELECT nome FROM ALUNO;

SELECT matricula_id FROM MATRICULA;

SELECT matricula_id FROM MATRICULA WHERE turma_id IS NULL;

SELECT matricula_id FROM MATRICULA WHERE turma_id = 30;

SELECT TURMA.horario
FROM ALUNO
JOIN MATRICULA ON ALUNO.aluno_id = MATRICULA.aluno_id
JOIN TURMA ON MATRICULA.turma_id = TURMA.turma_id
WHERE ALUNO.nome = 'Roger';

SELECT ALUNO.nome
FROM ALUNO
JOIN MATRICULA ON ALUNO.aluno_id = MATRICULA.aluno_id
JOIN TURMA ON MATRICULA.turma_id = TURMA.turma_id
WHERE TURMA.turma_id = 30;

SELECT ALUNO.nome
FROM ALUNO
LEFT JOIN MATRICULA ON ALUNO.aluno_id = MATRICULA.aluno_id
LEFT JOIN TURMA ON MATRICULA.turma_id = TURMA.turma_id
WHERE TURMA.turma_id IS NULL OR TURMA.turma_id <> 30;

SELECT DISTINCT TURMA.nometurma
FROM TURMA
JOIN MATRICULA ON TURMA.turma_id = MATRICULA.turma_id
WHERE MATRICULA.nota_final > 8;
-- -----------------------------------------------------------------------------------------------------------------

CREATE DATABASE exercicio3;
USE exercicio3;

CREATE TABLE EMPREGADO (
    idemp INT PRIMARY KEY,
    nomeemp VARCHAR(255) NOT NULL,
    aniversario DATE NOT NULL,
    enderecoemp VARCHAR(255) NOT NULL,
    sexoemp CHAR(1) NOT NULL,
    salarioemp DECIMAL(10, 2) NOT NULL,
    nrdep INT NOT NULL,
    FOREIGN KEY (nrdep) REFERENCES DEPARTAMENTO(nrdep)
);

CREATE TABLE DEPARTAMENTO (
    nrdep INT PRIMARY KEY,
    nomedep VARCHAR(255) NOT NULL,
    idgerente INT,
    horario TIME NOT NULL,
    FOREIGN KEY (idgerente) REFERENCES EMPREGADO(idemp)
);

CREATE TABLE LOCALIZACAO (
    localizacao VARCHAR(255) NOT NULL,
    nrdep INT NOT NULL,
    PRIMARY KEY (localizacao, nrdep),
    FOREIGN KEY (nrdep) REFERENCES DEPARTAMENTO(nrdep)
);

CREATE TABLE TRABALHA_EM (
    idemp INT NOT NULL,
    nrprojeto INT NOT NULL,
    horas DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (idemp, nrprojeto),
    FOREIGN KEY (idemp) REFERENCES EMPREGADO(idemp),
    FOREIGN KEY (nrprojeto) REFERENCES PROJETO(nrproj)
);

CREATE TABLE PROJETO (
    nrproj INT PRIMARY KEY,
    nomeproj VARCHAR(255) NOT NULL,
    nrdep INT NOT NULL,
    PRIMARY KEY (nrproj, nrdep),
    FOREIGN KEY (nrdep) REFERENCES DEPARTAMENTO(nrdep)
);

CREATE TABLE DEPENDENTE (
    iddepende INT PRIMARY KEY,
    idemp INT NOT NULL,
    nomedep VARCHAR(255) NOT NULL,
    sexodep CHAR(1) NOT NULL,
    aniversariodep DATE NOT NULL,
    parentesco VARCHAR(255) NOT NULL,
    FOREIGN KEY (idemp) REFERENCES EMPREGADO(idemp)
);

INSERT INTO EMPREGADO (idemp, nomeemp, aniversario, enderecoemp, sexoemp, salarioemp, nrdep)
VALUES (1, 'João', '1980-01-01', 'Rua A', 'M', 5000, 100);

INSERT INTO DEPARTAMENTO (nrdep, nomedep, idgerente, horario)
VALUES (100, 'Compras', 1, '08:00:00');

INSERT INTO LOCALIZACAO (localizacao, nrdep)
VALUES ('Rio de Janeiro', 100);

INSERT INTO PROJETO (nrproj, nomeproj, nrdep)
VALUES (200, 'Projeto X', 100);

INSERT INTO TRABALHA_EM (idemp, nrprojeto, horas)
VALUES (1, 200, 160);

INSERT INTO DEPENDENTE (iddepende, idemp, nomedep, sexodep, aniversariodep, parentesco)
VALUES (300, 1, 'Maria', 'F', '1990-01-01', 'Filha');

SELECT E.nomeemp, E.enderecoemp
FROM EMPREGADO E
JOIN TRABALHA_EM TE ON E.idemp = TE.idemp
JOIN PROJETO P ON TE.nrprojeto = P.nrproj
JOIN DEPARTAMENTO D ON P.nrdep = D.nrdep
WHERE D.nomedep = 'Compras';

SELECT P.nomeproj
FROM PROJETO P
JOIN TRABALHA_EM TE ON P.nrproj = TE.nrprojeto
JOIN EMPREGADO E ON TE.idemp = E.idemp
WHERE E.nomeemp = 'João';

SELECT P.nomeproj
FROM PROJETO P
JOIN TRABALHA_EM TE ON P.nrproj = TE.nrprojeto
JOIN EMPREGADO E ON TE.idemp = E.idemp
WHERE E.nomeemp = 'João';

-- -----------------------------------------------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS exercicio4;
USE exercicio4;

CREATE TABLE IF NOT EXISTS disciplinas (
    codigo_disciplina INT PRIMARY KEY,
    nome_disciplina VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS turmas (
    codigo_turma INT PRIMARY KEY,
    codigo_disciplina INT,
    sigla_turma VARCHAR(255) NOT NULL,
    ano_semestre INT NOT NULL,
    FOREIGN KEY (codigo_disciplina) REFERENCES disciplinas(codigo_disciplina)
);

CREATE TABLE IF NOT EXISTS alunos (
    codigo_aluno INT PRIMARY KEY,
    nome_aluno VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS alunos_turmas (
    codigo_aluno INT,
    codigo_turma INT,
    PRIMARY KEY (codigo_aluno, codigo_turma),
    FOREIGN KEY (codigo_aluno) REFERENCES alunos(codigo_aluno),
    FOREIGN KEY (codigo_turma) REFERENCES turmas(codigo_turma)
);

CREATE TABLE IF NOT EXISTS provas (
    codigo_prova INT PRIMARY KEY,
    codigo_turma INT,
    data_prova DATE NOT NULL,
    FOREIGN KEY (codigo_turma) REFERENCES turmas(codigo_turma)
);

CREATE TABLE IF NOT EXISTS notas (
    codigo_aluno INT,
    codigo_prova INT,
    nota DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (codigo_aluno, codigo_prova),
    FOREIGN KEY (codigo_aluno) REFERENCES alunos(codigo_aluno),
    FOREIGN KEY (codigo_prova) REFERENCES provas(codigo_prova)
);

INSERT INTO disciplinas (codigo_disciplina, nome_disciplina) VALUES
(1, 'Matemática'),
(2, 'História'),
(3, 'Ciências');

INSERT INTO turmas (codigo_turma, codigo_disciplina, sigla_turma, ano_semestre) VALUES
(1, 1, 'MAT101', 2023),
(2, 2, 'HIS201', 2023),
(3, 3, 'CIE301', 2024);

INSERT INTO alunos (codigo_aluno, nome_aluno) VALUES
(1, 'João'),
(2, 'Maria'),
(3, 'Pedro'),
(4, 'Ana'),
(5, 'Carlos');

INSERT INTO alunos_turmas (codigo_aluno, codigo_turma) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3);

INSERT INTO provas (codigo_prova, codigo_turma, data_prova) VALUES
(1, 1, '2023-04-10'),
(2, 1, '2023-05-15'),
(3, 2, '2023-04-20'),
(4, 2, '2023-06-05'),
(5, 3, '2024-03-01');

INSERT INTO notas (codigo_aluno, codigo_prova, nota) VALUES
(1, 1, 8.5),
(2, 1, 7.9),
(3, 3, 9.2),
(4, 3, 6.8),
(5, 5, 7.5);

SELECT alunos.nome_aluno, provas.data_prova, notas.nota
FROM alunos
JOIN alunos_turmas ON alunos.codigo_aluno = alunos_turmas.codigo_aluno
JOIN provas ON alunos_turmas.codigo_turma = provas.codigo_turma
JOIN notas ON alunos.codigo_aluno = notas.codigo_aluno AND provas.codigo_prova = notas.codigo_prova
JOIN turmas ON provas.codigo_turma = turmas.codigo_turma
WHERE turmas.sigla_turma = 'MAT101';


SELECT disciplinas.nome_disciplina, provas.data_prova, notas.nota
FROM alunos
JOIN alunos_turmas ON alunos.codigo_aluno = alunos_turmas.codigo_aluno
JOIN provas ON alunos_turmas.codigo_turma = provas.codigo_turma
JOIN notas ON alunos.codigo_aluno = notas.codigo_aluno AND provas.codigo_prova = notas.codigo_prova
JOIN turmas ON provas.codigo_turma = turmas.codigo_turma
JOIN disciplinas ON turmas.codigo_disciplina = disciplinas.codigo_disciplina
WHERE alunos.nome_aluno = 'João';

-- -----------------------------------------------------------------------------------------------------------------

CREATE DATABASE exercicio5;
USE exercicio5;

CREATE TABLE tipos_cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE professores (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    titulacao VARCHAR(255) NOT NULL,
    telefone1 VARCHAR(15),
    telefone2 VARCHAR(15),
    telefone3 VARCHAR(15)
);

CREATE TABLE alunos (
    codigo_matricula INT AUTO_INCREMENT PRIMARY KEY,
    data_matricula DATE NOT NULL,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    data_nascimento DATE NOT NULL,
    altura DECIMAL(5,2) NOT NULL,
    peso DECIMAL(5,2) NOT NULL
);

CREATE TABLE turmas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantidade_alunos INT NOT NULL,
    horario_aula TIME NOT NULL,
    data_aula DATE NOT NULL,
    data_inicial DATE NOT NULL,
    data_final DATE NOT NULL,
    id_professor VARCHAR(11) NOT NULL,
    id_curso INT NOT NULL,
    id_aluno_monitor INT,
    FOREIGN KEY (id_professor) REFERENCES professores(cpf),
    FOREIGN KEY (id_curso) REFERENCES tipos_cursos(id),
    FOREIGN KEY (id_aluno_monitor) REFERENCES alunos(codigo_matricula)
);

CREATE TABLE ausencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    data_ausencia DATE NOT NULL,
    FOREIGN KEY (id_matricula) REFERENCES alunos(codigo_matricula)
);

INSERT INTO tipos_cursos (nome) VALUES ('Curso A'), ('Curso B'), ('Curso C');

INSERT INTO professores (cpf, nome, data_nascimento, titulacao, telefone1, telefone2, telefone3) VALUES 
('12345678901', 'Professor A', '2000-01-01', 'Doutor', '11999999999', '22999999999', '33999999999'),
('23456789012', 'Professor B', '2001-01-01', 'Mestre', '44999999999', '55999999999', '66999999999');

INSERT INTO alunos (codigo_matricula, data_matricula, nome, endereco, telefone, data_nascimento, altura, peso) VALUES 
(1, '2020-01-01', 'Aluno A', 'Rua A, 123', '11999999999', '2000-01-01', '1.75', '65'),
(2, '2020-01-02', 'Aluno B', 'Rua B, 123', '22999999999', '2001-01-01', '1.80', '70'),
(3, '2020-01-03', 'Aluno C', 'Rua C, 123', '33999999999', '2002-01-01', '1.85', '75');

INSERT INTO turmas (id, quantidade_alunos, horario_aula, data_aula, data_inicial, data_final, id_professor, id_curso, id_aluno_monitor) VALUES 
(1, 20, '08:00:00', '2020-01-01', '2020-01-01', '2020-12-31', '12345678901', 1, 1),
(2, 25, '10:00:00', '2020-01-01', '2020-01-01', '2020-12-31', '23456789012', 2, 2),
(3, 30, '14:00:00', '2020-01-01', '2020-01-01', '2020-12-31', '12345678901', 3, NULL);

INSERT INTO ausencias (id_matricula, data_ausencia) VALUES 
(1, '2020-01-02'),
(1, '2020-01-03'),
(2, '2020-01-01');

SELECT t.id AS id_turma, t.quantidade_alunos, t.horario_aula, t.data_aula, t.data_inicial, t.data_final,
       tc.nome AS tipo_curso,
       p.nome AS nome_professor, p.cpf AS cpf_professor,
       m.nome AS nome_aluno_monitor, m.codigo_matricula AS codigo_aluno_monitor
FROM turmas t
INNER JOIN tipos_cursos tc ON t.id_curso = tc.id
INNER JOIN professores p ON t.id_professor = p.cpf
LEFT JOIN alunos m ON t.id_aluno_monitor = m.codigo_matricula;

SELECT t.id AS id_turma, t.quantidade_alunos, t.horario_aula, t.data_aula, t.data_inicial, t.data_final,
       tc.nome AS tipo_curso,
       p.nome AS nome_professor,
       a.codigo_matricula AS codigo_aluno, a.nome AS nome_aluno,
       a.data_matricula, a.endereco, a.telefone, a.data_nascimento, a.altura, a.peso,
       aus.data_ausencia
FROM turmas t
INNER JOIN tipos_cursos tc ON t.id_curso = tc.id
INNER JOIN professores p ON t.id_professor = p.cpf
INNER JOIN alunos a ON t.id_aluno_monitor = a.codigo_matricula OR t.id IN (SELECT id_matricula FROM ausencias WHERE id_matricula = a.codigo_matricula)
LEFT JOIN ausencias aus ON a.codigo_matricula = aus.id_matricula;

-- -----------------------------------------------------------------------------------------------------------------
CREATE DATABASE exercicio6;
USE exercicio6;

CREATE TABLE curso (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL
);

CREATE TABLE professor (
    cpf VARCHAR(11) PRIMARY KEY,
    nome TEXT NOT NULL,
    data_nascimento DATE NOT NULL,
    titulacao TEXT NOT NULL,
    telefone1 TEXT NOT NULL,
    telefone2 TEXT,
    telefone3 TEXT
);

CREATE TABLE aluno (
    codigo_matricula INTEGER PRIMARY KEY,
    data_matricula DATE NOT NULL,
    nome TEXT NOT NULL,
    endereco TEXT NOT NULL,
    telefone TEXT NOT NULL,
    data_nascimento DATE NOT NULL,
    altura REAL NOT NULL,
    peso REAL NOT NULL
);

CREATE TABLE turma (
    id INTEGER PRIMARY KEY,
    quantidade_alunos INTEGER NOT NULL,
    horario TEXT NOT NULL,
    duracao INTEGER NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    id_curso INTEGER NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES curso (id) ON DELETE CASCADE
);

CREATE TABLE monitor (
    id_aluno INTEGER PRIMARY KEY,
    id_turma INTEGER NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES aluno (codigo_matricula) ON DELETE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turma (id) ON DELETE CASCADE
);

CREATE TABLE professor_turma (
    id_professor VARCHAR(11) NOT NULL,
    id_turma INTEGER NOT NULL,
    PRIMARY KEY (id_professor, id_turma),
    FOREIGN KEY (id_professor) REFERENCES professor (cpf) ON DELETE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turma (id) ON DELETE CASCADE
);

CREATE TABLE aluno_turma (
    id_aluno INTEGER NOT NULL,
    id_turma INTEGER NOT NULL,
    ausencias INTEGER NOT NULL,
    PRIMARY KEY (id_aluno, id_turma),
    FOREIGN KEY (id_aluno) REFERENCES aluno (codigo_matricula) ON DELETE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turma (id) ON DELETE CASCADE
);

INSERT INTO curso (id, nome) VALUES 
    (1, 'Programação em Python'),
    (2, 'Desenvolvimento Web'),
    (3, 'Banco de Dados');

INSERT INTO professor (cpf, nome, data_nascimento, titulacao, telefone1, telefone2, telefone3) VALUES 
    ('12345678900', 'João Silva', '1980-05-15', 'Mestre', '111111111', '222222222', '333333333'),
    ('98765432100', 'Maria Souza', '1975-10-20', 'Doutor', '444444444', '555555555', NULL);

INSERT INTO aluno (codigo_matricula, data_matricula, nome, endereco, telefone, data_nascimento, altura, peso) VALUES 
    (1, '2023-01-10', 'Pedro Santos', 'Rua A, 123', '666666666', '2000-03-25', 1.75, 70.5),
    (2, '2023-02-15', 'Ana Oliveira', 'Rua B, 456', '777777777', '2001-07-12', 1.60, 55.0),
    (3, '2023-02-20', 'Carlos Pereira', 'Rua C, 789', '888888888', '2002-09-30', 1.80, 80.0);

INSERT INTO turma (id, quantidade_alunos, horario, duracao, data_inicio, data_fim, id_curso) VALUES 
    (1, 20, 'Segunda-feira 14:00', 60, '2023-03-01', '2023-06-01', 1),
    (2, 15, 'Terça-feira 19:00', 90, '2023-03-05', '2023-05-30', 2),
    (3, 25, 'Quarta-feira 10:00', 120, '2023-04-01', '2023-07-01', 3);

INSERT INTO monitor (id_aluno, id_turma) VALUES 
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO professor_turma (id_professor, id_turma) VALUES 
    ('12345678900', 1),
    ('98765432100', 2),
    ('12345678900', 3);

INSERT INTO aluno_turma (id_aluno, id_turma, ausencias) VALUES 
    (1, 1, 0),
    (2, 1, 2),
    (3, 3, 1);

SELECT * FROM aluno;

SELECT aluno.*, turma.*
FROM aluno
JOIN aluno_turma ON aluno.codigo_matricula = aluno_turma.id_aluno
JOIN turma ON aluno_turma.id_turma = turma.id;

SELECT aluno.*
FROM aluno
LEFT JOIN aluno_turma ON aluno.codigo_matricula = aluno_turma.id_aluno
GROUP BY aluno.codigo_matricula
HAVING COALESCE(SUM(aluno_turma.ausencias), 0) = 0;

SELECT p.nome AS nome_professor, COUNT(pt.id_turma) AS quantidade_turmas_lecionadas
FROM professor p
LEFT JOIN professor_turma pt ON p.cpf = pt.id_professor
GROUP BY p.nome;

SELECT p.nome AS nome_professor, 
       SUBSTRING_INDEX(p.telefone1, ',', 1) AS telefone, 
       t.id AS id_turma, 
       t.data_inicio, 
       t.data_fim, 
       t.horario, 
       c.nome AS curso, 
       a.nome AS nome_aluno
FROM professor p
JOIN professor_turma pt ON p.cpf = pt.id_professor
JOIN turma t ON pt.id_turma = t.id
JOIN curso c ON t.id_curso = c.id
JOIN aluno_turma at ON t.id = at.id_turma
JOIN aluno a ON at.id_aluno = a.codigo_matricula
ORDER BY p.nome, t.id, a.nome;

SELECT p.nome AS nome_professor, 
       t.id AS id_turma,
       (SELECT COUNT(id_aluno) FROM aluno_turma WHERE id_turma = t.id) AS quantidade_alunos
FROM professor p
JOIN professor_turma pt ON p.cpf = pt.id_professor
JOIN turma t ON pt.id_turma = t.id
ORDER BY quantidade_alunos DESC
LIMIT 1;

SELECT a.nome AS nome_aluno, 
       MAX(t.id) AS id_turma,
       SUM(at.ausencias) AS total_faltas
FROM aluno a
JOIN aluno_turma at ON a.codigo_matricula = at.id_aluno
JOIN turma t ON at.id_turma = t.id
GROUP BY a.nome
ORDER BY total_faltas DESC;

SELECT c.nome AS nome_curso, 
       AVG(t.quantidade_alunos) AS quantidade_media_alunos
FROM curso c
JOIN turma t ON c.id = t.id_curso
GROUP BY c.nome;

SET SQL_SAFE_UPDATES = 0;
UPDATE professor SET nome = UPPER(nome);

UPDATE professor 
SET nome = UPPER(nome) 
WHERE cpf = '12345678900' OR cpf = '98765432100';

SET SQL_SAFE_UPDATES = 1;

UPDATE aluno
SET nome = UPPER(nome)
WHERE codigo_matricula IN (
    SELECT at.id_aluno
    FROM aluno_turma at
    JOIN (
        SELECT id_turma, COUNT(*) AS quantidade_alunos
        FROM aluno_turma
        GROUP BY id_turma
        ORDER BY quantidade_alunos DESC
        LIMIT 1
    ) AS max_alunos_turma ON at.id_turma = max_alunos_turma.id_turma
);










-- -----------------------------------------------------------------------------------------------------------------
