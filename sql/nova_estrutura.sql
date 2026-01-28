-- ==========================================================
-- 🚀 SCRIPT DEFINITIVO E LIMPO - SYSFREQUENCIA (INTEGRADO)
-- ==========================================================

CREATE DATABASE IF NOT EXISTS sys_limpo_final;
USE sys_limpo_final;

-- ==========================================================
-- 1. TABELAS AUXILIARES (DEPENDÊNCIAS DA PESSOA)
-- ==========================================================

-- Etnia
CREATE TABLE IF NOT EXISTS etnia (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descricao varchar(191) NOT NULL
);
INSERT INTO etnia (id, descricao) VALUES (1, 'Branca'), (2, 'Preta'), (3, 'Amarela'), (4, 'Parda'), (5, 'Indígena');

-- Gênero
CREATE TABLE IF NOT EXISTS identidade_genero (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descricao varchar(191) NOT NULL
);
INSERT INTO identidade_genero (id, descricao) VALUES (1, 'Cisgênero'), (2, 'Transgênero'), (3, 'Não-binário');

CREATE TABLE IF NOT EXISTS genero (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descricao varchar(191) NOT NULL,
  identidade_id int NOT NULL,
  FOREIGN KEY (identidade_id) REFERENCES identidade_genero (id)
);
INSERT INTO genero (id, descricao, identidade_id) VALUES (1, 'Homem', 1), (2, 'Mulher', 1), (3, 'Outro', 3);

-- Escolaridade
CREATE TABLE IF NOT EXISTS escolaridade (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descricao varchar(191) NOT NULL
);
INSERT INTO escolaridade (id, descricao) VALUES (1, 'Fundamental'), (2, 'Médio'), (3, 'Superior');

-- Órgão Emissor
CREATE TABLE IF NOT EXISTS orgao_emissor (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descricao varchar(191) NOT NULL,
  uf_emissor varchar(191) NOT NULL
);
INSERT INTO orgao_emissor (id, descricao, uf_emissor) VALUES (1, 'SSP', 'PE'), (2, 'SDS', 'PE');

-- Tipo de Documento
CREATE TABLE IF NOT EXISTS tipo_documento (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome varchar(191) NOT NULL,
  categoria varchar(191) NOT NULL,
  obrigatorio tinyint(1) DEFAULT '0'
);

-- Perfis de Acesso
CREATE TABLE IF NOT EXISTS perfil_usuario (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descricao varchar(191) NOT NULL
);

INSERT INTO `perfil_usuario` (`id`, `descricao`) VALUES
(1, 'Administrador'),
(2, 'Coordenador'),
(3, 'Colaborador'),
(4, 'Estagiário'),
(5, 'Visualizador'),
(6, 'Professor');

INSERT INTO `tipo_documento` (`id`, `nome`, `descricao`, `categoria`, `obrigatorio`) VALUES
(1, 'cpf', 'CPF', 'documento', 0),
(2, 'rg', 'RG', 'documento', 0),
(3, 'certidao_nascimento', 'Certidão de Nascimento', 'documento', 0),
(4, 'comprovante_residencia', 'Comprovante de Residência', 'documento', 0),
(5, 'contrato', 'Contrato', 'documento', 0),
(6, 'carteira_trabalho', 'Carteira de Trabalho', 'documento', 0),
(7, 'titulo_eleitor', 'Título de Eleitor', 'documento', 0),
(8, 'certificado_reservista', 'Certificado de Reservista', 'documento', 0),
(9, 'passaporte', 'Passaporte', 'documento', 0),
(10, 'carteira_profissional', 'Carteira Profissional', 'documento', 0),
(11, 'foto_perfil', 'Foto de Perfil', 'foto', 1),
(12, 'foto_documento', 'Foto de Documento', 'foto', 0),
(13, 'foto_comprovante', 'Foto do Comprovante', 'foto', 0),
(14, 'curriculo', 'Currículo', 'documento', 0),
(15, 'cursos_certificados', 'Cursos e Certificados', 'documento', 0),
(16, 'comprovante_experiencia', 'Comprovante de Experiência', 'documento', 0),
(17, 'comprovacoes_fiscais_mei', 'Comprovações fiscais MEI', 'documento', 0),
(18, 'medicamentos', 'Medicamentos da pessoa', 'documento', 0);


