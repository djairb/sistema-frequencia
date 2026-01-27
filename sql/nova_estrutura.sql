CREATE DATABASE IF NOT EXISTS sysfrequenciaBeneficiario;
USE sysfrequenciaBeneficiario;
-- Estrutura para tabela `Beneficiario`
--

CREATE TABLE `Beneficiario` (
  `id` int NOT NULL,
  `pessoa_id` int NOT NULL,
  `id_projeto` int NOT NULL,
  `id_processo_inscricao` int NOT NULL,
  `data_vinculo` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `Beneficiario`
--

INSERT INTO `Beneficiario` (`id`, `pessoa_id`, `id_projeto`, `id_processo_inscricao`, `data_vinculo`) VALUES
(3, 2, 1, 1, '2026-01-26 12:13:27.002'),
(4, 3, 1, 1, '2026-01-26 13:22:51.421');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cargo`
--

CREATE TABLE `cargo` (
  `id` int NOT NULL,
  `descricao` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setor_id` int DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `cargo`
--

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

-- --------------------------------------------------------

--
-- Estrutura para tabela `colaborador`
--

CREATE TABLE `colaborador` (
  `id` int NOT NULL,
  `pessoa_id` int DEFAULT NULL,
  `cargo_id` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `email_institucional` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `colaborador`
-- --------------------------------------------------------

--
-- Estrutura para tabela `contato`
--

CREATE TABLE `contato` (
  `id` int NOT NULL,
  `pessoa_id` int NOT NULL,
  `telefone_fixo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `celular` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `contato`
---- --------------------------------------------------------

--
-- Estrutura para tabela `documento`
--

CREATE TABLE `documento` (
  `id` int NOT NULL,
  `pessoa_id` int NOT NULL,
  `tipo_documento_id` int NOT NULL,
  `nome_original` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome_arquivo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `caminho_minio` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tamanho` int NOT NULL,
  `tipo_mime` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extensao` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_upload` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `documento`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `endereco`
--

CREATE TABLE `endereco` (
  `id` int NOT NULL,
  `pessoa_id` int NOT NULL,
  `cep` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `localidade` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rua` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ponto_referencia` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bairro` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cidade` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zona_localidade` enum('Zona Urbana','Zona Rural') COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `endereco`
---- --------------------------------------------------------

--
-- Estrutura para tabela `escolaridade`
--

CREATE TABLE `escolaridade` (
  `id` int NOT NULL,
  `descricao` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `escolaridade`
--

INSERT INTO `escolaridade` (`id`, `descricao`) VALUES
(1, 'Não-alfabetizado'),
(2, 'Fundamental incompleto'),
(3, 'Fundamental completo'),
(4, 'Médio incompleto'),
(5, 'Médio completo'),
(6, 'Superior incompleto'),
(7, 'Superior completo'),
(8, 'Pós-graduação');

-- --------------------------------------------------------

--
-- Estrutura para tabela `etnia`
--

CREATE TABLE `etnia` (
  `id` int NOT NULL,
  `descricao` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `etnia`
--

INSERT INTO `etnia` (`id`, `descricao`) VALUES
(1, 'Branca'),
(2, 'Preta'),
(3, 'Amarela'),
(4, 'Parda'),
(5, 'Indígena');

-- --------------------------------------------------------

--
-- Estrutura para tabela `genero`
--

CREATE TABLE `genero` (
  `id` int NOT NULL,
  `descricao` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identidade_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `genero`
--

INSERT INTO `genero` (`id`, `descricao`, `identidade_id`) VALUES
(1, 'Homem', 1),
(2, 'Mulher', 1),
(3, 'Homem Trans', 2),
(4, 'Mulher Trans', 2),
(5, 'Não Binário', 3),
(6, 'Gênero Fluido', 3),
(7, 'Agênero', 3),
(8, 'Prefere não informar', 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `identidade_genero`
--

CREATE TABLE `identidade_genero` (
  `id` int NOT NULL,
  `descricao` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `identidade_genero`
--

INSERT INTO `identidade_genero` (`id`, `descricao`) VALUES
(1, 'Cisgênero'),
(2, 'Transgênero'),
(3, 'Não-binário'),
(4, 'Prefere não informar');

-- --------------------------------------------------------

--
-- Estrutura para tabela `orgao_emissor`
--

CREATE TABLE `orgao_emissor` (
  `id` int NOT NULL,
  `descricao` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uf_emissor` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `orgao_emissor`
--

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

-- --------------------------------------------------------

--
-- Estrutura para tabela `perfil_usuario`
--

CREATE TABLE `perfil_usuario` (
  `id` int NOT NULL,
  `descricao` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `perfil_usuario`
--

INSERT INTO `perfil_usuario` (`id`, `descricao`) VALUES
(1, 'Administrador'),
(2, 'Coordenador'),
(3, 'Colaborador'),
(4, 'Estagiário'),
(5, 'Visualizador'),
(6, 'Professor');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pessoa`
--

CREATE TABLE `pessoa` (
  `id` int NOT NULL,
  `nome_completo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome_social` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apelido` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_nasc` datetime(3) NOT NULL,
  `nome_mae` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome_pai` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cpf` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rg` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naturalidade` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nacionalidade` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero_id` int NOT NULL,
  `etnia_id` int NOT NULL,
  `escolaridade_id` int NOT NULL,
  `orgao_emissor_id` int NOT NULL,
  `tipo_sanguineo` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `cin` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `pessoa`
--
-------------------------------------------------------

--
-- Estrutura para tabela `processo_inscricao`
--

CREATE TABLE `processo_inscricao` (
  `id` int NOT NULL,
  `id_projeto` int DEFAULT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observacao` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_vagas` int DEFAULT NULL,
  `data_inicio` datetime(3) DEFAULT NULL,
  `data_fim` datetime(3) DEFAULT NULL,
  `status` enum('planejado','ativo','fechado','finalizado','cancelado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'planejado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `processo_inscricao`
--
 --------------------------------------------------------

--
-- Estrutura para tabela `projeto`
--

CREATE TABLE `projeto` (
  `id` int NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_inicio` datetime(3) DEFAULT NULL,
  `data_final_prevista` datetime(3) DEFAULT NULL,
  `status` enum('planejado','ativo','finalizado','cancelado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'planejado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `projeto`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `refresh_token`
--

--
-- Despejando dados para a tabela `refresh_token`
--



-- --------------------------------------------------------

--
-- Estrutura para tabela `setor`
--

CREATE TABLE `setor` (
  `id` int NOT NULL,
  `nome` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `setor`
--

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

-- --------------------------------------------------------

--
-- Estrutura para tabela `setor_hierarquia`
--

CREATE TABLE `setor_hierarquia` (
  `id` int NOT NULL,
  `setor_id` int NOT NULL,
  `setor_pai_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `setor_hierarquia`
--

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

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `id` int NOT NULL,
  `nome` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `obrigatorio` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `tipo_documento`
--

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

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--



--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `Beneficiario`
--
ALTER TABLE `Beneficiario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Beneficiario_pessoa_id_key` (`pessoa_id`),
  ADD KEY `beneficiario_id_projeto_fkey` (`id_projeto`),
  ADD KEY `beneficiario_id_processo_inscricao_fkey` (`id_processo_inscricao`);

--
-- Índices de tabela `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cargo_setor_id_fkey` (`setor_id`);

--
-- Índices de tabela `colaborador`
--
ALTER TABLE `colaborador`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `colaborador_email_institucional_key` (`email_institucional`),
  ADD UNIQUE KEY `colaborador_pessoa_id_key` (`pessoa_id`),
  ADD KEY `colaborador_cargo_id_fkey` (`cargo_id`);

--
-- Índices de tabela `contato`
--
ALTER TABLE `contato`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contato_pessoa_id_fkey` (`pessoa_id`);

--
-- Índices de tabela `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `documento_pessoa_id_tipo_documento_id_status_key` (`pessoa_id`,`tipo_documento_id`,`status`),
  ADD KEY `documento_tipo_documento_id_fkey` (`tipo_documento_id`);

--
-- Índices de tabela `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`id`),
  ADD KEY `endereco_pessoa_id_fkey` (`pessoa_id`);

--
-- Índices de tabela `escolaridade`
--
ALTER TABLE `escolaridade`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `etnia`
--
ALTER TABLE `etnia`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genero_identidade_id_fkey` (`identidade_id`);

--
-- Índices de tabela `identidade_genero`
--
ALTER TABLE `identidade_genero`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `orgao_emissor`
--
ALTER TABLE `orgao_emissor`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `perfil_usuario`
--
ALTER TABLE `perfil_usuario`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `pessoa`
--
ALTER TABLE `pessoa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pessoa_cpf_key` (`cpf`),
  ADD KEY `pessoa_escolaridade_id_fkey` (`escolaridade_id`),
  ADD KEY `pessoa_etnia_id_fkey` (`etnia_id`),
  ADD KEY `pessoa_genero_id_fkey` (`genero_id`),
  ADD KEY `pessoa_orgao_emissor_id_fkey` (`orgao_emissor_id`);

--
-- Índices de tabela `processo_inscricao`
--
ALTER TABLE `processo_inscricao`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `processo_inscricao_id_projeto_key` (`id_projeto`);

--
-- Índices de tabela `projeto`
--
ALTER TABLE `projeto`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `refresh_token`
--
ALTER TABLE `refresh_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `refresh_token_token_key` (`token`),
  ADD KEY `refresh_token_usuario_id_fkey` (`usuario_id`),
  ADD KEY `refresh_token_expires_at_idx` (`expires_at`);

--
-- Índices de tabela `setor`
--
ALTER TABLE `setor`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `setor_hierarquia`
--
ALTER TABLE `setor_hierarquia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `setor_hierarquia_setor_id_fkey` (`setor_id`),
  ADD KEY `setor_hierarquia_setor_pai_id_fkey` (`setor_pai_id`);

--
-- Índices de tabela `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tipo_documento_nome_key` (`nome`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id_colaborador_key` (`id_colaborador`),
  ADD UNIQUE KEY `usuario_login_key` (`login`),
  ADD KEY `usuario_id_perfil_usuario_fkey` (`id_perfil_usuario`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `Beneficiario`
--
ALTER TABLE `Beneficiario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de tabela `colaborador`
--
ALTER TABLE `colaborador`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `contato`
--
ALTER TABLE `contato`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `documento`
--
ALTER TABLE `documento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `endereco`
--
ALTER TABLE `endereco`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `escolaridade`
--
ALTER TABLE `escolaridade`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `etnia`
--
ALTER TABLE `etnia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `genero`
--
ALTER TABLE `genero`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `identidade_genero`
--
ALTER TABLE `identidade_genero`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `orgao_emissor`
--
ALTER TABLE `orgao_emissor`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT de tabela `perfil_usuario`
--
ALTER TABLE `perfil_usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `pessoa`
--
ALTER TABLE `pessoa`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `processo_inscricao`
--
ALTER TABLE `processo_inscricao`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `projeto`
--
ALTER TABLE `projeto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `refresh_token`
--
ALTER TABLE `refresh_token`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de tabela `setor`
--
ALTER TABLE `setor`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `setor_hierarquia`
--
ALTER TABLE `setor_hierarquia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `Beneficiario`
--
ALTER TABLE `Beneficiario`
  ADD CONSTRAINT `Beneficiario_id_processo_inscricao_fkey` FOREIGN KEY (`id_processo_inscricao`) REFERENCES `processo_inscricao` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Beneficiario_id_projeto_fkey` FOREIGN KEY (`id_projeto`) REFERENCES `projeto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Beneficiario_pessoa_id_fkey` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `cargo`
--
ALTER TABLE `cargo`
  ADD CONSTRAINT `cargo_setor_id_fkey` FOREIGN KEY (`setor_id`) REFERENCES `setor` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `colaborador`
--
ALTER TABLE `colaborador`
  ADD CONSTRAINT `colaborador_cargo_id_fkey` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `colaborador_pessoa_id_fkey` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `contato`
--
ALTER TABLE `contato`
  ADD CONSTRAINT `contato_pessoa_id_fkey` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `documento`
--
ALTER TABLE `documento`
  ADD CONSTRAINT `documento_pessoa_id_fkey` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `documento_tipo_documento_id_fkey` FOREIGN KEY (`tipo_documento_id`) REFERENCES `tipo_documento` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Restrições para tabelas `endereco`
--
ALTER TABLE `endereco`
  ADD CONSTRAINT `endereco_pessoa_id_fkey` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `genero`
--
ALTER TABLE `genero`
  ADD CONSTRAINT `genero_identidade_id_fkey` FOREIGN KEY (`identidade_id`) REFERENCES `identidade_genero` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `pessoa`
--
ALTER TABLE `pessoa`
  ADD CONSTRAINT `pessoa_escolaridade_id_fkey` FOREIGN KEY (`escolaridade_id`) REFERENCES `escolaridade` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `pessoa_etnia_id_fkey` FOREIGN KEY (`etnia_id`) REFERENCES `etnia` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `pessoa_genero_id_fkey` FOREIGN KEY (`genero_id`) REFERENCES `genero` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `pessoa_orgao_emissor_id_fkey` FOREIGN KEY (`orgao_emissor_id`) REFERENCES `orgao_emissor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Restrições para tabelas `processo_inscricao`
--
ALTER TABLE `processo_inscricao`
  ADD CONSTRAINT `processo_inscricao_id_projeto_fkey` FOREIGN KEY (`id_projeto`) REFERENCES `projeto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `refresh_token`
--
ALTER TABLE `refresh_token`
  ADD CONSTRAINT `refresh_token_usuario_id_fkey` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `setor_hierarquia`
--
ALTER TABLE `setor_hierarquia`
  ADD CONSTRAINT `setor_hierarquia_setor_id_fkey` FOREIGN KEY (`setor_id`) REFERENCES `setor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `setor_hierarquia_setor_pai_id_fkey` FOREIGN KEY (`setor_pai_id`) REFERENCES `setor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_id_colaborador_fkey` FOREIGN KEY (`id_colaborador`) REFERENCES `colaborador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuario_id_perfil_usuario_fkey` FOREIGN KEY (`id_perfil_usuario`) REFERENCES `perfil_usuario` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- =======================================================
-- MÓDULO ACADÊMICO (Nossas tabelas adaptadas ao SysConex)
-- =======================================================

-- 1. TABELA DE TURMAS
-- Mantemos igual, mas agora o projeto_id é chave estrangeira real
CREATE TABLE IF NOT EXISTS turmas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    projeto_id INT NOT NULL,      -- Liga com a tabela 'projeto' do Rhian
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

-- 2. TABELA DE DISCIPLINAS
CREATE TABLE IF NOT EXISTS disciplinas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT,
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE
);

-- 3. VÍNCULO PROFESSOR <-> TURMA
-- Atenção: Aqui ligamos com 'colaborador' (que é quem trabalha)
CREATE TABLE IF NOT EXISTS turma_professores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    colaborador_id INT NOT NULL, -- ID do Professor (tabela colaborador)
    disciplina_id INT,           -- Pode ser null se for polivalente
    ativo BOOLEAN DEFAULT TRUE,
    
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE,
    FOREIGN KEY (colaborador_id) REFERENCES colaborador(id),
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id)
);

-- 4. MATRÍCULAS (Vínculo Aluno <-> Turma)
-- Atenção: Aqui ligamos com 'Beneficiario' (que são os alunos no SysConex)
CREATE TABLE IF NOT EXISTS matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    beneficiario_id INT NOT NULL, -- ID do Aluno (tabela Beneficiario)
    data_matricula DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Ativo', 'Trancado', 'Concluido', 'Desistente') DEFAULT 'Ativo',
    
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE,
    FOREIGN KEY (beneficiario_id) REFERENCES Beneficiario(id),
    UNIQUE KEY aluno_turma_unico (turma_id, beneficiario_id)
);

-- 5. AULAS (Diário de Classe)
CREATE TABLE IF NOT EXISTS aulas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    colaborador_id INT NOT NULL, -- Quem deu a aula (tabela colaborador)
    data_aula DATE NOT NULL,
    conteudo TEXT,
    numero_aulas INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE,
    FOREIGN KEY (colaborador_id) REFERENCES colaborador(id)
);

-- 6. FREQUÊNCIAS (A Chamada)
CREATE TABLE IF NOT EXISTS frequencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aula_id INT NOT NULL,
    matricula_id INT NOT NULL, -- Link com a matrícula
    status ENUM('Presente', 'Ausente', 'Justificado') NOT NULL,
    observacao VARCHAR(255),
    
    FOREIGN KEY (aula_id) REFERENCES aulas(id) ON DELETE CASCADE,
    FOREIGN KEY (matricula_id) REFERENCES matriculas(id) ON DELETE CASCADE
);
