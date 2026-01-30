-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 30/01/2026 às 10:36
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

CREATE TABLE `aulas` (
  `id` int(11) NOT NULL,
  `turma_id` int(11) NOT NULL,
  `colaborador_id` int(11) NOT NULL,
  `data_aula` date NOT NULL,
  `conteudo` text,
  `numero_aulas` int(11) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Beneficiario`
--

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
(1, 8, 1, 1, '2026-01-28 18:25:04.626'),
(2, 9, 1, 1, '2026-01-28 18:25:04.628'),
(3, 10, 1, 1, '2026-01-28 18:25:04.629'),
(4, 11, 1, 1, '2026-01-28 18:25:04.631'),
(5, 12, 1, 1, '2026-01-28 18:25:04.632'),
(6, 13, 1, 1, '2026-01-28 18:25:04.634'),
(7, 14, 1, 1, '2026-01-28 18:25:04.636'),
(8, 15, 1, 1, '2026-01-28 18:25:04.637'),
(9, 16, 1, 1, '2026-01-28 18:25:04.639'),
(10, 17, 1, 1, '2026-01-28 18:25:04.641'),
(11, 18, 1, 1, '2026-01-28 18:25:04.642'),
(12, 19, 1, 1, '2026-01-28 18:25:04.643'),
(13, 20, 1, 1, '2026-01-28 18:25:04.643'),
(14, 21, 1, 1, '2026-01-28 18:25:04.644'),
(15, 22, 1, 1, '2026-01-28 18:25:04.647'),
(16, 23, 1, 1, '2026-01-28 18:25:04.649'),
(17, 24, 1, 1, '2026-01-28 18:25:04.650'),
(18, 25, 1, 1, '2026-01-28 18:25:04.651'),
(19, 26, 1, 1, '2026-01-28 18:25:04.653'),
(20, 27, 1, 1, '2026-01-28 18:25:04.654'),
(21, 28, 1, 1, '2026-01-28 18:25:04.655'),
(22, 29, 1, 1, '2026-01-28 18:25:04.657'),
(23, 30, 1, 1, '2026-01-28 18:25:04.660'),
(24, 31, 1, 1, '2026-01-28 18:25:04.662'),
(25, 32, 1, 1, '2026-01-28 18:25:04.664'),
(26, 33, 1, 1, '2026-01-28 18:25:04.665'),
(27, 34, 1, 1, '2026-01-28 18:25:04.666'),
(28, 35, 1, 1, '2026-01-28 18:25:04.667'),
(29, 36, 1, 1, '2026-01-28 18:25:04.668'),
(30, 37, 1, 1, '2026-01-28 18:25:04.668'),
(31, 38, 1, 1, '2026-01-28 18:25:04.669'),
(32, 39, 1, 1, '2026-01-28 18:25:04.670'),
(33, 40, 1, 1, '2026-01-28 18:25:04.671'),
(34, 41, 1, 1, '2026-01-28 18:25:04.672'),
(35, 42, 1, 1, '2026-01-28 18:25:04.673'),
(36, 43, 1, 1, '2026-01-28 18:25:04.674'),
(37, 44, 1, 1, '2026-01-28 18:25:04.674'),
(38, 45, 1, 1, '2026-01-28 18:25:04.675'),
(39, 46, 1, 1, '2026-01-28 18:25:04.677'),
(40, 47, 1, 1, '2026-01-28 18:25:04.688'),
(41, 48, 1, 1, '2026-01-28 18:25:04.692'),
(42, 49, 1, 1, '2026-01-28 18:25:04.694'),
(43, 51, 1, 1, '2026-01-28 18:25:04.698'),
(44, 53, 1, 1, '2026-01-28 18:25:04.706'),
(45, 55, 1, 1, '2026-01-28 18:25:04.710'),
(46, 56, 1, 1, '2026-01-28 18:25:04.711'),
(47, 57, 1, 1, '2026-01-28 18:25:04.712'),
(48, 58, 1, 1, '2026-01-28 18:25:04.714'),
(49, 63, 1, 1, '2026-01-28 18:25:04.723'),
(50, 70, 1, 1, '2026-01-28 18:25:04.734'),
(51, 75, 1, 1, '2026-01-28 18:25:04.743'),
(52, 87, 3, 1, '2026-01-29 18:25:02.820'),
(53, 88, 3, 1, '2026-01-29 18:25:02.825'),
(54, 89, 3, 1, '2026-01-29 18:25:02.827'),
(55, 90, 3, 1, '2026-01-29 18:25:02.829'),
(56, 91, 3, 1, '2026-01-29 18:25:02.831'),
(57, 92, 3, 1, '2026-01-29 18:25:02.832'),
(58, 93, 3, 1, '2026-01-29 18:25:02.834'),
(59, 94, 3, 1, '2026-01-29 18:25:02.836'),
(60, 95, 3, 1, '2026-01-29 18:25:02.838'),
(61, 96, 3, 1, '2026-01-29 18:25:02.840'),
(62, 97, 3, 1, '2026-01-29 18:25:02.841'),
(63, 98, 3, 1, '2026-01-29 18:25:02.843'),
(64, 99, 3, 1, '2026-01-29 18:25:02.846'),
(65, 100, 3, 1, '2026-01-29 18:25:02.847'),
(66, 101, 3, 1, '2026-01-29 18:25:02.849'),
(67, 102, 3, 1, '2026-01-29 18:25:02.851'),
(68, 103, 3, 1, '2026-01-29 18:25:02.853'),
(69, 104, 3, 1, '2026-01-29 18:25:02.855'),
(70, 105, 3, 1, '2026-01-29 18:25:02.857'),
(71, 106, 3, 1, '2026-01-29 18:25:02.859'),
(72, 107, 3, 1, '2026-01-29 18:25:02.860'),
(73, 108, 3, 1, '2026-01-29 18:25:02.862'),
(74, 109, 3, 1, '2026-01-29 18:25:02.864'),
(75, 110, 3, 1, '2026-01-29 18:25:02.865'),
(76, 111, 3, 1, '2026-01-29 18:25:02.867'),
(77, 112, 3, 1, '2026-01-29 18:25:02.869'),
(78, 113, 3, 1, '2026-01-29 18:25:02.870'),
(79, 114, 3, 1, '2026-01-29 18:25:02.872'),
(80, 115, 3, 1, '2026-01-29 18:25:02.874'),
(81, 116, 3, 1, '2026-01-29 18:25:02.875'),
(82, 117, 3, 1, '2026-01-29 18:25:02.878'),
(83, 118, 3, 1, '2026-01-29 18:25:02.879'),
(84, 119, 3, 1, '2026-01-29 18:25:02.880'),
(85, 120, 3, 1, '2026-01-29 18:25:02.881'),
(86, 121, 3, 1, '2026-01-29 18:25:02.882'),
(87, 122, 3, 1, '2026-01-29 18:25:02.884'),
(88, 123, 3, 1, '2026-01-29 18:25:02.885'),
(89, 124, 3, 1, '2026-01-29 18:25:02.887'),
(90, 125, 3, 1, '2026-01-29 18:25:02.888'),
(91, 126, 3, 1, '2026-01-29 18:25:02.890'),
(92, 127, 3, 1, '2026-01-29 18:25:02.891'),
(93, 128, 3, 1, '2026-01-29 18:25:02.892'),
(94, 129, 3, 1, '2026-01-29 18:25:02.894'),
(95, 130, 3, 1, '2026-01-29 18:25:02.895'),
(96, 131, 3, 1, '2026-01-29 18:25:02.898'),
(97, 132, 3, 1, '2026-01-29 18:25:02.899'),
(98, 133, 3, 1, '2026-01-29 18:25:02.901'),
(99, 134, 3, 1, '2026-01-29 18:25:02.902'),
(100, 135, 3, 1, '2026-01-29 18:25:02.904'),
(101, 136, 3, 1, '2026-01-29 18:25:02.905'),
(102, 137, 3, 1, '2026-01-29 18:25:02.906'),
(103, 138, 3, 1, '2026-01-29 18:25:02.907'),
(104, 139, 3, 1, '2026-01-29 18:25:02.927'),
(105, 140, 3, 1, '2026-01-29 18:25:02.929'),
(106, 141, 3, 1, '2026-01-29 18:25:02.930'),
(107, 142, 3, 1, '2026-01-29 18:25:02.931'),
(108, 143, 3, 1, '2026-01-29 18:25:02.932'),
(109, 144, 3, 1, '2026-01-29 18:25:02.932'),
(110, 145, 3, 1, '2026-01-29 18:25:02.933'),
(111, 146, 3, 1, '2026-01-29 18:25:02.934'),
(112, 147, 3, 1, '2026-01-29 18:25:02.935'),
(113, 148, 3, 1, '2026-01-29 18:25:02.936'),
(114, 149, 3, 1, '2026-01-29 18:25:02.936'),
(115, 150, 3, 1, '2026-01-29 18:25:02.938'),
(116, 151, 3, 1, '2026-01-29 18:25:02.939'),
(117, 152, 3, 1, '2026-01-29 18:25:02.940'),
(118, 153, 3, 1, '2026-01-29 18:25:02.940'),
(119, 154, 3, 1, '2026-01-29 18:25:02.941'),
(120, 155, 3, 1, '2026-01-29 18:25:02.942'),
(121, 156, 3, 1, '2026-01-29 18:25:02.942'),
(122, 157, 3, 1, '2026-01-29 18:25:02.943'),
(123, 158, 3, 1, '2026-01-29 18:25:02.944'),
(124, 159, 3, 1, '2026-01-29 18:25:02.945'),
(125, 160, 3, 1, '2026-01-29 18:25:02.945'),
(126, 161, 3, 1, '2026-01-29 18:25:02.946'),
(127, 162, 3, 1, '2026-01-29 18:25:02.948'),
(128, 163, 3, 1, '2026-01-29 18:25:02.949'),
(129, 164, 3, 1, '2026-01-29 18:25:02.950'),
(130, 165, 3, 1, '2026-01-29 18:25:02.952'),
(131, 166, 3, 1, '2026-01-29 18:25:02.953'),
(132, 167, 3, 1, '2026-01-29 18:25:02.954'),
(133, 168, 3, 1, '2026-01-29 18:25:02.956'),
(134, 169, 3, 1, '2026-01-29 18:25:02.957'),
(135, 170, 3, 1, '2026-01-29 18:25:02.958'),
(136, 171, 3, 1, '2026-01-29 18:25:02.958'),
(137, 172, 3, 1, '2026-01-29 18:25:02.959'),
(138, 173, 3, 1, '2026-01-29 18:25:02.960'),
(139, 174, 3, 1, '2026-01-29 18:25:02.961'),
(140, 175, 3, 1, '2026-01-29 18:25:02.961'),
(141, 176, 3, 1, '2026-01-29 18:25:02.962'),
(142, 177, 3, 1, '2026-01-29 18:25:02.963'),
(143, 178, 3, 1, '2026-01-29 18:25:02.964'),
(144, 179, 3, 1, '2026-01-29 18:25:02.965'),
(145, 180, 3, 1, '2026-01-29 18:25:02.965'),
(146, 181, 3, 1, '2026-01-29 18:25:02.966'),
(147, 182, 3, 1, '2026-01-29 18:25:02.967'),
(148, 183, 3, 1, '2026-01-29 18:25:02.968'),
(149, 184, 3, 1, '2026-01-29 18:25:02.969'),
(150, 185, 3, 1, '2026-01-29 18:25:02.970'),
(151, 186, 3, 1, '2026-01-29 18:25:02.970'),
(152, 187, 3, 1, '2026-01-29 18:25:02.971'),
(153, 188, 3, 1, '2026-01-29 18:25:02.972'),
(154, 189, 3, 1, '2026-01-29 18:25:02.972'),
(155, 190, 3, 1, '2026-01-29 18:25:02.973'),
(156, 191, 3, 1, '2026-01-29 18:25:02.974'),
(157, 192, 3, 1, '2026-01-29 18:25:02.974'),
(158, 193, 3, 1, '2026-01-29 18:25:02.975'),
(159, 194, 3, 1, '2026-01-29 18:25:02.976'),
(160, 195, 3, 1, '2026-01-29 18:25:02.977'),
(161, 196, 3, 1, '2026-01-29 18:25:02.979'),
(162, 197, 3, 1, '2026-01-29 18:25:02.988'),
(163, 198, 3, 1, '2026-01-29 18:25:02.989'),
(164, 199, 3, 1, '2026-01-29 18:25:02.996'),
(165, 200, 3, 1, '2026-01-29 18:25:02.997'),
(166, 201, 3, 1, '2026-01-29 18:25:02.998'),
(167, 202, 3, 1, '2026-01-29 18:25:02.999'),
(168, 203, 3, 1, '2026-01-29 18:25:03.000'),
(169, 204, 3, 1, '2026-01-29 18:25:03.000'),
(170, 205, 3, 1, '2026-01-29 18:25:03.001'),
(171, 206, 3, 1, '2026-01-29 18:25:03.002'),
(172, 207, 3, 1, '2026-01-29 18:25:03.002'),
(173, 208, 3, 1, '2026-01-29 18:25:03.003'),
(174, 209, 3, 1, '2026-01-29 18:25:03.004'),
(175, 210, 3, 1, '2026-01-29 18:25:03.004'),
(176, 211, 3, 1, '2026-01-29 18:25:03.005'),
(177, 212, 3, 1, '2026-01-29 18:25:03.006'),
(178, 213, 3, 1, '2026-01-29 18:25:03.007'),
(179, 214, 3, 1, '2026-01-29 18:25:03.008'),
(180, 215, 3, 1, '2026-01-29 18:25:03.010'),
(181, 216, 3, 1, '2026-01-29 18:25:03.011'),
(182, 217, 3, 1, '2026-01-29 18:25:03.013'),
(183, 218, 3, 1, '2026-01-29 18:25:03.014'),
(184, 219, 3, 1, '2026-01-29 18:25:03.016'),
(185, 220, 3, 1, '2026-01-29 18:25:03.017'),
(186, 221, 3, 1, '2026-01-29 18:25:03.018'),
(187, 222, 3, 1, '2026-01-29 18:25:03.019'),
(188, 223, 3, 1, '2026-01-29 18:25:03.020'),
(189, 224, 3, 1, '2026-01-29 18:25:03.021'),
(190, 225, 3, 1, '2026-01-29 18:25:03.022'),
(191, 226, 3, 1, '2026-01-29 18:25:03.023'),
(192, 227, 3, 1, '2026-01-29 18:25:03.025'),
(193, 228, 3, 1, '2026-01-29 18:25:03.026'),
(194, 229, 3, 1, '2026-01-29 18:25:03.027'),
(195, 230, 3, 1, '2026-01-29 18:25:03.030'),
(196, 231, 3, 1, '2026-01-29 18:25:03.031'),
(197, 232, 3, 1, '2026-01-29 18:25:03.032'),
(198, 233, 3, 1, '2026-01-29 18:25:03.033'),
(199, 234, 3, 1, '2026-01-29 18:25:03.033'),
(200, 235, 3, 1, '2026-01-29 18:25:03.034'),
(201, 236, 3, 1, '2026-01-29 18:25:03.035'),
(202, 237, 3, 1, '2026-01-29 18:25:03.036'),
(203, 238, 3, 1, '2026-01-29 18:25:03.036'),
(204, 239, 3, 1, '2026-01-29 18:25:03.037'),
(205, 240, 3, 1, '2026-01-29 18:25:03.038'),
(206, 241, 3, 1, '2026-01-29 18:25:03.039'),
(207, 242, 3, 1, '2026-01-29 18:25:03.040'),
(208, 243, 3, 1, '2026-01-29 18:25:03.042'),
(209, 244, 3, 1, '2026-01-29 18:25:03.044'),
(210, 245, 3, 1, '2026-01-29 18:25:03.047'),
(211, 246, 3, 1, '2026-01-29 18:25:03.050');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cargo`
--

CREATE TABLE `cargo` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL,
  `setor_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `colaborador`
--

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
(1, 1, 34, 1, 'rhiandark49787@gmail.com'),
(2, 2, 23, 1, 'luanderson.oliveira@somosconexaosocial.org'),
(3, 3, 6, 1, 'heloisa.beatriz@somosconexaosocial.org'),
(4, 4, 14, 1, 'fernanda.andrini@somosconexaosocial.org'),
(5, 5, 14, 1, 'ana.felix@somosconexaosocial.org'),
(6, 6, 14, 1, 'ana.silva@somosconeexaosocial.org'),
(7, 7, 14, 1, 'eduarda.vasconcelos@somosconexaosocial.org'),
(8, 50, 11, 1, 'andreis.santos@somosconexaosocial.org'),
(9, 52, 12, 1, 'jacy.lima@somosconexaosocial.org'),
(10, 54, 24, 1, 'tatiane.silva@somosconexaosocial.org'),
(11, 59, 21, 1, 'arthur.pereira@somosconexaosocial.org'),
(12, 60, 5, 1, 'marilia.eduarda@somosconexaosocial.org'),
(13, 61, 5, 1, 'natalia.silva@somosconexaosocial.org'),
(14, 62, 3, 1, 'ystella.maria@somosconexaosocial.org'),
(15, 64, 27, 1, 'HERNANDES.BORBA@SOMOSCONEXAOSOCIAL.ORG'),
(16, 65, 27, 1, 'alex.silva@somosconexaosocial.org'),
(17, 66, 25, 1, 'leandro.santana@somosconexaosocial.org'),
(18, 67, 28, 1, 'kilma.cabral@somosconexaosocial.org'),
(19, 68, 20, 1, 'vitoria.oliveira@somosconexaosocial.org'),
(20, 69, 23, 1, 'aparicio.luis@somosconexaosocial.org'),
(21, 71, 27, 1, 'marcus.gomes@somosconexaosocial.org'),
(22, 72, 27, 1, 'mendes.neto@somosconexaosocial.org'),
(23, 73, 13, 1, 'jailson.sousa@somosconexaosocial.org'),
(24, 74, 4, 1, 'marcos.paulo@somosconexaosocial.org'),
(25, 76, 7, 1, 'jenifer.farias@somosconexaosocial.org'),
(26, 77, 32, 1, 'ariel.gomes@somosconexaosocial.org'),
(27, 78, 27, 1, 'beatriz.sandra@somosconexaosocial.org'),
(28, 79, 27, 1, 'geovane.lima@somosconexaosocial.org'),
(29, 80, 27, 1, 'irlane.silva@somosconexaosocial.org'),
(30, 81, 30, 1, 'luciene.nascimento@somosconexaosocial.org'),
(31, 82, 8, 1, 'josematheusmatheus23@gmail.com'),
(32, 83, 15, 1, 'thiagomanoel06@gmail.com'),
(33, 84, 10, 1, 'rodolfo.marcio@gmail.com'),
(34, 85, 31, 1, 'vitoria.regia@somosconexaosocial.org'),
(35, 86, 2, 1, 'paulo.santana@somosconexaosocial.org');

-- --------------------------------------------------------

--
-- Estrutura para tabela `contato`
--

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
(1, 1, NULL, 'rhiandark49787@gmail.com'),
(2, 2, NULL, 'luanderson.oliveira@somosconexaosocial.org'),
(3, 3, NULL, 'heloisa.beatriz@somosconexaosocial.org'),
(4, 4, NULL, 'fernanda.andrini@somosconexaosocial.org'),
(5, 5, NULL, 'ana.felix@somosconexaosocial.org'),
(6, 6, NULL, 'ana.silva@somosconeexaosocial.org'),
(7, 7, NULL, 'eduarda.vasconcelos@somosconexaosocial.org'),
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
(44, 44, NULL, 'sem@email.com'),
(45, 45, NULL, 'sem@email.com'),
(46, 46, NULL, 'sem@email.com'),
(47, 47, NULL, 'sem@email.com'),
(48, 48, NULL, 'sem@email.com'),
(49, 49, NULL, 'sem@email.com'),
(50, 50, NULL, 'andreis.santos@somosconexaosocial.org'),
(51, 51, NULL, 'sem@email.com'),
(52, 52, NULL, 'jacy.lima@somosconexaosocial.org'),
(53, 53, NULL, 'sem@email.com'),
(54, 54, NULL, 'tatiane.silva@somosconexaosocial.org'),
(55, 55, NULL, 'sem@email.com'),
(56, 56, NULL, 'sem@email.com'),
(57, 57, NULL, 'sem@email.com'),
(58, 58, NULL, 'sem@email.com'),
(59, 59, NULL, 'arthur.pereira@somosconexaosocial.org'),
(60, 60, NULL, 'marilia.eduarda@somosconexaosocial.org'),
(61, 61, NULL, 'natalia.silva@somosconexaosocial.org'),
(62, 62, NULL, 'ystella.maria@somosconexaosocial.org'),
(63, 63, NULL, 'sem@email.com'),
(64, 64, NULL, 'HERNANDES.BORBA@SOMOSCONEXAOSOCIAL.ORG'),
(65, 65, NULL, 'alex.silva@somosconexaosocial.org'),
(66, 66, NULL, 'leandro.santana@somosconexaosocial.org'),
(67, 67, NULL, 'kilma.cabral@somosconexaosocial.org'),
(68, 68, NULL, 'vitoria.oliveira@somosconexaosocial.org'),
(69, 69, NULL, 'aparicio.luis@somosconexaosocial.org'),
(70, 70, NULL, 'sem@email.com'),
(71, 71, NULL, 'marcus.gomes@somosconexaosocial.org'),
(72, 72, NULL, 'mendes.neto@somosconexaosocial.org'),
(73, 73, NULL, 'jailson.sousa@somosconexaosocial.org'),
(74, 74, NULL, 'marcos.paulo@somosconexaosocial.org'),
(75, 75, NULL, 'sem@email.com'),
(76, 76, NULL, 'jenifer.farias@somosconexaosocial.org'),
(77, 77, NULL, 'ariel.gomes@somosconexaosocial.org'),
(78, 78, NULL, 'beatriz.sandra@somosconexaosocial.org'),
(79, 79, NULL, 'geovane.lima@somosconexaosocial.org'),
(80, 80, NULL, 'irlane.silva@somosconexaosocial.org'),
(81, 81, NULL, 'luciene.nascimento@somosconexaosocial.org'),
(82, 82, NULL, 'josematheusmatheus23@gmail.com'),
(83, 83, NULL, 'thiagomanoel06@gmail.com'),
(84, 84, NULL, 'rodolfo.marcio@gmail.com'),
(85, 85, NULL, 'vitoria.regia@somosconexaosocial.org'),
(86, 86, NULL, 'paulo.santana@somosconexaosocial.org'),
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
(246, 246, NULL, 'sem@email.com');

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplinas`
--

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

CREATE TABLE `escolaridade` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `etnia`
--

CREATE TABLE `etnia` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `frequencias`
--

CREATE TABLE `frequencias` (
  `id` int(11) NOT NULL,
  `aula_id` int(11) NOT NULL,
  `matricula_id` int(11) NOT NULL,
  `status` enum('Presente','Ausente','Justificado') NOT NULL,
  `observacao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `genero`
--

CREATE TABLE `genero` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL,
  `identidade_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `identidade_genero`
--

CREATE TABLE `identidade_genero` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `matriculas`
--

CREATE TABLE `matriculas` (
  `id` int(11) NOT NULL,
  `turma_id` int(11) NOT NULL,
  `beneficiario_id` int(11) NOT NULL,
  `data_matricula` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Ativo','Trancado','Concluido','Desistente') DEFAULT 'Ativo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `orgao_emissor`
--

CREATE TABLE `orgao_emissor` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL,
  `uf_emissor` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `perfil_usuario`
--

CREATE TABLE `perfil_usuario` (
  `id` int(11) NOT NULL,
  `descricao` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pessoa`
--

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
(1, 'RHIAN MAXIMIANO DA SILVA', NULL, NULL, '2008-11-10 00:00:00.000', 'VALDENICE JOSEFA DA SILVA', NULL, '16800374474', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.612'),
(2, 'LUANDERSON ARLINDO DE OLIVEIRA', NULL, NULL, '2003-06-27 00:00:00.000', 'SILVANIA JOSEFA PEREIRA', NULL, '14047504440', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.616'),
(3, 'HELOÍSA BEATRIZ DA SILVA HORA', NULL, NULL, '2001-01-02 00:00:00.000', 'ELIANE MARIA DA SILVA HORA', NULL, '70931193443', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.618'),
(4, 'FERNANDA DA SILVA ANDRINI', NULL, NULL, '1993-04-23 00:00:00.000', 'JOANA ISAURA DA SILVA ANDRINI', NULL, '10585124477', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.619'),
(5, 'ANA BEATRIZ DA SILVA FELIX', NULL, NULL, '2004-07-05 00:00:00.000', 'JOSINEIDE MARIA DA SILVA', NULL, '16662416444', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.621'),
(6, 'ANA PAULA INACIA DA SILVA', NULL, NULL, '1982-05-02 00:00:00.000', 'INACIA MARIA DA SILVA', NULL, '06481848466', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.622'),
(7, 'MARIA EDUARDA RODRIGUES VASCONCELOS', NULL, NULL, '1999-09-02 00:00:00.000', 'CLAUDIA DANIELLA RODRIGUES DA SILVA', NULL, '10814202438', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.624'),
(8, 'LENIRA BARBOSA TORRES', NULL, NULL, '1951-06-06 00:00:00.000', 'MARIA BARBOSA DOS SANTOS', NULL, '38835851491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.625'),
(9, 'JOSEFA MOREIRA PEREIRA DA SILVA', NULL, NULL, '1963-11-20 00:00:00.000', 'IZAURA VICENTE DA SILVA', NULL, '04847124464', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.626'),
(10, 'MANOEL PEREIRA DA SILVA', NULL, NULL, '1960-07-10 00:00:00.000', 'JOSEFA PEREIRA DA SILVA', NULL, '04413386825', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.628'),
(11, 'MARIA JOSÉ DOS SANTOS', NULL, NULL, '1943-01-29 00:00:00.000', 'JOSEFA CARNEIRO DE VASCONCELOS', NULL, '23195614472', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.630'),
(12, 'MARIA DE LOURDES MENDEIROS', NULL, NULL, '1964-06-26 00:00:00.000', 'MARIA JOSÉ DOS SANTOS', NULL, '43749631468', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.631'),
(13, 'FIRMINA MONTEIRO DE MOURA', NULL, NULL, '1962-01-01 00:00:00.000', 'MARILUCIA MONTEIRO DE MOURA', NULL, '37759388420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.633'),
(14, 'MARIA SEVERINA DE LIMA', NULL, NULL, '1951-01-29 00:00:00.000', 'SEVERINA JOSEFA DA CONCEIÇÃO', NULL, '29024129400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.635'),
(15, 'SEVERINA DE FATIMA SOARES', NULL, NULL, '1956-08-06 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '22405631415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.636'),
(16, 'MARIA MARQUES PINHEIRO', NULL, NULL, '1964-04-25 00:00:00.000', 'FRANCISCA JOSEFA DA CONCEIÇÃO', NULL, '58038337468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.638'),
(17, 'MARIA DO CARMO DE LOURDES', NULL, NULL, '1953-02-08 00:00:00.000', 'MARIA DE LOURDES DA CONCEIÇÃO', NULL, '22404503472', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.640'),
(18, 'MARIA DE LOURDES DOS SANTOS', NULL, NULL, '1962-04-14 00:00:00.000', 'SEVERINA URÇULINA DOS SANTOS', NULL, '02093095475', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.641'),
(19, 'MARIA JOSÉ GOMES DE ARAUJO', NULL, NULL, '1961-03-09 00:00:00.000', 'ALZIRA CORREIA DE MELO', NULL, '06164146410', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.642'),
(20, 'JOSEFA SEVERINA DOS SANTOS', NULL, NULL, '1960-12-14 00:00:00.000', 'SEVERINA MARIA DOS SANTOS', NULL, '45041822468', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.643'),
(21, 'JOSEFA ALBERTINA DE SOUZA', NULL, NULL, '1950-02-13 00:00:00.000', 'ALBERTINA FRANCISCA DA SILVA', NULL, '54411319420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.644'),
(22, 'JOANA IRACEMA GOMES DA SILVA', NULL, NULL, '1945-06-24 00:00:00.000', 'IRACEMA MARIA DA SILVA', NULL, '43098509449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.645'),
(23, 'JOSEFA  ALVES DE ALMEIDA CABRAL', NULL, NULL, '1956-02-19 00:00:00.000', 'JOSEFA ALVES DE ALMEIDA', NULL, '28267303472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.648'),
(24, 'ENEDINA JOSÉ LOPES DE VASCONCELOS', NULL, NULL, '1960-03-13 00:00:00.000', 'SEVERINO JOSÉ LOPE', NULL, '97543080478', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.649'),
(25, 'MARIA JOSÉ RAMOS DA SILVA', NULL, NULL, '1955-01-04 00:00:00.000', 'LEONILA MARIA RAMOS', NULL, '40009688404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.651'),
(26, 'SEVERINA MARIA DE ARAÚJO LIMA', NULL, NULL, '1950-11-19 00:00:00.000', 'MARIA STELA DE ARAÚJO', NULL, '28511000410', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.652'),
(27, 'MARIA GLEICE SANTIAGO RIBEIRO', NULL, NULL, '1963-05-03 00:00:00.000', 'RUFINA SEBASTIANA RIBEIRO', NULL, '90994949472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.653'),
(28, 'MARIA IRENE DA SILVA', NULL, NULL, '1964-09-10 00:00:00.000', 'IRENE SEVERINA DA CONCEIÇÃO', NULL, '71591613434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.654'),
(29, 'MARIA  JOSÉ DA CONCEIÇÃO SANTANA', NULL, NULL, '1966-01-08 00:00:00.000', 'MARIA LUZIA DA CONCEIÇÃO', NULL, '50706551400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.656'),
(30, 'MARIA MARQUES DOS SANTOS', NULL, NULL, '1954-12-25 00:00:00.000', 'SEVERINA MARQUES DOS SANTOS', NULL, '26263898895', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.658'),
(31, 'MARIA JOSEFA DOS SANTOS', NULL, NULL, '1958-11-13 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '62419471415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.661'),
(32, 'MARIA JOSÉ DA SILVA MOURA', NULL, NULL, '1959-05-05 00:00:00.000', 'GUILHERMINA INÁCIO DA SILVA', NULL, '39044629468', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.662'),
(33, 'JOSÉ FERNANDES BORBA SOBRINHO', NULL, NULL, '1962-04-26 00:00:00.000', 'MARIA ROSA DO VALE', NULL, '41541537491', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.664'),
(34, 'ODETE SEVERINA DE SANTANA', NULL, NULL, '1955-03-11 00:00:00.000', 'SEVERINA MARIA DE SANTANA', NULL, '71653716487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.665'),
(35, 'SEVERINO RAMOS DOS SANTOS', NULL, NULL, '1964-08-07 00:00:00.000', 'ANGELITA BEZERRA DA SILVA', NULL, '39897834400', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.666'),
(36, 'MARLUCE MARIA PEREIRA', NULL, NULL, '1960-01-01 00:00:00.000', 'COSMA MARIA BATISTA', NULL, '69665443453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.667'),
(37, 'MARIA JOVELINA DA CONCEIÇÃO', NULL, NULL, '1964-05-31 00:00:00.000', 'MARIA JOVELINA DA CONCEIÇÃO', NULL, '03956746465', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-28 18:25:04.668'),
(38, 'SEVERINA MARIA BATISTA DE SOUZA', NULL, NULL, '1957-02-17 00:00:00.000', 'COSMA MARIA BATISTA', NULL, '39754260478', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.669'),
(39, 'SEVERINA GESUINA DA SILVA', NULL, NULL, '1950-08-22 00:00:00.000', 'JOSEFA JESUINA DA CONCEIÇÃO', NULL, '02532400420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.670'),
(40, 'VALDIRA MARIA DA SILVA', NULL, NULL, '1962-01-30 00:00:00.000', 'JOSEFA MARIA DA SILVA', NULL, '32200595468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.670'),
(41, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1961-04-29 00:00:00.000', 'MARIA JOSE DA CONCEIÇÃO', NULL, '74337750487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.671'),
(42, 'SEVERINO FRANCISCO DA CRUZ', NULL, NULL, '1959-05-29 00:00:00.000', 'ALICE FRANCISCA DA CRUZ', NULL, '23552492453', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.672'),
(43, 'MARIA MARINA MONTEIRO', NULL, NULL, '1951-09-14 00:00:00.000', 'MARINA MADALENA DE JESUS', NULL, '40009580468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.673'),
(44, 'SEVERINA TEREZA DE SANTANA', NULL, NULL, '1957-10-18 00:00:00.000', 'SEVERINA TEREZA DE JESUS FILHA', NULL, '66804540425', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.674'),
(45, 'TEREZINHA EVANGELISTA FERREIRA DA SILVA', NULL, NULL, '1956-06-08 00:00:00.000', 'JOSEFA ALEXANDRINA DA CONCEIÇÃO', NULL, '07115574464', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.675'),
(46, 'MARIA ROSA DE BARROS', NULL, NULL, '1944-01-10 00:00:00.000', 'MARIA ROSA DO ESPÍRITO SANTO', NULL, '27086275468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.676'),
(47, 'MARIA DE FÁTIMA SANTOS', NULL, NULL, '1965-05-23 00:00:00.000', 'ROSA SEVERINA DA CONCEIÇÃO', NULL, '51370204434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.677'),
(48, 'BERNADETE IRENE DA HORA', NULL, NULL, '1963-12-10 00:00:00.000', 'IRENE FELISMINA DA HORA', NULL, '42872847472', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-28 18:25:04.690'),
(49, 'IZALTINA MARIA DE ARRUDA', NULL, NULL, '1955-10-20 00:00:00.000', 'MARIA JOSÉ DO NASCIMENTO', NULL, '30005086434', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-28 18:25:04.693'),
(50, 'ANDREIS VICTOR SANTANA DOS SANTOS', NULL, NULL, '1999-12-07 00:00:00.000', 'NORMA SEVERINA DE SANTANA SANTOS', NULL, '11638602476', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.695'),
(51, 'MARIA APARECIDA DE SANTANA HARM', NULL, NULL, '1942-09-10 00:00:00.000', 'ANTÔNIA BARBOSA DE SANTANA', NULL, '80957757468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.697'),
(52, 'JACIEDINA DA SILVA LIMA', NULL, NULL, '1988-07-13 00:00:00.000', 'HENEDINA SANTANA DA SILVA LIMA', NULL, '07196922450', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.699'),
(53, 'LUCIA MARIA DA SILVA', NULL, NULL, '1955-03-21 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '74264591449', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-28 18:25:04.700'),
(54, 'TATIANE MARIA DA SILVA', NULL, NULL, '1989-02-26 00:00:00.000', 'MARIA JOSÉ DE SOUZA', NULL, '01576152430', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.707'),
(55, 'ANTONIO SEVERINO DOS SANTOS', NULL, NULL, '1961-06-13 00:00:00.000', 'REGINA FRANCISCA DA CONCEIÇÃO', NULL, '25395130420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.709'),
(56, 'PETRONILA CANDIDA DE FRANÇA', NULL, NULL, '1951-12-25 00:00:00.000', 'VIRGINIA CANDIDA DE ALMEIDA', NULL, '43884245449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.710'),
(57, 'SEVERINA RODRIGUES DE ALMEIDA', NULL, NULL, '1959-12-28 00:00:00.000', 'SEVERINA RODRIGUES DE ALMEIDA', NULL, '02144942412', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.712'),
(58, 'SEVERINO MANOEL TAVAREZ', NULL, NULL, '1957-01-09 00:00:00.000', 'MARIA VIRGINIA DA CONCEIÇÃO', NULL, '35242515449', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.713'),
(59, 'ARTHUR YURE DOS SANTOS PEREIRA', NULL, NULL, '1995-10-19 00:00:00.000', 'LUCIANAA DOS SANTOS PEREIRA', NULL, '10651073405', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.714'),
(60, 'MARÍLIA EDUARDA DOS SANTOS', NULL, NULL, '1995-03-31 00:00:00.000', 'ALEXSANDRA ENEAS RIBEIRO', NULL, '11704862400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.717'),
(61, 'NATÁLIA ESMERALDA DA SILVA', NULL, NULL, '1988-12-22 00:00:00.000', 'ESMERALDA PAULINA DA SILVA', NULL, '10040744418', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.718'),
(62, 'MARIA YSTELLA AUREA DE LIMA', NULL, NULL, '1993-04-05 00:00:00.000', 'IAURA LUZIA DE BARROS LIMA', NULL, '09718666435', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.720'),
(63, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1955-06-29 00:00:00.000', 'JOSEFA MARIA DA SILVA', NULL, '40008746400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.723'),
(64, 'HERNANDES FERNANDES BORBA', NULL, NULL, '1998-03-27 00:00:00.000', 'DAMIANA MARIA DOS SANTOS BORBA', NULL, '12161301403', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.724'),
(65, 'ALEX JONATA DE SANTANA DA SILVA', NULL, NULL, '1997-05-09 00:00:00.000', 'ROZENILDA MARGARIDA DE SANTANA DA SILVA', NULL, '11441959424', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.725'),
(66, 'LEANDRO INÁCIO DE SANTANA', NULL, NULL, '1992-06-29 00:00:00.000', 'SEVERINA TEREZA DE SANTANA', NULL, '10965054446', NULL, 'BRASIL', 'BRASIL', 8, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.727'),
(67, 'KILMA SUÊNIA MARIA CABRAL', NULL, NULL, '1991-01-23 00:00:00.000', 'MARIA ALVES DA SILVA CABRAL', NULL, '10319960447', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.729'),
(68, 'VITÓRIA SILVA DE OLIVEIRA', NULL, NULL, '2005-09-26 00:00:00.000', 'GIRLEIDE SEVERINA DA SILVA', NULL, '15767716447', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.730'),
(69, 'APARÍCIO LUIS DOS SANTOS', NULL, NULL, '1997-01-29 00:00:00.000', 'MARIA DE FÁTIMA DO ESPÍRITO SANTO', NULL, '11654804410', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.732'),
(70, 'MARIA JOSÉ DE LIMA ALVES', NULL, NULL, '1961-07-15 00:00:00.000', 'SEVERINA MARIA DE LIMA', NULL, '52733882449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.733'),
(71, 'MARCUS GUILHERME ALBUQUERQUE GOMES', NULL, NULL, '2001-12-19 00:00:00.000', 'ANA ALBUQUERQUE DOS SANTOS GOMES', NULL, '14383618405', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.734'),
(72, 'JOSÉ MENDES DA SILVA NETO', NULL, NULL, '1996-06-21 00:00:00.000', 'ROSANA MENDES DA SILVA', NULL, '11739303458', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.736'),
(73, 'JAILSON SOUSA FELIX', NULL, NULL, '1995-04-13 00:00:00.000', 'MARIA MATILDE DE SOUSA', NULL, '12114129462', NULL, 'BRASIL', 'BRASIL', 8, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.737'),
(74, 'MARCO PAULO DA SILVA BARBOSA', NULL, NULL, '1993-01-09 00:00:00.000', 'SEVERINA MARIA DA SILVA', NULL, '11160386412', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.740'),
(75, 'SEBASTIÃO INACIO DA SILVA', NULL, NULL, '1957-10-19 00:00:00.000', 'ELVIRA MARIA DA CONCEIÇÃO', NULL, '17922747420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-28 18:25:04.742'),
(76, 'JÊNIFER DAIANE TOMÉ FARIAS', NULL, NULL, '1998-01-09 00:00:00.000', 'MARIA JOSÉ DA SILVA', NULL, '12372044451', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.744'),
(77, 'LAURA ARIEL GOMES DE LIMA', NULL, NULL, '2002-01-19 00:00:00.000', 'MARIA ALBERTINA GOMES', NULL, '06253327410', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.747'),
(78, 'BEATRIZ SANDRA DA SILVA', NULL, NULL, '2000-05-12 00:00:00.000', 'SANDRA CORREIA DOS SANTOS', NULL, '13030837440', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.750'),
(79, 'GEOVANE DA SILVA LIMA', NULL, NULL, '2001-07-11 00:00:00.000', 'SILVANA MARIA DA SILVA', NULL, '13331805432', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.753'),
(80, 'IRLANE IVANILZA DOS SANTOS SILVA', NULL, NULL, '2002-02-23 00:00:00.000', 'IVANILZA MARIA DOS SANTOS', NULL, '15520883408', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.755'),
(81, 'LUCIENE MARIA DO NASCIMENTO', NULL, NULL, '1982-09-18 00:00:00.000', 'LAUDICEIA MARIA DE LIMA', NULL, '06365605463', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.756'),
(82, 'JOSÉ MATHEUS DA SILVA MOURA', NULL, NULL, '1995-07-12 00:00:00.000', 'MARIA JOSÉ DA SILVA MOURA', NULL, '12253786489', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.758'),
(83, 'THIAGO MANUEL DA SILVA', NULL, NULL, '1998-12-29 00:00:00.000', 'JAQUELINE MONTEIRO DA SILVA', NULL, '14772783466', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.759'),
(84, 'MÁRCIO RODOLFO DE LIMA', NULL, NULL, '1988-10-03 00:00:00.000', 'IAURA LUZIA DE BARROS LIMA', NULL, '08541502422', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.761'),
(85, 'VITÓRIA RÉGIA DE BARROS MONTEIRO', NULL, NULL, '1999-03-14 00:00:00.000', 'MARIA JOSÉ SELMA DE BARROS MONTEIRO', NULL, '11864369485', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.766'),
(86, 'PAULO JOSE DE SANTANA', NULL, NULL, '1982-07-08 00:00:00.000', 'MARIA SEVERINA DE SANTANA', NULL, '04084130427', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-28 18:25:04.768'),
(87, 'VERA LUCIA BARBOSA DE SOUSA MENEZES', NULL, NULL, '1964-08-09 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '03914805455', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.808'),
(88, 'LUZIA MARIA BARBOSA SILVA', NULL, NULL, '1962-10-18 00:00:00.000', 'JOSEFA MARIA BARBOSA', NULL, '58555439434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.824'),
(89, 'JOSÉ LUIZ DE FRANÇA', NULL, NULL, '1956-11-20 00:00:00.000', 'MARIA MARCELINA DE MELO', NULL, '16553233420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.826'),
(90, 'TERESINHA MARINA MONTEIRO DA SILVA', NULL, NULL, '1963-05-13 00:00:00.000', 'MARINA MADALENA  DA CONCEIÇÃO', NULL, '39937232449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.828'),
(91, 'JOSEFA OLIMPIA DA SILVA', NULL, NULL, '1953-09-12 00:00:00.000', 'OLIMPIA MARIA DOS SANTOS', NULL, '02114490408', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.830'),
(92, 'MARIA SEVERINA DE LIMA', NULL, NULL, '1962-02-21 00:00:00.000', 'SEVERINA JOSEFA DA CONCEIÇÃO', NULL, '52573079449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.831'),
(93, 'ROSENILDA AMÉLIA DO NASCIMENTO', NULL, NULL, '1954-12-18 00:00:00.000', 'AMÉLIA COSMA DA SILVA', NULL, '42719933449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.833'),
(94, 'JOSEFA AMELIA SILVA DE SOUSA', NULL, NULL, '1962-10-18 00:00:00.000', 'AMÉLIA COSME DA SILVA', NULL, '71183124449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.835'),
(95, 'JUDITE SEVERINA DE LIMA PEREIRA', NULL, NULL, '1965-05-21 00:00:00.000', 'SEVERINA JOSEFA DA CONCIÇÃO', NULL, '54410924400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.837'),
(96, 'FÁTIMA FRANCISCA DE ALBUQUERQUE', NULL, NULL, '1960-12-01 00:00:00.000', 'REGINA FRANCISCA DE LIMA', NULL, '74264478472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.838'),
(97, 'JOSE FRANCCISCO DE ALBUQUERQUE', NULL, NULL, '1954-07-06 00:00:00.000', 'NOEMIA JULIA DA CONCEIÇÃO', NULL, '04679197803', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.840'),
(98, 'JOSEFA HONORINA DA SILVA', NULL, NULL, '1964-04-03 00:00:00.000', 'HONORINA JULIA DA SILVA', NULL, '40472272420', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.842'),
(99, 'CLEONICE MARIA DA SILVA', NULL, NULL, '1961-07-21 00:00:00.000', 'JULIA MARIA DA CONCEIÇÃO', NULL, '90993306420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.844'),
(100, 'SEVERINA MARIA SOARES BEZERRA', NULL, NULL, '1953-03-29 00:00:00.000', 'SEVERINA MARIA SOARES DA SILVA', NULL, '04418695486', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.846'),
(101, 'SEVERINA GOMES DE LIMA', NULL, NULL, '1953-09-01 00:00:00.000', 'SEVERINA FRANCISCA DA CONCEIÇÃO', NULL, '39389332400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.848'),
(102, 'SEVERINA FRANCISCA DE SOUZA', NULL, NULL, '1961-02-05 00:00:00.000', 'IRACI FRANCISCA DE SOUZA', NULL, '16688064871', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.850'),
(103, 'MARIA DA PAZ CANDIDA DA SILVA', NULL, NULL, '1957-11-09 00:00:00.000', 'JOSEFA CANDIDA DE MENDONÇA', NULL, '74247875434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.851'),
(104, 'MARIA ANTONIA DA SILVA', NULL, NULL, '1964-12-08 00:00:00.000', 'ANA ANTONIA DA CONCEIÇÃO', NULL, '83536019404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.853'),
(105, 'DORALICE GOMES DOS SANTOS', NULL, NULL, '1953-11-13 00:00:00.000', 'JOAQUINA GOMES DOS SANTOS', NULL, '58600582415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.856'),
(106, 'JOSEFA MARIA DA CONCEIÇÃO', NULL, NULL, '1957-03-06 00:00:00.000', 'MARIA JOSÉ DA CONCEIÇÃO', NULL, '83545620425', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.858'),
(107, 'REGINALDO DIAS DOS SANTOS', NULL, NULL, '1961-06-26 00:00:00.000', 'MARIA DO CARMO DOS SANTOS', NULL, '26849020463', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.859'),
(108, 'MARIA JOSÉ DO ESPÍRITO SANTO', NULL, NULL, '1963-09-13 00:00:00.000', 'RITA ROSA DA CONCEIÇÃO', NULL, '71591990491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.861'),
(109, 'MARIA DAS DORES DE SANTANA', NULL, NULL, '1954-01-23 00:00:00.000', 'MAXIMINIA MARIA DA CONCEIÇÃO', NULL, '68872410487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.863'),
(110, 'MARIA JOSÉ DE SANTANA', NULL, NULL, '1965-07-30 00:00:00.000', 'ANIZIA SEVERINA DA CONCEIÇÃO', NULL, '80981348491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.864'),
(111, 'MARIA DULCE DE FREITAS', NULL, NULL, '1955-12-06 00:00:00.000', 'JOSEFA DA CONCEIÇÃO DA SILVA', NULL, '21492018449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.866'),
(112, 'SEVERINA BARBOSA DO REGO', NULL, NULL, '1936-09-27 00:00:00.000', 'APOLINÁRIA BARBOSA DE SOUSA', NULL, '16539656491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.868'),
(113, 'SEVERINA MAXIMIANO BORGES', NULL, NULL, '1954-04-30 00:00:00.000', 'JOSEFA ANA DA CONCEIÇÃO', NULL, '45741930425', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.869'),
(114, 'MARGARIDA MARIA FERREIRA DE LIMA', NULL, NULL, '1951-09-07 00:00:00.000', 'MARIA JOSÉ DE LIMA', NULL, '35888202487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.871'),
(115, 'MARIA LUIZA MARTINS', NULL, NULL, '1944-09-13 00:00:00.000', 'INACIA FRNACISCA DA CONCEIÇÃO', NULL, '73480932487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.873'),
(116, 'MARIA DA CONCEIÇÃO DE SOUZA', NULL, NULL, '1962-02-04 00:00:00.000', 'OLINDINA MARIA DE SOUZA', NULL, '44683014491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.874'),
(117, 'SEVERINO MANOEL DA SILVA', NULL, NULL, '1947-01-04 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '47791250497', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.877'),
(118, 'MARIA BARBOSA NERY', NULL, NULL, '1955-07-22 00:00:00.000', 'PAULA NEUZA PEDROZA', NULL, '46090088404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.879'),
(119, 'SEBASTIANA FELIX DA LUZ', NULL, NULL, '1964-03-15 00:00:00.000', 'SEBASTIANA FELIX DA LUZ', NULL, '04884383494', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.880'),
(120, 'MARIA DE FATIMA DA SILVA', NULL, NULL, '1962-06-07 00:00:00.000', 'SEVERINA BELO DA SILVA', NULL, '46337407415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.881'),
(121, 'DEUZAMAR  SEVERINA DO NASCIMENTO', NULL, NULL, '1963-11-20 00:00:00.000', 'SEVERINA ELVIRA DA CONCEIÇÃO', NULL, '04935522437', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.882'),
(122, 'JOSÉ ANTONIO DOS SANTOS', NULL, NULL, '1944-12-27 00:00:00.000', 'LUZIA SEBASTIANA DA CONCEIÇÃO', NULL, '75677610410', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.883'),
(123, 'SONIA MARIA DA SILVA', NULL, NULL, '1961-06-01 00:00:00.000', 'MARIA FRANCISCA DA SILVA', NULL, '54642000453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.884'),
(124, 'JOSEFA FERREIRA BARBOSA', NULL, NULL, '1952-06-25 00:00:00.000', 'SEVERINA FERREIRA', NULL, '68876556400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.885'),
(125, 'DORALICE FERREIRA VIEIRA LIMA', NULL, NULL, '1964-05-05 00:00:00.000', 'SEVERINA VIEIRA DE LIRA', NULL, '45258112420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.887'),
(126, 'MARIA JOSÉ MARQUES', NULL, NULL, '1964-12-27 00:00:00.000', 'JOSEFA FRANCISCA XAVIER', NULL, '07501090416', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.889'),
(127, 'LUIZA BARBOSA BERNARDO', NULL, NULL, '1940-04-11 00:00:00.000', 'MARIA BARBOSA DA CONEIÇÃO', NULL, '39396746487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.890'),
(128, 'SEVERINA JOSEFA DA SILVA', NULL, NULL, '1947-12-16 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '74338374420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.892'),
(129, 'JOSEFA FERREIRA DA SILVA', NULL, NULL, '1961-05-11 00:00:00.000', 'MARIA JOSÉ BARBOSA', NULL, '71174761415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.893'),
(130, 'JOANA CELESTINA FAUSTINA', NULL, NULL, '1959-06-22 00:00:00.000', 'CELESTINA SEVERINA DA CONCEIÇÃO', NULL, '66804485491', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.894'),
(131, 'JULIA CELESTINA DA CONCEIÇÃO', NULL, NULL, '1955-04-21 00:00:00.000', 'CELESTINA SEVERINA DA CONCEIÇÃO', NULL, '58154604434', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.897'),
(132, 'LUIZA JOSEFA DS CONCEIÇAO', NULL, NULL, '1958-10-08 00:00:00.000', 'JOSEFA SEVRINA DA CONCEIÇÃO', NULL, '74339990434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.898'),
(133, 'SEVERINA MARIA FERREIRA DA SILVA', NULL, NULL, '1962-03-14 00:00:00.000', 'BEATRIZ JOSEFA DA SILVA', NULL, '94849013449', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.900'),
(134, 'MARIA JOSEFA DO NASCIMENTO', NULL, NULL, '1950-01-10 00:00:00.000', 'JOSEFA MARIA DA CONCEÇÃO', NULL, '62428950487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.901'),
(135, 'ROSA PAULINA DA SILVA', NULL, NULL, '1949-11-02 00:00:00.000', 'MARIA ENEDITA DOS SANTOS', NULL, '27815560415', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.904'),
(136, 'SEVERINA MARIA DA SILVA', NULL, NULL, '1947-03-03 00:00:00.000', 'MARIA JOSÉ DOS SANTOS', NULL, '62419382404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.905'),
(137, 'IZABEL MARIA DA SILVA', NULL, NULL, '1957-03-26 00:00:00.000', 'MARIA JOSÉ DO NASCIMENTO', NULL, '04931410499', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.906'),
(138, 'MARIA JOSÉ DE AQUINO E SILVA', NULL, NULL, '1939-08-28 00:00:00.000', 'SEVERINA MARIA DA FONSECA', NULL, '16553160449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.907'),
(139, 'IRENE AUXILIADORA DA SILVA', NULL, NULL, '1942-12-11 00:00:00.000', 'MARIA FRANCISCA DA CONCEIÇÃO', NULL, '72517719420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.909'),
(140, 'ADILENE JULIETA DA SILVA SOUZA', NULL, NULL, '1963-12-27 00:00:00.000', 'JULIETA ANA DA SILVA', NULL, '40010562400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.928'),
(141, 'MARIA SEVERINA DA SILVA SANTOS', NULL, NULL, '1964-05-24 00:00:00.000', 'MARIA SEVERINA DA CONCEIÇÃO', NULL, '83534075404', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.930'),
(142, 'ANTONIA JOVELINA DA SILVA', NULL, NULL, '1962-05-16 00:00:00.000', 'MARIA JOVELINA DA CONCEIÇÃO', NULL, '76401596449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.931'),
(143, 'JOSEFA SEVERINA DA SILVA', NULL, NULL, '1962-05-14 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '90771982453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.931'),
(144, 'JOSE PEREIRA DE MELO', NULL, NULL, '1947-06-12 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '25740547415', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.932'),
(145, 'MARIA JOSEFA DA SILVA', NULL, NULL, '1950-04-10 00:00:00.000', 'JOSEFA SEVERINA DO ESPIRITO SANTO', NULL, '26795469468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.933'),
(146, 'MARIA LOURENÇO DA SILVA', NULL, NULL, '1964-02-26 00:00:00.000', 'SEVERINA LOURENÇO DA SILVA', NULL, '93246404453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.934'),
(147, 'MARINETE FRANCO DE SANTANA', NULL, NULL, '1957-04-24 00:00:00.000', 'ALICE PEREIRA ANICETO', NULL, '68872690404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.934'),
(148, 'JOSEFA MARIA DA SILVA', NULL, NULL, '1954-04-28 00:00:00.000', 'JOSEFA SEVERINA DA CONCEIÇÃO', NULL, '68873069487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.935'),
(149, 'MARIA DE LOURDES DOS SANTOS COELHO', NULL, NULL, '1960-02-16 00:00:00.000', 'ANGELITA BEZERRA DA SILVA', NULL, '39897842420', NULL, 'BRASIL', 'BRASIL', 2, 3, 1, 1, NULL, 1, '2026-01-29 18:25:02.936'),
(150, 'VICENTE JOÃO DE SANTANA', NULL, NULL, '1959-10-15 00:00:00.000', 'JOSEFA  ANA DA CONCEIÇÃO', NULL, '62324098415', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.937'),
(151, 'JOSEFA CARMELITA DA SILVA', NULL, NULL, '1964-06-29 00:00:00.000', 'CARMELITA ROSALINA DE LIRA', NULL, '58601201415', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.938'),
(152, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1951-07-20 00:00:00.000', 'MARIA INÁCIA DA SILVA', NULL, '50705822400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.939'),
(153, 'ANA JOSEFA DA SILVA', NULL, NULL, '1957-12-04 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '03966184486', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.940'),
(154, 'LUZINETE FRANCISCA DE ALBUQUERQUE', NULL, NULL, '1958-03-25 00:00:00.000', 'FRANCISCA ADELINA DA CONCEIÇÃO', NULL, '54853281487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.941'),
(155, 'MARIA OLINDINA DE LIMA', NULL, NULL, '1956-12-24 00:00:00.000', 'OLINDINA MARIA DO CARMO', NULL, '39387720420', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.941'),
(156, 'MARIA GOMES DA PAZ', NULL, NULL, '1955-06-28 00:00:00.000', 'SEVERINA CÉSAR DE LIMA', NULL, '55502776468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.942'),
(157, 'IZABEL MARIA DA CONCEIÇÃO', NULL, NULL, '1953-05-02 00:00:00.000', 'ANTONIA MARIA DA CONCEIÇÃO', NULL, '50706349415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.943'),
(158, 'NEUSA HELENA FERNANDES', NULL, NULL, '1964-02-07 00:00:00.000', 'HELENA DE SANTANA FERNANDES', NULL, '58600400406', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.943'),
(159, 'MARIA JOSÉ DE SOUZA', NULL, NULL, '1963-11-05 00:00:00.000', 'MARGARIDA JOSÉ CIPRIANA', NULL, '73162582415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.944'),
(160, 'MARIA DAMIANA DA SILVA', NULL, NULL, '1964-11-24 00:00:00.000', 'DAMIANA JOSEFINA DA SILVA', NULL, '39387712400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.945'),
(161, 'MARIA RIBEIRO DA SILVA', NULL, NULL, '1960-09-14 00:00:00.000', 'TEREZA SEVERINA DA CONCEIÇÃO', NULL, '75678675400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.945'),
(162, 'ANTONIA MARIA DA SILVA', NULL, NULL, '1954-10-06 00:00:00.000', 'MARIA URBANA DA CONCEIÇÃO', NULL, '83562290497', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.946'),
(163, 'ANA MARIA BARBOSA', NULL, NULL, '1964-11-05 00:00:00.000', 'GERTRUDES MARIA DA CONCEIÇÃO', NULL, '01349867411', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.949'),
(164, 'JOSE MANOEL LINS IRMÃO', NULL, NULL, '1950-05-05 00:00:00.000', 'MARIA PORCINA DA CONCEIÇÃO', NULL, '01126726800', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.950'),
(165, 'EDILEUZA MARIA DE SANTANA NASCIMENTO', NULL, NULL, '1960-10-17 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '52211010415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.951'),
(166, 'LINDALVA CAITANO GOMES', NULL, NULL, '1959-03-05 00:00:00.000', 'ANTONIA MARIA DA CONCEIÇÃO', NULL, '39390179491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.952'),
(167, 'MARIA JOSÉ VALENTIM DA SILVA', NULL, NULL, '1947-01-07 00:00:00.000', 'ANTONIA FRANCISCA DE JESUS', NULL, '07106833835', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.953'),
(168, 'MARIA TEREZA DA SILVA', NULL, NULL, '1957-03-10 00:00:00.000', 'TEREZA DE JESUS DA SILVA', NULL, '83547002400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.955'),
(169, 'EDNALDO SEVERINO RAMOS', NULL, NULL, '1958-06-25 00:00:00.000', 'DIONILA MARIA RAMOS', NULL, '00856180807', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.956'),
(170, 'MARIA JOSÉ ALEXANDRE', NULL, NULL, '1950-07-20 00:00:00.000', 'ANGELITA FRANCISCA DA SILVA', NULL, '45742537468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.957'),
(171, 'MARIA LÍDIA PEREIRA', NULL, NULL, '1963-03-30 00:00:00.000', 'LIDIA SEBASTIANA DE SANTANA', NULL, '83545760430', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.958'),
(172, 'ANTONIO DAMIÃO PEREIRA', NULL, NULL, '1956-10-10 00:00:00.000', 'MARIA JOSÉ DO CARMO', NULL, '57525226415', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.959'),
(173, 'JOSÉ MARTINIANO DE BARROS FILHO', NULL, NULL, '1960-01-28 00:00:00.000', 'MARGARIDA  MARIA DA  ANUNCIAÇÃO', NULL, '28961382420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.960'),
(174, 'SEVERINA ALMEIDA BARBOSA', NULL, NULL, '1964-02-08 00:00:00.000', 'PAULA ALMEIDA PEDROSA', NULL, '43494811415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.960'),
(175, 'MARIA INEZ DE LIMA', NULL, NULL, '1947-10-01 00:00:00.000', 'INÊZ MARIA DE LIMA', NULL, '54642418415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.961'),
(176, 'TEREZINHA MARIA DOS SANTOS', NULL, NULL, '1947-10-23 00:00:00.000', 'MARIA CARMENCITA DA CONCEIÇÃO', NULL, '58039619491', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.962'),
(177, 'ANGELITA INEZ DE LIMA', NULL, NULL, '1966-02-07 00:00:00.000', 'INEZ MARIA DE LIMA', NULL, '81059302420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.963'),
(178, 'JOSEFA EDVETE DE SANTANA', NULL, NULL, '1960-08-01 00:00:00.000', 'ONECINA CÂNDIDA DA CONCEIÇÃO', NULL, '80983367434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.963'),
(179, 'CARMELITA MARIA GONÇALVES', NULL, NULL, '1950-05-04 00:00:00.000', 'MARIA ANTONIA DA CONCEIÇÃO', NULL, '75675617434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.964'),
(180, 'JOSEFA CORREIA DA SILVA', NULL, NULL, '1959-05-28 00:00:00.000', 'ONESCINA CÂNDIDA DA CONCEIÇÃO', NULL, '05168417426', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.965'),
(181, 'ISAURA TINTINO DA SILVA', NULL, NULL, '1955-10-01 00:00:00.000', 'MARIA DE LOURDES DA CONCEIÇÃO E SILVA', NULL, '11762168804', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.966'),
(182, 'MARIA DO SOCORRO SANTINA DA CONCEIÇÃO', NULL, NULL, '1963-09-10 00:00:00.000', 'MARIA SANTINA DA CONCEIÇÃO', NULL, '76399842468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.966'),
(183, 'MANOEL GERONIMO DA SILVA', NULL, NULL, '1959-05-15 00:00:00.000', 'TEREZINHA SEVERINA DA CONCEIÇÃO', NULL, '00755227808', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.968'),
(184, 'NIVALDO SEVERINO GONÇALVES', NULL, NULL, '1951-03-03 00:00:00.000', 'OLINDINA MARIA DO CARMO', NULL, '12819379400', NULL, 'BRASIL', 'BRASIL', 1, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.969'),
(185, 'CREUSA MARIA DA SILVA MELO', NULL, NULL, '1957-07-10 00:00:00.000', 'MARIA JOSE DA SILVA', NULL, '32836660406', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.969'),
(186, 'MARCELO FERREIRA DE MELO', NULL, NULL, '1960-12-02 00:00:00.000', 'JOSEFA FERREIRA MELO', NULL, '39389731453', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.970'),
(187, 'IZABEL LOPES DA SILVA', NULL, NULL, '1962-07-04 00:00:00.000', 'LUIZA LOPES DA SILVA', NULL, '02139284771', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.971'),
(188, 'ANA MARIA DA SILVA', NULL, NULL, '1963-10-03 00:00:00.000', 'MARIA ANA DA SILVA', NULL, '07693223444', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.971'),
(189, 'MARIA DO SOCORRO CORREIA DE MELO E SILVA', NULL, NULL, '1960-09-25 00:00:00.000', 'VALDECI  SEVERINA DO NASCIMENTO', NULL, '39389561434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.972'),
(190, 'MARIA CORREIA DE MELO SOUSA', NULL, NULL, '1956-12-30 00:00:00.000', 'VALDECÍ SEVERINA DO NASCIMENTO', NULL, '19857420478', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.973'),
(191, 'ANA MARIA DA CONCEIÇÃO', NULL, NULL, '1962-07-07 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '44765576434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.973'),
(192, 'HELENA PONCIANO DA CRUZ', NULL, NULL, '1955-06-12 00:00:00.000', 'JOANA MARIA DA CONCEIÇÃO', NULL, '39387518434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.974'),
(193, 'SEVERINA BERTULINA DOS SANTOS', NULL, NULL, '1955-05-25 00:00:00.000', 'BERTULINA ANA DA SILVA', NULL, '01418156809', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.975'),
(194, 'MARIA SEVERINA DOS SANTOS', NULL, NULL, '1963-03-11 00:00:00.000', 'JOSEFA SEVERINA DA CONCEIÇÃO', NULL, '04887882424', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.975'),
(195, 'MARIA DO CARMO MOREIRA DA SILVA', NULL, NULL, '1960-07-15 00:00:00.000', 'EULINA MOREIRA DE MENDONÇA', NULL, '83534121449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.976'),
(196, 'MARIA DAS DORES DA CRUZ SANTOS', NULL, NULL, '1958-10-03 00:00:00.000', 'MARIA JOSÉ DA CRUZ', NULL, '50706861434', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:02.978'),
(197, 'MARIA LÚCIA FERREIRA DA SILVA', NULL, NULL, '1964-12-05 00:00:00.000', 'JULIA FERREIRA DA SILVA', NULL, '90994280491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.983'),
(198, 'JOÃO JOSÉ DOS SANTOS', NULL, NULL, '1964-12-13 00:00:00.000', 'HELENA ANA DA CONCEIÇÃO', NULL, '66770939487', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.989'),
(199, 'IVANISE MARIA DA CONCEIÇÃO BORBA', NULL, NULL, '1951-07-12 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '52122409487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.990'),
(200, 'MARIA DE LOURDES DA CRUZ FARIAS', NULL, NULL, '1958-10-03 00:00:00.000', 'MARIA JOSÉ DA CRUZ', NULL, '74264265487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.997'),
(201, 'MARIA OLINDINA DA SILVA', NULL, NULL, '1961-05-15 00:00:00.000', 'OLINDINA JOSEFA DA CONCEIÇÃO', NULL, '42872057404', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.998'),
(202, 'MARINEUZA VIEIRA DE ALBUQUERQUE', NULL, NULL, '1965-03-17 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '83562206453', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:02.998'),
(203, 'MARIA JOSÉ DA CONCEIÇÃO', NULL, NULL, '1949-11-15 00:00:00.000', 'LAURA MARIA DA CONCEIÇÃO', NULL, '83312951453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:02.999'),
(204, 'MARIA CAETANA SILVA DO NASCIMENTO', NULL, NULL, '1955-04-22 00:00:00.000', 'MARIA CAETANA DA SILVA', NULL, '79507905472', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:03.000'),
(205, 'LINDALVA ANGELITA DA CONCEIÇÃO', NULL, NULL, '1957-12-30 00:00:00.000', 'ANGELITA PAULINA DA CONCEIÇÃO', NULL, '90997573449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.000'),
(206, 'MARIA ROSA DE ARAUJO DA SILVA', NULL, NULL, '1955-08-10 00:00:00.000', 'ROSA MARIA DE AQUINO', NULL, '78044677453', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.001'),
(207, 'IRACI ROSA DA SILVA', NULL, NULL, '1965-09-14 00:00:00.000', 'ROSA MARIANA DA SILVA', NULL, '48477010463', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.002'),
(208, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1954-05-28 00:00:00.000', 'MARIA JOSÉ DA CONCEIÇÃO', NULL, '83562451415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.003'),
(209, 'LUZIA MARIA DE BARROS', NULL, NULL, '1948-12-13 00:00:00.000', 'MARIA JOSÉ DE LIMA', NULL, '26795493415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.003'),
(210, 'ELIONAI DE FREITAS ABUD', NULL, NULL, '1958-06-25 00:00:00.000', 'IRACEMA COSTA DE FREITAS', NULL, '22480978400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.004'),
(211, 'ANA ROSA FERREIRA', NULL, NULL, '1957-04-16 00:00:00.000', 'JOSEFA ROSA DA SILVA', NULL, '79506879400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.005'),
(212, 'TEREZA MARIA DO NASCIMENTO', NULL, NULL, '1955-09-10 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '74337602453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.005'),
(213, 'COSMA SEVERINA BARBOSA DA SILVA', NULL, NULL, '1962-10-01 00:00:00.000', 'SEVERINA JOSEFA BARBOSA', NULL, '06766062452', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:03.006'),
(214, 'INÊZ MARIA DO NASCIMENTO', NULL, NULL, '1945-02-14 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '00893980412', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.007'),
(215, 'JOÃO MARIANO DA SILVA FILHO', NULL, NULL, '1958-12-28 00:00:00.000', 'JULIA MARIA DA SILVA', NULL, '58039325404', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.009'),
(216, 'JOSEFA MARIA DOS SANTOS', NULL, NULL, '1961-05-24 00:00:00.000', 'MARIA MIRANDA TEIXEIRA', NULL, '46064389400', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:03.010'),
(217, 'EZILVA EUGENIA GOMES', NULL, NULL, '1965-04-24 00:00:00.000', 'ZILDA EUGENIA GOMES', NULL, '52572366487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.012'),
(218, 'MARIA DO CARMO DE LIMA FARIAS', NULL, NULL, '1960-04-14 00:00:00.000', 'MARIA ANTONIA DE LIMA', NULL, '40339840463', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.014'),
(219, 'JOSÉ LUCIANO DA CRUZ', NULL, NULL, '1953-01-25 00:00:00.000', 'SEVERINA JOSEFA DA CRUZ', NULL, '58038809491', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.015'),
(220, 'JOSÉ JUSCELINO JOÃO DA SILVA', NULL, NULL, '1956-07-08 00:00:00.000', 'FRANQUILINA MARIA DA SILVA', NULL, '17964997491', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.016'),
(221, 'MARIA DA CONCEIÇÃO GONÇALO', NULL, NULL, '1959-08-19 00:00:00.000', 'DAMIANA MARIA GONÇALO', NULL, '05298635458', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.017'),
(222, 'LAURA MARIA DA CONCEIÇÃO', NULL, NULL, '1954-12-02 00:00:00.000', 'MARIA JOSÉ DA CONCEIÇÃO', NULL, '07407126402', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:03.018'),
(223, 'IVANILDA ALVES FERREIRA SILVA', NULL, NULL, '1964-10-12 00:00:00.000', 'ESMERALDINA ALVES FERREIRA', NULL, '74439286453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.019'),
(224, 'MARIA LÚCIA DA COSTA', NULL, NULL, '1963-10-16 00:00:00.000', 'JOSEFA FERREIRA DA COSTA', NULL, '44744455468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.021'),
(225, 'SEVERINA DA PAZ RIBEIRO', NULL, NULL, '1949-09-26 00:00:00.000', 'MARIA DA PAZ CAVALCANTE', NULL, '90990919404', NULL, 'BRASIL', 'BRASIL', 2, 3, 1, 1, NULL, 1, '2026-01-29 18:25:03.022'),
(226, 'MARIA DE FÁTIMA DE SANTANA', NULL, NULL, '1963-05-07 00:00:00.000', 'LETÍCIA MARIA DA CONCEIÇÃO', NULL, '96242442434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.023'),
(227, 'MARGARIDA ISABEL DA SILVA', NULL, NULL, '1951-10-09 00:00:00.000', 'SEVERINA MARIA DA SILVA', NULL, '79506801487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.024'),
(228, 'TERESA ISABEL RAMOS', NULL, NULL, '1957-04-05 00:00:00.000', 'SEVERINA MARIA DA SILVA', NULL, '08980966423', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.025'),
(229, 'JOSEFA RAMOS DE LIMA', NULL, NULL, '1961-06-02 00:00:00.000', 'JOSEFA MARIA DE SANTANA', NULL, '73237558400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.027'),
(230, 'LUZINETE MARIA DE LUNA FERREIRA', NULL, NULL, '1959-11-09 00:00:00.000', 'MARIA ANTONIA DA CONCEIÇÃO', NULL, '11110755490', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.028'),
(231, 'LENICE MARIA DE BARROS', NULL, NULL, '1963-11-10 00:00:00.000', 'MARIA ALMEIDA DA SILVA', NULL, '73237299472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.030'),
(232, 'LUCIA MARIA DE ANDRADE', NULL, NULL, '1957-05-28 00:00:00.000', 'MARIA LUIZA DA CONCEIÇÃO', NULL, '37233483434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.031'),
(233, 'JOÃO JOSÉ BEZERRA', NULL, NULL, '1954-05-25 00:00:00.000', 'JOSEFA ANTONIA BEZERRA', NULL, '33446288449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.032'),
(234, 'TEREZA MARIA DA SILVA', NULL, NULL, '1954-02-01 00:00:00.000', 'MARIA LUIZA DA CONCEIÇÃO', NULL, '07832347406', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.033'),
(235, 'MARIA SEVERINA DE SOUZA', NULL, NULL, '1952-09-22 00:00:00.000', 'SEVERINA JÚLIA DE SOUZA', NULL, '07017803477', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:03.034'),
(236, 'DAMIANA MARIA DOS SANTOS BORBA', NULL, NULL, '1964-09-05 00:00:00.000', 'MARIA JOSÉ DA SILVA', NULL, '74262513491', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.034'),
(237, 'MARIA DAS DORES DE ARAUJO', NULL, NULL, '1964-10-03 00:00:00.000', 'MARIA MADALENA DA CONCEIÇÃO OLIVEIRA', NULL, '43258700400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.035'),
(238, 'MARIA CECÍLIA DE MELO E SILVA', NULL, NULL, '1953-10-20 00:00:00.000', 'CECÍLIA JOSEFA DA CONCEIÇÃO', NULL, '74263854420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.036'),
(239, 'MARIA JOSÉ DE ALBURQUERQUE', NULL, NULL, '1960-10-08 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '03038417459', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.037'),
(240, 'MANOEL  FERNANDES BORBA', NULL, NULL, '1952-03-04 00:00:00.000', 'DONZÍLIA PETRONILA DE SOUSA', NULL, '18759580453', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.038'),
(241, 'JOANA MARIA DE ALBUQUERQUE', NULL, NULL, '1951-07-10 00:00:00.000', 'MARIA LUIZ DOS SANTOS', NULL, '74262505472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.038'),
(242, 'MARIA ARCELINA DA CONCEIÇÃO', NULL, NULL, '1952-08-24 00:00:00.000', 'ARCELINA MARIA DA CONCEIÇÃO', NULL, '83562281404', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.039'),
(243, 'MARIA OTACILIA DA CONCEIÇÃO SILVA', NULL, NULL, '1951-06-03 00:00:00.000', 'OTACILIA SEVERINA DA CONCEIÇÃO', NULL, '78103657468', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:03.041'),
(244, 'TEREZA CORREIA DE SOUZA', NULL, NULL, '1959-04-16 00:00:00.000', 'VALDECI SEVERINA DO NASCIMENTO', NULL, '36659592415', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-01-29 18:25:03.043'),
(245, 'GERALDA JOSEFA DA SILVA', NULL, NULL, '1959-11-09 00:00:00.000', 'JOSEFA SEVERINA DA SILVA', NULL, '79507751491', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-01-29 18:25:03.045'),
(246, 'VERA LUCIA DA SILVA SANTANA PESSOA', NULL, NULL, '1966-01-14 00:00:00.000', 'BEATRIZ DA SILVA SANTANA', NULL, '49320769400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-01-29 18:25:03.049');

-- --------------------------------------------------------

--
-- Estrutura para tabela `processo_inscricao`
--

CREATE TABLE `processo_inscricao` (
  `id` int(11) NOT NULL,
  `id_projeto` int(11) DEFAULT NULL,
  `titulo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `projeto`
--

CREATE TABLE `projeto` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `status` enum('planejado','ativo','finalizado') DEFAULT 'ativo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `setor`
--

CREATE TABLE `setor` (
  `id` int(11) NOT NULL,
  `nome` varchar(191) NOT NULL,
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_documento`
--

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

-- --------------------------------------------------------

--
-- Estrutura para tabela `turma_professores`
--

CREATE TABLE `turma_professores` (
  `id` int(11) NOT NULL,
  `turma_id` int(11) NOT NULL,
  `colaborador_id` int(11) NOT NULL,
  `disciplina_id` int(11) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `id_colaborador` int(11) NOT NULL,
  `id_perfil_usuario` int(11) NOT NULL,
  `login` varchar(191) NOT NULL,
  `senha` varchar(191) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`id`, `id_colaborador`, `id_perfil_usuario`, `login`, `senha`, `status`) VALUES
(1, 1, 6, '16800374474', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(2, 2, 6, '14047504440', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(3, 3, 6, '70931193443', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(4, 4, 6, '10585124477', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(5, 5, 6, '16662416444', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(6, 6, 6, '06481848466', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(7, 7, 6, '10814202438', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(8, 8, 6, '11638602476', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(9, 9, 6, '07196922450', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(10, 10, 6, '01576152430', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(11, 11, 6, '10651073405', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(12, 12, 6, '11704862400', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(13, 13, 6, '10040744418', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(14, 14, 6, '09718666435', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(15, 15, 6, '12161301403', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(16, 16, 6, '11441959424', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(17, 17, 6, '10965054446', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(18, 18, 6, '10319960447', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(19, 19, 6, '15767716447', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(20, 20, 6, '11654804410', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(21, 21, 6, '14383618405', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(22, 22, 6, '11739303458', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(23, 23, 6, '12114129462', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(24, 24, 6, '11160386412', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(25, 25, 6, '12372044451', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(26, 26, 6, '06253327410', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(27, 27, 6, '13030837440', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(28, 28, 6, '13331805432', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(29, 29, 6, '15520883408', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(30, 30, 6, '06365605463', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(31, 31, 6, '12253786489', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(32, 32, 6, '14772783466', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(33, 33, 6, '08541502422', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(34, 34, 6, '11864369485', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1),
(35, 35, 6, '04084130427', '$2b$10$naDMvm5M7NVIxt6sDtpAi.0uwmVpvvJKLGdcwzUDTunu/flYK8d82', 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Beneficiario`
--
ALTER TABLE `Beneficiario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT de tabela `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `colaborador`
--
ALTER TABLE `colaborador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de tabela `contato`
--
ALTER TABLE `contato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `etnia`
--
ALTER TABLE `etnia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `frequencias`
--
ALTER TABLE `frequencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `genero`
--
ALTER TABLE `genero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `identidade_genero`
--
ALTER TABLE `identidade_genero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `matriculas`
--
ALTER TABLE `matriculas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `orgao_emissor`
--
ALTER TABLE `orgao_emissor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `perfil_usuario`
--
ALTER TABLE `perfil_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pessoa`
--
ALTER TABLE `pessoa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT de tabela `processo_inscricao`
--
ALTER TABLE `processo_inscricao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `projeto`
--
ALTER TABLE `projeto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `setor`
--
ALTER TABLE `setor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `turmas`
--
ALTER TABLE `turmas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `turma_professores`
--
ALTER TABLE `turma_professores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- 1. Tabelas Básicas de Pessoa (Sem dependências)
INSERT INTO `etnia` (`id`, `descricao`) VALUES
(1, 'Branca'), (2, 'Preta'), (3, 'Amarela'), (4, 'Parda'), (5, 'Indígena');

INSERT INTO `escolaridade` (`id`, `descricao`) VALUES
(1, 'Não-alfabetizado'), (2, 'Fundamental incompleto'), (3, 'Fundamental completo'),
(4, 'Médio incompleto'), (5, 'Médio completo'), (6, 'Superior incompleto'),
(7, 'Superior completo'), (8, 'Pós-graduação');

INSERT INTO `identidade_genero` (`id`, `descricao`) VALUES
(1, 'Cisgênero'), (2, 'Transgênero'), (3, 'Não-binário'), (4, 'Prefere não informar');

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
(1, 'Administrador'), (2, 'Coordenador'), (3, 'Colaborador'),
(4, 'Estagiário'), (5, 'Visualizador'), (6, 'Professor');

-- 2. Gênero (Depende de identidade_genero)
INSERT INTO `genero` (`id`, `descricao`, `identidade_id`) VALUES
(1, 'Homem', 1), (2, 'Mulher', 1), (3, 'Homem Trans', 2),
(4, 'Mulher Trans', 2), (5, 'Não Binário', 3), (6, 'Gênero Fluido', 3),
(7, 'Agênero', 3), (8, 'Prefere não informar', 4);

-- 3. Setor (Dependência do Cargo)
INSERT INTO `setor` (`id`, `nome`, `status`) VALUES
(1, 'Coordenação Executiva',  1),
(2, 'Coordenação de Projetos',  1),
(3, 'Coordenação Financeira',  1),
(4, 'Nutrição',  1),
(5, 'Administrativo',  1),
(6, 'Pedagógico', 1),
(7, 'Comunicação',  1),
(8, 'Repografia',  1),
(9, 'Monitoramento',  1),
(10, 'Tecnologia',  1),
(11, 'Multidisciplinar',  1),
(12, 'Esportes',  1),
(13, 'Recepção',  1),
(14, 'Transporte',  1),
(15, 'Alimentação',  1),
(16, 'Agrícola', 1),
(17, 'Voluntários',  1),
(18, 'Estagiários', 1);

-- 4. Cargo (Depende do Setor) - CRUCIAL PARA PROFESSORES
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