INSERT INTO `escolaridade` (`id`, `descricao`) VALUES
(1, 'Não-alfabetizado'),
(2, 'Fundamental incompleto'),
(3, 'Fundamental completo'),
(4, 'Médio incompleto'),
(5, 'Médio completo'),
(6, 'Superior incompleto'),
(7, 'Superior completo'),
(8, 'Pós-graduação');

INSERT INTO `etnia` (`id`, `descricao`) VALUES
(1, 'Branca'),
(2, 'Preta'),
(3, 'Amarela'),
(4, 'Parda'),
(5, 'Indígena');

INSERT INTO `genero` (`id`, `descricao`, `identidade_id`) VALUES
(1, 'Homem', 1),
(2, 'Mulher', 1),
(3, 'Homem Trans', 2),
(4, 'Mulher Trans', 2),
(5, 'Não Binário', 3),
(6, 'Gênero Fluido', 3),
(7, 'Agênero', 3),
(8, 'Prefere não informar', 4);

INSERT INTO `identidade_genero` (`id`, `descricao`) VALUES
(1, 'Cisgênero'),
(2, 'Transgênero'),
(3, 'Não-binário'),
(4, 'Prefere não informar');

INSERT INTO `orgao_emissor` (`id`, `descricao`, `uf_emissor`) VALUES
(1, 'SSP', 'AC'),
(2, 'DETRAN', 'AC'),
(3, 'SSP', 'AL'),
(4, 'DETRAN', 'AL'),
(5, 'SSP', 'AP'),
(6, 'DETRAN', 'AP'),
(7, 'SSP', 'AM'),
(8, 'DETRAN', 'AM'),
(9, 'SSP', 'BA'),
(10, 'DETRAN', 'BA'),
(11, 'SSP', 'CE'),
(12, 'DETRAN', 'CE'),
(13, 'SSP', 'DF'),
(14, 'DETRAN', 'DF'),
(15, 'SSP', 'ES'),
(16, 'DETRAN', 'ES'),
(17, 'SSP', 'GO'),
(18, 'DETRAN', 'GO'),
(19, 'SSP', 'MA'),
(20, 'DETRAN', 'MA'),
(21, 'SSP', 'MT'),
(22, 'DETRAN', 'MT'),
(23, 'SSP', 'MS'),
(24, 'DETRAN', 'MS'),
(25, 'SSP', 'MG'),
(26, 'DETRAN', 'MG'),
(27, 'SSP', 'PA'),
(28, 'DETRAN', 'PA'),
(29, 'SSP', 'PB'),
(30, 'DETRAN', 'PB'),
(31, 'SSP', 'PR'),
(32, 'DETRAN', 'PR'),
(33, 'SSP', 'PE'),
(34, 'DETRAN', 'PE'),
(35, 'SSP', 'PI'),
(36, 'DETRAN', 'PI'),
(37, 'SSP', 'RJ'),
(38, 'DETRAN', 'RJ'),
(39, 'SSP', 'RN'),
(40, 'DETRAN', 'RN'),
(41, 'SSP', 'RS'),
(42, 'DETRAN', 'RS'),
(43, 'SSP', 'RO'),
(44, 'DETRAN', 'RO'),
(45, 'SSP', 'RR'),
(46, 'DETRAN', 'RR'),
(47, 'SSP', 'SC'),
(48, 'DETRAN', 'SC'),
(49, 'SSP', 'SP'),
(50, 'DETRAN', 'SP'),
(51, 'SSP', 'SE'),
(52, 'DETRAN', 'SE'),
(53, 'SSP', 'TO'),
(54, 'DETRAN', 'TO'),
(55, 'POLÍCIA CIVIL', 'BR'),
(56, 'POLÍCIA FEDERAL', 'BR'),
(57, 'MINISTÉRIO DA DEFESA', 'BR'),
(58, 'SEM CPF', 'BR'),
(59, 'CARTÓRIO', 'BR'),
(60, 'OUTRO', 'BR'),
(61, 'SEPC', 'AC'),
(62, 'POAL', 'AL'),
(63, 'SDS', 'AL'),
(64, 'POLITEC', 'AP'),
(65, 'PCAM', 'AM'),
(66, 'SPTC', 'BA'),
(67, 'SSPDS', 'CE'),
(68, 'PCCE', 'CE'),
(69, 'PEFOCE', 'CE'),
(70, 'PCDF', 'DF'),
(71, 'II/PCDF', 'DF'),
(72, 'SESP', 'ES'),
(73, 'PCES', 'ES'),
(74, 'SPTTC', 'GO'),
(75, 'DGPC', 'GO'),
(76, 'IDENT', 'MA'),
(77, 'POLITEC', 'MT'),
(78, 'SEJUSP', 'MS'),
(79, 'PCMS', 'MS'),
(80, 'PCMG', 'MG'),
(81, 'SESP', 'MG'),
(82, 'SEGUP', 'PA'),
(83, 'CPC', 'PA'),
(84, 'SEDS', 'PB'),
(85, 'IPC', 'PB'),
(86, 'SESP', 'PR'),
(87, 'IIPR', 'PR'),
(88, 'SDS', 'PE'),
(89, 'IITB', 'PE'),
(90, 'SDSC', 'PE'),
(91, 'PCPI', 'PI'),
(92, 'IFP', 'RJ'),
(93, 'DIC', 'RJ'),
(94, 'SEPOL', 'RJ'),
(95, 'ITEP', 'RN'),
(96, 'SESED', 'RN'),
(97, 'IGP', 'RS'),
(98, 'SJS', 'RS'),
(99, 'FGTAS', 'RS'),
(100, 'SESDEC', 'RO'),
(101, 'SESP', 'RR'),
(102, 'IGP', 'SC'),
(103, 'PCI', 'SC'),
(104, 'IIRGD', 'SP'),
(105, 'SSPSE', 'SE'),
(106, 'SJSP', 'TO'),
(107, 'DPF', 'BR'),
(108, 'MEX', 'BR'),
(109, 'MAER', 'BR'),
(110, 'MM', 'BR'),
(111, 'MD', 'BR');

