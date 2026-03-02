# Relatório Técnico Completo - SysConex (Sistema de Frequência)

Este documento detalha o ecossistema tecnológico e todas as funcionalidades implementadas no SysConex, separadas por módulos.

---

## 1. Stack Tecnológico (Tecnologias Utilizadas)

### Frontend (Aplicação Cliente)
A interface de usuário foi construída visando alta interatividade, performance e design responsivo.
* **React 19**: Biblioteca principal para construção das interfaces de usuário utilizando abordagens modernas (Hooks, Componentes Funcionais).
* **Vite**: Ferramenta de build e servidor de desenvolvimento ultrarrápido.
* **React Router DOM (^7.12.0)**: Gerenciamento de rotas e navegação SPA (Single Page Application).
* **TailwindCSS (^3.4.17)**: Framework de CSS utilitário utilizado para toda a estilização e layout responsivo do sistema.
* **Axios**: Cliente HTTP para comunicação com a API REST do backend.
* **Lucide React**: Biblioteca de ícones vetoriais modernos.
* **React Dropzone & Browser Image Compression**: Bibliotecas para interface de upload de arquivos (arrastar e soltar) e compressão de imagens no lado do cliente antes do envio para otimização de banda estruturada para o Diário de Classe.

### Backend (Servidor API)
A API RESTful responsável pela regra de negócio e persistência de dados.
* **Node.js**: Ambiente de execução JavaScript no servidor.
* **Express.js (^5.1.0)**: Framework web principal para mapeamento de rotas e tratamento de requisições HTTP.
* **MySQL & MySQL2**: Banco de dados relacional escolhido para persistência; o pacote `mysql2` provê suporte a Promises.
* **JSON Web Token (JWT)**: Padrão utilizado para autenticação via tokens e controle de sessões (Tokens duram 8h de padrão).
* **Bcryptjs**: Algoritmo de hash utilizado para criptografia segura das senhas dos usuários no banco de dados.
* **Multer**: Middleware utilizado para manipulação e upload de arquivos multipart/form-data (Fotos do Diário de Classe).
* **UUID**: Geração de identificadores únicos universais para renomeação segura de arquivos enviados no upload.

---

## 2. Funcionalidades do Sistema

O sistema atende principalmente a dois perfis: **Coordenadores** (Gestão Geral) e **Professores** (Gestão da Sala de Aula).

### 2.1. Segurança e Autenticação
* **Login por CPF e Senha**: Validação de credenciais através de senhas criptografadas (Bcrypt).
* **Controle de Acesso Baseado em Perfis (RBAC)**: O token JWT guarda o perfil do usuário, bloqueando acesso a rotas não autorizadas no front e no back (Ex: professor só pode alterar sua própria aula).
* **Proteção de Rotas API**: Middleware de verificação de token obrigatório (`verificarUsuario`) nas requisições do sistema.

### 2.2. Integração via Webhook
* **Sincronização de Dados Externa**: Rota dedicada (`/integracao/receber-dados`) protegida por um Token Header Estático, projetada para receber dados de um sistema central (Ex: Rhian API) e sincronizar usuários, estudantes e professores (Create/Update automáticos no banco de dados do SysConex).

### 2.3. Gestão de Turmas (CRUD Completo)
* **Criação e Edição**: Cadastro de turmas vinculadas a projetoss, definindo turno, período, dias da semana e vigência (data início/fim).
* **Listagem e Status**: Visualização de todas as turmas cadastradas exibindo quantidade de alunos ativos e professores vinculados.
* **Ativação/Inativação**: Turmas podem ser marcadas como inativas, bloqueando edição e ocultando-as de visões operacionais, permitindo reativação futura.

### 2.4. Gestão de Alunos (Matrículas)
* **Busca Global**: Motor de busca de beneficiários (alunos) por Nome ou CPF independente da turma.
* **Matrícula Inteligente**: 
  * Trava de segurança para impedir que o mesmo aluno tenha matrículas ativas em múltiplos projetos conflitantes.
  * Reativação automática do status se o aluno já existiu na turma anteriormente.
* **Desistência**: Rotação do status do aluno para "Desistente", preservando seu histórico na turma (sem exclusão física -"Soft Delete").
* **Estatísticas Turma**: Tela que consolida as faltas e presenças gerais da turma calculando a taxa percentual de frequência de cada aluno matriculado.

### 2.5. Gestão de Professores (Vínculos)
* **Busca e Listagem de Professores**: Filtra colaboradores exclusivamente com o perfil de professor (ID 6).
* **Vínculo Multidirecional**: Um professor pode ser alocado em diversas turmas e uma turma pode ter mais de um professor.
* **Desvinculação (Soft Delete)**: O professor pode ser removido da turma de forma lógica (ativo = 0).

### 2.6. Diário de Classe (Área do Professor)
* **Minhas Turmas**: Visão restrita onde o professor enxerga apenas as turmas ativas que lhe foram designadas.
* **Registro de Aulas e Frequência**:
  * Criação de nova aula contendo data e descrição do conteúdo lecionado.
  * Chamada (frequência) registrada individualmente para cada aluno da turma com os status: *Presente*, *Ausente* ou *Justificado* (admitindo campo de observação preenchível para justificativas).
* **Edição de Aula**: Caso o professor pule o lançamento ou erre algo, possibilita a auditoria e alteração do conteúdo e de frequências isoladas dadas naquela data.
* **Exclusão de Aula**: Exclusão em cascata (remove primeiro as presenças, em seguida a aula em si). Apenas o professor autor (dono) ou um coordenador pode efetuar esta e a ação anterior.
* **Registro Fotográfico da Aula**: 
  * Possibilidade de enviar arquivos de imagens JPG/PNG para documentar o andamento da aula.
  * Preview da foto em modal na listagem do diário de classe.
  * Funcionalidade completa de deleção física (remoção do banco de dados + remoção do arquivo de foto do diretório `./uploads/fotos_frequencia`).

### 2.7. Relatórios e Históricos
* **Histórico Individual do Aluno**: Modal/página robusta contendo:
  * Dados Pessoais do Aluno.
  * Trilho do tempo (Timeline) com todas as movimentações e matrículas no projeto.
  * Tabela minuciosa consolidando TODO o histórico de aulas que ele já participou listando as datas, status e nome do professor responsável.
  * Métricas resumidas do aproveitamento do respectivo beneficiário.
* **Dashboard Administrativo**: Visão superior para coordenadores, englobando contadores (Alunos matriculados, turmas em andamento/encerradas, total de professores), além de um painel de alerta focado em apontar turmas ativas que precisam de alocação de professor.
