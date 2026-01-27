-- 1. CRIAÇÃO DO BANCO
CREATE DATABASE IF NOT EXISTS sysfrequencia;
USE sysfrequencia;





-- 2. TABELA DE TURMAS (Híbrida)
-- O 'curso_id' virou 'projeto_id' que vem do Mock
DROP TABLE IF EXISTS turmas;
CREATE TABLE turmas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    projeto_id INT NOT NULL,     -- ID do Projeto (Vem do Mock/API Externa)
    nome VARCHAR(100) NOT NULL,  -- Ex: Téc. Enfermagem - Módulo I
    turno VARCHAR(20) NOT NULL,  -- Matutino, Vespertino, Noturno
    periodo VARCHAR(20) NOT NULL, -- Ex: 2026.1
    dias_aula TEXT,              -- JSON: '["Seg", "Qua"]'
    data_inicio DATE,
    data_fim DATE,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. TABELA DE MATRÍCULAS (Vínculo Aluno <-> Turma)
-- O 'aluno_id' é apenas um número que vem do Mock
DROP TABLE IF EXISTS matriculas;
CREATE TABLE matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    aluno_id INT NOT NULL,       -- ID do Aluno (Vem do Mock/API Externa)
    data_matricula DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Ativo', 'Trancado', 'Concluido', 'Desistente') DEFAULT 'Ativo',
    
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE,
    -- Garante que o mesmo aluno não entra 2x na mesma turma
    UNIQUE KEY aluno_turma_unico (turma_id, aluno_id)
);

-- 4. TABELA DE PROFESSORES DA TURMA
DROP TABLE IF EXISTS turma_professores;
CREATE TABLE turma_professores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    professor_id INT NOT NULL,
    disciplina_id INT NOT NULL, -- Agora é obrigatório saber a matéria
    
    ativo BOOLEAN DEFAULT TRUE, -- Para controlar substituições
    
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE,
    FOREIGN KEY (professor_id) REFERENCES professores(id) ON DELETE CASCADE, -- Supondo tabela professores
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id) ON DELETE CASCADE,
    
    -- Garante que não duplique a MESMA matéria para o MESMO professor na MESMA turma
    UNIQUE KEY professor_turma_disciplina (turma_id, professor_id, disciplina_id)
);

-- 5. TABELA DE DISCIPLINAS (Opcional por enquanto, mas já deixa pronto)
DROP TABLE IF EXISTS disciplinas;
CREATE TABLE disciplinas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,       -- Disciplina específica desta turma
    nome VARCHAR(100) NOT NULL,  -- Ex: Anatomia
    carga_horaria INT,
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE
);

-- 6. TABELA DE AULAS (Diário de Classe)
DROP TABLE IF EXISTS aulas;
CREATE TABLE aulas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    professor_id INT NOT NULL,   -- Quem deu a aula (Mock ID)
    disciplina_id INT,           -- Qual matéria (Opcional se for unidocente)
    data_aula DATE NOT NULL,
    conteudo TEXT,
    numero_aulas INT DEFAULT 1,
    
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE,
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id)
);

-- 7. TABELA DE FREQUÊNCIA
DROP TABLE IF EXISTS frequencias;
CREATE TABLE frequencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aula_id INT NOT NULL,
    matricula_id INT NOT NULL,   -- Link com a matrícula do aluno
    status ENUM('Presente', 'Ausente', 'Justificado') NOT NULL,
    observacao VARCHAR(255),
    
    FOREIGN KEY (aula_id) REFERENCES aulas(id) ON DELETE CASCADE,
    FOREIGN KEY (matricula_id) REFERENCES matriculas(id) ON DELETE CASCADE
);