INSERT INTO `perfil_usuario` (`id`, `descricao`) VALUES
(1, 'Administrador'),
(2, 'Coordenador'),
(3, 'Colaborador'),
(4, 'Estagiário'),
(5, 'Visualizador'),
(6, 'Professor');

INSERT INTO `setor` (`id`, `nome`, `descricao`, `status`) VALUES
(1, 'Coordenação Executiva', 'Topo da hierarquia organizacional', 1),
(2, 'Coordenação de Projetos', 'Gerenciamento de projetos institucionais', 1),
(3, 'Coordenação Financeira', 'Gestão financeira e orçamentária', 1),
(4, 'Coordenação Nutricional e Equipe Estratégica', 'Gestão nutricional e equipe estratégica', 1),
(5, 'Equipe Administrativa', 'Atividades administrativas e apoio', 1),
(6, 'Coordenação Pedagógica', 'Gestão pedagógica e educacional', 1),
(7, 'Comunicação', 'Comunicação interna e externa', 1),
(8, 'Repografia/Estoque', 'Gestão de documentos e estoque', 1),
(9, 'Coordenação de Monitoramento', 'Monitoramento de projetos e atividades', 1),
(10, 'Coordenação de Tecnologia', 'Gestão de tecnologia e inovação', 1),
(11, 'Coordenação Multidisciplinar', 'Equipe multidisciplinar de apoio', 1),
(12, 'Educadores Físicos', 'Atividades físicas e esportivas', 1),
(13, 'Recepção', 'Atendimento inicial e recepção', 1),
(14, 'Transporte', 'Serviços de transporte', 1),
(15, 'Alimentação', 'Serviços de alimentação', 1),
(16, 'Área Agrícola', 'Projetos agrícolas e técnicos', 1),
(17, 'Voluntários', 'Equipe de voluntários', 1),
(18, 'Estagiários', 'Equipe de estagiários', 1);


