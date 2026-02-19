-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 18/02/2026 às 19:38
-- Versão do servidor: 5.7.44
-- Versão do PHP: 8.1.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `somosc28_frequenciaBeneficiario`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `aulas`
--

DROP TABLE IF EXISTS `aulas`;
CREATE TABLE `aulas` (
  `id` int(11) NOT NULL,
  `turma_id` int(11) NOT NULL,
  `colaborador_id` int(11) NOT NULL,
  `data_aula` date NOT NULL,
  `conteudo` text,
  `numero_aulas` int(11) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `aulas`
--

INSERT INTO `aulas` (`id`, `turma_id`, `colaborador_id`, `data_aula`, `conteudo`, `numero_aulas`, `created_at`) VALUES
(1, 3, 2, '2026-02-04', 'Aula de arduino', 1, '2026-02-04 13:14:58'),
(2, 3, 2, '2026-02-04', 'Hoje aula de arduino 2', 1, '2026-02-04 13:15:31'),
(3, 2, 2, '2026-02-01', 'Vamos embora', 1, '2026-02-04 13:16:20'),
(4, 3, 2, '2026-02-02', 'aula de introduzção ', 1, '2026-02-04 13:26:37');

-- --------------------------------------------------------

--
-- Estrutura para tabela `Beneficiario`
--

DROP TABLE IF EXISTS `Beneficiario`;
CREATE TABLE `Beneficiario` (
  `id` int(11) NOT NULL,
  `pessoa_id` int(11) NOT NULL,
  `id_projeto` int(11) NOT NULL,
  `id_processo_inscricao` int(11) NOT NULL,
  `data_vinculo` datetime(3) DEFAULT CURRENT_TIMESTAMP(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `Beneficiario`
--

INSERT INTO `Beneficiario` (`id`, `pessoa_id`, `id_projeto`, `id_processo_inscricao`, `data_vinculo`) VALUES
(1, 2, 1, 1, '2026-02-10 12:18:39.179'),
(2, 3, 1, 1, '2026-02-10 12:18:39.181'),
(3, 4, 1, 1, '2026-02-10 12:18:39.182'),
(4, 5, 1, 1, '2026-02-10 12:18:39.184'),
(5, 6, 1, 1, '2026-02-10 12:18:39.186'),
(6, 7, 1, 1, '2026-02-10 12:18:39.189'),
(7, 8, 1, 1, '2026-02-10 12:18:39.191'),
(8, 9, 1, 1, '2026-02-10 12:18:39.193'),
(9, 10, 1, 1, '2026-02-10 12:18:39.194'),
(10, 11, 1, 1, '2026-02-10 12:18:39.196'),
(11, 12, 1, 1, '2026-02-10 12:18:39.197'),
(12, 13, 1, 1, '2026-02-10 12:18:39.198'),
(13, 14, 1, 1, '2026-02-10 12:18:39.199'),
(14, 15, 1, 1, '2026-02-10 12:18:39.200'),
(15, 16, 1, 1, '2026-02-10 12:18:39.201'),
(16, 17, 1, 1, '2026-02-10 12:18:39.202'),
(17, 18, 1, 1, '2026-02-10 12:18:39.203'),
(18, 19, 1, 1, '2026-02-10 12:18:39.204'),
(19, 20, 1, 1, '2026-02-10 12:18:39.209'),
(20, 21, 1, 1, '2026-02-10 12:18:39.211'),
(21, 22, 1, 1, '2026-02-10 12:18:39.212'),
(22, 23, 1, 1, '2026-02-10 12:18:39.213'),
(23, 24, 1, 1, '2026-02-10 12:18:39.214'),
(24, 25, 1, 1, '2026-02-10 12:18:39.215'),
(25, 26, 1, 1, '2026-02-10 12:18:39.217'),
(26, 27, 1, 1, '2026-02-10 12:18:39.218'),
(27, 28, 1, 1, '2026-02-10 12:18:39.219'),
(28, 29, 1, 1, '2026-02-10 12:18:39.220'),
(29, 30, 1, 1, '2026-02-10 12:18:39.221'),
(30, 31, 1, 1, '2026-02-10 12:18:39.222'),
(31, 32, 1, 1, '2026-02-10 12:18:39.223'),
(32, 33, 1, 1, '2026-02-10 12:18:39.224'),
(33, 34, 1, 1, '2026-02-10 12:18:39.226'),
(34, 35, 1, 1, '2026-02-10 12:18:39.227'),
(35, 36, 1, 1, '2026-02-10 12:18:39.228'),
(36, 37, 1, 1, '2026-02-10 12:18:39.229'),
(37, 38, 1, 1, '2026-02-10 12:18:39.230'),
(38, 39, 1, 1, '2026-02-10 12:18:39.231'),
(39, 40, 1, 1, '2026-02-10 12:18:39.232'),
(40, 41, 1, 1, '2026-02-10 12:18:39.233'),
(41, 42, 1, 1, '2026-02-10 12:18:39.234'),
(42, 43, 1, 1, '2026-02-10 12:18:39.235'),
(43, 45, 1, 1, '2026-02-10 12:18:39.239'),
(44, 47, 1, 1, '2026-02-10 12:18:39.243'),
(45, 49, 1, 1, '2026-02-10 12:18:39.246'),
(46, 50, 1, 1, '2026-02-10 12:18:39.247'),
(47, 51, 1, 1, '2026-02-10 12:18:39.249'),
(48, 52, 1, 1, '2026-02-10 12:18:39.250'),
(49, 54, 1, 1, '2026-02-10 12:18:39.253'),
(50, 56, 1, 1, '2026-02-10 12:18:39.256'),
(51, 57, 1, 1, '2026-02-10 12:18:39.258'),
(52, 58, 3, 1, '2026-02-10 12:18:39.260'),
(53, 60, 3, 1, '2026-02-10 12:18:39.264'),
(54, 61, 3, 1, '2026-02-10 12:18:39.265'),
(55, 62, 3, 1, '2026-02-10 12:18:39.267'),
(56, 63, 3, 1, '2026-02-10 12:18:39.268'),
(57, 64, 3, 1, '2026-02-10 12:18:39.270'),
(58, 65, 3, 1, '2026-02-10 12:18:39.273'),
(59, 66, 3, 1, '2026-02-10 12:18:39.277'),
(60, 67, 3, 1, '2026-02-10 12:18:39.279'),
(61, 68, 3, 1, '2026-02-10 12:18:39.280'),
(62, 69, 3, 1, '2026-02-10 12:18:39.281'),
(63, 70, 3, 1, '2026-02-10 12:18:39.283'),
(64, 71, 3, 1, '2026-02-10 12:18:39.284'),
(65, 72, 3, 1, '2026-02-10 12:18:39.286'),
(66, 73, 3, 1, '2026-02-10 12:18:39.287'),
(67, 74, 3, 1, '2026-02-10 12:18:39.288'),
(68, 75, 3, 1, '2026-02-10 12:18:39.289'),
(69, 76, 3, 1, '2026-02-10 12:18:39.290'),
(70, 77, 3, 1, '2026-02-10 12:18:39.293'),
(71, 78, 3, 1, '2026-02-10 12:18:39.295'),
(72, 79, 3, 1, '2026-02-10 12:18:39.296'),
(73, 80, 3, 1, '2026-02-10 12:18:39.297'),
(74, 81, 3, 1, '2026-02-10 12:18:39.298'),
(75, 82, 3, 1, '2026-02-10 12:18:39.299'),
(76, 83, 3, 1, '2026-02-10 12:18:39.300'),
(77, 84, 3, 1, '2026-02-10 12:18:39.301'),
(78, 85, 3, 1, '2026-02-10 12:18:39.302'),
(79, 86, 3, 1, '2026-02-10 12:18:39.303'),
(80, 87, 3, 1, '2026-02-10 12:18:39.303'),
(81, 88, 3, 1, '2026-02-10 12:18:39.304'),
(82, 89, 3, 1, '2026-02-10 12:18:39.305'),
(83, 90, 3, 1, '2026-02-10 12:18:39.307'),
(84, 91, 3, 1, '2026-02-10 12:18:39.308'),
(85, 92, 3, 1, '2026-02-10 12:18:39.308'),
(86, 93, 3, 1, '2026-02-10 12:18:39.309'),
(87, 94, 3, 1, '2026-02-10 12:18:39.315'),
(88, 95, 3, 1, '2026-02-10 12:18:39.319'),
(89, 96, 3, 1, '2026-02-10 12:18:39.322'),
(90, 97, 3, 1, '2026-02-10 12:18:39.324'),
(91, 98, 3, 1, '2026-02-10 12:18:39.326'),
(92, 99, 3, 1, '2026-02-10 12:18:39.328'),
(93, 100, 3, 1, '2026-02-10 12:18:39.332'),
(94, 101, 3, 1, '2026-02-10 12:18:39.334'),
(95, 102, 3, 1, '2026-02-10 12:18:39.337'),
(96, 103, 3, 1, '2026-02-10 12:18:39.338'),
(97, 104, 3, 1, '2026-02-10 12:18:39.339'),
(98, 105, 3, 1, '2026-02-10 12:18:39.340'),
(99, 106, 3, 1, '2026-02-10 12:18:39.341'),
(100, 107, 3, 1, '2026-02-10 12:18:39.342'),
(101, 108, 3, 1, '2026-02-10 12:18:39.343'),
(102, 109, 3, 1, '2026-02-10 12:18:39.345'),
(103, 110, 3, 1, '2026-02-10 12:18:39.346'),
(104, 111, 3, 1, '2026-02-10 12:18:39.348'),
(105, 112, 3, 1, '2026-02-10 12:18:39.349'),
(106, 113, 3, 1, '2026-02-10 12:18:39.351'),
(107, 114, 3, 1, '2026-02-10 12:18:39.353'),
(108, 115, 3, 1, '2026-02-10 12:18:39.354'),
(109, 116, 3, 1, '2026-02-10 12:18:39.356'),
(110, 117, 3, 1, '2026-02-10 12:18:39.358'),
(111, 118, 3, 1, '2026-02-10 12:18:39.359'),
(112, 119, 3, 1, '2026-02-10 12:18:39.359'),
(113, 120, 3, 1, '2026-02-10 12:18:39.360'),
(114, 121, 3, 1, '2026-02-10 12:18:39.361'),
(115, 122, 3, 1, '2026-02-10 12:18:39.362'),
(116, 123, 3, 1, '2026-02-10 12:18:39.363'),
(117, 124, 3, 1, '2026-02-10 12:18:39.363'),
(118, 125, 3, 1, '2026-02-10 12:18:39.364'),
(119, 126, 3, 1, '2026-02-10 12:18:39.365'),
(120, 127, 3, 1, '2026-02-10 12:18:39.365'),
(121, 128, 3, 1, '2026-02-10 12:18:39.366'),
(122, 129, 3, 1, '2026-02-10 12:18:39.367'),
(123, 130, 3, 1, '2026-02-10 12:18:39.369'),
(124, 131, 3, 1, '2026-02-10 12:18:39.370'),
(125, 132, 3, 1, '2026-02-10 12:18:39.372'),
(126, 133, 3, 1, '2026-02-10 12:18:39.373'),
(127, 134, 3, 1, '2026-02-10 12:18:39.375'),
(128, 135, 3, 1, '2026-02-10 12:18:39.379'),
(129, 136, 3, 1, '2026-02-10 12:18:39.380'),
(130, 137, 3, 1, '2026-02-10 12:18:39.383'),
(131, 138, 3, 1, '2026-02-10 12:18:39.384'),
(132, 139, 3, 1, '2026-02-10 12:18:39.386'),
(133, 140, 3, 1, '2026-02-10 12:18:39.388'),
(134, 141, 3, 1, '2026-02-10 12:18:39.390'),
(135, 142, 3, 1, '2026-02-10 12:18:39.392'),
(136, 143, 3, 1, '2026-02-10 12:18:39.393'),
(137, 144, 3, 1, '2026-02-10 12:18:39.394'),
(138, 145, 3, 1, '2026-02-10 12:18:39.395'),
(139, 146, 3, 1, '2026-02-10 12:18:39.395'),
(140, 147, 3, 1, '2026-02-10 12:18:39.397'),
(141, 148, 3, 1, '2026-02-10 12:18:39.399'),
(142, 149, 3, 1, '2026-02-10 12:18:39.400'),
(143, 150, 3, 1, '2026-02-10 12:18:39.402'),
(144, 151, 3, 1, '2026-02-10 12:18:39.403'),
(145, 152, 3, 1, '2026-02-10 12:18:39.405'),
(146, 153, 3, 1, '2026-02-10 12:18:39.407'),
(147, 154, 3, 1, '2026-02-10 12:18:39.409'),
(148, 155, 3, 1, '2026-02-10 12:18:39.410'),
(149, 156, 3, 1, '2026-02-10 12:18:39.412'),
(150, 157, 3, 1, '2026-02-10 12:18:39.414'),
(151, 158, 3, 1, '2026-02-10 12:18:39.415'),
(152, 159, 3, 1, '2026-02-10 12:18:39.417'),
(153, 160, 3, 1, '2026-02-10 12:18:39.418'),
(154, 161, 3, 1, '2026-02-10 12:18:39.420'),
(155, 162, 3, 1, '2026-02-10 12:18:39.422'),
(156, 163, 3, 1, '2026-02-10 12:18:39.422'),
(157, 164, 3, 1, '2026-02-10 12:18:39.424'),
(158, 165, 3, 1, '2026-02-10 12:18:39.424'),
(159, 166, 3, 1, '2026-02-10 12:18:39.425'),
(160, 167, 3, 1, '2026-02-10 12:18:39.426'),
(161, 168, 3, 1, '2026-02-10 12:18:39.427'),
(162, 169, 3, 1, '2026-02-10 12:18:39.427'),
(163, 170, 3, 1, '2026-02-10 12:18:39.431'),
(164, 171, 3, 1, '2026-02-10 12:18:39.432'),
(165, 172, 3, 1, '2026-02-10 12:18:39.433'),
(166, 173, 3, 1, '2026-02-10 12:18:39.434'),
(167, 174, 3, 1, '2026-02-10 12:18:39.435'),
(168, 175, 3, 1, '2026-02-10 12:18:39.439'),
(169, 176, 3, 1, '2026-02-10 12:18:39.441'),
(170, 177, 3, 1, '2026-02-10 12:18:39.443'),
(171, 178, 3, 1, '2026-02-10 12:18:39.445'),
(172, 179, 3, 1, '2026-02-10 12:18:39.447'),
(173, 180, 3, 1, '2026-02-10 12:18:39.450'),
(174, 181, 3, 1, '2026-02-10 12:18:39.452'),
(175, 182, 3, 1, '2026-02-10 12:18:39.454'),
(176, 183, 3, 1, '2026-02-10 12:18:39.456'),
(177, 184, 3, 1, '2026-02-10 12:18:39.457'),
(178, 185, 3, 1, '2026-02-10 12:18:39.457'),
(179, 186, 3, 1, '2026-02-10 12:18:39.458'),
(180, 187, 3, 1, '2026-02-10 12:18:39.459'),
(181, 188, 3, 1, '2026-02-10 12:18:39.460'),
(182, 189, 3, 1, '2026-02-10 12:18:39.462'),
(183, 190, 3, 1, '2026-02-10 12:18:39.465'),
(184, 191, 3, 1, '2026-02-10 12:18:39.466'),
(185, 192, 3, 1, '2026-02-10 12:18:39.467'),
(186, 193, 3, 1, '2026-02-10 12:18:39.468'),
(187, 194, 3, 1, '2026-02-10 12:18:39.469'),
(188, 195, 3, 1, '2026-02-10 12:18:39.469'),
(189, 196, 3, 1, '2026-02-10 12:18:39.471'),
(190, 197, 3, 1, '2026-02-10 12:18:39.473'),
(191, 198, 3, 1, '2026-02-10 12:18:39.474'),
(192, 199, 3, 1, '2026-02-10 12:18:39.476'),
(193, 200, 3, 1, '2026-02-10 12:18:39.479'),
(194, 201, 3, 1, '2026-02-10 12:18:39.480'),
(195, 202, 3, 1, '2026-02-10 12:18:39.481'),
(196, 203, 3, 1, '2026-02-10 12:18:39.482'),
(197, 204, 3, 1, '2026-02-10 12:18:39.483'),
(198, 205, 3, 1, '2026-02-10 12:18:39.485'),
(199, 206, 3, 1, '2026-02-10 12:18:39.486'),
(200, 207, 3, 1, '2026-02-10 12:18:39.487'),
(201, 208, 3, 1, '2026-02-10 12:18:39.488'),
(202, 209, 3, 1, '2026-02-10 12:18:39.489'),
(203, 210, 3, 1, '2026-02-10 12:18:39.490'),
(204, 211, 3, 1, '2026-02-10 12:18:39.491'),
(205, 212, 3, 1, '2026-02-10 12:18:39.492'),
(206, 213, 3, 1, '2026-02-10 12:18:39.493'),
(207, 214, 3, 1, '2026-02-10 12:18:39.494'),
(208, 215, 3, 1, '2026-02-10 12:18:39.495'),
(209, 216, 3, 1, '2026-02-10 12:18:39.496'),
(210, 217, 3, 1, '2026-02-10 12:18:39.497'),
(211, 218, 3, 1, '2026-02-10 12:18:39.498'),
(212, 219, 2, 1, '2026-02-10 12:18:39.499'),
(213, 220, 2, 1, '2026-02-10 12:18:39.501'),
(214, 221, 2, 1, '2026-02-10 12:18:39.503'),
(215, 222, 2, 1, '2026-02-10 12:18:39.504'),
(216, 223, 2, 1, '2026-02-10 12:18:39.505'),
(217, 224, 2, 1, '2026-02-10 12:18:39.506'),
(218, 225, 2, 1, '2026-02-10 12:18:39.507'),
(219, 226, 2, 1, '2026-02-10 12:18:39.508'),
(220, 227, 2, 1, '2026-02-10 12:18:39.509'),
(221, 228, 2, 1, '2026-02-10 12:18:39.510'),
(222, 229, 2, 1, '2026-02-10 12:18:39.511'),
(223, 230, 2, 1, '2026-02-10 12:18:39.512'),
(224, 231, 2, 1, '2026-02-10 12:18:39.513'),
(225, 232, 2, 1, '2026-02-10 12:18:39.515'),
(226, 233, 2, 1, '2026-02-10 12:18:39.516'),
(227, 234, 2, 1, '2026-02-10 12:18:39.517'),
(228, 235, 2, 1, '2026-02-10 12:18:39.518'),
(229, 236, 2, 1, '2026-02-10 12:18:39.520'),
(230, 237, 2, 1, '2026-02-10 12:18:39.521'),
(231, 238, 2, 1, '2026-02-10 12:18:39.521'),
(232, 239, 2, 1, '2026-02-10 12:18:39.522'),
(233, 240, 2, 1, '2026-02-10 12:18:39.522'),
(234, 241, 2, 1, '2026-02-10 12:18:39.523'),
(235, 242, 2, 1, '2026-02-10 12:18:39.524'),
(236, 243, 2, 1, '2026-02-10 12:18:39.525'),
(237, 244, 2, 1, '2026-02-10 12:18:39.525'),
(238, 245, 2, 1, '2026-02-10 12:18:39.526'),
(239, 246, 2, 1, '2026-02-10 12:18:39.527'),
(240, 247, 2, 1, '2026-02-10 12:18:39.527'),
(241, 248, 2, 1, '2026-02-10 12:18:39.528'),
(242, 258, 3, 1, '2026-02-12 18:15:02.529');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cargo`
--

DROP TABLE IF EXISTS `cargo`;
CREATE TABLE `cargo` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL,
  `setor_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

DROP TABLE IF EXISTS `colaborador`;
CREATE TABLE `colaborador` (
  `id` int(11) NOT NULL,
  `pessoa_id` int(11) DEFAULT NULL,
  `cargo_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `email_institucional` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `colaborador`
--

INSERT INTO `colaborador` (`id`, `pessoa_id`, `cargo_id`, `status`, `email_institucional`) VALUES
(1, 1, 6, 1, 'heloisa.beatriz@somosconexaosocial.org'),
(2, 44, 11, 1, 'andreis.santos@somosconexaosocial.org'),
(3, 46, 12, 1, 'jacy.lima@somosconexaosocial.org'),
(4, 48, 24, 1, 'tatiane.silva@somosconexaosocial.org'),
(5, 53, 21, 1, 'arthur.pereira@somosconexaosocial.org'),
(6, 55, 23, 1, 'aparicio.luis@somosconexaosocial.org'),
(7, 59, 2, 1, 'paulo.santana@somosconexaosocial.org'),
(8, 249, 23, 1, 'luanderson.oliveira@somosconexaosocial.org'),
(9, 250, 14, 1, 'fernanda.andrini@somosconexaosocial.org'),
(10, 251, 14, 1, 'ana.felix@somosconexaosocial.org'),
(11, 252, 14, 1, 'ana.silva@somosconeexaosocial.org'),
(12, 253, 14, 1, 'eduarda.vasconcelos@somosconexaosocial.org'),
(13, 254, 5, 1, 'marilia.eduarda@somosconexaosocial.org'),
(14, 255, 5, 1, 'natalia.silva@somosconexaosocial.org'),
(15, 256, 3, 1, 'ystella.maria@somosconexaosocial.org'),
(16, 257, 20, 1, 'vitoria.oliveira@somosconexaosocial.org');

-- --------------------------------------------------------

--
-- Estrutura para tabela `contato`
--

DROP TABLE IF EXISTS `contato`;
CREATE TABLE `contato` (
  `id` int(11) NOT NULL,
  `pessoa_id` int(11) NOT NULL,
  `celular` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `contato`
--

INSERT INTO `contato` (`id`, `pessoa_id`, `celular`, `email`) VALUES
(1, 1, NULL, 'heloisa.beatriz@somosconexaosocial.org'),
(2, 2, NULL, 'sem@email.com'),
(3, 3, NULL, 'sem@email.com'),
(4, 4, NULL, 'sem@email.com'),
(5, 5, NULL, 'sem@email.com'),
(6, 6, NULL, 'sem@email.com'),
(7, 7, NULL, 'sem@email.com'),
(8, 8, NULL, 'sem@email.com'),
(9, 9, NULL, 'sem@email.com'),
(10, 10, NULL, 'sem@email.com'),
(11, 11, NULL, 'sem@email.com'),
(12, 12, NULL, 'sem@email.com'),
(13, 13, NULL, 'sem@email.com'),
(14, 14, NULL, 'sem@email.com'),
(15, 15, NULL, 'sem@email.com'),
(16, 16, NULL, 'sem@email.com'),
(17, 17, NULL, 'sem@email.com'),
(18, 18, NULL, 'sem@email.com'),
(19, 19, NULL, 'sem@email.com'),
(20, 20, NULL, 'sem@email.com'),
(21, 21, NULL, 'sem@email.com'),
(22, 22, NULL, 'sem@email.com'),
(23, 23, NULL, 'sem@email.com'),
(24, 24, NULL, 'sem@email.com'),
(25, 25, NULL, 'sem@email.com'),
(26, 26, NULL, 'sem@email.com'),
(27, 27, NULL, 'sem@email.com'),
(28, 28, NULL, 'sem@email.com'),
(29, 29, NULL, 'sem@email.com'),
(30, 30, NULL, 'sem@email.com'),
(31, 31, NULL, 'sem@email.com'),
(32, 32, NULL, 'sem@email.com'),
(33, 33, NULL, 'sem@email.com'),
(34, 34, NULL, 'sem@email.com'),
(35, 35, NULL, 'sem@email.com'),
(36, 36, NULL, 'sem@email.com'),
(37, 37, NULL, 'sem@email.com'),
(38, 38, NULL, 'sem@email.com'),
(39, 39, NULL, 'sem@email.com'),
(40, 40, NULL, 'sem@email.com'),
(41, 41, NULL, 'sem@email.com'),
(42, 42, NULL, 'sem@email.com'),
(43, 43, NULL, 'sem@email.com'),
(44, 44, NULL, 'andreis.santos@somosconexaosocial.org'),
(45, 45, NULL, 'sem@email.com'),
(46, 46, NULL, 'jacy.lima@somosconexaosocial.org'),
(47, 47, NULL, 'sem@email.com'),
(48, 48, NULL, 'tatiane.silva@somosconexaosocial.org'),
(49, 49, NULL, 'sem@email.com'),
(50, 50, NULL, 'sem@email.com'),
(51, 51, NULL, 'sem@email.com'),
(52, 52, NULL, 'sem@email.com'),
(53, 53, NULL, 'arthur.pereira@somosconexaosocial.org'),
(54, 54, NULL, 'sem@email.com'),
(55, 55, NULL, 'aparicio.luis@somosconexaosocial.org'),
(56, 56, NULL, 'sem@email.com'),
(57, 57, NULL, 'sem@email.com'),
(58, 58, NULL, 'sem@email.com'),
(59, 59, NULL, 'paulo.santana@somosconexaosocial.org'),
(60, 60, NULL, 'sem@email.com'),
(61, 61, NULL, 'sem@email.com'),
(62, 62, NULL, 'sem@email.com'),
(63, 63, NULL, 'sem@email.com'),
(64, 64, NULL, 'sem@email.com'),
(65, 65, NULL, 'sem@email.com'),
(66, 66, NULL, 'sem@email.com'),
(67, 67, NULL, 'sem@email.com'),
(68, 68, NULL, 'sem@email.com'),
(69, 69, NULL, 'sem@email.com'),
(70, 70, NULL, 'sem@email.com'),
(71, 71, NULL, 'sem@email.com'),
(72, 72, NULL, 'sem@email.com'),
(73, 73, NULL, 'sem@email.com'),
(74, 74, NULL, 'sem@email.com'),
(75, 75, NULL, 'sem@email.com'),
(76, 76, NULL, 'sem@email.com'),
(77, 77, NULL, 'sem@email.com'),
(78, 78, NULL, 'sem@email.com'),
(79, 79, NULL, 'sem@email.com'),
(80, 80, NULL, 'sem@email.com'),
(81, 81, NULL, 'sem@email.com'),
(82, 82, NULL, 'sem@email.com'),
(83, 83, NULL, 'sem@email.com'),
(84, 84, NULL, 'sem@email.com'),
(85, 85, NULL, 'sem@email.com'),
(86, 86, NULL, 'sem@email.com'),
(87, 87, NULL, 'sem@email.com'),
(88, 88, NULL, 'sem@email.com'),
(89, 89, NULL, 'sem@email.com'),
(90, 90, NULL, 'sem@email.com'),
(91, 91, NULL, 'sem@email.com'),
(92, 92, NULL, 'sem@email.com'),
(93, 93, NULL, 'sem@email.com'),
(94, 94, NULL, 'sem@email.com'),
(95, 95, NULL, 'sem@email.com'),
(96, 96, NULL, 'sem@email.com'),
(97, 97, NULL, 'sem@email.com'),
(98, 98, NULL, 'sem@email.com'),
(99, 99, NULL, 'sem@email.com'),
(100, 100, NULL, 'sem@email.com'),
(101, 101, NULL, 'sem@email.com'),
(102, 102, NULL, 'sem@email.com'),
(103, 103, NULL, 'sem@email.com'),
(104, 104, NULL, 'sem@email.com'),
(105, 105, NULL, 'sem@email.com'),
(106, 106, NULL, 'sem@email.com'),
(107, 107, NULL, 'sem@email.com'),
(108, 108, NULL, 'sem@email.com'),
(109, 109, NULL, 'sem@email.com'),
(110, 110, NULL, 'sem@email.com'),
(111, 111, NULL, 'sem@email.com'),
(112, 112, NULL, 'sem@email.com'),
(113, 113, NULL, 'sem@email.com'),
(114, 114, NULL, 'sem@email.com'),
(115, 115, NULL, 'sem@email.com'),
(116, 116, NULL, 'sem@email.com'),
(117, 117, NULL, 'sem@email.com'),
(118, 118, NULL, 'sem@email.com'),
(119, 119, NULL, 'sem@email.com'),
(120, 120, NULL, 'sem@email.com'),
(121, 121, NULL, 'sem@email.com'),
(122, 122, NULL, 'sem@email.com'),
(123, 123, NULL, 'sem@email.com'),
(124, 124, NULL, 'sem@email.com'),
(125, 125, NULL, 'sem@email.com'),
(126, 126, NULL, 'sem@email.com'),
(127, 127, NULL, 'sem@email.com'),
(128, 128, NULL, 'sem@email.com'),
(129, 129, NULL, 'sem@email.com'),
(130, 130, NULL, 'sem@email.com'),
(131, 131, NULL, 'sem@email.com'),
(132, 132, NULL, 'sem@email.com'),
(133, 133, NULL, 'sem@email.com'),
(134, 134, NULL, 'sem@email.com'),
(135, 135, NULL, 'sem@email.com'),
(136, 136, NULL, 'sem@email.com'),
(137, 137, NULL, 'sem@email.com'),
(138, 138, NULL, 'sem@email.com'),
(139, 139, NULL, 'sem@email.com'),
(140, 140, NULL, 'sem@email.com'),
(141, 141, NULL, 'sem@email.com'),
(142, 142, NULL, 'sem@email.com'),
(143, 143, NULL, 'sem@email.com'),
(144, 144, NULL, 'sem@email.com'),
(145, 145, NULL, 'sem@email.com'),
(146, 146, NULL, 'sem@email.com'),
(147, 147, NULL, 'sem@email.com'),
(148, 148, NULL, 'sem@email.com'),
(149, 149, NULL, 'sem@email.com'),
(150, 150, NULL, 'sem@email.com'),
(151, 151, NULL, 'sem@email.com'),
(152, 152, NULL, 'sem@email.com'),
(153, 153, NULL, 'sem@email.com'),
(154, 154, NULL, 'sem@email.com'),
(155, 155, NULL, 'sem@email.com'),
(156, 156, NULL, 'sem@email.com'),
(157, 157, NULL, 'sem@email.com'),
(158, 158, NULL, 'sem@email.com'),
(159, 159, NULL, 'sem@email.com'),
(160, 160, NULL, 'sem@email.com'),
(161, 161, NULL, 'sem@email.com'),
(162, 162, NULL, 'sem@email.com'),
(163, 163, NULL, 'sem@email.com'),
(164, 164, NULL, 'sem@email.com'),
(165, 165, NULL, 'sem@email.com'),
(166, 166, NULL, 'sem@email.com'),
(167, 167, NULL, 'sem@email.com'),
(168, 168, NULL, 'sem@email.com'),
(169, 169, NULL, 'sem@email.com'),
(170, 170, NULL, 'sem@email.com'),
(171, 171, NULL, 'sem@email.com'),
(172, 172, NULL, 'sem@email.com'),
(173, 173, NULL, 'sem@email.com'),
(174, 174, NULL, 'sem@email.com'),
(175, 175, NULL, 'sem@email.com'),
(176, 176, NULL, 'sem@email.com'),
(177, 177, NULL, 'sem@email.com'),
(178, 178, NULL, 'sem@email.com'),
(179, 179, NULL, 'sem@email.com'),
(180, 180, NULL, 'sem@email.com'),
(181, 181, NULL, 'sem@email.com'),
(182, 182, NULL, 'sem@email.com'),
(183, 183, NULL, 'sem@email.com'),
(184, 184, NULL, 'sem@email.com'),
(185, 185, NULL, 'sem@email.com'),
(186, 186, NULL, 'sem@email.com'),
(187, 187, NULL, 'sem@email.com'),
(188, 188, NULL, 'sem@email.com'),
(189, 189, NULL, 'sem@email.com'),
(190, 190, NULL, 'sem@email.com'),
(191, 191, NULL, 'sem@email.com'),
(192, 192, NULL, 'sem@email.com'),
(193, 193, NULL, 'sem@email.com'),
(194, 194, NULL, 'sem@email.com'),
(195, 195, NULL, 'sem@email.com'),
(196, 196, NULL, 'sem@email.com'),
(197, 197, NULL, 'sem@email.com'),
(198, 198, NULL, 'sem@email.com'),
(199, 199, NULL, 'sem@email.com'),
(200, 200, NULL, 'sem@email.com'),
(201, 201, NULL, 'sem@email.com'),
(202, 202, NULL, 'sem@email.com'),
(203, 203, NULL, 'sem@email.com'),
(204, 204, NULL, 'sem@email.com'),
(205, 205, NULL, 'sem@email.com'),
(206, 206, NULL, 'sem@email.com'),
(207, 207, NULL, 'sem@email.com'),
(208, 208, NULL, 'sem@email.com'),
(209, 209, NULL, 'sem@email.com'),
(210, 210, NULL, 'sem@email.com'),
(211, 211, NULL, 'sem@email.com'),
(212, 212, NULL, 'sem@email.com'),
(213, 213, NULL, 'sem@email.com'),
(214, 214, NULL, 'sem@email.com'),
(215, 215, NULL, 'sem@email.com'),
(216, 216, NULL, 'sem@email.com'),
(217, 217, NULL, 'sem@email.com'),
(218, 218, NULL, 'sem@email.com'),
(219, 219, NULL, 'sem@email.com'),
(220, 220, NULL, 'sem@email.com'),
(221, 221, NULL, 'sem@email.com'),
(222, 222, NULL, 'sem@email.com'),
(223, 223, NULL, 'sem@email.com'),
(224, 224, NULL, 'sem@email.com'),
(225, 225, NULL, 'sem@email.com'),
(226, 226, NULL, 'sem@email.com'),
(227, 227, NULL, 'sem@email.com'),
(228, 228, NULL, 'sem@email.com'),
(229, 229, NULL, 'sem@email.com'),
(230, 230, NULL, 'sem@email.com'),
(231, 231, NULL, 'sem@email.com'),
(232, 232, NULL, 'sem@email.com'),
(233, 233, NULL, 'sem@email.com'),
(234, 234, NULL, 'sem@email.com'),
(235, 235, NULL, 'sem@email.com'),
(236, 236, NULL, 'sem@email.com'),
(237, 237, NULL, 'sem@email.com'),
(238, 238, NULL, 'sem@email.com'),
(239, 239, NULL, 'sem@email.com'),
(240, 240, NULL, 'sem@email.com'),
(241, 241, NULL, 'sem@email.com'),
(242, 242, NULL, 'sem@email.com'),
(243, 243, NULL, 'sem@email.com'),
(244, 244, NULL, 'sem@email.com'),
(245, 245, NULL, 'sem@email.com'),
(246, 246, NULL, 'sem@email.com'),
(247, 247, NULL, 'sem@email.com'),
(248, 248, NULL, 'sem@email.com'),
(249, 249, NULL, 'luanderson.oliveira@somosconexaosocial.org'),
(250, 250, NULL, 'fernanda.andrini@somosconexaosocial.org'),
(251, 251, NULL, 'ana.felix@somosconexaosocial.org'),
(252, 252, NULL, 'ana.silva@somosconeexaosocial.org'),
(253, 253, NULL, 'eduarda.vasconcelos@somosconexaosocial.org'),
(254, 254, NULL, 'marilia.eduarda@somosconexaosocial.org'),
(255, 255, NULL, 'natalia.silva@somosconexaosocial.org'),
(256, 256, NULL, 'ystella.maria@somosconexaosocial.org'),
(257, 257, NULL, 'vitoria.oliveira@somosconexaosocial.org'),
(258, 258, NULL, 'sem@email.com');

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplinas`
--

DROP TABLE IF EXISTS `disciplinas`;
CREATE TABLE `disciplinas` (
  `id` int(11) NOT NULL,
  `turma_id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `carga_horaria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `endereco`
--

DROP TABLE IF EXISTS `endereco`;
CREATE TABLE `endereco` (
  `id` int(11) NOT NULL,
  `pessoa_id` int(11) NOT NULL,
  `cep` varchar(191) NOT NULL,
  `localidade` varchar(191) NOT NULL,
  `rua` varchar(191) NOT NULL,
  `numero` varchar(191) NOT NULL,
  `bairro` varchar(191) NOT NULL,
  `cidade` varchar(191) NOT NULL,
  `estado` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `escolaridade`
--

DROP TABLE IF EXISTS `escolaridade`;
CREATE TABLE `escolaridade` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

DROP TABLE IF EXISTS `etnia`;
CREATE TABLE `etnia` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Estrutura para tabela `frequencias`
--

DROP TABLE IF EXISTS `frequencias`;
CREATE TABLE `frequencias` (
  `id` int(11) NOT NULL,
  `aula_id` int(11) NOT NULL,
  `matricula_id` int(11) NOT NULL,
  `status` enum('Presente','Ausente','Justificado') NOT NULL,
  `observacao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `frequencias`
--

INSERT INTO `frequencias` (`id`, `aula_id`, `matricula_id`, `status`, `observacao`) VALUES
(1, 3, 6, 'Justificado', 'Dor de barriga'),
(2, 3, 7, 'Ausente', NULL),
(3, 3, 8, 'Presente', NULL),
(4, 3, 9, 'Presente', NULL),
(5, 3, 10, 'Presente', NULL),
(6, 3, 11, 'Presente', NULL),
(7, 3, 12, 'Presente', NULL),
(8, 3, 13, 'Presente', NULL),
(9, 3, 14, 'Presente', NULL),
(10, 3, 15, 'Presente', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `genero`
--

DROP TABLE IF EXISTS `genero`;
CREATE TABLE `genero` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL,
  `identidade_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

DROP TABLE IF EXISTS `identidade_genero`;
CREATE TABLE `identidade_genero` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Estrutura para tabela `matriculas`
--

DROP TABLE IF EXISTS `matriculas`;
CREATE TABLE `matriculas` (
  `id` int(11) NOT NULL,
  `turma_id` int(11) NOT NULL,
  `beneficiario_id` int(11) NOT NULL,
  `data_matricula` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Ativo','Trancado','Concluido','Desistente') DEFAULT 'Ativo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `matriculas`
--

INSERT INTO `matriculas` (`id`, `turma_id`, `beneficiario_id`, `data_matricula`, `status`) VALUES
(1, 1, 118, '2026-02-02 10:26:22', 'Ativo'),
(2, 1, 128, '2026-02-02 10:26:22', 'Ativo'),
(3, 1, 156, '2026-02-02 10:26:22', 'Ativo'),
(4, 1, 15, '2026-02-02 10:26:22', 'Ativo'),
(5, 1, 27, '2026-02-02 10:26:22', 'Ativo'),
(6, 2, 153, '2026-02-02 11:04:34', 'Ativo'),
(7, 2, 176, '2026-02-02 11:04:34', 'Ativo'),
(8, 2, 201, '2026-02-02 11:04:34', 'Ativo'),
(9, 2, 130, '2026-02-02 11:04:34', 'Ativo'),
(10, 2, 95, '2026-02-02 11:04:34', 'Ativo'),
(11, 2, 206, '2026-02-02 11:04:34', 'Ativo'),
(12, 2, 211, '2026-02-02 11:04:52', 'Ativo'),
(13, 2, 115, '2026-02-02 11:04:52', 'Ativo'),
(14, 2, 37, '2026-02-02 11:04:52', 'Ativo'),
(15, 2, 84, '2026-02-02 11:04:52', 'Ativo'),
(16, 1, 239, '2026-02-04 09:59:35', 'Ativo'),
(17, 1, 127, '2026-02-04 10:00:21', 'Ativo'),
(18, 1, 144, '2026-02-04 10:00:21', 'Ativo'),
(19, 1, 64, '2026-02-04 10:00:21', 'Ativo'),
(20, 1, 150, '2026-02-04 10:00:21', 'Ativo'),
(21, 1, 42, '2026-02-04 10:00:21', 'Ativo'),
(22, 1, 102, '2026-02-04 10:00:21', 'Ativo'),
(23, 1, 122, '2026-02-04 10:00:21', 'Ativo'),
(24, 1, 164, '2026-02-04 10:00:21', 'Ativo');

-- --------------------------------------------------------

--
-- Estrutura para tabela `orgao_emissor`
--

DROP TABLE IF EXISTS `orgao_emissor`;
CREATE TABLE `orgao_emissor` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL,
  `uf_emissor` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

DROP TABLE IF EXISTS `perfil_usuario`;
CREATE TABLE `perfil_usuario` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

DROP TABLE IF EXISTS `pessoa`;
CREATE TABLE `pessoa` (
  `id` int(11) NOT NULL,
  `nome_completo` varchar(191) NOT NULL,
  `nome_social` varchar(191) DEFAULT NULL,
  `apelido` varchar(191) DEFAULT NULL,
  `data_nasc` datetime(3) NOT NULL,
  `nome_mae` varchar(191) NOT NULL,
  `nome_pai` varchar(191) DEFAULT NULL,
  `cpf` varchar(191) DEFAULT NULL,
  `rg` varchar(191) DEFAULT NULL,
  `naturalidade` varchar(191) NOT NULL DEFAULT 'BRASIL',
  `nacionalidade` varchar(191) NOT NULL DEFAULT 'BRASIL',
  `genero_id` int(11) NOT NULL,
  `etnia_id` int(11) NOT NULL,
  `escolaridade_id` int(11) NOT NULL,
  `orgao_emissor_id` int(11) NOT NULL,
  `tipo_sanguineo` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) DEFAULT CURRENT_TIMESTAMP(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `pessoa`
--

INSERT INTO `pessoa` (`id`, `nome_completo`, `nome_social`, `apelido`, `data_nasc`, `nome_mae`, `nome_pai`, `cpf`, `rg`, `naturalidade`, `nacionalidade`, `genero_id`, `etnia_id`, `escolaridade_id`, `orgao_emissor_id`, `tipo_sanguineo`, `status`, `created_at`) VALUES
(1, 'HELOÍSA BEATRIZ DA SILVA HORA', NULL, NULL, '2001-01-02 00:00:00.000', 'ELIANE MARIA DA SILVA HORA', NULL, '70931193443', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.165'),
(2, 'LENIRA BARBOSA TORRES', NULL, NULL, '1951-06-06 00:00:00.000', 'MARIA BARBOSA DOS SANTOS', NULL, '38835851491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.169'),
(3, 'JOSEFA MOREIRA PEREIRA DA SILVA', NULL, NULL, '1963-11-20 00:00:00.000', 'IZAURA VICENTE DA SILVA', NULL, '04847124464', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.180'),
(4, 'MANOEL PEREIRA DA SILVA', NULL, NULL, '1960-07-10 00:00:00.000', 'JOSEFA PEREIRA DA SILVA', NULL, '04413386825', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.181'),
(5, 'MARIA JOSÉ DOS SANTOS', NULL, NULL, '1943-01-29 00:00:00.000', 'JOSEFA CARNEIRO DE VASCONCELOS', NULL, '23195614472', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.183'),
(6, 'MARIA DE LOURDES MEDEIROS', NULL, NULL, '1964-06-26 00:00:00.000', 'MARIA JOSÉ DOS SANTOS', NULL, '43749631468', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.185'),
(7, 'FIRMINA MONTEIRO DE MOURA', NULL, NULL, '1962-01-01 00:00:00.000', 'MARILUCIA MONTEIRO DE MOURA', NULL, '37759388420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.186'),
(8, 'MARIA SEVERINA DE LIMA', NULL, NULL, '1951-01-29 00:00:00.000', 'SEVERINA JOSEFA DA CONCEIÇÃO', NULL, '29024129400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.189'),
(9, 'SEVERINA DE FATIMA SOARES', NULL, NULL, '1956-08-06 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '22405631415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.192'),
(10, 'MARIA MARQUES PINHEIRO', NULL, NULL, '1964-04-25 00:00:00.000', 'FRANCISCA JOSEFA DA CONCEIÇÃO', NULL, '58038337468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.194'),
(11, 'MARIA DO CARMO DE LOURDES', NULL, NULL, '1953-02-08 00:00:00.000', 'MARIA DE LOURDES DA CONCEIÇÃO', NULL, '22404503472', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.195'),
(12, 'MARIA DE LOURDES DOS SANTOS', NULL, NULL, '1962-04-14 00:00:00.000', 'SEVERINA URÇULINA DOS SANTOS', NULL, '02093095475', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.196'),
(13, 'MARIA JOSÉ GOMES DE ARAUJO', NULL, NULL, '1961-03-09 00:00:00.000', 'ALZIRA CORREIA DE MELO', NULL, '06164146410', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.197'),
(14, 'JOSEFA SEVERINA DOS SANTOS', NULL, NULL, '1960-12-14 00:00:00.000', 'SEVERINA MARIA DOS SANTOS', NULL, '45041822468', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.198'),
(15, 'JOSEFA ALBERTINA DE SOUZA', NULL, NULL, '1950-02-13 00:00:00.000', 'ALBERTINA FRANCISCA DA SILVA', NULL, '54411319420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.199'),
(16, 'JOANA IRACEMA GOMES DA SILVA', NULL, NULL, '1945-06-24 00:00:00.000', 'IRACEMA MARIA DA SILVA', NULL, '43098509449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.201'),
(17, 'JOSEFA  ALVES DE ALMEIDA CABRAL', NULL, NULL, '1956-02-19 00:00:00.000', 'JOSEFA ALVES DE ALMEIDA', NULL, '28267303472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.202'),
(18, 'ENEDINA JOSÉ LOPES DE VASCONCELOS', NULL, NULL, '1960-03-13 00:00:00.000', 'SEVERINO JOSÉ LOPE', NULL, '97543080478', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.203'),
(19, 'MARIA JOSÉ RAMOS DA SILVA', NULL, NULL, '1955-01-04 00:00:00.000', 'LEONILA MARIA RAMOS', NULL, '40009688404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.203'),
(20, 'SEVERINA MARIA DE ARAÚJO LIMA', NULL, NULL, '1950-11-19 00:00:00.000', 'MARIA STELA DE ARAÚJO', NULL, '28511000410', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.205'),
(21, 'MARIA GLEICE SANTIAGO RIBEIRO', NULL, NULL, '1963-05-03 00:00:00.000', 'RUFINA SEBASTIANA RIBEIRO', NULL, '90994949472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.211'),
(22, 'MARIA IRENE DA SILVA', NULL, NULL, '1964-09-10 00:00:00.000', 'IRENE SEVERINA DA CONCEIÇÃO', NULL, '71591613434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.212'),
(23, 'MARIA JOSÉ DA CONCEIÇÃO SANTANA', NULL, NULL, '1966-01-08 00:00:00.000', 'MARIA LUZIA DA CONCEIÇÃO', NULL, '50706551400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.213'),
(24, 'MARIA MARQUES DOS SANTOS', NULL, NULL, '1954-12-25 00:00:00.000', 'SEVERINA MARQUES DOS SANTOS', NULL, '26263898895', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.214'),
(25, 'MARIA JOSEFA DOS SANTOS', NULL, NULL, '1958-11-13 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '62419471415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.215'),
(26, 'MARIA JOSÉ DA SILVA MOURA', NULL, NULL, '1959-05-05 00:00:00.000', 'GUILHERMINA INÁCIO DA SILVA', NULL, '39044629468', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.216'),
(27, 'JOSÉ FERNANDES BORBA SOBRINHO', NULL, NULL, '1962-04-26 00:00:00.000', 'MARIA ROSA DO VALE', NULL, '41541537491', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.217'),
(28, 'ODETE SEVERINA DE SANTANA', NULL, NULL, '1955-03-11 00:00:00.000', 'SEVERINA MARIA DE SANTANA', NULL, '71653716487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.218'),
(29, 'SEVERINO RAMOS DOS SANTOS', NULL, NULL, '1964-08-07 00:00:00.000', 'ANGELITA BEZERRA DA SILVA', NULL, '39897834400', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.219'),
(30, 'MARLUCE MARIA PEREIRA', NULL, NULL, '1960-01-01 00:00:00.000', 'COSMA MARIA BATISTA', NULL, '69665443453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.220'),
(31, 'MARIA JOVELINA DA CONCEIÇÃO', NULL, NULL, '1964-05-31 00:00:00.000', 'MARIA JOVELINA DA CONCEIÇÃO', NULL, '03956746465', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.221'),
(32, 'SEVERINA MARIA BATISTA DE SOUZA', NULL, NULL, '1957-02-17 00:00:00.000', 'COSMA MARIA BATISTA', NULL, '39754260478', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.222'),
(33, 'SEVERINA GESUINA DA SILVA', NULL, NULL, '1950-08-22 00:00:00.000', 'JOSEFA JESUINA DA CONCEIÇÃO', NULL, '02532400420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.223'),
(34, 'VALDIRA MARIA DA SILVA', NULL, NULL, '1962-01-30 00:00:00.000', 'JOSEFA MARIA DA SILVA', NULL, '32200595468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.225'),
(35, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1961-04-29 00:00:00.000', 'MARIA JOSE DA CONCEIÇÃO', NULL, '74337750487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.226'),
(36, 'SEVERINO FRANCISCO DA CRUZ', NULL, NULL, '1959-05-29 00:00:00.000', 'ALICE FRANCISCA DA CRUZ', NULL, '23552492453', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.227'),
(37, 'MARIA MARINA MONTEIRO', NULL, NULL, '1951-09-14 00:00:00.000', 'MARINA MADALENA DE JESUS', NULL, '40009580468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.228'),
(38, 'SEVERINA TEREZA DE SANTANA', NULL, NULL, '1957-10-18 00:00:00.000', 'SEVERINA TEREZA DE JESUS FILHA', NULL, '66804540425', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.229'),
(39, 'TEREZINHA EVANGELISTA FERREIRA DA SILVA', NULL, NULL, '1956-06-08 00:00:00.000', 'JOSEFA ALEXANDRINA DA CONCEIÇÃO', NULL, '07115574464', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.230'),
(40, 'MARIA ROSA DE BARROS', NULL, NULL, '1944-01-10 00:00:00.000', 'MARIA ROSA DO ESPÍRITO SANTO', NULL, '27086275468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.231'),
(41, 'MARIA DE FÁTIMA SANTOS', NULL, NULL, '1965-05-23 00:00:00.000', 'ROSA SEVERINA DA CONCEIÇÃO', NULL, '51370204434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.232'),
(42, 'BERNADETE IRENE DA HORA', NULL, NULL, '1963-12-10 00:00:00.000', 'IRENE FELISMINA DA HORA', NULL, '42872847472', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.233'),
(43, 'IZALTINA MARIA DE ARRUDA', NULL, NULL, '1955-10-20 00:00:00.000', 'MARIA JOSÉ DO NASCIMENTO', NULL, '30005086434', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.234'),
(44, 'ANDREIS VICTOR SANTANA DOS SANTOS', NULL, NULL, '1999-12-07 00:00:00.000', 'NORMA SEVERINA DE SANTANA SANTOS', NULL, '11638602476', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.235'),
(45, 'MARIA APARECIDA DE SANTANA HARM', NULL, NULL, '1942-09-10 00:00:00.000', 'ANTÔNIA BARBOSA DE SANTANA', NULL, '80957757468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.238'),
(46, 'JACIEDINA DA SILVA LIMA', NULL, NULL, '1988-07-13 00:00:00.000', 'HENEDINA SANTANA DA SILVA LIMA', NULL, '07196922450', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.240'),
(47, 'LUCIA MARIA DA SILVA', NULL, NULL, '1955-03-21 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '74264591449', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.242'),
(48, 'TATIANE MARIA DA SILVA', NULL, NULL, '1989-02-26 00:00:00.000', 'MARIA JOSÉ DE SOUZA', NULL, '01576152430', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.244'),
(49, 'ANTONIO SEVERINO DOS SANTOS', NULL, NULL, '1961-06-13 00:00:00.000', 'REGINA FRANCISCA DA CONCEIÇÃO', NULL, '25395130420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.245'),
(50, 'PETRONILA CANDIDA DE FRANÇA', NULL, NULL, '1951-12-25 00:00:00.000', 'VIRGINIA CANDIDA DE ALMEIDA', NULL, '43884245449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.246'),
(51, 'SEVERINA RODRIGUES DE ALMEIDA', NULL, NULL, '1959-12-28 00:00:00.000', 'SEVERINA RODRIGUES DE ALMEIDA', NULL, '02144942412', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.247'),
(52, 'SEVERINO MANOEL TAVAREZ', NULL, NULL, '1957-01-09 00:00:00.000', 'MARIA VIRGINIA DA CONCEIÇÃO', NULL, '35242515449', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.250'),
(53, 'ARTHUR YURE DOS SANTOS PEREIRA', NULL, NULL, '1995-10-19 00:00:00.000', 'LUCIANAA DOS SANTOS PEREIRA', NULL, '10651073405', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.251'),
(54, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1955-06-29 00:00:00.000', 'JOSEFA MARIA DA SILVA', NULL, '40008746400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.252'),
(55, 'APARÍCIO LUIS DOS SANTOS', NULL, NULL, '1997-01-29 00:00:00.000', 'MARIA DE FÁTIMA DO ESPÍRITO SANTO', NULL, '11654804410', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.253'),
(56, 'MARIA JOSÉ DE LIMA ALVES', NULL, NULL, '1961-07-15 00:00:00.000', 'SEVERINA MARIA DE LIMA', NULL, '52733882449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.254'),
(57, 'SEBASTIÃO INACIO DA SILVA', NULL, NULL, '1957-10-19 00:00:00.000', 'ELVIRA MARIA DA CONCEIÇÃO', NULL, '17922747420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.257'),
(58, 'VERA LUCIA BARBOSA DE SOUSA MENEZES', NULL, NULL, '1964-08-09 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '03914805455', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.259'),
(59, 'PAULO JOSE DE SANTANA', NULL, NULL, '1982-07-08 00:00:00.000', 'MARIA SEVERINA DE SANTANA', NULL, '04084130427', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.261'),
(60, 'LUZIA MARIA BARBOSA SILVA', NULL, NULL, '1962-10-18 00:00:00.000', 'JOSEFA MARIA BARBOSA', NULL, '58555439434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.263'),
(61, 'JOSÉ LUIZ DE FRANÇA', NULL, NULL, '1956-11-20 00:00:00.000', 'MARIA MARCELINA DE MELO', NULL, '16553233420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.265'),
(62, 'TERESINHA MARINA MONTEIRO DA SILVA', NULL, NULL, '1963-05-13 00:00:00.000', 'MARINA MADALENA  DA CONCEIÇÃO', NULL, '39937232449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.266'),
(63, 'JOSEFA OLIMPIA DA SILVA', NULL, NULL, '1953-09-12 00:00:00.000', 'OLIMPIA MARIA DOS SANTOS', NULL, '02114490408', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.267'),
(64, 'MARIA SEVERINA DE LIMA', NULL, NULL, '1962-02-21 00:00:00.000', 'SEVERINA JOSEFA DA CONCEIÇÃO', NULL, '52573079449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.269'),
(65, 'ROSENILDA AMÉLIA DO NASCIMENTO', NULL, NULL, '1954-12-18 00:00:00.000', 'AMÉLIA COSMA DA SILVA', NULL, '42719933449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.272'),
(66, 'JOSEFA AMELIA SILVA DE SOUSA', NULL, NULL, '1962-10-18 00:00:00.000', 'AMÉLIA COSME DA SILVA', NULL, '71183124449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.274'),
(67, 'JUDITE SEVERINA DE LIMA PEREIRA', NULL, NULL, '1965-05-21 00:00:00.000', 'SEVERINA JOSEFA DA CONCIÇÃO', NULL, '54410924400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.278'),
(68, 'FÁTIMA FRANCISCA DE ALBUQUERQUE', NULL, NULL, '1960-12-01 00:00:00.000', 'REGINA FRANCISCA DE LIMA', NULL, '74264478472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.279'),
(69, 'JOSE FRANCCISCO DE ALBUQUERQUE', NULL, NULL, '1954-07-06 00:00:00.000', 'NOEMIA JULIA DA CONCEIÇÃO', NULL, '04679197803', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.281'),
(70, 'JOSEFA HONORINA DA SILVA', NULL, NULL, '1964-04-03 00:00:00.000', 'HONORINA JULIA DA SILVA', NULL, '40472272420', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.282'),
(71, 'CLEONICE MARIA DA SILVA', NULL, NULL, '1961-07-21 00:00:00.000', 'JULIA MARIA DA CONCEIÇÃO', NULL, '90993306420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.283'),
(72, 'SEVERINA MARIA SOARES BEZERRA', NULL, NULL, '1953-03-29 00:00:00.000', 'SEVERINA MARIA SOARES DA SILVA', NULL, '04418695486', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.285'),
(73, 'SEVERINA GOMES DE LIMA', NULL, NULL, '1953-09-01 00:00:00.000', 'SEVERINA FRANCISCA DA CONCEIÇÃO', NULL, '39389332400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.286'),
(74, 'SEVERINA FRANCISCA DE SOUZA', NULL, NULL, '1961-02-05 00:00:00.000', 'IRACI FRANCISCA DE SOUZA', NULL, '16688064871', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.288'),
(75, 'MARIA DA PAZ CANDIDA DA SILVA', NULL, NULL, '1957-11-09 00:00:00.000', 'JOSEFA CANDIDA DE MENDONÇA', NULL, '74247875434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.289'),
(76, 'MARIA ANTONIA DA SILVA', NULL, NULL, '1964-12-08 00:00:00.000', 'ANA ANTONIA DA CONCEIÇÃO', NULL, '83536019404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.290'),
(77, 'DORALICE GOMES DOS SANTOS', NULL, NULL, '1953-11-13 00:00:00.000', 'JOAQUINA GOMES DOS SANTOS', NULL, '58600582415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.291'),
(78, 'JOSEFA MARIA DA CONCEIÇÃO', NULL, NULL, '1957-03-06 00:00:00.000', 'MARIA JOSÉ DA CONCEIÇÃO', NULL, '83545620425', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.294'),
(79, 'REGINALDO DIAS DOS SANTOS', NULL, NULL, '1961-06-26 00:00:00.000', 'MARIA DO CARMO DOS SANTOS', NULL, '26849020463', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.295'),
(80, 'MARIA JOSÉ DO ESPÍRITO SANTO', NULL, NULL, '1963-09-13 00:00:00.000', 'RITA ROSA DA CONCEIÇÃO', NULL, '71591990491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.296'),
(81, 'MARIA DAS DORES DE SANTANA', NULL, NULL, '1954-01-23 00:00:00.000', 'MAXIMINIA MARIA DA CONCEIÇÃO', NULL, '68872410487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.297'),
(82, 'MARIA JOSÉ DE SANTANA', NULL, NULL, '1965-07-30 00:00:00.000', 'ANIZIA SEVERINA DA CONCEIÇÃO', NULL, '80981348491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.298'),
(83, 'MARIA DULCE DE FREITAS', NULL, NULL, '1955-12-06 00:00:00.000', 'JOSEFA DA CONCEIÇÃO DA SILVA', NULL, '21492018449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.299'),
(84, 'SEVERINA BARBOSA DO REGO', NULL, NULL, '1936-09-27 00:00:00.000', 'APOLINÁRIA BARBOSA DE SOUSA', NULL, '16539656491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.300'),
(85, 'SEVERINA MAXIMIANO BORGES', NULL, NULL, '1954-04-30 00:00:00.000', 'JOSEFA ANA DA CONCEIÇÃO', NULL, '45741930425', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.301'),
(86, 'MARGARIDA MARIA FERREIRA DE LIMA', NULL, NULL, '1951-09-07 00:00:00.000', 'MARIA JOSÉ DE LIMA', NULL, '35888202487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.302'),
(87, 'MARIA LUIZA MARTINS', NULL, NULL, '1944-09-13 00:00:00.000', 'INACIA FRNACISCA DA CONCEIÇÃO', NULL, '73480932487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.303'),
(88, 'MARIA DA CONCEIÇÃO DE SOUZA', NULL, NULL, '1962-02-04 00:00:00.000', 'OLINDINA MARIA DE SOUZA', NULL, '44683014491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.304'),
(89, 'SEVERINO MANOEL DA SILVA', NULL, NULL, '1947-01-04 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '47791250497', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.305'),
(90, 'MARIA BARBOSA NERY', NULL, NULL, '1955-07-22 00:00:00.000', 'PAULA NEUZA PEDROZA', NULL, '46090088404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.306'),
(91, 'SEBASTIANA FELIX DA LUZ', NULL, NULL, '1964-03-15 00:00:00.000', 'SEBASTIANA FELIX DA LUZ', NULL, '04884383494', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.307'),
(92, 'MARIA DE FATIMA DA SILVA', NULL, NULL, '1962-06-07 00:00:00.000', 'SEVERINA BELO DA SILVA', NULL, '46337407415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.308'),
(93, 'DEUZAMAR  SEVERINA DO NASCIMENTO', NULL, NULL, '1963-11-20 00:00:00.000', 'SEVERINA ELVIRA DA CONCEIÇÃO', NULL, '04935522437', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.309'),
(94, 'JOSÉ ANTONIO DOS SANTOS', NULL, NULL, '1944-12-27 00:00:00.000', 'LUZIA SEBASTIANA DA CONCEIÇÃO', NULL, '75677610410', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.309'),
(95, 'SONIA MARIA DA SILVA', NULL, NULL, '1961-06-01 00:00:00.000', 'MARIA FRANCISCA DA SILVA', NULL, '54642000453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.317'),
(96, 'JOSEFA FERREIRA BARBOSA', NULL, NULL, '1952-06-25 00:00:00.000', 'SEVERINA FERREIRA', NULL, '68876556400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.320'),
(97, 'DORALICE FERREIRA VIEIRA LIMA', NULL, NULL, '1964-05-05 00:00:00.000', 'SEVERINA VIEIRA DE LIRA', NULL, '45258112420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.322'),
(98, 'MARIA JOSÉ MARQUES', NULL, NULL, '1964-12-27 00:00:00.000', 'JOSEFA FRANCISCA XAVIER', NULL, '07501090416', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.325'),
(99, 'LUIZA BARBOSA BERNARDO', NULL, NULL, '1940-04-11 00:00:00.000', 'MARIA BARBOSA DA CONEIÇÃO', NULL, '39396746487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.326'),
(100, 'SEVERINA JOSEFA DA SILVA', NULL, NULL, '1947-12-16 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '74338374420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.328'),
(101, 'JOSEFA FERREIRA DA SILVA', NULL, NULL, '1961-05-11 00:00:00.000', 'MARIA JOSÉ BARBOSA', NULL, '71174761415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.333'),
(102, 'JOANA CELESTINA FAUSTINA', NULL, NULL, '1959-06-22 00:00:00.000', 'CELESTINA SEVERINA DA CONCEIÇÃO', NULL, '66804485491', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.335'),
(103, 'JULIA CELESTINA DA CONCEIÇÃO', NULL, NULL, '1955-04-21 00:00:00.000', 'CELESTINA SEVERINA DA CONCEIÇÃO', NULL, '58154604434', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.337'),
(104, 'LUIZA JOSEFA DS CONCEIÇAO', NULL, NULL, '1958-10-08 00:00:00.000', 'JOSEFA SEVRINA DA CONCEIÇÃO', NULL, '74339990434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.339'),
(105, 'SEVERINA MARIA FERREIRA DA SILVA', NULL, NULL, '1962-03-14 00:00:00.000', 'BEATRIZ JOSEFA DA SILVA', NULL, '94849013449', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.340'),
(106, 'MARIA JOSEFA DO NASCIMENTO', NULL, NULL, '1950-01-10 00:00:00.000', 'JOSEFA MARIA DA CONCEÇÃO', NULL, '62428950487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.341'),
(107, 'ROSA PAULINA DA SILVA', NULL, NULL, '1949-11-02 00:00:00.000', 'MARIA ENEDITA DOS SANTOS', NULL, '27815560415', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.342'),
(108, 'SEVERINA MARIA DA SILVA', NULL, NULL, '1947-03-03 00:00:00.000', 'MARIA JOSÉ DOS SANTOS', NULL, '62419382404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.343'),
(109, 'IZABEL MARIA DA SILVA', NULL, NULL, '1957-03-26 00:00:00.000', 'MARIA JOSÉ DO NASCIMENTO', NULL, '04931410499', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.343'),
(110, 'MARIA JOSÉ DE AQUINO E SILVA', NULL, NULL, '1939-08-28 00:00:00.000', 'SEVERINA MARIA DA FONSECA', NULL, '16553160449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.345'),
(111, 'IRENE AUXILIADORA DA SILVA', NULL, NULL, '1942-12-11 00:00:00.000', 'MARIA FRANCISCA DA CONCEIÇÃO', NULL, '72517719420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.347'),
(112, 'ADILENE JULIETA DA SILVA SOUZA', NULL, NULL, '1963-12-27 00:00:00.000', 'JULIETA ANA DA SILVA', NULL, '40010562400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.348'),
(113, 'MARIA SEVERINA DA SILVA SANTOS', NULL, NULL, '1964-05-24 00:00:00.000', 'MARIA SEVERINA DA CONCEIÇÃO', NULL, '83534075404', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.350'),
(114, 'ANTONIA JOVELINA DA SILVA', NULL, NULL, '1962-05-16 00:00:00.000', 'MARIA JOVELINA DA CONCEIÇÃO', NULL, '76401596449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.352'),
(115, 'JOSEFA SEVERINA DA SILVA', NULL, NULL, '1962-05-14 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '90771982453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.353'),
(116, 'JOSE PEREIRA DE MELO', NULL, NULL, '1947-06-12 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '25740547415', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.355'),
(117, 'MARIA JOSEFA DA SILVA', NULL, NULL, '1950-04-10 00:00:00.000', 'JOSEFA SEVERINA DO ESPIRITO SANTO', NULL, '26795469468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.356'),
(118, 'MARIA LOURENÇO DA SILVA', NULL, NULL, '1964-02-26 00:00:00.000', 'SEVERINA LOURENÇO DA SILVA', NULL, '93246404453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.358'),
(119, 'MARINETE FRANCO DE SANTANA', NULL, NULL, '1957-04-24 00:00:00.000', 'ALICE PEREIRA ANICETO', NULL, '68872690404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.359'),
(120, 'JOSEFA MARIA DA SILVA', NULL, NULL, '1954-04-28 00:00:00.000', 'JOSEFA SEVERINA DA CONCEIÇÃO', NULL, '68873069487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.360'),
(121, 'MARIA DE LOURDES DOS SANTOS COELHO', NULL, NULL, '1960-02-16 00:00:00.000', 'ANGELITA BEZERRA DA SILVA', NULL, '39897842420', NULL, 'BRASIL', 'BRASIL', 2, 3, 1, 1, NULL, 1, '2026-02-10 12:18:39.360'),
(122, 'VICENTE JOÃO DE SANTANA', NULL, NULL, '1959-10-15 00:00:00.000', 'JOSEFA  ANA DA CONCEIÇÃO', NULL, '62324098415', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.361'),
(123, 'JOSEFA CARMELITA DA SILVA', NULL, NULL, '1964-06-29 00:00:00.000', 'CARMELITA ROSALINA DE LIRA', NULL, '58601201415', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.362'),
(124, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1951-07-20 00:00:00.000', 'MARIA INÁCIA DA SILVA', NULL, '50705822400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.363'),
(125, 'ANA JOSEFA DA SILVA', NULL, NULL, '1957-12-04 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '03966184486', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.364'),
(126, 'LUZINETE FRANCISCA DE ALBUQUERQUE', NULL, NULL, '1958-03-25 00:00:00.000', 'FRANCISCA ADELINA DA CONCEIÇÃO', NULL, '54853281487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.364'),
(127, 'MARIA OLINDINA DE LIMA', NULL, NULL, '1956-12-24 00:00:00.000', 'OLINDINA MARIA DO CARMO', NULL, '39387720420', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.365'),
(128, 'MARIA GOMES DA PAZ', NULL, NULL, '1955-06-28 00:00:00.000', 'SEVERINA CÉSAR DE LIMA', NULL, '55502776468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.366'),
(129, 'IZABEL MARIA DA CONCEIÇÃO', NULL, NULL, '1953-05-02 00:00:00.000', 'ANTONIA MARIA DA CONCEIÇÃO', NULL, '50706349415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.367'),
(130, 'NEUSA HELENA FERNANDES', NULL, NULL, '1964-02-07 00:00:00.000', 'HELENA DE SANTANA FERNANDES', NULL, '58600400406', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.368'),
(131, 'MARIA JOSÉ DE SOUZA', NULL, NULL, '1963-11-05 00:00:00.000', 'MARGARIDA JOSÉ CIPRIANA', NULL, '73162582415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.369'),
(132, 'MARIA DAMIANA DA SILVA', NULL, NULL, '1964-11-24 00:00:00.000', 'DAMIANA JOSEFINA DA SILVA', NULL, '39387712400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.370'),
(133, 'MARIA RIBEIRO DA SILVA', NULL, NULL, '1960-09-14 00:00:00.000', 'TEREZA SEVERINA DA CONCEIÇÃO', NULL, '75678675400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.372'),
(134, 'ANTONIA MARIA DA SILVA', NULL, NULL, '1954-10-06 00:00:00.000', 'MARIA URBANA DA CONCEIÇÃO', NULL, '83562290497', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.374'),
(135, 'ANA MARIA BARBOSA', NULL, NULL, '1964-11-05 00:00:00.000', 'GERTRUDES MARIA DA CONCEIÇÃO', NULL, '01349867411', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.377'),
(136, 'JOSE MANOEL LINS IRMÃO', NULL, NULL, '1950-05-05 00:00:00.000', 'MARIA PORCINA DA CONCEIÇÃO', NULL, '01126726800', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.379'),
(137, 'EDILEUZA MARIA DE SANTANA NASCIMENTO', NULL, NULL, '1960-10-17 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '52211010415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.382'),
(138, 'LINDALVA CAITANO GOMES', NULL, NULL, '1959-03-05 00:00:00.000', 'ANTONIA MARIA DA CONCEIÇÃO', NULL, '39390179491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.383'),
(139, 'MARIA JOSÉ VALENTIM DA SILVA', NULL, NULL, '1947-01-07 00:00:00.000', 'ANTONIA FRANCISCA DE JESUS', NULL, '07106833835', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.385'),
(140, 'MARIA TEREZA DA SILVA', NULL, NULL, '1957-03-10 00:00:00.000', 'TEREZA DE JESUS DA SILVA', NULL, '83547002400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.387'),
(141, 'EDNALDO SEVERINO RAMOS', NULL, NULL, '1958-06-25 00:00:00.000', 'DIONILA MARIA RAMOS', NULL, '00856180807', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.389'),
(142, 'MARIA JOSÉ ALEXANDRE', NULL, NULL, '1950-07-20 00:00:00.000', 'ANGELITA FRANCISCA DA SILVA', NULL, '45742537468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.391'),
(143, 'MARIA LÍDIA PEREIRA', NULL, NULL, '1963-03-30 00:00:00.000', 'LIDIA SEBASTIANA DE SANTANA', NULL, '83545760430', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.392'),
(144, 'ANTONIO DAMIÃO PEREIRA', NULL, NULL, '1956-10-10 00:00:00.000', 'MARIA JOSÉ DO CARMO', NULL, '57525226415', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.393'),
(145, 'JOSÉ MARTINIANO DE BARROS FILHO', NULL, NULL, '1960-01-28 00:00:00.000', 'MARGARIDA  MARIA DA  ANUNCIAÇÃO', NULL, '28961382420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.394'),
(146, 'SEVERINA ALMEIDA BARBOSA', NULL, NULL, '1964-02-08 00:00:00.000', 'PAULA ALMEIDA PEDROSA', NULL, '43494811415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.395'),
(147, 'MARIA INEZ DE LIMA', NULL, NULL, '1947-10-01 00:00:00.000', 'INÊZ MARIA DE LIMA', NULL, '54642418415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.396'),
(148, 'TEREZINHA MARIA DOS SANTOS', NULL, NULL, '1947-10-23 00:00:00.000', 'MARIA CARMENCITA DA CONCEIÇÃO', NULL, '58039619491', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.398'),
(149, 'ANGELITA INEZ DE LIMA', NULL, NULL, '1966-02-07 00:00:00.000', 'INEZ MARIA DE LIMA', NULL, '81059302420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.400'),
(150, 'JOSEFA EDVETE DE SANTANA', NULL, NULL, '1960-08-01 00:00:00.000', 'ONECINA CÂNDIDA DA CONCEIÇÃO', NULL, '80983367434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.401'),
(151, 'CARMELITA MARIA GONÇALVES', NULL, NULL, '1950-05-04 00:00:00.000', 'MARIA ANTONIA DA CONCEIÇÃO', NULL, '75675617434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.403'),
(152, 'JOSEFA CORREIA DA SILVA', NULL, NULL, '1959-05-28 00:00:00.000', 'ONESCINA CÂNDIDA DA CONCEIÇÃO', NULL, '05168417426', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.404'),
(153, 'ISAURA TINTINO DA SILVA', NULL, NULL, '1955-10-01 00:00:00.000', 'MARIA DE LOURDES DA CONCEIÇÃO E SILVA', NULL, '11762168804', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.406'),
(154, 'MARIA DO SOCORRO SANTINA DA CONCEIÇÃO', NULL, NULL, '1963-09-10 00:00:00.000', 'MARIA SANTINA DA CONCEIÇÃO', NULL, '76399842468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.408'),
(155, 'MANOEL GERONIMO DA SILVA', NULL, NULL, '1959-05-15 00:00:00.000', 'TEREZINHA SEVERINA DA CONCEIÇÃO', NULL, '00755227808', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.409'),
(156, 'NIVALDO SEVERINO GONÇALVES', NULL, NULL, '1951-03-03 00:00:00.000', 'OLINDINA MARIA DO CARMO', NULL, '12819379400', NULL, 'BRASIL', 'BRASIL', 1, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.411'),
(157, 'CREUSA MARIA DA SILVA MELO', NULL, NULL, '1957-07-10 00:00:00.000', 'MARIA JOSE DA SILVA', NULL, '32836660406', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.412'),
(158, 'MARCELO FERREIRA DE MELO', NULL, NULL, '1960-12-02 00:00:00.000', 'JOSEFA FERREIRA MELO', NULL, '39389731453', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.414'),
(159, 'IZABEL LOPES DA SILVA', NULL, NULL, '1962-07-04 00:00:00.000', 'LUIZA LOPES DA SILVA', NULL, '02139284771', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.416'),
(160, 'ANA MARIA DA SILVA', NULL, NULL, '1963-10-03 00:00:00.000', 'MARIA ANA DA SILVA', NULL, '07693223444', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.417'),
(161, 'MARIA DO SOCORRO CORREIA DE MELO E SILVA', NULL, NULL, '1960-09-25 00:00:00.000', 'VALDECI  SEVERINA DO NASCIMENTO', NULL, '39389561434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.419'),
(162, 'MARIA CORREIA DE MELO SOUSA', NULL, NULL, '1956-12-30 00:00:00.000', 'VALDECÍ SEVERINA DO NASCIMENTO', NULL, '19857420478', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.421'),
(163, 'ANA MARIA DA CONCEIÇÃO', NULL, NULL, '1962-07-07 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '44765576434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.422'),
(164, 'HELENA PONCIANO DA CRUZ', NULL, NULL, '1955-06-12 00:00:00.000', 'JOANA MARIA DA CONCEIÇÃO', NULL, '39387518434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.423'),
(165, 'SEVERINA BERTULINA DOS SANTOS', NULL, NULL, '1955-05-25 00:00:00.000', 'BERTULINA ANA DA SILVA', NULL, '01418156809', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.424'),
(166, 'MARIA SEVERINA DOS SANTOS', NULL, NULL, '1963-03-11 00:00:00.000', 'JOSEFA SEVERINA DA CONCEIÇÃO', NULL, '04887882424', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.425'),
(167, 'MARIA DO CARMO MOREIRA DA SILVA', NULL, NULL, '1960-07-15 00:00:00.000', 'EULINA MOREIRA DE MENDONÇA', NULL, '83534121449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.426'),
(168, 'MARIA DAS DORES DA CRUZ SANTOS', NULL, NULL, '1958-10-03 00:00:00.000', 'MARIA JOSÉ DA CRUZ', NULL, '50706861434', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.426'),
(169, 'MARIA LÚCIA FERREIRA DA SILVA', NULL, NULL, '1964-12-05 00:00:00.000', 'JULIA FERREIRA DA SILVA', NULL, '90994280491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.427'),
(170, 'JOÃO JOSÉ DOS SANTOS', NULL, NULL, '1964-12-13 00:00:00.000', 'HELENA ANA DA CONCEIÇÃO', NULL, '66770939487', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.428'),
(171, 'IVANISE MARIA DA CONCEIÇÃO BORBA', NULL, NULL, '1951-07-12 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '52122409487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.431'),
(172, 'MARIA DE LOURDES DA CRUZ FARIAS', NULL, NULL, '1958-10-03 00:00:00.000', 'MARIA JOSÉ DA CRUZ', NULL, '74264265487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.432'),
(173, 'MARIA OLINDINA DA SILVA', NULL, NULL, '1961-05-15 00:00:00.000', 'OLINDINA JOSEFA DA CONCEIÇÃO', NULL, '42872057404', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.433'),
(174, 'MARINEUZA VIEIRA DE ALBUQUERQUE', NULL, NULL, '1965-03-17 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '83562206453', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.434'),
(175, 'MARIA JOSÉ DA CONCEIÇÃO', NULL, NULL, '1949-11-15 00:00:00.000', 'LAURA MARIA DA CONCEIÇÃO', NULL, '83312951453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.436'),
(176, 'MARIA CAETANA SILVA DO NASCIMENTO', NULL, NULL, '1955-04-22 00:00:00.000', 'MARIA CAETANA DA SILVA', NULL, '79507905472', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.440'),
(177, 'LINDALVA ANGELITA DA CONCEIÇÃO', NULL, NULL, '1957-12-30 00:00:00.000', 'ANGELITA PAULINA DA CONCEIÇÃO', NULL, '90997573449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.442'),
(178, 'MARIA ROSA DE ARAUJO DA SILVA', NULL, NULL, '1955-08-10 00:00:00.000', 'ROSA MARIA DE AQUINO', NULL, '78044677453', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.444'),
(179, 'IRACI ROSA DA SILVA', NULL, NULL, '1965-09-14 00:00:00.000', 'ROSA MARIANA DA SILVA', NULL, '48477010463', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.446'),
(180, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1954-05-28 00:00:00.000', 'MARIA JOSÉ DA CONCEIÇÃO', NULL, '83562451415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.448'),
(181, 'LUSIA MARIA DE BARROS', NULL, NULL, '1948-12-13 00:00:00.000', 'MARIA JOSÉ DE LIMA', NULL, '26795493415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.451'),
(182, 'ELIONAI DE FREITAS ABUD', NULL, NULL, '1958-06-25 00:00:00.000', 'IRACEMA COSTA DE FREITAS', NULL, '22480978400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.453'),
(183, 'ANA ROSA FERREIRA', NULL, NULL, '1957-04-16 00:00:00.000', 'JOSEFA ROSA DA SILVA', NULL, '79506879400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.455'),
(184, 'TEREZA MARIA DO NASCIMENTO', NULL, NULL, '1955-09-10 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '74337602453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.456'),
(185, 'COSMA SEVERINA BARBOSA DA SILVA', NULL, NULL, '1962-10-01 00:00:00.000', 'SEVERINA JOSEFA BARBOSA', NULL, '06766062452', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.457'),
(186, 'INÊZ MARIA DO NASCIMENTO', NULL, NULL, '1945-02-14 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '00893980412', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.458'),
(187, 'JOÃO MARIANO DA SILVA FILHO', NULL, NULL, '1958-12-28 00:00:00.000', 'JULIA MARIA DA SILVA', NULL, '58039325404', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.459'),
(188, 'JOSEFA MARIA DOS SANTOS', NULL, NULL, '1961-05-24 00:00:00.000', 'MARIA MIRANDA TEIXEIRA', NULL, '46064389400', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.460'),
(189, 'EZILVA EUGENIA GOMES', NULL, NULL, '1965-04-24 00:00:00.000', 'ZILDA EUGENIA GOMES', NULL, '52572366487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.460'),
(190, 'MARIA DO CARMO DE LIMA FARIAS', NULL, NULL, '1960-04-14 00:00:00.000', 'MARIA ANTONIA DE LIMA', NULL, '40339840463', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.463'),
(191, 'JOSÉ LUCIANO DA CRUZ', NULL, NULL, '1953-01-25 00:00:00.000', 'SEVERINA JOSEFA DA CRUZ', NULL, '58038809491', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.465'),
(192, 'JOSÉ JUSCELINO JOÃO DA SILVA', NULL, NULL, '1956-07-08 00:00:00.000', 'FRANQUILINA MARIA DA SILVA', NULL, '17964997491', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.466'),
(193, 'MARIA DA CONCEIÇÃO GONÇALO', NULL, NULL, '1959-08-19 00:00:00.000', 'DAMIANA MARIA GONÇALO', NULL, '05298635458', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.467'),
(194, 'LAURA MARIA DA CONCEIÇÃO', NULL, NULL, '1954-12-02 00:00:00.000', 'MARIA JOSÉ DA CONCEIÇÃO', NULL, '07407126402', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.468'),
(195, 'IVANILDA ALVES FERREIRA SILVA', NULL, NULL, '1964-10-12 00:00:00.000', 'ESMERALDINA ALVES FERREIRA', NULL, '74439286453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.469'),
(196, 'MARIA LÚCIA DA COSTA', NULL, NULL, '1963-10-16 00:00:00.000', 'JOSEFA FERREIRA DA COSTA', NULL, '44744455468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.470'),
(197, 'SEVERINA DA PAZ RIBEIRO', NULL, NULL, '1949-09-26 00:00:00.000', 'MARIA DA PAZ CAVALCANTE', NULL, '90990919404', NULL, 'BRASIL', 'BRASIL', 2, 3, 1, 1, NULL, 1, '2026-02-10 12:18:39.471'),
(198, 'MARIA DE FÁTIMA DE SANTANA', NULL, NULL, '1963-05-07 00:00:00.000', 'LETÍCIA MARIA DA CONCEIÇÃO', NULL, '96242442434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.474'),
(199, 'MARGARIDA ISABEL DA SILVA', NULL, NULL, '1951-10-09 00:00:00.000', 'SEVERINA MARIA DA SILVA', NULL, '79506801487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.475'),
(200, 'TERESA ISABEL RAMOS', NULL, NULL, '1957-04-05 00:00:00.000', 'SEVERINA MARIA DA SILVA', NULL, '08980966423', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.476'),
(201, 'JOSEFA RAMOS DE LIMA', NULL, NULL, '1961-06-02 00:00:00.000', 'JOSEFA MARIA DE SANTANA', NULL, '73237558400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.479'),
(202, 'LUZINETE MARIA DE LUNA FERREIRA', NULL, NULL, '1959-11-09 00:00:00.000', 'MARIA ANTONIA DA CONCEIÇÃO', NULL, '11110755490', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.480'),
(203, 'LENICE MARIA DE BARROS', NULL, NULL, '1963-11-10 00:00:00.000', 'MARIA ALMEIDA DA SILVA', NULL, '73237299472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.481'),
(204, 'LUCIA MARIA DE ANDRADE', NULL, NULL, '1957-05-28 00:00:00.000', 'MARIA LUIZA DA CONCEIÇÃO', NULL, '37233483434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.483'),
(205, 'JOÃO JOSÉ BEZERRA', NULL, NULL, '1954-05-25 00:00:00.000', 'JOSEFA ANTONIA BEZERRA', NULL, '33446288449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.484'),
(206, 'TEREZA MARIA DA SILVA', NULL, NULL, '1954-02-01 00:00:00.000', 'MARIA LUIZA DA CONCEIÇÃO', NULL, '07832347406', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.485'),
(207, 'MARIA SEVERINA DE SOUZA', NULL, NULL, '1952-09-22 00:00:00.000', 'SEVERINA JÚLIA DE SOUZA', NULL, '07017803477', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.486'),
(208, 'DAMIANA MARIA DOS SANTOS BORBA', NULL, NULL, '1964-09-05 00:00:00.000', 'MARIA JOSÉ DA SILVA', NULL, '74262513491', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.487'),
(209, 'MARIA DAS DORES DE ARAUJO', NULL, NULL, '1964-10-03 00:00:00.000', 'MARIA MADALENA DA CONCEIÇÃO OLIVEIRA', NULL, '43258700400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.488'),
(210, 'MARIA CECÍLIA DE MELO E SILVA', NULL, NULL, '1953-10-20 00:00:00.000', 'CECÍLIA JOSEFA DA CONCEIÇÃO', NULL, '74263854420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.489'),
(211, 'MARIA JOSÉ DE ALBURQUERQUE', NULL, NULL, '1960-10-08 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '03038417459', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.490'),
(212, 'MANOEL  FERNANDES BORBA', NULL, NULL, '1952-03-04 00:00:00.000', 'DONZÍLIA PETRONILA DE SOUSA', NULL, '18759580453', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.491'),
(213, 'JOANA MARIA DE ALBUQUERQUE', NULL, NULL, '1951-07-10 00:00:00.000', 'MARIA LUIZ DOS SANTOS', NULL, '74262505472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.493'),
(214, 'MARIA ARCELINA DA CONCEIÇÃO', NULL, NULL, '1952-08-24 00:00:00.000', 'ARCELINA MARIA DA CONCEIÇÃO', NULL, '83562281404', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.494'),
(215, 'MARIA OTACILIA DA CONCEIÇÃO SILVA', NULL, NULL, '1951-06-03 00:00:00.000', 'OTACILIA SEVERINA DA CONCEIÇÃO', NULL, '78103657468', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.495'),
(216, 'TEREZA CORREIA DE SOUZA', NULL, NULL, '1959-04-16 00:00:00.000', 'VALDECI SEVERINA DO NASCIMENTO', NULL, '36659592415', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.496'),
(217, 'GERALDA JOSEFA DA SILVA', NULL, NULL, '1959-11-09 00:00:00.000', 'JOSEFA SEVERINA DA SILVA', NULL, '79507751491', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.497'),
(218, 'VERA LUCIA DA SILVA SANTANA PESSOA', NULL, NULL, '1966-01-14 00:00:00.000', 'BEATRIZ DA SILVA SANTANA', NULL, '49320769400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.498'),
(219, 'GABRYELLA MAYARA VELOZO DA SILVA', NULL, NULL, '2017-07-10 00:00:00.000', 'MARIA APARECIDA VELOZO DA SILVA', NULL, '14672905489', NULL, 'BRASIL', 'BRASIL', 2, 5, 1, 1, NULL, 1, '2026-02-10 12:18:39.499'),
(220, 'MARIA VITÓRIA DE SOUZA LIMA', NULL, NULL, '2014-08-29 00:00:00.000', 'SEVERINA MARIA DE SOUZA', NULL, '17366086495', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.500'),
(221, 'JOÃO GUILHERME DA SILVA', NULL, NULL, '2012-11-04 00:00:00.000', 'VIVIANE MÔNICA DA CONCEIÇÃO SILVA', NULL, '17673638428', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.502'),
(222, 'ISAAC RAFAEL PEREIRA DE SANTANA', NULL, NULL, '2013-01-22 00:00:00.000', 'IVANEIDE JULIA DA CONCEIÇÃO PEREIRA', NULL, '16818108407', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.503'),
(223, 'JOSÉ DANILO NASCIMENTO DOS SANTOS', NULL, NULL, '2013-11-25 00:00:00.000', 'JAQUELINE MARIA DO NASCIMENTO', NULL, '16623783431', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.504'),
(224, 'ADRYAN DAVID DO NASCIMENTO SANTOS', NULL, NULL, '2013-02-20 00:00:00.000', 'ADRIANA SEVERINA DO NASCIMENTO', NULL, '15913842499', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.505'),
(225, 'JHONNATAN RYQUELMY ALVES DA SILVA', NULL, NULL, '2014-10-18 00:00:00.000', 'TATIANE MARIA SA SILVA', NULL, '15767755426', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.506'),
(226, 'JEFFERSON TOBIAS DA SILVA SANTOS', NULL, NULL, '2013-05-22 00:00:00.000', 'MARIA JOSÉ DA SILVA', NULL, '16692448492', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.507'),
(227, 'KAWAN DHIESUS PEREIRA DE OLIVEIRA', NULL, NULL, '2017-04-01 00:00:00.000', 'MÔNICA GERLÂNE DO NASCIMENTO PEREIRA', NULL, '14457309443', NULL, 'BRASIL', 'BRASIL', 1, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.508'),
(228, 'MARLON SANTOS DE MACÊDO SILVA', NULL, NULL, '2014-02-13 00:00:00.000', 'MICILENE SANTOS DE MACÊDO SILVA', NULL, '16835546476', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.509'),
(229, 'WESLLEY HENRIQUE DA SILVA LIBERATO', NULL, NULL, '2014-02-27 00:00:00.000', 'AURICLÉCIA LEIDJANE DA SILVA LIBERATO', NULL, '08112618160', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.510'),
(230, 'JHENNIFER YASMIM DA SILVA NASCIMENTO', NULL, NULL, '2010-03-18 00:00:00.000', 'SILENE CECÍCILA DA SILVA NASCIMENTO', NULL, '17348039405', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.511'),
(231, 'ALLANA  BEATRIZ DA SILVA LIBERATO', NULL, NULL, '2018-03-12 00:00:00.000', 'BENEDITA ANGELITA DE FRANÇA', NULL, '09166829194', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.513'),
(232, 'WANDERSON DA SILVA LUNA', NULL, NULL, '2013-09-13 00:00:00.000', 'JACILENE MARIA ANUNCIADA DA SILVA', NULL, '13987030445', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.514'),
(233, 'RAFAEL DA SILVA SILVESTRE', NULL, NULL, '2016-03-17 00:00:00.000', 'LINDACI SEVERINA DA SILVA', NULL, '13725293490', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.515'),
(234, 'ALICE PEREIRA BARBOSA DE LIMA', NULL, NULL, '2014-08-09 00:00:00.000', 'MÔNICA MARIA PEREIRA', NULL, '17138097450', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.516'),
(235, 'SAMUEL HEITOR PEREIRA BARBOSA LIMA', NULL, NULL, '2015-07-10 00:00:00.000', 'MÔNICA MARIA PEREIRA LIMA', NULL, '17137962440', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.518'),
(236, 'MARIA LÍDIA PEREIRA BARBOSA DE LIMA', NULL, NULL, '2019-04-22 00:00:00.000', 'MÔNICA MARIA PEREIRA LIMA', NULL, '16474234490', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.520'),
(237, 'JOÃO GUILHERME LIMA BORGES', NULL, NULL, '2013-02-24 00:00:00.000', 'AGENARIA MARIA DA CONCEIÇÃO LIMA', NULL, '14171324424', NULL, 'BRASIL', 'BRASIL', 1, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.520'),
(238, 'KEVYN IGOR FERREIRA DOS SANTOS', NULL, NULL, '2013-10-16 00:00:00.000', 'MARIA DE FÁTIMA DA CONCEIÇÃO FERREIRA', NULL, '08730313180', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.521'),
(239, 'YAGO FERREIRA DE LIMA', NULL, NULL, '2013-03-17 00:00:00.000', 'DANIELA MARIA DE LIMA', NULL, '18146264417', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.521'),
(240, 'LUCIANA SOFYA SILVA', NULL, NULL, '2016-12-16 00:00:00.000', 'JULIETE MARLENE DA SILVA', NULL, '15976819460', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.522'),
(241, 'PIETRO MARTINS DE SANTANA', NULL, NULL, '2017-09-22 00:00:00.000', 'GRACE KELLY SOARES DA SILVA', NULL, '14856448447', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.523'),
(242, 'LUIZ FELIPE DOS SANTOS SILVA', NULL, NULL, '2013-12-31 00:00:00.000', 'MARTA MARIA DOS SANTOS', NULL, '16802243440', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.523'),
(243, 'JOSÉ DAVI DA SILVA LIMA', NULL, NULL, '2014-04-01 00:00:00.000', 'MARIA JOSÉ DA SILVA LIMA', NULL, '16081973441', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.524'),
(244, 'JEFERSON CAIO DA SILVA SANTOS', NULL, NULL, '2013-02-28 00:00:00.000', 'IVONERE SEVERINA DA SILVA', NULL, '16762047416', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.525'),
(245, 'MARCELO HENRIQUE SANTIAGO OLIVEIRA', NULL, NULL, '2014-02-10 00:00:00.000', 'MARIA ROSA DA SILVA SANTIAGO', NULL, '00364143444', NULL, 'BRASIL', 'BRASIL', 1, 2, 1, 1, NULL, 1, '2026-02-10 12:18:39.526'),
(246, 'MARIANA GOMES DE SOUSA', NULL, NULL, '2015-12-10 00:00:00.000', 'MARIA STERFFANE GOMES DA SILVA', NULL, '17977432447', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.526'),
(247, 'ALLANA VITÓRIA GOMMES DA SILVA', NULL, NULL, '2019-06-11 00:00:00.000', 'MARIA STERFFANE GOMES DA SILVA', NULL, '16558303418', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-10 12:18:39.527'),
(248, 'MARINA GOMES DE SOUZA', NULL, NULL, '2015-12-10 00:00:00.000', 'MARIA STERFFANE GOMES DA SILVA', NULL, '17977447479', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 12:18:39.528'),
(249, 'LUANDERSON ARLINDO DE OLIVEIRA', NULL, NULL, '2003-06-27 00:00:00.000', 'SILVANIA JOSEFA PEREIRA', NULL, '14047504440', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-10 12:32:34.685'),
(250, 'FERNANDA DA SILVA ANDRINI', NULL, NULL, '1993-04-23 00:00:00.000', 'JOANA ISAURA DA SILVA ANDRINI', NULL, '10585124477', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 13:05:49.276'),
(251, 'ANA BEATRIZ DA SILVA FELIX', NULL, NULL, '2004-07-05 00:00:00.000', 'JOSINEIDE MARIA DA SILVA', NULL, '16662416444', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 13:05:49.278'),
(252, 'ANA PAULA INACIA DA SILVA', NULL, NULL, '1982-05-02 00:00:00.000', 'INACIA MARIA DA SILVA', NULL, '06481848466', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 13:05:49.281');
INSERT INTO `pessoa` (`id`, `nome_completo`, `nome_social`, `apelido`, `data_nasc`, `nome_mae`, `nome_pai`, `cpf`, `rg`, `naturalidade`, `nacionalidade`, `genero_id`, `etnia_id`, `escolaridade_id`, `orgao_emissor_id`, `tipo_sanguineo`, `status`, `created_at`) VALUES
(253, 'MARIA EDUARDA RODRIGUES VASCONCELOS', NULL, NULL, '1999-09-02 00:00:00.000', 'CLAUDIA DANIELLA RODRIGUES DA SILVA', NULL, '10814202438', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 13:05:49.283'),
(254, 'MARÍLIA EDUARDA DOS SANTOS', NULL, NULL, '1995-03-31 00:00:00.000', 'ALEXSANDRA ENEAS RIBEIRO', NULL, '11704862400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 13:05:49.355'),
(255, 'NATÁLIA ESMERALDA DA SILVA', NULL, NULL, '1988-12-22 00:00:00.000', 'ESMERALDA PAULINA DA SILVA', NULL, '10040744418', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 13:05:49.358'),
(256, 'MARIA YSTELLA AUREA DE LIMA', NULL, NULL, '1993-04-05 00:00:00.000', 'IAURA LUZIA DE BARROS LIMA', NULL, '09718666435', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 13:05:49.360'),
(257, 'VITÓRIA SILVA DE OLIVEIRA', NULL, NULL, '2005-09-26 00:00:00.000', 'GIRLEIDE SEVERINA DA SILVA', NULL, '15767716447', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-10 13:05:49.364'),
(258, 'ANGELA MARIA DA SILVA', NULL, NULL, '1958-12-03 00:00:00.000', 'JOSEFA SEVERINA MARIA DA SILVA', NULL, '75676745487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-12 18:15:02.484');

-- --------------------------------------------------------

--
-- Estrutura para tabela `processo_inscricao`
--

DROP TABLE IF EXISTS `processo_inscricao`;
CREATE TABLE `processo_inscricao` (
  `id` int(11) NOT NULL,
  `id_projeto` int(11) DEFAULT NULL,
  `titulo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `projeto`
--

DROP TABLE IF EXISTS `projeto`;
CREATE TABLE `projeto` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `status` enum('planejado','ativo','finalizado') DEFAULT 'ativo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `projeto`
--

INSERT INTO `projeto` (`id`, `titulo`, `status`) VALUES
(1, 'Projeto VamoSimbora?', 'ativo'),
(2, 'Projeto Oportunizar Comunidades', 'ativo'),
(3, 'Projeto Conecta Vidas - Letramento Digital e educação financeira para pessoas idosas', 'ativo'),
(4, 'Projeto Comunidade Rural', 'ativo'),
(5, 'Projeto Skate Livre', 'ativo');

-- --------------------------------------------------------

--
-- Estrutura para tabela `setor`
--

DROP TABLE IF EXISTS `setor`;
CREATE TABLE `setor` (
  `id` int(11) NOT NULL,
  `nome` varchar(191) NOT NULL,
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `setor`
--

INSERT INTO `setor` (`id`, `nome`, `status`) VALUES
(1, 'Coordenação Executiva', 1),
(2, 'Coordenação de Projetos', 1),
(3, 'Coordenação Financeira', 1),
(4, 'Nutrição', 1),
(5, 'Administrativo', 1),
(6, 'Pedagógico', 1),
(7, 'Comunicação', 1),
(8, 'Repografia', 1),
(9, 'Monitoramento', 1),
(10, 'Tecnologia', 1),
(11, 'Multidisciplinar', 1),
(12, 'Esportes', 1),
(13, 'Recepção', 1),
(14, 'Transporte', 1),
(15, 'Alimentação', 1),
(16, 'Agrícola', 1),
(17, 'Voluntários', 1),
(18, 'Estagiários', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_documento`
--

DROP TABLE IF EXISTS `tipo_documento`;
CREATE TABLE `tipo_documento` (
  `id` int(11) NOT NULL,
  `nome` varchar(191) NOT NULL,
  `categoria` varchar(191) NOT NULL,
  `obrigatorio` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `turmas`
--

DROP TABLE IF EXISTS `turmas`;
CREATE TABLE `turmas` (
  `id` int(11) NOT NULL,
  `projeto_id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `turno` varchar(20) NOT NULL,
  `periodo` varchar(20) NOT NULL,
  `dias_aula` text,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `turmas`
--

INSERT INTO `turmas` (`id`, `projeto_id`, `nome`, `turno`, `periodo`, `dias_aula`, `data_inicio`, `data_fim`, `ativo`, `created_at`) VALUES
(1, 3, 'LETRAMENTO DIGITAL', 'Manhã', '2026.2', '[]', NULL, NULL, 1, '2026-02-02 13:26:03'),
(2, 1, 'V-B', 'Tarde', '2026.2', '[\"Seg\",\"Qua\",\"Sex\"]', '2026-02-02', '2025-12-30', 0, '2026-02-02 13:54:00'),
(3, 5, 'Skate', 'Manhã', '2026.2', '[\"Seg\",\"Qua\",\"Ter\",\"Qui\",\"Sex\"]', NULL, NULL, 0, '2026-02-04 13:03:07');

-- --------------------------------------------------------

--
-- Estrutura para tabela `turma_professores`
--

DROP TABLE IF EXISTS `turma_professores`;
CREATE TABLE `turma_professores` (
  `id` int(11) NOT NULL,
  `turma_id` int(11) NOT NULL,
  `colaborador_id` int(11) NOT NULL,
  `disciplina_id` int(11) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `turma_professores`
--

INSERT INTO `turma_professores` (`id`, `turma_id`, `colaborador_id`, `disciplina_id`, `ativo`) VALUES
(1, 1, 16, NULL, 1),
(2, 1, 15, NULL, 1),
(3, 2, 2, NULL, 0),
(4, 2, 16, NULL, 0),
(5, 3, 16, NULL, 1),
(6, 3, 15, NULL, 1),
(7, 3, 21, NULL, 1),
(8, 3, 2, NULL, 1),
(9, 2, 164, NULL, 1),
(10, 2, 102, NULL, 1),
(11, 2, 24, NULL, 0),
(12, 2, 21, NULL, 0),
(13, 2, 7, NULL, 0),
(14, 1, 2, NULL, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `id_colaborador` int(11) NOT NULL,
  `id_perfil_usuario` int(11) NOT NULL,
  `login` varchar(191) NOT NULL,
  `senha` varchar(191) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fotos_aula`;
CREATE TABLE `fotos_aula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aula_id` int(11) NOT NULL,
  `caminho_foto` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `aula_id` (`aula_id`),
  CONSTRAINT `fk_fotos_aula` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`id`, `id_colaborador`, `id_perfil_usuario`, `login`, `senha`, `status`) VALUES
(1, 1, 3, 'heloisa.hora', '$2b$10$qVp4KkRwwdcQyEO7hi/9ouw8S9gIASGXJgrOTL3w.m67ZsZtKqk7y', 1),
(2, 2, 2, 'andreis.victor', '$2b$10$DLYvgDYu4rP0Y0VzynoCi.ATHBZDxMh9M6TT7IMev6W3McVDUhIBO', 1),
(3, 3, 2, 'jacy.lima', '$2b$10$cLoqzEM2J4LCrBPhB.v.uezjBzHppMSGOLdXDRzzqmXsj.aub3fBS', 1),
(4, 4, 2, 'tatiane.maria', '$2b$10$ntTw1uGO3hmCiD7mfXCZ6upgRNFvqDkzbZc73rZfJl.f8LImPr75G', 1),
(5, 5, 2, 'arthur.yure', '$2b$10$Re2CiYNBzxy.I3MCq4mH5.3hE17mDExm9lh03.iEpF2Mk8CL3A2Um', 1),
(6, 6, 6, 'aparicio.luis', '$2b$10$2lDeMNJ.pPmhvNBIswWr4OAaxIOSCFSrYLGnnOf39.25a8E9mYH.W', 1),
(7, 7, 2, 'paulo.santana', '$2b$10$MxME9GO338z0/URt4v5QtOOu0oSGyZ3IZS1hAjPuBfHnN3XXnhThi', 1),
(8, 8, 6, 'luanderson.oliveira', '$2b$10$d9Y73tcPQwEGxf.Ji2K0sOZbEe7X1o2ktd3mQ/te.DpomdiMPNA96', 1),
(9, 9, 3, 'fernanda.andrini', '$2b$10$v8A2HfXQbcF.yQ.XZ3tIz.p4bkbJRJ.1kcCF1xLHOLoWTbmG1uW8C', 1),
(10, 10, 3, 'ana.beatriz', '$2b$10$jml6VfjUiXhoukIennX7Pej4JL8PkkIZGa850RWQrI1FqN5ZW8Fgm', 1),
(11, 11, 3, 'ana.silva', '$2b$10$aXHGPAv5GA6rTUAqxWNz3enClYIjlQQ3G7boHPTz9P3OOqe45oSZ2', 1),
(12, 12, 3, 'eduarda.vasconcelos', '$2b$10$ngdff0tMaJ1P6mBxiV5qvunT4a.QhnithPJR5Nuoby1yG4piYn912', 1),
(13, 13, 3, 'marilia.eduarda', '$2b$10$oSmytNky7y3L5FyVzJJGAubJEFMC3F9.n1K3L5aWQ3xbzExvOekKG', 1),
(14, 14, 3, 'natalia.esmeralda', '$2b$10$Ydk/kjYyOnjidbiv7Hd/ouzEm.x05TbKpqhZWhUTrOZ2Mwp/gE022', 1),
(15, 15, 3, 'maria.ystella', '$2b$10$tYbtUU0byS.I/zOgYheUKe4Oox3YLOQH454vdpccERO3QT8n2OByS', 1),
(16, 16, 3, 'vitoria.oliveira', '$2b$10$L0XJZSglv806JL3QxYDVKOB6.FRlPWqFTa5J8zgquQ7LewmjTfkJm', 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `aulas`
--
ALTER TABLE `aulas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `turma_id` (`turma_id`),
  ADD KEY `colaborador_id` (`colaborador_id`);

--
-- Índices de tabela `Beneficiario`
--
ALTER TABLE `Beneficiario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pessoa_id` (`pessoa_id`),
  ADD KEY `id_projeto` (`id_projeto`),
  ADD KEY `id_processo_inscricao` (`id_processo_inscricao`);

--
-- Índices de tabela `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `setor_id` (`setor_id`);

--
-- Índices de tabela `colaborador`
--
ALTER TABLE `colaborador`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_institucional` (`email_institucional`),
  ADD KEY `pessoa_id` (`pessoa_id`),
  ADD KEY `cargo_id` (`cargo_id`);

--
-- Índices de tabela `contato`
--
ALTER TABLE `contato`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pessoa_id` (`pessoa_id`);

--
-- Índices de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `turma_id` (`turma_id`);

--
-- Índices de tabela `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pessoa_id` (`pessoa_id`);

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
-- Índices de tabela `frequencias`
--
ALTER TABLE `frequencias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aula_id` (`aula_id`),
  ADD KEY `matricula_id` (`matricula_id`);

--
-- Índices de tabela `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identidade_id` (`identidade_id`);

--
-- Índices de tabela `identidade_genero`
--
ALTER TABLE `identidade_genero`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `matriculas`
--
ALTER TABLE `matriculas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `aluno_turma_unico` (`turma_id`,`beneficiario_id`),
  ADD KEY `beneficiario_id` (`beneficiario_id`);

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
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD KEY `genero_id` (`genero_id`),
  ADD KEY `etnia_id` (`etnia_id`),
  ADD KEY `escolaridade_id` (`escolaridade_id`),
  ADD KEY `orgao_emissor_id` (`orgao_emissor_id`);

--
-- Índices de tabela `processo_inscricao`
--
ALTER TABLE `processo_inscricao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_projeto` (`id_projeto`);

--
-- Índices de tabela `projeto`
--
ALTER TABLE `projeto`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `setor`
--
ALTER TABLE `setor`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `turmas`
--
ALTER TABLE `turmas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projeto_id` (`projeto_id`);

--
-- Índices de tabela `turma_professores`
--
ALTER TABLE `turma_professores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `turma_id` (`turma_id`),
  ADD KEY `colaborador_id` (`colaborador_id`),
  ADD KEY `disciplina_id` (`disciplina_id`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_colaborador` (`id_colaborador`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `id_perfil_usuario` (`id_perfil_usuario`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `aulas`
--
ALTER TABLE `aulas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `Beneficiario`
--
ALTER TABLE `Beneficiario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=243;

--
-- AUTO_INCREMENT de tabela `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de tabela `colaborador`
--
ALTER TABLE `colaborador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `contato`
--
ALTER TABLE `contato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=259;

--
-- AUTO_INCREMENT de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `endereco`
--
ALTER TABLE `endereco`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `escolaridade`
--
ALTER TABLE `escolaridade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `etnia`
--
ALTER TABLE `etnia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `frequencias`
--
ALTER TABLE `frequencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de tabela `genero`
--
ALTER TABLE `genero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `identidade_genero`
--
ALTER TABLE `identidade_genero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `matriculas`
--
ALTER TABLE `matriculas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de tabela `orgao_emissor`
--
ALTER TABLE `orgao_emissor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT de tabela `perfil_usuario`
--
ALTER TABLE `perfil_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `pessoa`
--
ALTER TABLE `pessoa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=259;

--
-- AUTO_INCREMENT de tabela `processo_inscricao`
--
ALTER TABLE `processo_inscricao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `projeto`
--
ALTER TABLE `projeto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `setor`
--
ALTER TABLE `setor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `turmas`
--
ALTER TABLE `turmas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `turma_professores`
--
ALTER TABLE `turma_professores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