INSERT INTO `setor_hierarquia` (`id`, `setor_id`, `setor_pai_id`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 4, 1),
(4, 5, 1),
(5, 6, 1),
(6, 7, 5),
(7, 8, 5),
(8, 9, 1),
(9, 10, 1),
(10, 11, 1),
(11, 12, 6),
(12, 13, 5),
(13, 14, 5),
(14, 15, 4),
(15, 16, 2);


-- ==========================================================
-- 2. NÚCLEO: PESSOAS E ENDEREÇO
-- ==========================================================

CREATE TABLE IF NOT EXISTS pessoa (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome_completo varchar(191) NOT NULL,
  nome_social varchar(191) DEFAULT NULL,
  apelido varchar(191) DEFAULT NULL,
  data_nasc datetime(3) NOT NULL,
  nome_mae varchar(191) NOT NULL,
  nome_pai varchar(191) DEFAULT NULL,
  cpf varchar(191) UNIQUE DEFAULT NULL, -- Chave da Integração
  rg varchar(191) DEFAULT NULL,
  naturalidade varchar(191) NOT NULL DEFAULT 'BRASIL',
  nacionalidade varchar(191) NOT NULL DEFAULT 'BRASIL',
  genero_id int NOT NULL,
  etnia_id int NOT NULL,
  escolaridade_id int NOT NULL,
  orgao_emissor_id int NOT NULL,
  tipo_sanguineo enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  status tinyint(1) NOT NULL DEFAULT '1',
  created_at datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  
  FOREIGN KEY (genero_id) REFERENCES genero (id),
  FOREIGN KEY (etnia_id) REFERENCES etnia (id),
  FOREIGN KEY (escolaridade_id) REFERENCES escolaridade (id),
  FOREIGN KEY (orgao_emissor_id) REFERENCES orgao_emissor (id)
);

CREATE TABLE IF NOT EXISTS endereco (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  pessoa_id int NOT NULL,
  cep varchar(191) NOT NULL,
  localidade varchar(191) NOT NULL,
  rua varchar(191) NOT NULL,
  numero varchar(191) NOT NULL,
  bairro varchar(191) NOT NULL,
  cidade varchar(191) NOT NULL,
  estado varchar(191) NOT NULL,
  FOREIGN KEY (pessoa_id) REFERENCES pessoa (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS contato (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  pessoa_id int NOT NULL,
  celular varchar(191) DEFAULT NULL,
  email varchar(191) DEFAULT NULL,
  FOREIGN KEY (pessoa_id) REFERENCES pessoa (id) ON DELETE CASCADE
);


-- ==========================================================
-- 3. ESTRUTURA ORGANIZACIONAL (CARGOS E SETORES)
-- ==========================================================

CREATE TABLE IF NOT EXISTS setor (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome varchar(191) NOT NULL,
  status tinyint(1) DEFAULT '1'
);
INSERT INTO setor (id, nome) VALUES (1, 'Pedagógico'), (2, 'Administrativo');

CREATE TABLE IF NOT EXISTS cargo (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descricao varchar(191) NOT NULL,
  setor_id int DEFAULT NULL,
  status tinyint(1) DEFAULT '1',
  FOREIGN KEY (setor_id) REFERENCES setor (id)
);

INSERT INTO `cargo` (`id`, `descricao`, `setor_id`, `status`) VALUES
(1, 'Coordenador(a) Geral', 1, 1),
(2, 'Coordenador(a) de Projetos', 2, 1),
(3, 'Coordenador(a) de Financeira', 3, 1),
(4, 'Nutricionista', 4, 1),
(5, 'Assistente Administrativo(a)', 5, 1),
(6, 'Assistente', 5, 1),
(7, 'Assistente Social', 5, 1),
(8, 'Serviços de Limpeza', 5, 1),
(9, 'Motorista', 5, 1),
(10, 'Motorista', 14, 1),
(11, 'Coordenador(a) Pedagógico(a)', 6, 1),
(12, 'Assessor(a) de Coordenação Pedagógica', 6, 1),
(13, 'Educador(a)', 6, 1),
(14, 'Educador(a) de Apoio', 6, 1),
(15, 'Educador(a) Social', 6, 1),
(16, 'Educador(a) Social de Apoio', 6, 1),
(17, 'Educador(a)/Instrutor(a)', 6, 1),
(18, 'Jornalista', 7, 1),
(19, 'Design Gráfico', 7, 1),
(20, 'Reprografia', 8, 1),
(21, 'Coordenador(a) de Monitoramento', 9, 1),
(22, 'Coordenador(a) de Tecnologia', 10, 1),
(23, 'Educador(a) de Tecnologia', 10, 1),
(24, 'Coordenador(a) de Multidisciplinar', 11, 1),
(25, 'Psicólogo(a)', 11, 1),
(26, 'Enfermeiro(a)', 11, 1),
(27, 'Educador(a) Físico(a)', 12, 1),
(28, 'Atendente/Recepção', 13, 1),
(29, 'Apoio na Alimentação', 15, 1),
(30, 'Cozinheiro(a)', 15, 1),
(31, 'Técnico(a) Agrícola', 16, 1),
(32, 'Equipe Multidisciplinar', 11, 1),
(33, 'Voluntário(a)', 17, 1),
(34, 'Estagiário(a)', 18, 1);


-- ==========================================================
-- 4. STAFF E LOGIN (PROFESSORES E ADMINS)
-- ==========================================================

CREATE TABLE IF NOT EXISTS colaborador (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  pessoa_id int DEFAULT NULL,
  cargo_id int NOT NULL,
  status tinyint(1) NOT NULL DEFAULT '1',
  email_institucional varchar(191) UNIQUE NOT NULL,
  
  FOREIGN KEY (pessoa_id) REFERENCES pessoa (id) ON DELETE CASCADE,
  FOREIGN KEY (cargo_id) REFERENCES cargo (id)
);

CREATE TABLE IF NOT EXISTS usuario (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_colaborador int NOT NULL UNIQUE,
  id_perfil_usuario int NOT NULL,
  login varchar(191) UNIQUE NOT NULL,
  senha varchar(191) NOT NULL,
  status tinyint(1) NOT NULL DEFAULT '1',
  
  FOREIGN KEY (id_colaborador) REFERENCES colaborador (id) ON DELETE CASCADE,
  FOREIGN KEY (id_perfil_usuario) REFERENCES perfil_usuario (id)
);


-- ==========================================================
-- 5. CONTEXTO DO ALUNO (BENEFICIÁRIO)
-- ==========================================================

CREATE TABLE IF NOT EXISTS projeto (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  titulo varchar(255) NOT NULL,
  status enum('planejado','ativo','finalizado') DEFAULT 'ativo'
);
INSERT INTO projeto (id, titulo) VALUES (1, 'Curso Técnico 2026');

CREATE TABLE IF NOT EXISTS processo_inscricao (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_projeto int DEFAULT NULL,
  titulo varchar(255) NOT NULL,
  FOREIGN KEY (id_projeto) REFERENCES projeto (id)
);
INSERT INTO processo_inscricao (id, id_projeto, titulo) VALUES (1, 1, 'Processo Seletivo 2026.1');

CREATE TABLE IF NOT EXISTS Beneficiario (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  pessoa_id int NOT NULL UNIQUE,
  id_projeto int NOT NULL,
  id_processo_inscricao int NOT NULL,
  data_vinculo datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  
  FOREIGN KEY (pessoa_id) REFERENCES pessoa (id) ON DELETE CASCADE,
  FOREIGN KEY (id_projeto) REFERENCES projeto (id),
  FOREIGN KEY (id_processo_inscricao) REFERENCES processo_inscricao (id)
);


-- ==========================================================
-- 6. MÓDULO ACADÊMICO (NOSSAS TABELAS DE FREQUÊNCIA)
-- ==========================================================

-- TURMAS (Ligadas ao Projeto)
CREATE TABLE IF NOT EXISTS turmas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    projeto_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,   
    turno VARCHAR(20) NOT NULL,   
    periodo VARCHAR(20) NOT NULL, 
    dias_aula TEXT,               
    data_inicio DATE,
    data_fim DATE,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (projeto_id) REFERENCES projeto(id)
);

-- DISCIPLINAS
CREATE TABLE IF NOT EXISTS disciplinas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT,
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE
);

-- VÍNCULO PROFESSOR <-> TURMA (Usa Colaborador)
CREATE TABLE IF NOT EXISTS turma_professores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    colaborador_id INT NOT NULL, 
    disciplina_id INT,           
    ativo BOOLEAN DEFAULT TRUE,
    
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE,
    FOREIGN KEY (colaborador_id) REFERENCES colaborador(id),
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id)
);

-- MATRÍCULAS (Usa Beneficiario)
CREATE TABLE IF NOT EXISTS matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    beneficiario_id INT NOT NULL, 
    data_matricula DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Ativo', 'Trancado', 'Concluido', 'Desistente') DEFAULT 'Ativo',
    
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE,
    FOREIGN KEY (beneficiario_id) REFERENCES Beneficiario(id),
    UNIQUE KEY aluno_turma_unico (turma_id, beneficiario_id)
);

-- AULAS (Diário)
CREATE TABLE IF NOT EXISTS aulas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    colaborador_id INT NOT NULL, 
    data_aula DATE NOT NULL,
    conteudo TEXT,
    numero_aulas INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE,
    FOREIGN KEY (colaborador_id) REFERENCES colaborador(id)
);

-- FREQUÊNCIAS (Chamada)
CREATE TABLE IF NOT EXISTS frequencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aula_id INT NOT NULL,
    matricula_id INT NOT NULL, 
    status ENUM('Presente', 'Ausente', 'Justificado') NOT NULL,
    observacao VARCHAR(255),
    
    FOREIGN KEY (aula_id) REFERENCES aulas(id) ON DELETE CASCADE,
    FOREIGN KEY (matricula_id) REFERENCES matriculas(id) ON DELETE CASCADE
);

-- INSERIR UM ADMIN PADRÃO PRA VOCÊ NÃO FICAR TRANCADO DO LADO DE FORA
-- 1. Cria a Pessoa
INSERT INTO pessoa (id, nome_completo, nome_mae, cpf, data_nasc, genero_id, etnia_id, escolaridade_id, orgao_emissor_id) 
VALUES (1, 'ADMINISTRADOR MESTRE', 'SYSTEM', '00000000000', '2000-01-01', 1, 1, 3, 1);

-- 2. Cria o Colaborador
INSERT INTO colaborador (id, pessoa_id, cargo_id, email_institucional) 
VALUES (1, 1, 1, 'admin@sysfrequencia.com'); -- Cargo 1 = Coordenador (já criado acima)

-- 3. Cria o Usuário (Login: admin / Senha: 123 - Hash)
INSERT INTO usuario (id_colaborador, id_perfil_usuario, login, senha) 
VALUES (1, 1, 'admin', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82');