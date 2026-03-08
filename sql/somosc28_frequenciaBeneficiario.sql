-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 08/03/2026 às 17:45
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
  `titulo_aula` varchar(255) NOT NULL,
  `data_aula` date NOT NULL,
  `conteudo` text,
  `numero_aulas` int(11) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `aulas`
--

INSERT INTO `aulas` (`id`, `turma_id`, `colaborador_id`, `titulo_aula`, `data_aula`, `conteudo`, `numero_aulas`, `created_at`) VALUES
(12, 22, 19, 'Aula 1 - mundo digital', '2026-03-02', 'Podemos aumentar o tamanho da div a qual esta todos elementos, mes, relatorio, plano e feedback para um espaçamento ', 1, '2026-03-02 22:44:26');

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
(1, 7, 1, 1, '2026-02-26 12:56:08.549'),
(2, 8, 1, 1, '2026-02-26 12:56:08.551'),
(3, 9, 1, 1, '2026-02-26 12:56:08.552'),
(4, 10, 1, 1, '2026-02-26 12:56:08.553'),
(5, 11, 1, 1, '2026-02-26 12:56:08.554'),
(6, 12, 1, 1, '2026-02-26 12:56:08.554'),
(7, 13, 1, 1, '2026-02-26 12:56:08.556'),
(8, 14, 1, 1, '2026-02-26 12:56:08.556'),
(9, 15, 1, 1, '2026-02-26 12:56:08.557'),
(10, 16, 1, 1, '2026-02-26 12:56:08.557'),
(11, 17, 1, 1, '2026-02-26 12:56:08.558'),
(12, 18, 1, 1, '2026-02-26 12:56:08.558'),
(13, 19, 1, 1, '2026-02-26 12:56:08.559'),
(14, 20, 1, 1, '2026-02-26 12:56:08.559'),
(15, 21, 1, 1, '2026-02-26 12:56:08.560'),
(16, 22, 1, 1, '2026-02-26 12:56:08.560'),
(17, 23, 1, 1, '2026-02-26 12:56:08.561'),
(18, 24, 1, 1, '2026-02-26 12:56:08.561'),
(19, 25, 1, 1, '2026-02-26 12:56:08.562'),
(20, 26, 1, 1, '2026-02-26 12:56:08.562'),
(21, 27, 1, 1, '2026-02-26 12:56:08.563'),
(22, 28, 1, 1, '2026-02-26 12:56:08.563'),
(23, 29, 1, 1, '2026-02-26 12:56:08.564'),
(24, 30, 1, 1, '2026-02-26 12:56:08.565'),
(25, 31, 1, 1, '2026-02-26 12:56:08.565'),
(26, 32, 1, 1, '2026-02-26 12:56:08.566'),
(27, 33, 1, 1, '2026-02-26 12:56:08.566'),
(28, 34, 1, 1, '2026-02-26 12:56:08.567'),
(29, 35, 1, 1, '2026-02-26 12:56:08.567'),
(30, 36, 1, 1, '2026-02-26 12:56:08.568'),
(31, 37, 1, 1, '2026-02-26 12:56:08.568'),
(32, 38, 1, 1, '2026-02-26 12:56:08.568'),
(33, 39, 1, 1, '2026-02-26 12:56:08.569'),
(34, 40, 1, 1, '2026-02-26 12:56:08.569'),
(35, 41, 1, 1, '2026-02-26 12:56:08.570'),
(36, 42, 1, 1, '2026-02-26 12:56:08.570'),
(37, 43, 1, 1, '2026-02-26 12:56:08.570'),
(38, 44, 1, 1, '2026-02-26 12:56:08.571'),
(39, 45, 1, 1, '2026-02-26 12:56:08.571'),
(40, 46, 1, 1, '2026-02-26 12:56:08.572'),
(41, 47, 3, 1, '2026-02-26 12:56:08.573'),
(42, 48, 1, 1, '2026-02-26 12:56:08.573'),
(43, 50, 1, 1, '2026-02-26 12:56:08.575'),
(44, 52, 1, 1, '2026-02-26 12:56:08.576'),
(45, 54, 1, 1, '2026-02-26 12:56:08.578'),
(46, 55, 1, 1, '2026-02-26 12:56:08.578'),
(47, 56, 1, 1, '2026-02-26 12:56:08.579'),
(48, 57, 1, 1, '2026-02-26 12:56:08.579'),
(49, 62, 1, 1, '2026-02-26 12:56:08.584'),
(50, 65, 1, 1, '2026-02-26 12:56:08.587'),
(51, 66, 1, 1, '2026-02-26 12:56:08.588'),
(52, 67, 3, 1, '2026-02-26 12:56:08.588'),
(53, 69, 3, 1, '2026-02-26 12:56:08.589'),
(54, 70, 3, 1, '2026-02-26 12:56:08.590'),
(55, 71, 3, 1, '2026-02-26 12:56:08.590'),
(56, 72, 3, 1, '2026-02-26 12:56:08.590'),
(57, 73, 3, 1, '2026-02-26 12:56:08.591'),
(58, 74, 3, 1, '2026-02-26 12:56:08.591'),
(59, 75, 3, 1, '2026-02-26 12:56:08.592'),
(60, 76, 3, 1, '2026-02-26 12:56:08.592'),
(61, 77, 3, 1, '2026-02-26 12:56:08.593'),
(62, 78, 3, 1, '2026-02-26 12:56:08.594'),
(63, 79, 3, 1, '2026-02-26 12:56:08.594'),
(64, 80, 3, 1, '2026-02-26 12:56:08.595'),
(65, 81, 3, 1, '2026-02-26 12:56:08.596'),
(66, 82, 3, 1, '2026-02-26 12:56:08.597'),
(67, 83, 3, 1, '2026-02-26 12:56:08.597'),
(68, 84, 3, 1, '2026-02-26 12:56:08.598'),
(69, 85, 3, 1, '2026-02-26 12:56:08.599'),
(70, 86, 3, 1, '2026-02-26 12:56:08.599'),
(71, 87, 3, 1, '2026-02-26 12:56:08.600'),
(72, 88, 3, 1, '2026-02-26 12:56:08.600'),
(73, 89, 3, 1, '2026-02-26 12:56:08.601'),
(74, 90, 3, 1, '2026-02-26 12:56:08.602'),
(75, 91, 3, 1, '2026-02-26 12:56:08.602'),
(76, 92, 3, 1, '2026-02-26 12:56:08.603'),
(77, 93, 3, 1, '2026-02-26 12:56:08.604'),
(78, 94, 3, 1, '2026-02-26 12:56:08.604'),
(79, 95, 3, 1, '2026-02-26 12:56:08.605'),
(80, 96, 3, 1, '2026-02-26 12:56:08.606'),
(81, 97, 3, 1, '2026-02-26 12:56:08.606'),
(82, 98, 3, 1, '2026-02-26 12:56:08.607'),
(83, 99, 3, 1, '2026-02-26 12:56:08.608'),
(84, 100, 3, 1, '2026-02-26 12:56:08.609'),
(85, 101, 3, 1, '2026-02-26 12:56:08.610'),
(86, 102, 3, 1, '2026-02-26 12:56:08.610'),
(87, 103, 3, 1, '2026-02-26 12:56:08.611'),
(88, 104, 3, 1, '2026-02-26 12:56:08.611'),
(89, 105, 3, 1, '2026-02-26 12:56:08.612'),
(90, 106, 3, 1, '2026-02-26 12:56:08.613'),
(91, 107, 3, 1, '2026-02-26 12:56:08.613'),
(92, 108, 3, 1, '2026-02-26 12:56:08.614'),
(93, 109, 3, 1, '2026-02-26 12:56:08.615'),
(94, 110, 3, 1, '2026-02-26 12:56:08.615'),
(95, 111, 3, 1, '2026-02-26 12:56:08.616'),
(96, 112, 3, 1, '2026-02-26 12:56:08.617'),
(97, 113, 3, 1, '2026-02-26 12:56:08.626'),
(98, 114, 3, 1, '2026-02-26 12:56:08.627'),
(99, 115, 3, 1, '2026-02-26 12:56:08.628'),
(100, 116, 3, 1, '2026-02-26 12:56:08.628'),
(101, 117, 3, 1, '2026-02-26 12:56:08.630'),
(102, 118, 3, 1, '2026-02-26 12:56:08.630'),
(103, 119, 3, 1, '2026-02-26 12:56:08.631'),
(104, 120, 3, 1, '2026-02-26 12:56:08.631'),
(105, 121, 3, 1, '2026-02-26 12:56:08.632'),
(106, 122, 3, 1, '2026-02-26 12:56:08.632'),
(107, 123, 3, 1, '2026-02-26 12:56:08.633'),
(108, 124, 3, 1, '2026-02-26 12:56:08.633'),
(109, 125, 3, 1, '2026-02-26 12:56:08.634'),
(110, 126, 3, 1, '2026-02-26 12:56:08.634'),
(111, 127, 3, 1, '2026-02-26 12:56:08.635'),
(112, 128, 3, 1, '2026-02-26 12:56:08.635'),
(113, 129, 3, 1, '2026-02-26 12:56:08.636'),
(114, 130, 3, 1, '2026-02-26 12:56:08.636'),
(115, 131, 3, 1, '2026-02-26 12:56:08.637'),
(116, 132, 3, 1, '2026-02-26 12:56:08.637'),
(117, 133, 3, 1, '2026-02-26 12:56:08.638'),
(118, 134, 3, 1, '2026-02-26 12:56:08.639'),
(119, 135, 3, 1, '2026-02-26 12:56:08.639'),
(120, 136, 3, 1, '2026-02-26 12:56:08.640'),
(121, 137, 3, 1, '2026-02-26 12:56:08.640'),
(122, 138, 3, 1, '2026-02-26 12:56:08.640'),
(123, 139, 3, 1, '2026-02-26 12:56:08.641'),
(124, 140, 3, 1, '2026-02-26 12:56:08.641'),
(125, 141, 3, 1, '2026-02-26 12:56:08.642'),
(126, 142, 3, 1, '2026-02-26 12:56:08.642'),
(127, 143, 3, 1, '2026-02-26 12:56:08.643'),
(128, 144, 3, 1, '2026-02-26 12:56:08.643'),
(129, 145, 3, 1, '2026-02-26 12:56:08.644'),
(130, 146, 3, 1, '2026-02-26 12:56:08.644'),
(131, 147, 3, 1, '2026-02-26 12:56:08.645'),
(132, 148, 3, 1, '2026-02-26 12:56:08.646'),
(133, 149, 3, 1, '2026-02-26 12:56:08.646'),
(134, 150, 3, 1, '2026-02-26 12:56:08.647'),
(135, 151, 3, 1, '2026-02-26 12:56:08.647'),
(136, 152, 3, 1, '2026-02-26 12:56:08.648'),
(137, 153, 3, 1, '2026-02-26 12:56:08.648'),
(138, 154, 3, 1, '2026-02-26 12:56:08.649'),
(139, 155, 3, 1, '2026-02-26 12:56:08.649'),
(140, 156, 3, 1, '2026-02-26 12:56:08.649'),
(141, 157, 3, 1, '2026-02-26 12:56:08.650'),
(142, 158, 3, 1, '2026-02-26 12:56:08.650'),
(143, 159, 3, 1, '2026-02-26 12:56:08.651'),
(144, 160, 3, 1, '2026-02-26 12:56:08.651'),
(145, 161, 3, 1, '2026-02-26 12:56:08.652'),
(146, 162, 3, 1, '2026-02-26 12:56:08.652'),
(147, 163, 3, 1, '2026-02-26 12:56:08.653'),
(148, 164, 3, 1, '2026-02-26 12:56:08.653'),
(149, 165, 3, 1, '2026-02-26 12:56:08.654'),
(150, 166, 3, 1, '2026-02-26 12:56:08.655'),
(151, 167, 3, 1, '2026-02-26 12:56:08.655'),
(152, 168, 3, 1, '2026-02-26 12:56:08.656'),
(153, 169, 3, 1, '2026-02-26 12:56:08.656'),
(154, 170, 3, 1, '2026-02-26 12:56:08.660'),
(155, 171, 3, 1, '2026-02-26 12:56:08.661'),
(156, 172, 3, 1, '2026-02-26 12:56:08.661'),
(157, 173, 3, 1, '2026-02-26 12:56:08.662'),
(158, 174, 3, 1, '2026-02-26 12:56:08.662'),
(159, 175, 3, 1, '2026-02-26 12:56:08.663'),
(160, 176, 3, 1, '2026-02-26 12:56:08.664'),
(161, 177, 3, 1, '2026-02-26 12:56:08.664'),
(162, 178, 3, 1, '2026-02-26 12:56:08.665'),
(163, 179, 3, 1, '2026-02-26 12:56:08.666'),
(164, 180, 3, 1, '2026-02-26 12:56:08.667'),
(165, 181, 3, 1, '2026-02-26 12:56:08.668'),
(166, 182, 3, 1, '2026-02-26 12:56:08.669'),
(167, 183, 3, 1, '2026-02-26 12:56:08.670'),
(168, 184, 3, 1, '2026-02-26 12:56:08.670'),
(169, 185, 3, 1, '2026-02-26 12:56:08.671'),
(170, 186, 3, 1, '2026-02-26 12:56:08.671'),
(171, 187, 3, 1, '2026-02-26 12:56:08.672'),
(172, 188, 3, 1, '2026-02-26 12:56:08.672'),
(173, 189, 3, 1, '2026-02-26 12:56:08.673'),
(174, 190, 3, 1, '2026-02-26 12:56:08.674'),
(175, 191, 3, 1, '2026-02-26 12:56:08.674'),
(176, 192, 3, 1, '2026-02-26 12:56:08.675'),
(177, 193, 3, 1, '2026-02-26 12:56:08.675'),
(178, 194, 3, 1, '2026-02-26 12:56:08.676'),
(179, 195, 3, 1, '2026-02-26 12:56:08.677'),
(180, 196, 3, 1, '2026-02-26 12:56:08.678'),
(181, 197, 3, 1, '2026-02-26 12:56:08.678'),
(182, 198, 3, 1, '2026-02-26 12:56:08.679'),
(183, 199, 3, 1, '2026-02-26 12:56:08.679'),
(184, 200, 3, 1, '2026-02-26 12:56:08.680'),
(185, 201, 3, 1, '2026-02-26 12:56:08.681'),
(186, 202, 3, 1, '2026-02-26 12:56:08.681'),
(187, 203, 3, 1, '2026-02-26 12:56:08.682'),
(188, 204, 3, 1, '2026-02-26 12:56:08.682'),
(189, 205, 3, 1, '2026-02-26 12:56:08.683'),
(190, 206, 3, 1, '2026-02-26 12:56:08.683'),
(191, 207, 3, 1, '2026-02-26 12:56:08.684'),
(192, 208, 3, 1, '2026-02-26 12:56:08.684'),
(193, 209, 3, 1, '2026-02-26 12:56:08.685'),
(194, 210, 3, 1, '2026-02-26 12:56:08.685'),
(195, 211, 3, 1, '2026-02-26 12:56:08.686'),
(196, 212, 3, 1, '2026-02-26 12:56:08.686'),
(197, 213, 3, 1, '2026-02-26 12:56:08.687'),
(198, 214, 3, 1, '2026-02-26 12:56:08.687'),
(199, 215, 3, 1, '2026-02-26 12:56:08.687'),
(200, 216, 3, 1, '2026-02-26 12:56:08.688'),
(201, 217, 3, 1, '2026-02-26 12:56:08.688'),
(202, 218, 3, 1, '2026-02-26 12:56:08.689'),
(203, 219, 3, 1, '2026-02-26 12:56:08.690'),
(204, 220, 3, 1, '2026-02-26 12:56:08.690'),
(205, 221, 3, 1, '2026-02-26 12:56:08.691'),
(206, 222, 3, 1, '2026-02-26 12:56:08.691'),
(207, 223, 3, 1, '2026-02-26 12:56:08.692'),
(208, 224, 3, 1, '2026-02-26 12:56:08.692'),
(209, 225, 3, 1, '2026-02-26 12:56:08.692'),
(210, 226, 3, 1, '2026-02-26 12:56:08.693'),
(211, 227, 3, 1, '2026-02-26 12:56:08.693'),
(212, 228, 2, 1, '2026-02-26 12:56:08.694'),
(213, 229, 2, 1, '2026-02-26 12:56:08.694'),
(214, 230, 2, 1, '2026-02-26 12:56:08.695'),
(215, 231, 2, 1, '2026-02-26 12:56:08.695'),
(216, 232, 2, 1, '2026-02-26 12:56:08.696'),
(217, 233, 2, 1, '2026-02-26 12:56:08.696'),
(218, 234, 2, 1, '2026-02-26 12:56:08.697'),
(219, 235, 2, 1, '2026-02-26 12:56:08.697'),
(220, 236, 2, 1, '2026-02-26 12:56:08.698'),
(221, 237, 2, 1, '2026-02-26 12:56:08.698'),
(222, 238, 2, 1, '2026-02-26 12:56:08.699'),
(223, 239, 2, 1, '2026-02-26 12:56:08.699'),
(224, 240, 2, 1, '2026-02-26 12:56:08.700'),
(225, 241, 2, 1, '2026-02-26 12:56:08.700'),
(226, 242, 2, 1, '2026-02-26 12:56:08.701'),
(227, 243, 2, 1, '2026-02-26 12:56:08.701'),
(228, 244, 2, 1, '2026-02-26 12:56:08.702'),
(229, 245, 2, 1, '2026-02-26 12:56:08.702'),
(230, 246, 2, 1, '2026-02-26 12:56:08.703'),
(231, 247, 2, 1, '2026-02-26 12:56:08.703'),
(232, 248, 2, 1, '2026-02-26 12:56:08.704'),
(233, 249, 2, 1, '2026-02-26 12:56:08.704'),
(234, 250, 2, 1, '2026-02-26 12:56:08.705'),
(235, 251, 2, 1, '2026-02-26 12:56:08.706'),
(236, 252, 2, 1, '2026-02-26 12:56:08.706'),
(237, 253, 2, 1, '2026-02-26 12:56:08.707'),
(238, 254, 2, 1, '2026-02-26 12:56:08.707'),
(239, 255, 2, 1, '2026-02-26 12:56:08.708'),
(240, 256, 2, 1, '2026-02-26 12:56:08.708'),
(241, 257, 2, 1, '2026-02-26 12:56:08.709'),
(242, 258, 3, 1, '2026-02-26 12:56:08.709'),
(243, 260, 3, 1, '2026-02-26 16:09:02.999'),
(244, 261, 3, 1, '2026-02-26 16:09:03.001'),
(245, 262, 3, 1, '2026-02-26 16:09:03.002'),
(246, 263, 3, 1, '2026-02-26 16:09:03.003'),
(247, 264, 1, 1, '2026-02-26 16:09:03.004'),
(248, 265, 1, 1, '2026-02-26 16:09:03.004'),
(249, 266, 3, 1, '2026-02-26 16:09:03.006'),
(250, 267, 3, 1, '2026-02-26 16:09:03.007'),
(251, 268, 3, 1, '2026-02-26 16:09:03.008'),
(252, 269, 3, 1, '2026-02-26 16:09:03.008'),
(253, 270, 3, 1, '2026-02-26 16:09:03.009'),
(254, 271, 1, 1, '2026-02-26 16:09:03.010'),
(255, 272, 3, 1, '2026-02-26 16:09:03.011'),
(256, 273, 3, 1, '2026-02-26 16:09:03.012'),
(257, 274, 3, 1, '2026-02-26 16:09:03.013'),
(258, 275, 3, 1, '2026-02-26 16:09:03.014'),
(259, 276, 3, 1, '2026-02-26 16:09:03.015'),
(260, 277, 3, 1, '2026-02-26 16:09:03.016'),
(261, 278, 3, 1, '2026-02-26 16:09:03.016'),
(262, 279, 3, 1, '2026-02-26 16:09:03.017'),
(263, 280, 3, 1, '2026-02-26 16:09:03.018'),
(264, 281, 3, 1, '2026-02-26 16:09:03.020'),
(265, 282, 3, 1, '2026-02-26 16:09:03.031'),
(266, 283, 3, 1, '2026-02-26 16:09:03.033'),
(267, 284, 3, 1, '2026-02-26 16:09:03.035'),
(268, 285, 3, 1, '2026-02-26 16:09:03.037'),
(269, 286, 3, 1, '2026-02-26 16:09:03.040'),
(270, 287, 3, 1, '2026-02-26 16:09:03.050'),
(271, 303, 4, 1, '2026-03-05 10:00:02.962'),
(272, 304, 4, 1, '2026-03-05 10:00:02.971'),
(273, 305, 4, 1, '2026-03-05 10:00:02.972'),
(274, 306, 4, 1, '2026-03-05 10:00:02.973'),
(275, 307, 4, 1, '2026-03-05 10:00:02.975'),
(276, 308, 4, 1, '2026-03-05 10:00:02.976'),
(277, 309, 4, 1, '2026-03-05 10:00:02.977'),
(278, 310, 4, 1, '2026-03-05 10:00:02.978'),
(279, 311, 4, 1, '2026-03-05 10:00:02.981'),
(280, 312, 4, 1, '2026-03-05 10:00:02.982'),
(281, 313, 4, 1, '2026-03-05 10:00:02.984'),
(282, 314, 4, 1, '2026-03-05 11:53:55.590'),
(283, 315, 4, 1, '2026-03-05 11:53:55.591'),
(284, 316, 4, 1, '2026-03-05 11:53:55.592'),
(285, 317, 4, 1, '2026-03-05 11:53:55.593'),
(286, 318, 4, 1, '2026-03-05 11:53:55.594'),
(287, 319, 4, 1, '2026-03-05 11:53:55.595'),
(288, 320, 4, 1, '2026-03-05 11:53:55.595'),
(289, 321, 4, 1, '2026-03-05 11:53:55.596'),
(290, 322, 4, 1, '2026-03-05 11:53:55.596'),
(291, 323, 4, 1, '2026-03-05 11:53:55.597'),
(292, 324, 4, 1, '2026-03-05 11:53:55.599'),
(293, 325, 4, 1, '2026-03-05 11:53:55.599'),
(294, 326, 4, 1, '2026-03-05 11:53:55.600'),
(295, 327, 4, 1, '2026-03-05 11:53:55.600'),
(296, 328, 4, 1, '2026-03-05 11:53:55.601'),
(297, 329, 4, 1, '2026-03-05 11:53:55.602'),
(298, 330, 4, 1, '2026-03-05 11:53:55.602'),
(299, 331, 4, 1, '2026-03-05 11:53:55.605'),
(300, 332, 4, 1, '2026-03-05 11:53:55.605'),
(301, 333, 4, 1, '2026-03-05 11:53:55.606'),
(302, 334, 4, 1, '2026-03-05 11:53:55.606'),
(303, 335, 4, 1, '2026-03-05 11:53:55.607'),
(304, 336, 4, 1, '2026-03-05 11:53:55.616'),
(305, 337, 4, 1, '2026-03-05 12:00:02.410'),
(306, 338, 4, 1, '2026-03-05 14:00:03.985'),
(307, 339, 4, 1, '2026-03-05 14:00:03.993'),
(308, 340, 4, 1, '2026-03-05 14:00:03.994'),
(309, 341, 4, 1, '2026-03-05 15:00:02.438'),
(310, 342, 4, 1, '2026-03-05 15:00:02.442'),
(311, 343, 4, 1, '2026-03-05 15:00:02.447'),
(312, 344, 4, 1, '2026-03-05 15:00:02.448'),
(313, 345, 4, 1, '2026-03-05 15:00:02.449'),
(314, 346, 4, 1, '2026-03-05 15:00:02.449'),
(315, 347, 4, 1, '2026-03-05 15:00:02.450'),
(316, 348, 4, 1, '2026-03-05 15:00:02.451'),
(317, 349, 4, 1, '2026-03-05 15:00:02.454'),
(318, 350, 4, 1, '2026-03-05 15:00:02.457'),
(319, 351, 4, 1, '2026-03-05 16:00:02.785');

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
(1, 1, 23, 1, 'luanderson.oliveira@somosconexaosocial.org'),
(2, 2, 6, 1, 'heloisa.beatriz@somosconexaosocial.org'),
(3, 3, 14, 1, 'fernanda.andrini@somosconexaosocial.org'),
(4, 4, 14, 1, 'ana.felix@somosconexaosocial.org'),
(5, 5, 14, 1, 'ana.silva@somosconeexaosocial.org'),
(6, 6, 14, 1, 'eduarda.vasconcelos@somosconexaosocial.org'),
(7, 49, 11, 1, 'andreis.santos@somosconexaosocial.org'),
(8, 51, 12, 1, 'jacy.lima@somosconexaosocial.org'),
(9, 53, 24, 1, 'tatiane.silva@somosconexaosocial.org'),
(10, 58, 21, 1, 'arthur.pereira@somosconexaosocial.org'),
(11, 59, 5, 1, 'marilia.eduarda@somosconexaosocial.org'),
(12, 60, 5, 1, 'natalia.silva@somosconexaosocial.org'),
(13, 61, 3, 1, 'ystella.maria@somosconexaosocial.org'),
(14, 63, 20, 1, 'vitoria.oliveira@somosconexaosocial.org'),
(15, 64, 23, 1, 'aparicio.luis@somosconexaosocial.org'),
(16, 68, 2, 1, 'paulo.santana@somosconexaosocial.org'),
(17, 259, 22, 1, 'wenderson.farias@somosconexaosocial.org'),
(18, 288, 23, 1, 'daniel.neto@somosconexaosocial.org'),
(19, 289, 27, 1, 'geovane.lima@somosconexaosocial.org'),
(20, 290, 27, 1, 'HERNANDES.BORBA@SOMOSCONEXAOSOCIAL.ORG'),
(21, 291, 27, 1, 'alex.silva@somosconexaosocial.org'),
(22, 292, 27, 1, 'marcus.gomes@somosconexaosocial.org'),
(23, 293, 13, 1, 'jailson.sousa@somosconexaosocial.org'),
(24, 294, 32, 1, 'ariel.gomes@somosconexaosocial.org'),
(25, 295, 27, 1, 'beatriz.sandra@somosconexaosocial.org'),
(26, 296, 27, 1, 'irlane.silva@somosconexaosocial.org'),
(27, 297, 31, 1, 'vitoria.regia@somosconexaosocial.org'),
(28, 298, 27, 1, 'vitor.silva@somosconexaosocial.org'),
(29, 299, 5, 1, 'djair.batista@somosconexaosocial.org'),
(30, 300, 25, 1, 'leandro.santana@somosconexaosocial.org'),
(31, 301, 4, 1, 'marcos.paulo@somosconexaosocial.org'),
(32, 302, 7, 1, 'jenifer.farias@somosconexaosocial.org');

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
(1, 1, NULL, 'luanderson.oliveira@somosconexaosocial.org'),
(2, 2, NULL, 'heloisa.beatriz@somosconexaosocial.org'),
(3, 3, NULL, 'fernanda.andrini@somosconexaosocial.org'),
(4, 4, NULL, 'ana.felix@somosconexaosocial.org'),
(5, 5, NULL, 'ana.silva@somosconeexaosocial.org'),
(6, 6, NULL, 'eduarda.vasconcelos@somosconexaosocial.org'),
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
(44, 44, NULL, 'sem@email.com'),
(45, 45, NULL, 'sem@email.com'),
(46, 46, NULL, 'sem@email.com'),
(47, 47, NULL, 'sem@email.com'),
(48, 48, NULL, 'sem@email.com'),
(49, 49, NULL, 'andreis.santos@somosconexaosocial.org'),
(50, 50, NULL, 'sem@email.com'),
(51, 51, NULL, 'jacy.lima@somosconexaosocial.org'),
(52, 52, NULL, 'sem@email.com'),
(53, 53, NULL, 'tatiane.silva@somosconexaosocial.org'),
(54, 54, NULL, 'sem@email.com'),
(55, 55, NULL, 'sem@email.com'),
(56, 56, NULL, 'sem@email.com'),
(57, 57, NULL, 'sem@email.com'),
(58, 58, NULL, 'arthur.pereira@somosconexaosocial.org'),
(59, 59, NULL, 'marilia.eduarda@somosconexaosocial.org'),
(60, 60, NULL, 'natalia.silva@somosconexaosocial.org'),
(61, 61, NULL, 'ystella.maria@somosconexaosocial.org'),
(62, 62, NULL, 'sem@email.com'),
(63, 63, NULL, 'vitoria.oliveira@somosconexaosocial.org'),
(64, 64, NULL, 'aparicio.luis@somosconexaosocial.org'),
(65, 65, NULL, 'sem@email.com'),
(66, 66, NULL, 'sem@email.com'),
(67, 67, NULL, 'sem@email.com'),
(68, 68, NULL, 'paulo.santana@somosconexaosocial.org'),
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
(249, 249, NULL, 'sem@email.com'),
(250, 250, NULL, 'sem@email.com'),
(251, 251, NULL, 'sem@email.com'),
(252, 252, NULL, 'sem@email.com'),
(253, 253, NULL, 'sem@email.com'),
(254, 254, NULL, 'sem@email.com'),
(255, 255, NULL, 'sem@email.com'),
(256, 256, NULL, 'sem@email.com'),
(257, 257, NULL, 'sem@email.com'),
(258, 258, NULL, 'sem@email.com'),
(259, 259, NULL, 'wenderson.farias@somosconexaosocial.org'),
(260, 260, NULL, 'sem@email.com'),
(261, 261, NULL, 'sem@email.com'),
(262, 262, NULL, 'sem@email.com'),
(263, 263, NULL, 'sem@email.com'),
(264, 264, NULL, 'sem@email.com'),
(265, 265, NULL, 'sem@email.com'),
(266, 266, NULL, 'sem@email.com'),
(267, 267, NULL, 'sem@email.com'),
(268, 268, NULL, 'sem@email.com'),
(269, 269, NULL, 'sem@email.com'),
(270, 270, NULL, 'sem@email.com'),
(271, 271, NULL, 'sem@email.com'),
(272, 272, NULL, 'sem@email.com'),
(273, 273, NULL, 'sem@email.com'),
(274, 274, NULL, 'sem@email.com'),
(275, 275, NULL, 'sem@email.com'),
(276, 276, NULL, 'sem@email.com'),
(277, 277, NULL, 'sem@email.com'),
(278, 278, NULL, 'sem@email.com'),
(279, 279, NULL, 'sem@email.com'),
(280, 280, NULL, 'sem@email.com'),
(281, 281, NULL, 'sem@email.com'),
(282, 282, NULL, 'sem@email.com'),
(283, 283, NULL, 'sem@email.com'),
(284, 284, NULL, 'sem@email.com'),
(285, 285, NULL, 'sem@email.com'),
(286, 286, NULL, 'sem@email.com'),
(287, 287, NULL, 'sem@email.com'),
(288, 288, NULL, 'daniel.neto@somosconexaosocial.org'),
(289, 289, NULL, 'geovane.lima@somosconexaosocial.org'),
(290, 290, NULL, 'HERNANDES.BORBA@SOMOSCONEXAOSOCIAL.ORG'),
(291, 291, NULL, 'alex.silva@somosconexaosocial.org'),
(292, 292, NULL, 'marcus.gomes@somosconexaosocial.org'),
(293, 293, NULL, 'jailson.sousa@somosconexaosocial.org'),
(294, 294, NULL, 'ariel.gomes@somosconexaosocial.org'),
(295, 295, NULL, 'beatriz.sandra@somosconexaosocial.org'),
(296, 296, NULL, 'irlane.silva@somosconexaosocial.org'),
(297, 297, NULL, 'vitoria.regia@somosconexaosocial.org'),
(298, 298, NULL, 'vitor.silva@somosconexaosocial.org'),
(299, 299, NULL, 'djair.batista@somosconexaosocial.org'),
(300, 300, NULL, 'leandro.santana@somosconexaosocial.org'),
(301, 301, NULL, 'marcos.paulo@somosconexaosocial.org'),
(302, 302, NULL, 'jenifer.farias@somosconexaosocial.org'),
(303, 303, NULL, 'sem@email.com'),
(304, 304, NULL, 'sem@email.com'),
(305, 305, NULL, 'sem@email.com'),
(306, 306, NULL, 'sem@email.com'),
(307, 307, NULL, 'sem@email.com'),
(308, 308, NULL, 'sem@email.com'),
(309, 309, NULL, 'sem@email.com'),
(310, 310, NULL, 'sem@email.com'),
(311, 311, NULL, 'sem@email.com'),
(312, 312, NULL, 'sem@email.com'),
(313, 313, NULL, 'sem@email.com'),
(314, 314, NULL, 'sem@email.com'),
(315, 315, NULL, 'sem@email.com'),
(316, 316, NULL, 'sem@email.com'),
(317, 317, NULL, 'sem@email.com'),
(318, 318, NULL, 'sem@email.com'),
(319, 319, NULL, 'sem@email.com'),
(320, 320, NULL, 'sem@email.com'),
(321, 321, NULL, 'sem@email.com'),
(322, 322, NULL, 'sem@email.com'),
(323, 323, NULL, 'sem@email.com'),
(324, 324, NULL, 'sem@email.com'),
(325, 325, NULL, 'sem@email.com'),
(326, 326, NULL, 'sem@email.com'),
(327, 327, NULL, 'sem@email.com'),
(328, 328, NULL, 'sem@email.com'),
(329, 329, NULL, 'sem@email.com'),
(330, 330, NULL, 'sem@email.com'),
(331, 331, NULL, 'sem@email.com'),
(332, 332, NULL, 'sem@email.com'),
(333, 333, NULL, 'sem@email.com'),
(334, 334, NULL, 'sem@email.com'),
(335, 335, NULL, 'sem@email.com'),
(336, 336, NULL, 'sem@email.com'),
(337, 337, NULL, 'sem@email.com'),
(338, 338, NULL, 'sem@email.com'),
(339, 339, NULL, 'sem@email.com'),
(340, 340, NULL, 'sem@email.com'),
(341, 341, NULL, 'sem@email.com'),
(342, 342, NULL, 'sem@email.com'),
(343, 343, NULL, 'sem@email.com'),
(344, 344, NULL, 'sem@email.com'),
(345, 345, NULL, 'sem@email.com'),
(346, 346, NULL, 'sem@email.com'),
(347, 347, NULL, 'sem@email.com'),
(348, 348, NULL, 'sem@email.com'),
(349, 349, NULL, 'sem@email.com'),
(350, 350, NULL, 'sem@email.com'),
(351, 351, NULL, 'sem@email.com');

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
-- Estrutura para tabela `fotos_aula`
--

DROP TABLE IF EXISTS `fotos_aula`;
CREATE TABLE `fotos_aula` (
  `id` int(11) NOT NULL,
  `aula_id` int(11) NOT NULL,
  `caminho_foto` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `fotos_aula`
--

INSERT INTO `fotos_aula` (`id`, `aula_id`, `caminho_foto`, `created_at`) VALUES
(6, 12, '/uploads/fotos_frequencia/a35f2023-c906-45c0-8d63-1dead159fa0e.jpg', '2026-03-02 22:44:27');

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
(31, 7, 35, 'Presente', NULL),
(32, 8, 35, 'Presente', NULL),
(33, 9, 35, 'Presente', NULL),
(34, 10, 25, 'Presente', NULL),
(35, 10, 26, 'Presente', NULL),
(36, 10, 27, 'Presente', NULL),
(37, 10, 28, 'Presente', NULL),
(38, 10, 29, 'Presente', NULL),
(39, 10, 30, 'Presente', NULL),
(40, 10, 31, 'Presente', NULL),
(41, 10, 32, 'Presente', NULL),
(42, 10, 33, 'Presente', NULL),
(43, 10, 34, 'Presente', NULL),
(44, 11, 35, 'Presente', NULL);

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
(25, 4, 45, '2026-02-24 10:47:13', 'Ativo'),
(26, 4, 41, '2026-02-24 10:47:13', 'Ativo'),
(27, 4, 17, '2026-02-24 10:47:13', 'Ativo'),
(28, 4, 6, '2026-02-24 10:47:13', 'Ativo'),
(29, 4, 42, '2026-02-24 10:47:13', 'Ativo'),
(30, 4, 15, '2026-02-24 10:47:13', 'Ativo'),
(31, 4, 26, '2026-02-24 10:47:13', 'Ativo'),
(32, 4, 16, '2026-02-24 10:47:13', 'Ativo'),
(33, 4, 14, '2026-02-24 10:47:13', 'Ativo'),
(34, 4, 2, '2026-02-24 10:47:13', 'Ativo'),
(35, 5, 45, '2026-02-24 10:48:37', 'Ativo'),
(36, 9, 2, '2026-02-26 21:03:59', 'Ativo'),
(37, 9, 3, '2026-02-26 21:03:59', 'Ativo'),
(38, 9, 1, '2026-02-26 21:03:59', 'Ativo'),
(39, 9, 5, '2026-02-26 21:03:59', 'Ativo'),
(40, 9, 4, '2026-02-26 21:06:26', 'Ativo'),
(41, 9, 6, '2026-02-26 21:06:26', 'Ativo'),
(42, 9, 7, '2026-02-26 21:06:26', 'Ativo'),
(43, 9, 8, '2026-02-26 21:06:26', 'Ativo'),
(44, 9, 9, '2026-02-26 21:06:26', 'Ativo'),
(45, 9, 10, '2026-02-26 21:06:27', 'Ativo'),
(46, 9, 11, '2026-02-26 21:06:27', 'Ativo'),
(47, 9, 13, '2026-02-26 21:06:27', 'Ativo'),
(48, 9, 12, '2026-02-26 21:06:27', 'Ativo'),
(49, 9, 15, '2026-02-26 21:06:27', 'Ativo'),
(50, 9, 14, '2026-02-26 21:06:27', 'Ativo'),
(51, 9, 17, '2026-02-26 21:06:27', 'Ativo'),
(52, 9, 18, '2026-02-26 21:06:27', 'Ativo'),
(53, 9, 19, '2026-02-26 21:15:25', 'Ativo'),
(54, 9, 16, '2026-02-26 21:19:12', 'Ativo'),
(55, 9, 21, '2026-02-26 21:19:12', 'Ativo'),
(56, 9, 22, '2026-02-26 21:19:12', 'Ativo'),
(57, 9, 20, '2026-02-26 21:19:12', 'Ativo'),
(58, 9, 23, '2026-02-26 21:19:12', 'Ativo'),
(59, 9, 25, '2026-02-26 21:19:12', 'Ativo'),
(60, 9, 26, '2026-02-26 21:19:12', 'Ativo'),
(61, 9, 28, '2026-02-26 21:19:12', 'Ativo'),
(62, 10, 29, '2026-02-26 21:46:15', 'Ativo'),
(63, 10, 27, '2026-02-26 21:46:15', 'Ativo'),
(64, 10, 30, '2026-02-26 21:46:15', 'Ativo'),
(65, 10, 31, '2026-02-26 21:46:15', 'Ativo'),
(66, 10, 32, '2026-02-26 21:46:15', 'Ativo'),
(67, 10, 33, '2026-02-26 21:46:15', 'Ativo'),
(68, 10, 49, '2026-02-26 21:46:15', 'Ativo'),
(69, 10, 37, '2026-02-26 21:46:15', 'Ativo'),
(70, 10, 35, '2026-02-26 21:46:15', 'Ativo'),
(71, 10, 38, '2026-02-26 21:46:15', 'Ativo'),
(72, 10, 36, '2026-02-26 21:46:15', 'Ativo'),
(73, 10, 39, '2026-02-26 21:46:15', 'Ativo'),
(74, 10, 40, '2026-02-26 21:46:15', 'Ativo'),
(75, 10, 42, '2026-02-26 21:46:15', 'Ativo'),
(76, 10, 44, '2026-02-26 21:46:15', 'Ativo'),
(77, 10, 43, '2026-02-26 21:46:15', 'Ativo'),
(78, 10, 46, '2026-02-26 21:46:15', 'Ativo'),
(79, 10, 47, '2026-02-26 21:46:16', 'Ativo'),
(80, 10, 45, '2026-02-26 21:46:16', 'Ativo'),
(81, 10, 48, '2026-02-26 21:46:16', 'Ativo'),
(82, 10, 34, '2026-02-26 21:46:16', 'Ativo'),
(83, 10, 50, '2026-02-26 21:46:16', 'Ativo'),
(84, 10, 51, '2026-02-26 21:46:16', 'Ativo'),
(85, 10, 245, '2026-02-26 21:46:16', 'Desistente'),
(86, 10, 247, '2026-02-26 21:46:16', 'Ativo'),
(87, 10, 248, '2026-02-26 21:46:16', 'Ativo'),
(88, 10, 254, '2026-02-26 21:46:16', 'Ativo'),
(89, 8, 80, '2026-02-26 21:55:43', 'Ativo'),
(90, 8, 93, '2026-02-26 21:55:43', 'Ativo'),
(91, 8, 100, '2026-02-26 21:55:43', 'Ativo'),
(92, 8, 101, '2026-02-26 21:55:43', 'Ativo'),
(93, 8, 105, '2026-02-26 21:55:43', 'Ativo'),
(94, 8, 107, '2026-02-26 21:55:43', 'Ativo'),
(95, 8, 259, '2026-02-26 21:55:43', 'Desistente'),
(96, 8, 109, '2026-02-26 21:55:43', 'Ativo'),
(97, 8, 110, '2026-02-26 21:55:43', 'Ativo'),
(98, 9, 24, '2026-02-27 08:57:49', 'Ativo'),
(99, 8, 112, '2026-02-27 09:02:55', 'Ativo'),
(100, 8, 114, '2026-02-27 09:02:55', 'Ativo'),
(101, 8, 115, '2026-02-27 09:02:55', 'Ativo'),
(102, 8, 118, '2026-02-27 09:02:55', 'Ativo'),
(103, 8, 120, '2026-02-27 09:02:55', 'Ativo'),
(104, 8, 122, '2026-02-27 09:02:55', 'Ativo'),
(105, 8, 123, '2026-02-27 09:02:55', 'Ativo'),
(106, 8, 124, '2026-02-27 09:02:55', 'Ativo'),
(107, 8, 126, '2026-02-27 09:02:55', 'Ativo'),
(108, 8, 127, '2026-02-27 09:02:55', 'Ativo'),
(109, 8, 128, '2026-02-27 09:02:55', 'Ativo'),
(110, 8, 129, '2026-02-27 09:02:55', 'Ativo'),
(111, 8, 130, '2026-02-27 09:02:55', 'Ativo'),
(112, 11, 170, '2026-02-27 09:12:44', 'Ativo'),
(113, 11, 132, '2026-02-27 09:12:44', 'Ativo'),
(114, 11, 143, '2026-02-27 09:12:44', 'Ativo'),
(115, 11, 118, '2026-02-27 09:12:44', 'Ativo'),
(116, 11, 145, '2026-02-27 09:12:44', 'Ativo'),
(117, 11, 148, '2026-02-27 09:12:44', 'Ativo'),
(118, 11, 153, '2026-02-27 09:12:44', 'Ativo'),
(119, 11, 159, '2026-02-27 09:12:44', 'Ativo'),
(120, 11, 164, '2026-02-27 09:12:44', 'Ativo'),
(121, 11, 169, '2026-02-27 09:12:44', 'Ativo'),
(122, 11, 174, '2026-02-27 09:12:44', 'Ativo'),
(123, 11, 189, '2026-02-27 09:12:44', 'Ativo'),
(124, 11, 194, '2026-02-27 09:12:44', 'Ativo'),
(125, 11, 204, '2026-02-27 09:12:44', 'Ativo'),
(126, 11, 205, '2026-02-27 09:12:44', 'Ativo'),
(127, 11, 210, '2026-02-27 09:12:44', 'Ativo'),
(128, 11, 74, '2026-02-27 09:12:44', 'Ativo'),
(129, 11, 190, '2026-02-27 09:12:44', 'Ativo'),
(130, 11, 211, '2026-02-27 09:12:44', 'Ativo'),
(131, 11, 253, '2026-02-27 09:12:44', 'Ativo'),
(132, 11, 251, '2026-02-27 09:12:44', 'Ativo'),
(133, 11, 262, '2026-02-27 09:12:44', 'Ativo'),
(134, 11, 268, '2026-02-27 09:12:44', 'Ativo'),
(135, 12, 52, '2026-02-27 09:26:52', 'Ativo'),
(136, 12, 53, '2026-02-27 09:26:52', 'Ativo'),
(137, 12, 54, '2026-02-27 09:26:52', 'Ativo'),
(138, 12, 55, '2026-02-27 09:26:52', 'Ativo'),
(139, 12, 56, '2026-02-27 09:26:52', 'Ativo'),
(140, 12, 57, '2026-02-27 09:26:52', 'Ativo'),
(141, 12, 58, '2026-02-27 09:26:52', 'Ativo'),
(142, 12, 59, '2026-02-27 09:26:52', 'Ativo'),
(143, 12, 62, '2026-02-27 09:26:52', 'Ativo'),
(144, 12, 60, '2026-02-27 09:26:52', 'Ativo'),
(145, 12, 61, '2026-02-27 09:26:52', 'Ativo'),
(146, 12, 63, '2026-02-27 09:26:52', 'Ativo'),
(147, 12, 64, '2026-02-27 09:26:52', 'Ativo'),
(148, 12, 65, '2026-02-27 09:26:52', 'Ativo'),
(149, 12, 66, '2026-02-27 09:26:52', 'Ativo'),
(150, 12, 67, '2026-02-27 09:26:52', 'Ativo'),
(151, 12, 68, '2026-02-27 09:26:52', 'Ativo'),
(152, 12, 69, '2026-02-27 09:26:52', 'Ativo'),
(153, 12, 70, '2026-02-27 09:26:52', 'Ativo'),
(154, 12, 73, '2026-02-27 09:26:52', 'Ativo'),
(155, 12, 71, '2026-02-27 09:26:52', 'Ativo'),
(156, 12, 72, '2026-02-27 09:26:52', 'Ativo'),
(157, 12, 75, '2026-02-27 09:26:52', 'Ativo'),
(158, 12, 76, '2026-02-27 09:26:52', 'Ativo'),
(159, 12, 77, '2026-02-27 09:26:52', 'Ativo'),
(160, 12, 78, '2026-02-27 09:26:52', 'Ativo'),
(161, 12, 79, '2026-02-27 09:26:52', 'Ativo'),
(162, 12, 82, '2026-02-27 09:26:52', 'Ativo'),
(163, 12, 84, '2026-02-27 09:26:52', 'Ativo'),
(164, 12, 85, '2026-02-27 09:26:52', 'Ativo'),
(165, 13, 86, '2026-02-27 09:38:37', 'Ativo'),
(166, 13, 89, '2026-02-27 09:38:37', 'Ativo'),
(167, 13, 87, '2026-02-27 09:38:37', 'Ativo'),
(168, 13, 88, '2026-02-27 09:38:37', 'Ativo'),
(169, 13, 90, '2026-02-27 09:38:37', 'Ativo'),
(170, 13, 91, '2026-02-27 09:38:37', 'Ativo'),
(171, 13, 92, '2026-02-27 09:38:37', 'Ativo'),
(172, 13, 94, '2026-02-27 09:38:37', 'Ativo'),
(173, 13, 95, '2026-02-27 09:38:37', 'Ativo'),
(174, 13, 97, '2026-02-27 09:38:37', 'Ativo'),
(175, 13, 96, '2026-02-27 09:38:37', 'Ativo'),
(176, 13, 98, '2026-02-27 09:38:37', 'Ativo'),
(177, 13, 99, '2026-02-27 09:38:37', 'Ativo'),
(178, 13, 103, '2026-02-27 09:38:37', 'Ativo'),
(179, 13, 104, '2026-02-27 09:38:37', 'Ativo'),
(180, 13, 106, '2026-02-27 09:38:37', 'Ativo'),
(181, 13, 111, '2026-02-27 09:38:37', 'Ativo'),
(182, 13, 116, '2026-02-27 09:38:37', 'Ativo'),
(183, 13, 119, '2026-02-27 09:38:37', 'Ativo'),
(184, 13, 150, '2026-02-27 09:38:37', 'Ativo'),
(185, 13, 151, '2026-02-27 09:38:37', 'Ativo'),
(186, 13, 184, '2026-02-27 09:38:37', 'Ativo'),
(187, 13, 243, '2026-02-27 09:38:37', 'Ativo'),
(188, 13, 244, '2026-02-27 09:38:37', 'Ativo'),
(189, 13, 260, '2026-02-27 09:38:37', 'Ativo'),
(190, 13, 269, '2026-02-27 09:38:37', 'Ativo'),
(191, 13, 242, '2026-02-27 09:38:54', 'Ativo'),
(192, 14, 156, '2026-02-27 09:49:43', 'Ativo'),
(193, 14, 176, '2026-02-27 09:49:43', 'Ativo'),
(194, 14, 142, '2026-02-27 09:49:43', 'Ativo'),
(195, 14, 178, '2026-02-27 09:49:43', 'Ativo'),
(196, 14, 201, '2026-02-27 09:49:43', 'Ativo'),
(197, 14, 175, '2026-02-27 09:49:43', 'Ativo'),
(198, 14, 182, '2026-02-27 09:49:43', 'Ativo'),
(199, 14, 157, '2026-02-27 09:49:43', 'Ativo'),
(200, 14, 179, '2026-02-27 09:49:43', 'Ativo'),
(201, 14, 146, '2026-02-27 09:49:43', 'Ativo'),
(202, 14, 180, '2026-02-27 09:49:43', 'Ativo'),
(203, 14, 196, '2026-02-27 09:49:43', 'Ativo'),
(204, 14, 197, '2026-02-27 09:49:43', 'Ativo'),
(205, 14, 195, '2026-02-27 09:49:43', 'Ativo'),
(206, 14, 207, '2026-02-27 09:49:43', 'Ativo'),
(207, 14, 83, '2026-02-27 09:49:43', 'Ativo'),
(208, 14, 203, '2026-02-27 09:49:43', 'Ativo'),
(209, 14, 155, '2026-02-27 09:49:43', 'Ativo'),
(210, 14, 81, '2026-02-27 09:49:43', 'Ativo'),
(211, 14, 154, '2026-02-27 09:49:43', 'Ativo'),
(212, 14, 147, '2026-02-27 09:49:43', 'Ativo'),
(213, 14, 121, '2026-02-27 09:49:43', 'Ativo'),
(214, 15, 140, '2026-02-27 09:57:48', 'Ativo'),
(215, 15, 135, '2026-02-27 09:57:48', 'Ativo'),
(216, 15, 162, '2026-02-27 09:57:48', 'Ativo'),
(217, 15, 166, '2026-02-27 09:57:48', 'Ativo'),
(218, 15, 171, '2026-02-27 09:57:48', 'Ativo'),
(219, 15, 200, '2026-02-27 09:57:48', 'Ativo'),
(220, 15, 133, '2026-02-27 09:57:48', 'Ativo'),
(221, 15, 149, '2026-02-27 09:57:48', 'Ativo'),
(222, 15, 81, '2026-02-27 09:57:48', 'Ativo'),
(223, 15, 209, '2026-02-27 09:57:48', 'Ativo'),
(224, 15, 199, '2026-02-27 09:57:48', 'Ativo'),
(225, 15, 177, '2026-02-27 09:57:48', 'Ativo'),
(226, 15, 255, '2026-02-27 09:57:48', 'Ativo'),
(227, 15, 256, '2026-02-27 09:57:48', 'Ativo'),
(228, 15, 257, '2026-02-27 09:57:48', 'Ativo'),
(229, 15, 258, '2026-02-27 09:57:48', 'Ativo'),
(230, 15, 259, '2026-02-27 09:57:48', 'Ativo'),
(231, 15, 263, '2026-02-27 09:57:48', 'Ativo'),
(232, 15, 264, '2026-02-27 09:57:48', 'Ativo'),
(233, 15, 139, '2026-02-27 09:57:48', 'Ativo'),
(234, 8, 108, '2026-02-27 09:58:44', 'Ativo'),
(235, 16, 102, '2026-02-27 10:21:45', 'Ativo'),
(236, 16, 125, '2026-02-27 10:21:45', 'Ativo'),
(237, 16, 134, '2026-02-27 10:21:45', 'Ativo'),
(238, 16, 137, '2026-02-27 10:21:45', 'Ativo'),
(239, 16, 136, '2026-02-27 10:21:45', 'Ativo'),
(240, 16, 138, '2026-02-27 10:21:45', 'Ativo'),
(241, 16, 141, '2026-02-27 10:21:45', 'Ativo'),
(242, 16, 144, '2026-02-27 10:21:45', 'Ativo'),
(243, 16, 158, '2026-02-27 10:21:45', 'Ativo'),
(244, 16, 160, '2026-02-27 10:21:45', 'Ativo'),
(245, 16, 161, '2026-02-27 10:21:45', 'Ativo'),
(246, 16, 163, '2026-02-27 10:21:45', 'Ativo'),
(247, 16, 165, '2026-02-27 10:21:45', 'Ativo'),
(248, 16, 167, '2026-02-27 10:21:45', 'Ativo'),
(249, 16, 168, '2026-02-27 10:21:45', 'Ativo'),
(250, 16, 170, '2026-02-27 10:21:45', 'Ativo'),
(251, 16, 172, '2026-02-27 10:21:45', 'Ativo'),
(252, 16, 181, '2026-02-27 10:21:45', 'Ativo'),
(253, 16, 183, '2026-02-27 10:21:45', 'Ativo'),
(254, 17, 185, '2026-02-27 10:27:36', 'Ativo'),
(255, 17, 186, '2026-02-27 10:27:36', 'Ativo'),
(256, 17, 187, '2026-02-27 10:27:36', 'Ativo'),
(257, 17, 188, '2026-02-27 10:27:36', 'Ativo'),
(258, 17, 191, '2026-02-27 10:27:36', 'Ativo'),
(259, 17, 192, '2026-02-27 10:27:36', 'Ativo'),
(260, 17, 193, '2026-02-27 10:27:36', 'Ativo'),
(261, 17, 198, '2026-02-27 10:27:36', 'Ativo'),
(262, 17, 202, '2026-02-27 10:27:36', 'Ativo'),
(263, 17, 206, '2026-02-27 10:27:36', 'Ativo'),
(264, 17, 208, '2026-02-27 10:27:36', 'Ativo'),
(265, 17, 246, '2026-02-27 10:27:36', 'Ativo'),
(266, 17, 250, '2026-02-27 10:27:36', 'Ativo'),
(267, 17, 252, '2026-02-27 10:27:36', 'Ativo'),
(268, 17, 265, '2026-02-27 10:27:36', 'Ativo'),
(269, 17, 266, '2026-02-27 10:27:36', 'Ativo'),
(270, 17, 113, '2026-02-27 10:27:36', 'Ativo'),
(271, 17, 270, '2026-02-27 10:27:36', 'Ativo'),
(272, 18, 2, '2026-02-27 10:51:25', 'Ativo'),
(273, 18, 3, '2026-02-27 10:51:25', 'Ativo'),
(274, 18, 1, '2026-02-27 10:51:25', 'Ativo'),
(275, 18, 5, '2026-02-27 10:51:25', 'Ativo'),
(276, 18, 4, '2026-02-27 10:51:25', 'Ativo'),
(277, 18, 6, '2026-02-27 10:51:25', 'Ativo'),
(278, 18, 7, '2026-02-27 10:51:25', 'Ativo'),
(279, 18, 8, '2026-02-27 10:51:25', 'Ativo'),
(280, 18, 9, '2026-02-27 10:51:25', 'Ativo'),
(281, 18, 10, '2026-02-27 10:51:25', 'Ativo'),
(282, 18, 11, '2026-02-27 10:51:25', 'Ativo'),
(283, 18, 13, '2026-02-27 10:51:25', 'Ativo'),
(284, 18, 12, '2026-02-27 10:51:25', 'Ativo'),
(285, 18, 15, '2026-02-27 10:51:25', 'Ativo'),
(286, 18, 14, '2026-02-27 10:51:25', 'Ativo'),
(287, 18, 17, '2026-02-27 10:51:25', 'Ativo'),
(288, 18, 18, '2026-02-27 10:51:25', 'Ativo'),
(289, 18, 19, '2026-02-27 10:51:25', 'Ativo'),
(290, 18, 16, '2026-02-27 10:51:25', 'Ativo'),
(291, 18, 21, '2026-02-27 10:51:25', 'Ativo'),
(292, 18, 22, '2026-02-27 10:51:25', 'Ativo'),
(293, 18, 20, '2026-02-27 10:51:25', 'Ativo'),
(294, 18, 23, '2026-02-27 10:51:25', 'Ativo'),
(295, 18, 24, '2026-02-27 10:51:25', 'Ativo'),
(296, 18, 25, '2026-02-27 10:51:25', 'Ativo'),
(297, 18, 26, '2026-02-27 10:51:25', 'Ativo'),
(298, 18, 28, '2026-02-27 10:51:25', 'Ativo'),
(299, 18, 29, '2026-02-27 10:51:25', 'Ativo'),
(300, 18, 27, '2026-02-27 10:51:25', 'Ativo'),
(301, 18, 30, '2026-02-27 10:51:25', 'Ativo'),
(302, 18, 31, '2026-02-27 10:51:25', 'Ativo'),
(303, 18, 32, '2026-02-27 10:51:25', 'Ativo'),
(304, 18, 33, '2026-02-27 10:51:25', 'Ativo'),
(305, 18, 37, '2026-02-27 10:51:25', 'Ativo'),
(306, 18, 35, '2026-02-27 10:51:25', 'Ativo'),
(307, 18, 38, '2026-02-27 10:51:25', 'Ativo'),
(308, 18, 36, '2026-02-27 10:51:25', 'Ativo'),
(309, 18, 39, '2026-02-27 10:51:25', 'Ativo'),
(310, 18, 40, '2026-02-27 10:51:25', 'Ativo'),
(311, 18, 42, '2026-02-27 10:51:25', 'Ativo'),
(312, 18, 44, '2026-02-27 10:51:25', 'Ativo'),
(313, 18, 43, '2026-02-27 10:51:25', 'Ativo'),
(314, 18, 46, '2026-02-27 10:51:25', 'Ativo'),
(315, 18, 47, '2026-02-27 10:51:25', 'Ativo'),
(316, 18, 45, '2026-02-27 10:51:25', 'Ativo'),
(317, 18, 48, '2026-02-27 10:51:25', 'Ativo'),
(318, 18, 50, '2026-02-27 10:51:25', 'Ativo'),
(319, 18, 51, '2026-02-27 10:51:25', 'Ativo'),
(320, 18, 245, '2026-02-27 10:51:25', 'Desistente'),
(321, 18, 247, '2026-02-27 10:51:25', 'Ativo'),
(322, 18, 248, '2026-02-27 10:51:25', 'Ativo'),
(323, 18, 254, '2026-02-27 10:51:25', 'Ativo'),
(324, 19, 2, '2026-02-27 11:29:02', 'Ativo'),
(325, 19, 3, '2026-02-27 11:29:02', 'Ativo'),
(326, 19, 1, '2026-02-27 11:29:02', 'Ativo'),
(327, 19, 5, '2026-02-27 11:29:02', 'Ativo'),
(328, 19, 4, '2026-02-27 11:29:02', 'Ativo'),
(329, 19, 6, '2026-02-27 11:29:02', 'Ativo'),
(330, 19, 7, '2026-02-27 11:29:02', 'Ativo'),
(331, 19, 8, '2026-02-27 11:29:02', 'Ativo'),
(332, 19, 9, '2026-02-27 11:29:02', 'Ativo'),
(333, 19, 10, '2026-02-27 11:29:02', 'Ativo'),
(334, 19, 11, '2026-02-27 11:29:02', 'Ativo'),
(335, 19, 13, '2026-02-27 11:29:02', 'Ativo'),
(336, 19, 12, '2026-02-27 11:29:02', 'Ativo'),
(337, 19, 15, '2026-02-27 11:29:02', 'Ativo'),
(338, 19, 14, '2026-02-27 11:29:02', 'Ativo'),
(339, 19, 17, '2026-02-27 11:29:02', 'Ativo'),
(340, 19, 18, '2026-02-27 11:29:02', 'Ativo'),
(341, 19, 19, '2026-02-27 11:29:02', 'Ativo'),
(342, 19, 16, '2026-02-27 11:29:02', 'Ativo'),
(343, 19, 21, '2026-02-27 11:29:02', 'Ativo'),
(344, 19, 22, '2026-02-27 11:29:02', 'Ativo'),
(345, 19, 20, '2026-02-27 11:29:02', 'Ativo'),
(346, 19, 23, '2026-02-27 11:29:02', 'Ativo'),
(347, 19, 24, '2026-02-27 11:29:02', 'Ativo'),
(348, 19, 25, '2026-02-27 11:29:02', 'Ativo'),
(349, 19, 26, '2026-02-27 11:29:02', 'Ativo'),
(350, 19, 45, '2026-02-27 11:29:02', 'Ativo'),
(351, 19, 37, '2026-02-27 11:29:02', 'Ativo'),
(352, 19, 47, '2026-02-27 11:29:02', 'Ativo'),
(353, 19, 31, '2026-02-27 11:29:02', 'Ativo'),
(354, 19, 32, '2026-02-27 11:29:02', 'Ativo'),
(355, 19, 27, '2026-02-27 11:29:02', 'Ativo'),
(356, 19, 42, '2026-02-27 11:29:02', 'Ativo'),
(357, 19, 44, '2026-02-27 11:29:02', 'Ativo'),
(358, 19, 40, '2026-02-27 11:29:02', 'Ativo'),
(359, 19, 254, '2026-02-27 11:29:02', 'Ativo'),
(360, 19, 247, '2026-02-27 11:29:02', 'Ativo'),
(361, 19, 43, '2026-02-27 11:29:02', 'Ativo'),
(362, 19, 50, '2026-02-27 11:29:02', 'Ativo'),
(363, 19, 34, '2026-02-27 11:29:02', 'Ativo'),
(364, 19, 49, '2026-02-27 11:29:02', 'Ativo'),
(365, 19, 30, '2026-02-27 11:29:02', 'Ativo'),
(366, 19, 33, '2026-02-27 11:29:02', 'Ativo'),
(367, 19, 35, '2026-02-27 11:29:02', 'Ativo'),
(368, 19, 38, '2026-02-27 11:29:02', 'Ativo'),
(369, 19, 36, '2026-02-27 11:29:02', 'Ativo'),
(370, 19, 39, '2026-02-27 11:29:02', 'Ativo'),
(371, 19, 29, '2026-02-27 11:29:02', 'Ativo'),
(372, 19, 46, '2026-02-27 11:29:02', 'Ativo'),
(373, 19, 48, '2026-02-27 11:29:02', 'Ativo'),
(374, 19, 51, '2026-02-27 11:29:02', 'Ativo'),
(375, 19, 245, '2026-02-27 11:29:02', 'Desistente'),
(376, 19, 248, '2026-02-27 11:29:02', 'Ativo'),
(377, 18, 34, '2026-02-27 11:29:23', 'Ativo'),
(378, 18, 49, '2026-02-27 11:29:23', 'Ativo'),
(379, 20, 45, '2026-02-27 11:37:01', 'Ativo'),
(380, 20, 245, '2026-02-27 11:37:01', 'Desistente'),
(381, 20, 17, '2026-02-27 11:37:01', 'Ativo'),
(382, 20, 42, '2026-02-27 11:37:01', 'Ativo'),
(383, 20, 6, '2026-02-27 11:37:01', 'Ativo'),
(384, 20, 15, '2026-02-27 11:37:01', 'Ativo'),
(385, 20, 26, '2026-02-27 11:37:01', 'Ativo'),
(386, 20, 16, '2026-02-27 11:37:01', 'Ativo'),
(387, 20, 14, '2026-02-27 11:37:01', 'Ativo'),
(388, 20, 248, '2026-02-27 11:37:01', 'Ativo'),
(389, 20, 2, '2026-02-27 11:37:01', 'Ativo'),
(390, 20, 13, '2026-02-27 11:37:01', 'Ativo'),
(391, 20, 1, '2026-02-27 11:37:01', 'Ativo'),
(392, 20, 44, '2026-02-27 11:37:01', 'Ativo'),
(393, 20, 3, '2026-02-27 11:37:01', 'Ativo'),
(394, 20, 43, '2026-02-27 11:37:01', 'Ativo'),
(395, 20, 254, '2026-02-27 11:37:01', 'Ativo'),
(396, 20, 247, '2026-02-27 11:37:01', 'Ativo'),
(397, 20, 40, '2026-02-27 11:37:01', 'Ativo'),
(398, 20, 50, '2026-02-27 11:37:01', 'Ativo'),
(399, 20, 25, '2026-02-27 11:37:01', 'Ativo'),
(400, 20, 34, '2026-02-27 11:37:01', 'Ativo'),
(401, 20, 49, '2026-02-27 11:37:01', 'Ativo'),
(402, 20, 22, '2026-02-27 11:37:01', 'Ativo'),
(403, 20, 21, '2026-02-27 11:37:01', 'Ativo'),
(404, 20, 20, '2026-02-27 11:37:01', 'Ativo'),
(405, 20, 10, '2026-02-27 11:37:01', 'Ativo'),
(406, 20, 11, '2026-02-27 11:37:01', 'Ativo'),
(407, 20, 5, '2026-02-27 11:37:01', 'Ativo'),
(408, 20, 7, '2026-02-27 11:37:01', 'Ativo'),
(409, 20, 39, '2026-02-27 11:37:01', 'Ativo'),
(410, 20, 9, '2026-02-27 11:37:01', 'Ativo'),
(411, 20, 23, '2026-02-27 11:37:01', 'Ativo'),
(412, 20, 36, '2026-02-27 11:37:01', 'Ativo'),
(413, 20, 30, '2026-02-27 11:37:01', 'Ativo'),
(414, 20, 24, '2026-02-27 11:37:01', 'Ativo'),
(415, 20, 18, '2026-02-27 11:37:01', 'Ativo'),
(416, 20, 12, '2026-02-27 11:37:01', 'Ativo'),
(417, 20, 4, '2026-02-27 11:37:01', 'Ativo'),
(418, 20, 37, '2026-02-27 11:37:01', 'Ativo'),
(419, 20, 47, '2026-02-27 11:37:01', 'Ativo'),
(420, 20, 19, '2026-02-27 11:37:01', 'Ativo'),
(421, 20, 31, '2026-02-27 11:37:01', 'Ativo'),
(422, 20, 32, '2026-02-27 11:37:01', 'Ativo'),
(423, 20, 8, '2026-02-27 11:37:01', 'Ativo'),
(424, 20, 51, '2026-02-27 11:37:01', 'Ativo'),
(425, 20, 29, '2026-02-27 11:37:01', 'Ativo'),
(426, 20, 27, '2026-02-27 11:37:01', 'Ativo'),
(427, 20, 46, '2026-02-27 11:37:01', 'Ativo'),
(428, 20, 33, '2026-02-27 11:37:01', 'Ativo'),
(429, 20, 38, '2026-02-27 11:37:01', 'Ativo'),
(430, 20, 28, '2026-02-27 11:37:01', 'Ativo'),
(431, 20, 48, '2026-02-27 11:37:01', 'Ativo'),
(432, 20, 35, '2026-02-27 11:37:01', 'Ativo'),
(433, 21, 118, '2026-03-03 10:43:53', 'Ativo'),
(434, 21, 52, '2026-03-03 10:43:53', 'Ativo'),
(435, 21, 53, '2026-03-03 10:43:53', 'Ativo'),
(436, 21, 54, '2026-03-03 10:43:53', 'Ativo'),
(437, 21, 55, '2026-03-03 10:43:53', 'Ativo'),
(438, 21, 56, '2026-03-03 10:43:53', 'Ativo'),
(439, 21, 57, '2026-03-03 10:43:53', 'Ativo'),
(440, 21, 58, '2026-03-03 10:43:53', 'Ativo'),
(441, 21, 59, '2026-03-03 10:43:53', 'Ativo'),
(442, 21, 62, '2026-03-03 10:43:53', 'Ativo'),
(443, 21, 60, '2026-03-03 10:43:53', 'Ativo'),
(444, 21, 61, '2026-03-03 10:43:53', 'Ativo'),
(445, 21, 63, '2026-03-03 10:43:53', 'Ativo'),
(446, 21, 64, '2026-03-03 10:43:53', 'Ativo'),
(447, 21, 65, '2026-03-03 10:43:53', 'Ativo'),
(448, 21, 66, '2026-03-03 10:43:53', 'Ativo'),
(449, 21, 67, '2026-03-03 10:43:53', 'Ativo'),
(450, 21, 68, '2026-03-03 10:43:53', 'Ativo'),
(451, 21, 69, '2026-03-03 10:43:53', 'Ativo'),
(452, 21, 70, '2026-03-03 10:43:53', 'Ativo'),
(453, 21, 90, '2026-03-03 10:43:53', 'Ativo'),
(454, 21, 73, '2026-03-03 10:43:53', 'Ativo'),
(455, 21, 71, '2026-03-03 10:43:53', 'Ativo'),
(456, 21, 72, '2026-03-03 10:43:53', 'Ativo'),
(457, 21, 75, '2026-03-03 10:43:53', 'Ativo'),
(458, 21, 76, '2026-03-03 10:43:53', 'Ativo'),
(459, 21, 77, '2026-03-03 10:43:53', 'Ativo'),
(460, 21, 78, '2026-03-03 10:43:53', 'Ativo'),
(461, 21, 79, '2026-03-03 10:43:53', 'Ativo'),
(462, 21, 82, '2026-03-03 10:43:53', 'Ativo'),
(463, 21, 84, '2026-03-03 10:43:53', 'Ativo'),
(464, 21, 85, '2026-03-03 10:43:53', 'Ativo'),
(465, 21, 86, '2026-03-03 10:43:53', 'Ativo'),
(466, 21, 89, '2026-03-03 10:43:53', 'Ativo'),
(467, 21, 87, '2026-03-03 10:43:53', 'Ativo'),
(468, 21, 88, '2026-03-03 10:43:53', 'Ativo'),
(469, 21, 91, '2026-03-03 10:43:53', 'Ativo'),
(470, 21, 92, '2026-03-03 10:43:53', 'Ativo'),
(471, 21, 94, '2026-03-03 10:43:53', 'Ativo'),
(472, 21, 95, '2026-03-03 10:43:53', 'Ativo'),
(473, 21, 97, '2026-03-03 10:43:53', 'Ativo'),
(474, 21, 96, '2026-03-03 10:43:53', 'Ativo'),
(475, 21, 98, '2026-03-03 10:43:53', 'Ativo'),
(476, 21, 99, '2026-03-03 10:43:53', 'Ativo'),
(477, 21, 103, '2026-03-03 10:43:53', 'Ativo'),
(478, 21, 104, '2026-03-03 10:43:53', 'Ativo'),
(479, 21, 106, '2026-03-03 10:43:53', 'Ativo'),
(480, 21, 111, '2026-03-03 10:43:53', 'Ativo'),
(481, 21, 116, '2026-03-03 10:43:53', 'Ativo'),
(482, 21, 119, '2026-03-03 10:43:53', 'Ativo'),
(483, 21, 150, '2026-03-03 10:43:53', 'Ativo'),
(484, 21, 151, '2026-03-03 10:43:53', 'Ativo'),
(485, 21, 152, '2026-03-03 10:43:53', 'Ativo'),
(486, 21, 184, '2026-03-03 10:43:53', 'Ativo'),
(487, 21, 243, '2026-03-03 10:43:53', 'Ativo'),
(488, 21, 244, '2026-03-03 10:43:53', 'Ativo'),
(489, 21, 260, '2026-03-03 10:43:53', 'Ativo'),
(490, 21, 269, '2026-03-03 10:43:53', 'Ativo'),
(491, 21, 242, '2026-03-03 10:43:53', 'Ativo'),
(492, 22, 80, '2026-03-03 10:56:59', 'Ativo'),
(493, 22, 93, '2026-03-03 10:56:59', 'Ativo'),
(494, 22, 100, '2026-03-03 10:56:59', 'Ativo'),
(495, 22, 101, '2026-03-03 10:56:59', 'Ativo'),
(496, 22, 105, '2026-03-03 10:56:59', 'Ativo'),
(497, 22, 107, '2026-03-03 10:56:59', 'Ativo'),
(498, 22, 109, '2026-03-03 10:56:59', 'Ativo'),
(499, 22, 110, '2026-03-03 10:56:59', 'Ativo'),
(500, 22, 267, '2026-03-03 10:56:59', 'Ativo'),
(501, 22, 112, '2026-03-03 10:56:59', 'Ativo'),
(502, 22, 114, '2026-03-03 10:56:59', 'Ativo'),
(503, 22, 115, '2026-03-03 10:56:59', 'Ativo'),
(504, 22, 120, '2026-03-03 10:56:59', 'Ativo'),
(505, 22, 122, '2026-03-03 10:56:59', 'Ativo'),
(506, 22, 123, '2026-03-03 10:56:59', 'Ativo'),
(507, 22, 124, '2026-03-03 10:56:59', 'Ativo'),
(508, 22, 126, '2026-03-03 10:56:59', 'Ativo'),
(509, 22, 127, '2026-03-03 10:56:59', 'Ativo'),
(510, 22, 128, '2026-03-03 10:56:59', 'Ativo'),
(511, 22, 129, '2026-03-03 10:56:59', 'Ativo'),
(512, 22, 130, '2026-03-03 10:56:59', 'Ativo'),
(513, 22, 131, '2026-03-03 10:56:59', 'Ativo'),
(514, 22, 132, '2026-03-03 10:56:59', 'Ativo'),
(515, 22, 143, '2026-03-03 10:56:59', 'Ativo'),
(516, 22, 145, '2026-03-03 10:56:59', 'Ativo'),
(517, 22, 148, '2026-03-03 10:56:59', 'Ativo'),
(518, 22, 153, '2026-03-03 10:56:59', 'Ativo'),
(519, 22, 159, '2026-03-03 10:56:59', 'Ativo'),
(520, 22, 164, '2026-03-03 10:56:59', 'Ativo'),
(521, 22, 169, '2026-03-03 10:56:59', 'Ativo'),
(522, 22, 174, '2026-03-03 10:56:59', 'Ativo'),
(523, 22, 189, '2026-03-03 10:56:59', 'Ativo'),
(524, 22, 194, '2026-03-03 10:56:59', 'Ativo'),
(525, 22, 204, '2026-03-03 10:56:59', 'Ativo'),
(526, 22, 205, '2026-03-03 10:56:59', 'Ativo'),
(527, 22, 210, '2026-03-03 10:56:59', 'Ativo'),
(528, 22, 74, '2026-03-03 10:56:59', 'Ativo'),
(529, 22, 190, '2026-03-03 10:56:59', 'Ativo'),
(530, 22, 211, '2026-03-03 10:56:59', 'Ativo'),
(531, 22, 253, '2026-03-03 10:56:59', 'Ativo'),
(532, 22, 251, '2026-03-03 10:56:59', 'Ativo'),
(533, 22, 262, '2026-03-03 10:56:59', 'Ativo'),
(534, 22, 268, '2026-03-03 10:56:59', 'Ativo'),
(535, 24, 156, '2026-03-03 11:02:44', 'Ativo'),
(536, 24, 176, '2026-03-03 11:02:44', 'Ativo'),
(537, 24, 142, '2026-03-03 11:02:44', 'Ativo'),
(538, 24, 178, '2026-03-03 11:02:44', 'Ativo'),
(539, 24, 201, '2026-03-03 11:02:44', 'Ativo'),
(540, 24, 175, '2026-03-03 11:02:44', 'Ativo'),
(541, 24, 182, '2026-03-03 11:02:44', 'Ativo'),
(542, 24, 157, '2026-03-03 11:02:44', 'Ativo'),
(543, 24, 179, '2026-03-03 11:02:44', 'Ativo'),
(544, 24, 146, '2026-03-03 11:02:44', 'Ativo'),
(545, 24, 180, '2026-03-03 11:02:44', 'Ativo'),
(546, 24, 196, '2026-03-03 11:02:44', 'Ativo'),
(547, 24, 197, '2026-03-03 11:02:44', 'Ativo'),
(548, 24, 195, '2026-03-03 11:02:44', 'Ativo'),
(549, 24, 207, '2026-03-03 11:02:44', 'Ativo'),
(550, 24, 83, '2026-03-03 11:02:44', 'Ativo'),
(551, 24, 203, '2026-03-03 11:02:44', 'Ativo'),
(552, 24, 155, '2026-03-03 11:02:44', 'Ativo'),
(553, 24, 81, '2026-03-03 11:02:44', 'Ativo'),
(554, 24, 154, '2026-03-03 11:02:44', 'Ativo'),
(555, 24, 147, '2026-03-03 11:02:44', 'Ativo'),
(556, 24, 121, '2026-03-03 11:02:44', 'Ativo'),
(557, 24, 140, '2026-03-03 11:02:44', 'Ativo'),
(558, 24, 135, '2026-03-03 11:02:44', 'Ativo'),
(559, 24, 162, '2026-03-03 11:02:44', 'Ativo'),
(560, 24, 166, '2026-03-03 11:02:44', 'Ativo'),
(561, 24, 171, '2026-03-03 11:02:44', 'Ativo'),
(562, 24, 200, '2026-03-03 11:02:44', 'Ativo'),
(563, 24, 133, '2026-03-03 11:02:44', 'Ativo'),
(564, 24, 149, '2026-03-03 11:02:44', 'Ativo'),
(565, 24, 209, '2026-03-03 11:02:44', 'Ativo'),
(566, 24, 199, '2026-03-03 11:02:44', 'Ativo'),
(567, 24, 177, '2026-03-03 11:02:44', 'Ativo'),
(568, 24, 255, '2026-03-03 11:02:44', 'Ativo'),
(569, 24, 256, '2026-03-03 11:02:44', 'Ativo'),
(570, 24, 257, '2026-03-03 11:02:44', 'Ativo'),
(571, 24, 258, '2026-03-03 11:02:44', 'Ativo'),
(572, 24, 259, '2026-03-03 11:02:44', 'Ativo'),
(573, 24, 263, '2026-03-03 11:02:44', 'Ativo'),
(574, 24, 264, '2026-03-03 11:02:44', 'Ativo'),
(575, 24, 139, '2026-03-03 11:02:44', 'Ativo'),
(576, 25, 102, '2026-03-03 11:10:47', 'Ativo'),
(577, 25, 125, '2026-03-03 11:10:47', 'Ativo'),
(578, 25, 134, '2026-03-03 11:10:47', 'Ativo'),
(579, 25, 137, '2026-03-03 11:10:47', 'Ativo'),
(580, 25, 136, '2026-03-03 11:10:47', 'Ativo'),
(581, 25, 138, '2026-03-03 11:10:47', 'Ativo'),
(582, 25, 141, '2026-03-03 11:10:47', 'Ativo'),
(583, 25, 144, '2026-03-03 11:10:47', 'Ativo'),
(584, 25, 158, '2026-03-03 11:10:47', 'Ativo'),
(585, 25, 160, '2026-03-03 11:10:47', 'Ativo'),
(586, 25, 161, '2026-03-03 11:10:47', 'Ativo'),
(587, 25, 163, '2026-03-03 11:10:47', 'Ativo'),
(588, 25, 165, '2026-03-03 11:10:47', 'Ativo'),
(589, 25, 167, '2026-03-03 11:10:47', 'Ativo'),
(590, 25, 168, '2026-03-03 11:10:47', 'Ativo'),
(591, 25, 170, '2026-03-03 11:10:47', 'Ativo'),
(592, 25, 172, '2026-03-03 11:10:47', 'Ativo'),
(593, 25, 181, '2026-03-03 11:10:48', 'Ativo'),
(594, 25, 183, '2026-03-03 11:10:48', 'Ativo'),
(595, 25, 185, '2026-03-03 11:10:48', 'Ativo'),
(596, 25, 186, '2026-03-03 11:10:48', 'Ativo'),
(597, 25, 187, '2026-03-03 11:10:48', 'Ativo'),
(598, 25, 188, '2026-03-03 11:10:48', 'Ativo'),
(599, 25, 191, '2026-03-03 11:10:48', 'Ativo'),
(600, 25, 192, '2026-03-03 11:10:48', 'Ativo'),
(601, 25, 193, '2026-03-03 11:10:48', 'Ativo'),
(602, 25, 198, '2026-03-03 11:10:48', 'Ativo'),
(603, 25, 202, '2026-03-03 11:10:48', 'Ativo'),
(604, 25, 206, '2026-03-03 11:10:48', 'Ativo'),
(605, 25, 208, '2026-03-03 11:10:48', 'Ativo'),
(606, 25, 246, '2026-03-03 11:10:48', 'Ativo'),
(607, 25, 250, '2026-03-03 11:10:48', 'Ativo'),
(608, 25, 252, '2026-03-03 11:10:48', 'Ativo'),
(609, 25, 265, '2026-03-03 11:10:48', 'Ativo'),
(610, 25, 266, '2026-03-03 11:10:48', 'Ativo'),
(611, 25, 267, '2026-03-03 11:10:48', 'Ativo'),
(612, 25, 270, '2026-03-03 11:10:48', 'Ativo'),
(613, 26, 102, '2026-03-04 11:08:31', 'Ativo'),
(614, 26, 125, '2026-03-04 11:08:31', 'Ativo'),
(615, 26, 134, '2026-03-04 11:08:31', 'Ativo'),
(616, 26, 136, '2026-03-04 11:08:31', 'Ativo'),
(617, 26, 137, '2026-03-04 11:08:31', 'Ativo'),
(618, 26, 138, '2026-03-04 11:08:31', 'Ativo'),
(619, 26, 141, '2026-03-04 11:08:31', 'Ativo'),
(620, 26, 144, '2026-03-04 11:08:31', 'Ativo'),
(621, 26, 158, '2026-03-04 11:08:31', 'Ativo'),
(622, 26, 160, '2026-03-04 11:08:31', 'Ativo'),
(623, 26, 161, '2026-03-04 11:08:31', 'Ativo'),
(624, 26, 163, '2026-03-04 11:08:31', 'Ativo'),
(625, 26, 165, '2026-03-04 11:08:31', 'Ativo'),
(626, 26, 167, '2026-03-04 11:08:31', 'Ativo'),
(627, 26, 168, '2026-03-04 11:08:31', 'Ativo'),
(628, 26, 170, '2026-03-04 11:08:31', 'Ativo'),
(629, 26, 172, '2026-03-04 11:08:31', 'Ativo'),
(630, 26, 181, '2026-03-04 11:08:31', 'Ativo'),
(631, 26, 183, '2026-03-04 11:08:31', 'Ativo'),
(632, 26, 185, '2026-03-04 11:08:31', 'Ativo'),
(633, 26, 186, '2026-03-04 11:08:31', 'Ativo'),
(634, 26, 187, '2026-03-04 11:08:31', 'Ativo'),
(635, 26, 188, '2026-03-04 11:08:31', 'Ativo'),
(636, 26, 191, '2026-03-04 11:08:31', 'Ativo'),
(637, 26, 192, '2026-03-04 11:08:31', 'Ativo'),
(638, 26, 193, '2026-03-04 11:08:31', 'Ativo'),
(639, 26, 198, '2026-03-04 11:08:31', 'Ativo'),
(640, 26, 202, '2026-03-04 11:08:31', 'Ativo'),
(641, 26, 206, '2026-03-04 11:08:31', 'Ativo'),
(642, 26, 208, '2026-03-04 11:08:31', 'Ativo'),
(643, 26, 246, '2026-03-04 11:08:31', 'Ativo'),
(644, 26, 250, '2026-03-04 11:08:31', 'Ativo'),
(645, 26, 252, '2026-03-04 11:08:31', 'Ativo'),
(646, 26, 265, '2026-03-04 11:08:31', 'Ativo'),
(647, 26, 266, '2026-03-04 11:08:31', 'Ativo'),
(648, 26, 267, '2026-03-04 11:08:31', 'Ativo'),
(649, 26, 270, '2026-03-04 11:08:31', 'Ativo'),
(650, 27, 74, '2026-03-04 11:09:28', 'Ativo'),
(651, 27, 80, '2026-03-04 11:09:28', 'Ativo'),
(652, 27, 93, '2026-03-04 11:09:28', 'Ativo'),
(653, 27, 100, '2026-03-04 11:09:28', 'Ativo'),
(654, 27, 101, '2026-03-04 11:09:28', 'Ativo'),
(655, 27, 105, '2026-03-04 11:09:28', 'Ativo'),
(656, 27, 107, '2026-03-04 11:09:28', 'Ativo'),
(657, 27, 109, '2026-03-04 11:09:28', 'Ativo'),
(658, 27, 110, '2026-03-04 11:09:28', 'Ativo'),
(659, 27, 112, '2026-03-04 11:09:28', 'Ativo'),
(660, 27, 114, '2026-03-04 11:09:28', 'Ativo'),
(661, 27, 115, '2026-03-04 11:09:28', 'Ativo'),
(662, 27, 120, '2026-03-04 11:09:28', 'Ativo'),
(663, 27, 122, '2026-03-04 11:09:28', 'Ativo'),
(664, 27, 123, '2026-03-04 11:09:28', 'Ativo'),
(665, 27, 124, '2026-03-04 11:09:28', 'Ativo'),
(666, 27, 126, '2026-03-04 11:09:28', 'Ativo'),
(667, 27, 127, '2026-03-04 11:09:28', 'Ativo'),
(668, 27, 128, '2026-03-04 11:09:28', 'Ativo'),
(669, 27, 129, '2026-03-04 11:09:28', 'Ativo'),
(670, 27, 130, '2026-03-04 11:09:28', 'Ativo'),
(671, 27, 131, '2026-03-04 11:09:28', 'Ativo'),
(672, 27, 132, '2026-03-04 11:09:28', 'Ativo'),
(673, 27, 143, '2026-03-04 11:09:28', 'Ativo'),
(674, 27, 145, '2026-03-04 11:09:28', 'Ativo'),
(675, 27, 148, '2026-03-04 11:09:28', 'Ativo'),
(676, 27, 153, '2026-03-04 11:09:28', 'Ativo'),
(677, 27, 159, '2026-03-04 11:09:28', 'Ativo'),
(678, 27, 164, '2026-03-04 11:09:28', 'Ativo'),
(679, 27, 169, '2026-03-04 11:09:28', 'Ativo'),
(680, 27, 174, '2026-03-04 11:09:28', 'Ativo'),
(681, 27, 189, '2026-03-04 11:09:28', 'Ativo'),
(682, 27, 190, '2026-03-04 11:09:28', 'Ativo'),
(683, 27, 194, '2026-03-04 11:09:28', 'Ativo'),
(684, 27, 204, '2026-03-04 11:09:28', 'Ativo'),
(685, 27, 205, '2026-03-04 11:09:28', 'Ativo'),
(686, 27, 210, '2026-03-04 11:09:28', 'Ativo'),
(687, 27, 211, '2026-03-04 11:09:28', 'Ativo'),
(688, 27, 251, '2026-03-04 11:09:28', 'Ativo'),
(689, 27, 253, '2026-03-04 11:09:28', 'Ativo'),
(690, 27, 262, '2026-03-04 11:09:28', 'Ativo'),
(691, 27, 267, '2026-03-04 11:09:28', 'Ativo'),
(692, 27, 268, '2026-03-04 11:09:28', 'Ativo'),
(693, 28, 102, '2026-03-04 14:23:55', 'Ativo'),
(694, 28, 125, '2026-03-04 14:23:55', 'Ativo'),
(695, 28, 134, '2026-03-04 14:23:55', 'Ativo'),
(696, 28, 136, '2026-03-04 14:23:55', 'Ativo'),
(697, 28, 137, '2026-03-04 14:23:55', 'Ativo'),
(698, 28, 138, '2026-03-04 14:23:55', 'Ativo'),
(699, 28, 141, '2026-03-04 14:23:55', 'Ativo'),
(700, 28, 144, '2026-03-04 14:23:55', 'Ativo'),
(701, 28, 158, '2026-03-04 14:23:55', 'Ativo'),
(702, 28, 160, '2026-03-04 14:23:55', 'Ativo'),
(703, 28, 161, '2026-03-04 14:23:55', 'Ativo'),
(704, 28, 163, '2026-03-04 14:23:55', 'Ativo'),
(705, 28, 165, '2026-03-04 14:23:55', 'Ativo'),
(706, 28, 167, '2026-03-04 14:23:55', 'Ativo'),
(707, 28, 168, '2026-03-04 14:23:55', 'Ativo'),
(708, 28, 170, '2026-03-04 14:23:55', 'Ativo'),
(709, 28, 172, '2026-03-04 14:23:55', 'Ativo'),
(710, 28, 181, '2026-03-04 14:23:55', 'Ativo'),
(711, 28, 183, '2026-03-04 14:23:55', 'Ativo'),
(712, 28, 185, '2026-03-04 14:23:55', 'Ativo'),
(713, 28, 186, '2026-03-04 14:23:55', 'Ativo'),
(714, 28, 187, '2026-03-04 14:23:55', 'Ativo'),
(715, 28, 188, '2026-03-04 14:23:55', 'Ativo'),
(716, 28, 191, '2026-03-04 14:23:55', 'Ativo'),
(717, 28, 192, '2026-03-04 14:23:55', 'Ativo'),
(718, 28, 193, '2026-03-04 14:23:55', 'Ativo'),
(719, 28, 198, '2026-03-04 14:23:55', 'Ativo'),
(720, 28, 202, '2026-03-04 14:23:55', 'Ativo'),
(721, 28, 206, '2026-03-04 14:23:55', 'Ativo'),
(722, 28, 208, '2026-03-04 14:23:55', 'Ativo'),
(723, 28, 246, '2026-03-04 14:23:55', 'Ativo'),
(724, 28, 250, '2026-03-04 14:23:55', 'Ativo'),
(725, 28, 252, '2026-03-04 14:23:55', 'Ativo'),
(726, 28, 265, '2026-03-04 14:23:55', 'Ativo'),
(727, 28, 266, '2026-03-04 14:23:55', 'Ativo'),
(728, 28, 267, '2026-03-04 14:23:55', 'Ativo'),
(729, 28, 270, '2026-03-04 14:23:55', 'Ativo'),
(730, 29, 52, '2026-03-04 16:28:52', 'Ativo'),
(731, 29, 53, '2026-03-04 16:28:52', 'Ativo'),
(732, 29, 54, '2026-03-04 16:28:52', 'Ativo'),
(733, 29, 55, '2026-03-04 16:28:52', 'Ativo'),
(734, 29, 56, '2026-03-04 16:28:52', 'Ativo'),
(735, 29, 57, '2026-03-04 16:28:52', 'Ativo'),
(736, 29, 58, '2026-03-04 16:28:52', 'Ativo'),
(737, 29, 59, '2026-03-04 16:28:52', 'Ativo'),
(738, 29, 60, '2026-03-04 16:28:52', 'Ativo'),
(739, 29, 61, '2026-03-04 16:28:52', 'Ativo'),
(740, 29, 62, '2026-03-04 16:28:52', 'Ativo'),
(741, 29, 63, '2026-03-04 16:28:52', 'Ativo'),
(742, 29, 64, '2026-03-04 16:28:52', 'Ativo'),
(743, 29, 65, '2026-03-04 16:28:52', 'Ativo'),
(744, 29, 66, '2026-03-04 16:28:52', 'Ativo'),
(745, 29, 67, '2026-03-04 16:28:52', 'Ativo'),
(746, 29, 68, '2026-03-04 16:28:52', 'Ativo'),
(747, 29, 69, '2026-03-04 16:28:52', 'Ativo'),
(748, 29, 70, '2026-03-04 16:28:52', 'Ativo'),
(749, 29, 71, '2026-03-04 16:28:52', 'Ativo'),
(750, 29, 72, '2026-03-04 16:28:52', 'Ativo'),
(751, 29, 73, '2026-03-04 16:28:52', 'Ativo'),
(752, 29, 75, '2026-03-04 16:28:52', 'Ativo'),
(753, 29, 76, '2026-03-04 16:28:52', 'Ativo'),
(754, 29, 77, '2026-03-04 16:28:52', 'Ativo'),
(755, 29, 78, '2026-03-04 16:28:52', 'Ativo'),
(756, 29, 79, '2026-03-04 16:28:52', 'Ativo'),
(757, 29, 82, '2026-03-04 16:28:52', 'Ativo'),
(758, 29, 84, '2026-03-04 16:28:52', 'Ativo'),
(759, 29, 85, '2026-03-04 16:28:52', 'Ativo'),
(760, 29, 86, '2026-03-04 16:28:52', 'Ativo'),
(761, 29, 87, '2026-03-04 16:28:52', 'Ativo'),
(762, 29, 88, '2026-03-04 16:28:52', 'Ativo'),
(763, 29, 89, '2026-03-04 16:28:52', 'Ativo'),
(764, 29, 90, '2026-03-04 16:28:52', 'Ativo'),
(765, 29, 91, '2026-03-04 16:28:52', 'Ativo'),
(766, 29, 92, '2026-03-04 16:28:52', 'Ativo'),
(767, 29, 94, '2026-03-04 16:28:52', 'Ativo'),
(768, 29, 95, '2026-03-04 16:28:52', 'Ativo'),
(769, 29, 96, '2026-03-04 16:28:52', 'Ativo'),
(770, 29, 97, '2026-03-04 16:28:52', 'Ativo'),
(771, 29, 98, '2026-03-04 16:28:52', 'Ativo'),
(772, 29, 99, '2026-03-04 16:28:52', 'Ativo'),
(773, 29, 103, '2026-03-04 16:28:52', 'Ativo'),
(774, 29, 104, '2026-03-04 16:28:52', 'Ativo'),
(775, 29, 106, '2026-03-04 16:28:52', 'Ativo'),
(776, 29, 111, '2026-03-04 16:28:52', 'Ativo'),
(777, 29, 116, '2026-03-04 16:28:52', 'Ativo'),
(778, 29, 118, '2026-03-04 16:28:52', 'Ativo'),
(779, 29, 119, '2026-03-04 16:28:52', 'Ativo'),
(780, 29, 150, '2026-03-04 16:28:52', 'Ativo'),
(781, 29, 151, '2026-03-04 16:28:52', 'Ativo'),
(782, 29, 152, '2026-03-04 16:28:52', 'Ativo'),
(783, 29, 184, '2026-03-04 16:28:52', 'Ativo'),
(784, 29, 242, '2026-03-04 16:28:52', 'Ativo'),
(785, 29, 243, '2026-03-04 16:28:52', 'Ativo'),
(786, 29, 244, '2026-03-04 16:28:52', 'Ativo'),
(787, 29, 260, '2026-03-04 16:28:52', 'Ativo'),
(788, 29, 269, '2026-03-04 16:28:52', 'Ativo'),
(789, 30, 52, '2026-03-04 16:30:22', 'Ativo'),
(790, 30, 53, '2026-03-04 16:30:22', 'Ativo'),
(791, 30, 54, '2026-03-04 16:30:22', 'Ativo'),
(792, 30, 55, '2026-03-04 16:30:22', 'Ativo'),
(793, 30, 56, '2026-03-04 16:30:22', 'Ativo'),
(794, 30, 57, '2026-03-04 16:30:22', 'Ativo'),
(795, 30, 58, '2026-03-04 16:30:22', 'Ativo'),
(796, 30, 59, '2026-03-04 16:30:22', 'Ativo'),
(797, 30, 60, '2026-03-04 16:30:22', 'Ativo'),
(798, 30, 61, '2026-03-04 16:30:22', 'Ativo'),
(799, 30, 62, '2026-03-04 16:30:22', 'Ativo'),
(800, 30, 63, '2026-03-04 16:30:22', 'Ativo'),
(801, 30, 64, '2026-03-04 16:30:22', 'Ativo'),
(802, 30, 65, '2026-03-04 16:30:22', 'Ativo'),
(803, 30, 66, '2026-03-04 16:30:22', 'Ativo'),
(804, 30, 67, '2026-03-04 16:30:22', 'Ativo'),
(805, 30, 68, '2026-03-04 16:30:22', 'Ativo'),
(806, 30, 69, '2026-03-04 16:30:22', 'Ativo'),
(807, 30, 70, '2026-03-04 16:30:22', 'Ativo'),
(808, 30, 71, '2026-03-04 16:30:22', 'Ativo'),
(809, 30, 72, '2026-03-04 16:30:22', 'Ativo'),
(810, 30, 73, '2026-03-04 16:30:22', 'Ativo'),
(811, 30, 75, '2026-03-04 16:30:22', 'Ativo'),
(812, 30, 76, '2026-03-04 16:30:22', 'Ativo'),
(813, 30, 77, '2026-03-04 16:30:22', 'Ativo'),
(814, 30, 78, '2026-03-04 16:30:22', 'Ativo'),
(815, 30, 79, '2026-03-04 16:30:22', 'Ativo'),
(816, 30, 82, '2026-03-04 16:30:22', 'Ativo'),
(817, 30, 84, '2026-03-04 16:30:22', 'Ativo'),
(818, 30, 85, '2026-03-04 16:30:22', 'Ativo'),
(819, 30, 86, '2026-03-04 16:30:22', 'Ativo'),
(820, 30, 87, '2026-03-04 16:30:22', 'Ativo'),
(821, 30, 88, '2026-03-04 16:30:22', 'Ativo'),
(822, 30, 89, '2026-03-04 16:30:22', 'Ativo'),
(823, 30, 90, '2026-03-04 16:30:22', 'Ativo'),
(824, 30, 91, '2026-03-04 16:30:22', 'Ativo'),
(825, 30, 92, '2026-03-04 16:30:22', 'Ativo'),
(826, 30, 94, '2026-03-04 16:30:22', 'Ativo'),
(827, 30, 95, '2026-03-04 16:30:22', 'Ativo'),
(828, 30, 96, '2026-03-04 16:30:22', 'Ativo'),
(829, 30, 97, '2026-03-04 16:30:22', 'Ativo'),
(830, 30, 98, '2026-03-04 16:30:22', 'Ativo'),
(831, 30, 99, '2026-03-04 16:30:22', 'Ativo'),
(832, 30, 103, '2026-03-04 16:30:22', 'Ativo'),
(833, 30, 104, '2026-03-04 16:30:22', 'Ativo'),
(834, 30, 106, '2026-03-04 16:30:22', 'Ativo'),
(835, 30, 111, '2026-03-04 16:30:22', 'Ativo'),
(836, 30, 116, '2026-03-04 16:30:22', 'Ativo'),
(837, 30, 118, '2026-03-04 16:30:22', 'Ativo'),
(838, 30, 119, '2026-03-04 16:30:22', 'Ativo'),
(839, 30, 150, '2026-03-04 16:30:22', 'Ativo'),
(840, 30, 151, '2026-03-04 16:30:22', 'Ativo'),
(841, 30, 152, '2026-03-04 16:30:22', 'Ativo'),
(842, 30, 184, '2026-03-04 16:30:22', 'Ativo'),
(843, 30, 242, '2026-03-04 16:30:22', 'Ativo'),
(844, 30, 243, '2026-03-04 16:30:22', 'Ativo'),
(845, 30, 244, '2026-03-04 16:30:22', 'Ativo'),
(846, 30, 260, '2026-03-04 16:30:22', 'Ativo'),
(847, 30, 269, '2026-03-04 16:30:22', 'Ativo'),
(848, 31, 52, '2026-03-04 16:34:23', 'Ativo'),
(849, 31, 53, '2026-03-04 16:34:23', 'Ativo'),
(850, 31, 54, '2026-03-04 16:34:23', 'Ativo'),
(851, 31, 55, '2026-03-04 16:34:23', 'Ativo'),
(852, 31, 56, '2026-03-04 16:34:23', 'Ativo'),
(853, 31, 57, '2026-03-04 16:34:23', 'Ativo'),
(854, 31, 58, '2026-03-04 16:34:23', 'Ativo'),
(855, 31, 59, '2026-03-04 16:34:23', 'Ativo'),
(856, 31, 60, '2026-03-04 16:34:23', 'Ativo'),
(857, 31, 61, '2026-03-04 16:34:23', 'Ativo'),
(858, 31, 62, '2026-03-04 16:34:23', 'Ativo'),
(859, 31, 63, '2026-03-04 16:34:23', 'Ativo'),
(860, 31, 64, '2026-03-04 16:34:23', 'Ativo'),
(861, 31, 65, '2026-03-04 16:34:23', 'Ativo'),
(862, 31, 66, '2026-03-04 16:34:23', 'Ativo'),
(863, 31, 67, '2026-03-04 16:34:23', 'Ativo'),
(864, 31, 68, '2026-03-04 16:34:23', 'Ativo'),
(865, 31, 69, '2026-03-04 16:34:23', 'Ativo'),
(866, 31, 70, '2026-03-04 16:34:23', 'Ativo'),
(867, 31, 71, '2026-03-04 16:34:23', 'Ativo'),
(868, 31, 72, '2026-03-04 16:34:23', 'Ativo'),
(869, 31, 73, '2026-03-04 16:34:23', 'Ativo'),
(870, 31, 75, '2026-03-04 16:34:23', 'Ativo'),
(871, 31, 76, '2026-03-04 16:34:23', 'Ativo'),
(872, 31, 77, '2026-03-04 16:34:23', 'Ativo'),
(873, 31, 78, '2026-03-04 16:34:23', 'Ativo'),
(874, 31, 79, '2026-03-04 16:34:23', 'Ativo'),
(875, 31, 82, '2026-03-04 16:34:23', 'Ativo'),
(876, 31, 84, '2026-03-04 16:34:23', 'Ativo'),
(877, 31, 85, '2026-03-04 16:34:23', 'Ativo'),
(878, 31, 86, '2026-03-04 16:34:23', 'Ativo'),
(879, 31, 87, '2026-03-04 16:34:23', 'Ativo'),
(880, 31, 88, '2026-03-04 16:34:23', 'Ativo'),
(881, 31, 89, '2026-03-04 16:34:23', 'Ativo'),
(882, 31, 90, '2026-03-04 16:34:23', 'Ativo'),
(883, 31, 91, '2026-03-04 16:34:23', 'Ativo'),
(884, 31, 92, '2026-03-04 16:34:23', 'Ativo'),
(885, 31, 94, '2026-03-04 16:34:23', 'Ativo'),
(886, 31, 95, '2026-03-04 16:34:23', 'Ativo'),
(887, 31, 96, '2026-03-04 16:34:23', 'Ativo'),
(888, 31, 97, '2026-03-04 16:34:23', 'Ativo'),
(889, 31, 98, '2026-03-04 16:34:23', 'Ativo'),
(890, 31, 99, '2026-03-04 16:34:23', 'Ativo'),
(891, 31, 103, '2026-03-04 16:34:23', 'Ativo'),
(892, 31, 104, '2026-03-04 16:34:23', 'Ativo'),
(893, 31, 106, '2026-03-04 16:34:23', 'Ativo'),
(894, 31, 111, '2026-03-04 16:34:23', 'Ativo'),
(895, 31, 116, '2026-03-04 16:34:23', 'Ativo'),
(896, 31, 118, '2026-03-04 16:34:23', 'Ativo'),
(897, 31, 119, '2026-03-04 16:34:23', 'Ativo'),
(898, 31, 150, '2026-03-04 16:34:23', 'Ativo'),
(899, 31, 151, '2026-03-04 16:34:23', 'Ativo'),
(900, 31, 152, '2026-03-04 16:34:23', 'Ativo'),
(901, 31, 184, '2026-03-04 16:34:23', 'Ativo'),
(902, 31, 242, '2026-03-04 16:34:23', 'Ativo'),
(903, 31, 243, '2026-03-04 16:34:23', 'Ativo'),
(904, 31, 244, '2026-03-04 16:34:23', 'Ativo'),
(905, 31, 260, '2026-03-04 16:34:23', 'Ativo'),
(906, 31, 269, '2026-03-04 16:34:23', 'Ativo'),
(907, 32, 74, '2026-03-04 16:38:30', 'Ativo'),
(908, 32, 80, '2026-03-04 16:38:30', 'Ativo'),
(909, 32, 93, '2026-03-04 16:38:30', 'Ativo'),
(910, 32, 100, '2026-03-04 16:38:30', 'Ativo'),
(911, 32, 101, '2026-03-04 16:38:30', 'Ativo'),
(912, 32, 105, '2026-03-04 16:38:30', 'Ativo'),
(913, 32, 107, '2026-03-04 16:38:30', 'Ativo'),
(914, 32, 109, '2026-03-04 16:38:30', 'Ativo'),
(915, 32, 110, '2026-03-04 16:38:30', 'Ativo'),
(916, 32, 112, '2026-03-04 16:38:30', 'Ativo'),
(917, 32, 114, '2026-03-04 16:38:30', 'Ativo'),
(918, 32, 115, '2026-03-04 16:38:30', 'Ativo'),
(919, 32, 120, '2026-03-04 16:38:30', 'Ativo'),
(920, 32, 122, '2026-03-04 16:38:30', 'Ativo'),
(921, 32, 123, '2026-03-04 16:38:30', 'Ativo'),
(922, 32, 124, '2026-03-04 16:38:30', 'Ativo'),
(923, 32, 126, '2026-03-04 16:38:30', 'Ativo'),
(924, 32, 127, '2026-03-04 16:38:30', 'Ativo'),
(925, 32, 128, '2026-03-04 16:38:30', 'Ativo'),
(926, 32, 129, '2026-03-04 16:38:30', 'Ativo'),
(927, 32, 130, '2026-03-04 16:38:30', 'Ativo'),
(928, 32, 131, '2026-03-04 16:38:30', 'Ativo'),
(929, 32, 132, '2026-03-04 16:38:30', 'Ativo'),
(930, 32, 143, '2026-03-04 16:38:30', 'Ativo'),
(931, 32, 145, '2026-03-04 16:38:30', 'Ativo'),
(932, 32, 148, '2026-03-04 16:38:30', 'Ativo'),
(933, 32, 153, '2026-03-04 16:38:30', 'Ativo'),
(934, 32, 159, '2026-03-04 16:38:30', 'Ativo'),
(935, 32, 164, '2026-03-04 16:38:30', 'Ativo'),
(936, 32, 169, '2026-03-04 16:38:30', 'Ativo'),
(937, 32, 174, '2026-03-04 16:38:30', 'Ativo'),
(938, 32, 189, '2026-03-04 16:38:30', 'Ativo'),
(939, 32, 190, '2026-03-04 16:38:30', 'Ativo'),
(940, 32, 194, '2026-03-04 16:38:30', 'Ativo'),
(941, 32, 204, '2026-03-04 16:38:30', 'Ativo'),
(942, 32, 205, '2026-03-04 16:38:30', 'Ativo'),
(943, 32, 210, '2026-03-04 16:38:30', 'Ativo'),
(944, 32, 211, '2026-03-04 16:38:30', 'Ativo'),
(945, 32, 251, '2026-03-04 16:38:30', 'Ativo'),
(946, 32, 253, '2026-03-04 16:38:30', 'Ativo'),
(947, 32, 262, '2026-03-04 16:38:30', 'Ativo'),
(948, 32, 267, '2026-03-04 16:38:30', 'Ativo'),
(949, 32, 268, '2026-03-04 16:38:30', 'Ativo'),
(950, 33, 74, '2026-03-04 16:40:00', 'Ativo'),
(951, 33, 80, '2026-03-04 16:40:00', 'Ativo'),
(952, 33, 93, '2026-03-04 16:40:00', 'Ativo'),
(953, 33, 100, '2026-03-04 16:40:00', 'Ativo'),
(954, 33, 101, '2026-03-04 16:40:00', 'Ativo'),
(955, 33, 105, '2026-03-04 16:40:00', 'Ativo'),
(956, 33, 107, '2026-03-04 16:40:00', 'Ativo'),
(957, 33, 109, '2026-03-04 16:40:00', 'Ativo'),
(958, 33, 110, '2026-03-04 16:40:00', 'Ativo'),
(959, 33, 112, '2026-03-04 16:40:00', 'Ativo'),
(960, 33, 114, '2026-03-04 16:40:00', 'Ativo'),
(961, 33, 115, '2026-03-04 16:40:00', 'Ativo'),
(962, 33, 120, '2026-03-04 16:40:00', 'Ativo'),
(963, 33, 122, '2026-03-04 16:40:00', 'Ativo'),
(964, 33, 123, '2026-03-04 16:40:00', 'Ativo'),
(965, 33, 124, '2026-03-04 16:40:00', 'Ativo'),
(966, 33, 126, '2026-03-04 16:40:00', 'Ativo'),
(967, 33, 127, '2026-03-04 16:40:00', 'Ativo'),
(968, 33, 128, '2026-03-04 16:40:00', 'Ativo'),
(969, 33, 129, '2026-03-04 16:40:00', 'Ativo'),
(970, 33, 130, '2026-03-04 16:40:00', 'Ativo'),
(971, 33, 131, '2026-03-04 16:40:00', 'Ativo'),
(972, 33, 132, '2026-03-04 16:40:00', 'Ativo'),
(973, 33, 143, '2026-03-04 16:40:00', 'Ativo'),
(974, 33, 145, '2026-03-04 16:40:00', 'Ativo'),
(975, 33, 148, '2026-03-04 16:40:00', 'Ativo'),
(976, 33, 153, '2026-03-04 16:40:00', 'Ativo'),
(977, 33, 159, '2026-03-04 16:40:00', 'Ativo'),
(978, 33, 164, '2026-03-04 16:40:00', 'Ativo'),
(979, 33, 169, '2026-03-04 16:40:00', 'Ativo'),
(980, 33, 174, '2026-03-04 16:40:00', 'Ativo'),
(981, 33, 189, '2026-03-04 16:40:00', 'Ativo'),
(982, 33, 190, '2026-03-04 16:40:00', 'Ativo'),
(983, 33, 194, '2026-03-04 16:40:00', 'Ativo'),
(984, 33, 204, '2026-03-04 16:40:00', 'Ativo'),
(985, 33, 205, '2026-03-04 16:40:00', 'Ativo'),
(986, 33, 210, '2026-03-04 16:40:00', 'Ativo'),
(987, 33, 211, '2026-03-04 16:40:00', 'Ativo'),
(988, 33, 251, '2026-03-04 16:40:00', 'Ativo'),
(989, 33, 253, '2026-03-04 16:40:00', 'Ativo'),
(990, 33, 262, '2026-03-04 16:40:00', 'Ativo'),
(991, 33, 267, '2026-03-04 16:40:00', 'Ativo'),
(992, 33, 268, '2026-03-04 16:40:00', 'Ativo'),
(993, 34, 74, '2026-03-04 16:40:52', 'Ativo'),
(994, 34, 80, '2026-03-04 16:40:52', 'Ativo'),
(995, 34, 93, '2026-03-04 16:40:52', 'Ativo'),
(996, 34, 100, '2026-03-04 16:40:52', 'Ativo'),
(997, 34, 101, '2026-03-04 16:40:52', 'Ativo'),
(998, 34, 105, '2026-03-04 16:40:52', 'Ativo'),
(999, 34, 107, '2026-03-04 16:40:52', 'Ativo'),
(1000, 34, 109, '2026-03-04 16:40:52', 'Ativo'),
(1001, 34, 110, '2026-03-04 16:40:52', 'Ativo'),
(1002, 34, 112, '2026-03-04 16:40:52', 'Ativo'),
(1003, 34, 114, '2026-03-04 16:40:52', 'Ativo'),
(1004, 34, 115, '2026-03-04 16:40:52', 'Ativo'),
(1005, 34, 120, '2026-03-04 16:40:52', 'Ativo'),
(1006, 34, 122, '2026-03-04 16:40:52', 'Ativo'),
(1007, 34, 123, '2026-03-04 16:40:52', 'Ativo'),
(1008, 34, 124, '2026-03-04 16:40:52', 'Ativo'),
(1009, 34, 126, '2026-03-04 16:40:52', 'Ativo'),
(1010, 34, 127, '2026-03-04 16:40:52', 'Ativo'),
(1011, 34, 128, '2026-03-04 16:40:52', 'Ativo'),
(1012, 34, 129, '2026-03-04 16:40:52', 'Ativo'),
(1013, 34, 130, '2026-03-04 16:40:52', 'Ativo'),
(1014, 34, 131, '2026-03-04 16:40:52', 'Ativo'),
(1015, 34, 132, '2026-03-04 16:40:52', 'Ativo'),
(1016, 34, 143, '2026-03-04 16:40:52', 'Ativo'),
(1017, 34, 145, '2026-03-04 16:40:52', 'Ativo'),
(1018, 34, 148, '2026-03-04 16:40:52', 'Ativo'),
(1019, 34, 153, '2026-03-04 16:40:52', 'Ativo'),
(1020, 34, 159, '2026-03-04 16:40:52', 'Ativo'),
(1021, 34, 164, '2026-03-04 16:40:52', 'Ativo'),
(1022, 34, 169, '2026-03-04 16:40:52', 'Ativo'),
(1023, 34, 174, '2026-03-04 16:40:52', 'Ativo'),
(1024, 34, 189, '2026-03-04 16:40:52', 'Ativo'),
(1025, 34, 190, '2026-03-04 16:40:52', 'Ativo'),
(1026, 34, 194, '2026-03-04 16:40:52', 'Ativo'),
(1027, 34, 204, '2026-03-04 16:40:52', 'Ativo'),
(1028, 34, 205, '2026-03-04 16:40:52', 'Ativo'),
(1029, 34, 210, '2026-03-04 16:40:52', 'Ativo'),
(1030, 34, 211, '2026-03-04 16:40:52', 'Ativo'),
(1031, 34, 251, '2026-03-04 16:40:52', 'Ativo'),
(1032, 34, 253, '2026-03-04 16:40:52', 'Ativo'),
(1033, 34, 262, '2026-03-04 16:40:52', 'Ativo'),
(1034, 34, 267, '2026-03-04 16:40:52', 'Ativo'),
(1035, 34, 268, '2026-03-04 16:40:52', 'Ativo'),
(1036, 35, 81, '2026-03-04 16:43:40', 'Ativo'),
(1037, 35, 83, '2026-03-04 16:43:40', 'Ativo'),
(1038, 35, 121, '2026-03-04 16:43:40', 'Ativo'),
(1039, 35, 133, '2026-03-04 16:43:40', 'Ativo'),
(1040, 35, 135, '2026-03-04 16:43:40', 'Ativo'),
(1041, 35, 139, '2026-03-04 16:43:40', 'Ativo'),
(1042, 35, 140, '2026-03-04 16:43:40', 'Ativo'),
(1043, 35, 142, '2026-03-04 16:43:40', 'Ativo'),
(1044, 35, 146, '2026-03-04 16:43:40', 'Ativo'),
(1045, 35, 147, '2026-03-04 16:43:40', 'Ativo'),
(1046, 35, 149, '2026-03-04 16:43:40', 'Ativo'),
(1047, 35, 154, '2026-03-04 16:43:40', 'Ativo'),
(1048, 35, 155, '2026-03-04 16:43:40', 'Ativo'),
(1049, 35, 156, '2026-03-04 16:43:40', 'Ativo'),
(1050, 35, 157, '2026-03-04 16:43:40', 'Ativo'),
(1051, 35, 162, '2026-03-04 16:43:40', 'Ativo'),
(1052, 35, 166, '2026-03-04 16:43:40', 'Ativo'),
(1053, 35, 171, '2026-03-04 16:43:40', 'Ativo'),
(1054, 35, 175, '2026-03-04 16:43:40', 'Ativo'),
(1055, 35, 176, '2026-03-04 16:43:40', 'Ativo'),
(1056, 35, 177, '2026-03-04 16:43:40', 'Ativo'),
(1057, 35, 178, '2026-03-04 16:43:40', 'Ativo'),
(1058, 35, 179, '2026-03-04 16:43:40', 'Ativo'),
(1059, 35, 180, '2026-03-04 16:43:40', 'Ativo'),
(1060, 35, 182, '2026-03-04 16:43:40', 'Ativo'),
(1061, 35, 195, '2026-03-04 16:43:40', 'Ativo'),
(1062, 35, 196, '2026-03-04 16:43:40', 'Ativo'),
(1063, 35, 197, '2026-03-04 16:43:40', 'Ativo'),
(1064, 35, 199, '2026-03-04 16:43:40', 'Ativo'),
(1065, 35, 200, '2026-03-04 16:43:40', 'Ativo'),
(1066, 35, 201, '2026-03-04 16:43:40', 'Ativo'),
(1067, 35, 203, '2026-03-04 16:43:40', 'Ativo'),
(1068, 35, 207, '2026-03-04 16:43:40', 'Ativo'),
(1069, 35, 209, '2026-03-04 16:43:40', 'Ativo'),
(1070, 35, 255, '2026-03-04 16:43:40', 'Ativo'),
(1071, 35, 256, '2026-03-04 16:43:40', 'Ativo'),
(1072, 35, 257, '2026-03-04 16:43:40', 'Ativo'),
(1073, 35, 258, '2026-03-04 16:43:40', 'Ativo'),
(1074, 35, 259, '2026-03-04 16:43:40', 'Ativo'),
(1075, 35, 263, '2026-03-04 16:43:40', 'Ativo'),
(1076, 35, 264, '2026-03-04 16:43:40', 'Ativo'),
(1077, 36, 81, '2026-03-04 16:44:39', 'Ativo'),
(1078, 36, 83, '2026-03-04 16:44:39', 'Ativo'),
(1079, 36, 121, '2026-03-04 16:44:39', 'Ativo'),
(1080, 36, 133, '2026-03-04 16:44:39', 'Ativo'),
(1081, 36, 135, '2026-03-04 16:44:39', 'Ativo'),
(1082, 36, 139, '2026-03-04 16:44:39', 'Ativo'),
(1083, 36, 140, '2026-03-04 16:44:39', 'Ativo'),
(1084, 36, 142, '2026-03-04 16:44:39', 'Ativo'),
(1085, 36, 146, '2026-03-04 16:44:39', 'Ativo'),
(1086, 36, 147, '2026-03-04 16:44:39', 'Ativo'),
(1087, 36, 149, '2026-03-04 16:44:39', 'Ativo'),
(1088, 36, 154, '2026-03-04 16:44:39', 'Ativo'),
(1089, 36, 155, '2026-03-04 16:44:39', 'Ativo'),
(1090, 36, 156, '2026-03-04 16:44:39', 'Ativo'),
(1091, 36, 157, '2026-03-04 16:44:39', 'Ativo'),
(1092, 36, 162, '2026-03-04 16:44:39', 'Ativo'),
(1093, 36, 166, '2026-03-04 16:44:39', 'Ativo'),
(1094, 36, 171, '2026-03-04 16:44:39', 'Ativo'),
(1095, 36, 175, '2026-03-04 16:44:39', 'Ativo'),
(1096, 36, 176, '2026-03-04 16:44:39', 'Ativo'),
(1097, 36, 177, '2026-03-04 16:44:39', 'Ativo'),
(1098, 36, 178, '2026-03-04 16:44:39', 'Ativo'),
(1099, 36, 179, '2026-03-04 16:44:39', 'Ativo'),
(1100, 36, 180, '2026-03-04 16:44:39', 'Ativo'),
(1101, 36, 182, '2026-03-04 16:44:39', 'Ativo'),
(1102, 36, 195, '2026-03-04 16:44:39', 'Ativo'),
(1103, 36, 196, '2026-03-04 16:44:39', 'Ativo'),
(1104, 36, 197, '2026-03-04 16:44:39', 'Ativo'),
(1105, 36, 199, '2026-03-04 16:44:39', 'Ativo'),
(1106, 36, 200, '2026-03-04 16:44:39', 'Ativo'),
(1107, 36, 201, '2026-03-04 16:44:39', 'Ativo'),
(1108, 36, 203, '2026-03-04 16:44:39', 'Ativo'),
(1109, 36, 207, '2026-03-04 16:44:39', 'Ativo'),
(1110, 36, 209, '2026-03-04 16:44:39', 'Ativo'),
(1111, 36, 255, '2026-03-04 16:44:39', 'Ativo'),
(1112, 36, 256, '2026-03-04 16:44:39', 'Ativo'),
(1113, 36, 257, '2026-03-04 16:44:39', 'Ativo'),
(1114, 36, 258, '2026-03-04 16:44:39', 'Ativo'),
(1115, 36, 259, '2026-03-04 16:44:39', 'Ativo'),
(1116, 36, 263, '2026-03-04 16:44:39', 'Ativo'),
(1117, 36, 264, '2026-03-04 16:44:39', 'Ativo'),
(1118, 37, 81, '2026-03-04 16:45:31', 'Ativo'),
(1119, 37, 83, '2026-03-04 16:45:31', 'Ativo');
INSERT INTO `matriculas` (`id`, `turma_id`, `beneficiario_id`, `data_matricula`, `status`) VALUES
(1120, 37, 121, '2026-03-04 16:45:31', 'Ativo'),
(1121, 37, 133, '2026-03-04 16:45:31', 'Ativo'),
(1122, 37, 135, '2026-03-04 16:45:31', 'Ativo'),
(1123, 37, 139, '2026-03-04 16:45:31', 'Ativo'),
(1124, 37, 140, '2026-03-04 16:45:31', 'Ativo'),
(1125, 37, 142, '2026-03-04 16:45:31', 'Ativo'),
(1126, 37, 146, '2026-03-04 16:45:31', 'Ativo'),
(1127, 37, 147, '2026-03-04 16:45:31', 'Ativo'),
(1128, 37, 149, '2026-03-04 16:45:31', 'Ativo'),
(1129, 37, 154, '2026-03-04 16:45:31', 'Ativo'),
(1130, 37, 155, '2026-03-04 16:45:31', 'Ativo'),
(1131, 37, 156, '2026-03-04 16:45:31', 'Ativo'),
(1132, 37, 157, '2026-03-04 16:45:31', 'Ativo'),
(1133, 37, 162, '2026-03-04 16:45:31', 'Ativo'),
(1134, 37, 166, '2026-03-04 16:45:31', 'Ativo'),
(1135, 37, 171, '2026-03-04 16:45:31', 'Ativo'),
(1136, 37, 175, '2026-03-04 16:45:31', 'Ativo'),
(1137, 37, 176, '2026-03-04 16:45:31', 'Ativo'),
(1138, 37, 177, '2026-03-04 16:45:31', 'Ativo'),
(1139, 37, 178, '2026-03-04 16:45:31', 'Ativo'),
(1140, 37, 179, '2026-03-04 16:45:31', 'Ativo'),
(1141, 37, 180, '2026-03-04 16:45:31', 'Ativo'),
(1142, 37, 182, '2026-03-04 16:45:31', 'Ativo'),
(1143, 37, 195, '2026-03-04 16:45:31', 'Ativo'),
(1144, 37, 196, '2026-03-04 16:45:31', 'Ativo'),
(1145, 37, 197, '2026-03-04 16:45:31', 'Ativo'),
(1146, 37, 199, '2026-03-04 16:45:31', 'Ativo'),
(1147, 37, 200, '2026-03-04 16:45:31', 'Ativo'),
(1148, 37, 201, '2026-03-04 16:45:31', 'Ativo'),
(1149, 37, 203, '2026-03-04 16:45:31', 'Ativo'),
(1150, 37, 207, '2026-03-04 16:45:31', 'Ativo'),
(1151, 37, 209, '2026-03-04 16:45:31', 'Ativo'),
(1152, 37, 255, '2026-03-04 16:45:31', 'Ativo'),
(1153, 37, 256, '2026-03-04 16:45:31', 'Ativo'),
(1154, 37, 257, '2026-03-04 16:45:31', 'Ativo'),
(1155, 37, 258, '2026-03-04 16:45:31', 'Ativo'),
(1156, 37, 259, '2026-03-04 16:45:31', 'Ativo'),
(1157, 37, 263, '2026-03-04 16:45:31', 'Ativo'),
(1158, 37, 264, '2026-03-04 16:45:31', 'Ativo'),
(1159, 38, 102, '2026-03-04 16:47:47', 'Ativo'),
(1160, 38, 125, '2026-03-04 16:47:47', 'Ativo'),
(1161, 38, 134, '2026-03-04 16:47:47', 'Ativo'),
(1162, 38, 136, '2026-03-04 16:47:47', 'Ativo'),
(1163, 38, 137, '2026-03-04 16:47:47', 'Ativo'),
(1164, 38, 138, '2026-03-04 16:47:47', 'Ativo'),
(1165, 38, 141, '2026-03-04 16:47:47', 'Ativo'),
(1166, 38, 144, '2026-03-04 16:47:47', 'Ativo'),
(1167, 38, 158, '2026-03-04 16:47:47', 'Ativo'),
(1168, 38, 160, '2026-03-04 16:47:47', 'Ativo'),
(1169, 38, 161, '2026-03-04 16:47:47', 'Ativo'),
(1170, 38, 163, '2026-03-04 16:47:47', 'Ativo'),
(1171, 38, 165, '2026-03-04 16:47:47', 'Ativo'),
(1172, 38, 167, '2026-03-04 16:47:47', 'Ativo'),
(1173, 38, 168, '2026-03-04 16:47:47', 'Ativo'),
(1174, 38, 170, '2026-03-04 16:47:47', 'Ativo'),
(1175, 38, 172, '2026-03-04 16:47:47', 'Ativo'),
(1176, 38, 181, '2026-03-04 16:47:47', 'Ativo'),
(1177, 38, 183, '2026-03-04 16:47:47', 'Ativo'),
(1178, 38, 185, '2026-03-04 16:47:47', 'Ativo'),
(1179, 38, 186, '2026-03-04 16:47:47', 'Ativo'),
(1180, 38, 187, '2026-03-04 16:47:47', 'Ativo'),
(1181, 38, 188, '2026-03-04 16:47:47', 'Ativo'),
(1182, 38, 191, '2026-03-04 16:47:47', 'Ativo'),
(1183, 38, 192, '2026-03-04 16:47:47', 'Ativo'),
(1184, 38, 193, '2026-03-04 16:47:47', 'Ativo'),
(1185, 38, 198, '2026-03-04 16:47:47', 'Ativo'),
(1186, 38, 202, '2026-03-04 16:47:47', 'Ativo'),
(1187, 38, 206, '2026-03-04 16:47:47', 'Ativo'),
(1188, 38, 208, '2026-03-04 16:47:47', 'Ativo'),
(1189, 38, 246, '2026-03-04 16:47:47', 'Ativo'),
(1190, 38, 250, '2026-03-04 16:47:47', 'Ativo'),
(1191, 38, 252, '2026-03-04 16:47:47', 'Ativo'),
(1192, 38, 265, '2026-03-04 16:47:47', 'Ativo'),
(1193, 38, 266, '2026-03-04 16:47:47', 'Ativo'),
(1194, 38, 267, '2026-03-04 16:47:47', 'Ativo'),
(1195, 38, 270, '2026-03-04 16:47:47', 'Ativo'),
(1196, 39, 102, '2026-03-04 16:50:58', 'Ativo'),
(1197, 39, 125, '2026-03-04 16:50:58', 'Ativo'),
(1198, 39, 134, '2026-03-04 16:50:58', 'Ativo'),
(1199, 39, 136, '2026-03-04 16:50:58', 'Ativo'),
(1200, 39, 137, '2026-03-04 16:50:58', 'Ativo'),
(1201, 39, 138, '2026-03-04 16:50:58', 'Ativo'),
(1202, 39, 141, '2026-03-04 16:50:58', 'Ativo'),
(1203, 39, 144, '2026-03-04 16:50:58', 'Ativo'),
(1204, 39, 158, '2026-03-04 16:50:58', 'Ativo'),
(1205, 39, 160, '2026-03-04 16:50:58', 'Ativo'),
(1206, 39, 161, '2026-03-04 16:50:58', 'Ativo'),
(1207, 39, 163, '2026-03-04 16:50:58', 'Ativo'),
(1208, 39, 165, '2026-03-04 16:50:58', 'Ativo'),
(1209, 39, 167, '2026-03-04 16:50:58', 'Ativo'),
(1210, 39, 168, '2026-03-04 16:50:58', 'Ativo'),
(1211, 39, 170, '2026-03-04 16:50:58', 'Ativo'),
(1212, 39, 172, '2026-03-04 16:50:58', 'Ativo'),
(1213, 39, 181, '2026-03-04 16:50:58', 'Ativo'),
(1214, 39, 183, '2026-03-04 16:50:58', 'Ativo'),
(1215, 39, 185, '2026-03-04 16:50:58', 'Ativo'),
(1216, 39, 186, '2026-03-04 16:50:58', 'Ativo'),
(1217, 39, 187, '2026-03-04 16:50:58', 'Ativo'),
(1218, 39, 188, '2026-03-04 16:50:58', 'Ativo'),
(1219, 39, 191, '2026-03-04 16:50:58', 'Ativo'),
(1220, 39, 192, '2026-03-04 16:50:58', 'Ativo'),
(1221, 39, 193, '2026-03-04 16:50:58', 'Ativo'),
(1222, 39, 198, '2026-03-04 16:50:58', 'Ativo'),
(1223, 39, 202, '2026-03-04 16:50:58', 'Ativo'),
(1224, 39, 206, '2026-03-04 16:50:58', 'Ativo'),
(1225, 39, 208, '2026-03-04 16:50:58', 'Ativo'),
(1226, 39, 246, '2026-03-04 16:50:58', 'Ativo'),
(1227, 39, 250, '2026-03-04 16:50:58', 'Ativo'),
(1228, 39, 252, '2026-03-04 16:50:58', 'Ativo'),
(1229, 39, 265, '2026-03-04 16:50:58', 'Ativo'),
(1230, 39, 266, '2026-03-04 16:50:58', 'Ativo'),
(1231, 39, 267, '2026-03-04 16:50:58', 'Ativo'),
(1232, 39, 270, '2026-03-04 16:50:58', 'Ativo'),
(1233, 40, 102, '2026-03-04 16:52:34', 'Ativo'),
(1234, 40, 125, '2026-03-04 16:52:34', 'Ativo'),
(1235, 40, 134, '2026-03-04 16:52:34', 'Ativo'),
(1236, 40, 136, '2026-03-04 16:52:34', 'Ativo'),
(1237, 40, 137, '2026-03-04 16:52:34', 'Ativo'),
(1238, 40, 138, '2026-03-04 16:52:34', 'Ativo'),
(1239, 40, 141, '2026-03-04 16:52:34', 'Ativo'),
(1240, 40, 144, '2026-03-04 16:52:34', 'Ativo'),
(1241, 40, 158, '2026-03-04 16:52:34', 'Ativo'),
(1242, 40, 160, '2026-03-04 16:52:34', 'Ativo'),
(1243, 40, 161, '2026-03-04 16:52:34', 'Ativo'),
(1244, 40, 163, '2026-03-04 16:52:34', 'Ativo'),
(1245, 40, 165, '2026-03-04 16:52:34', 'Ativo'),
(1246, 40, 167, '2026-03-04 16:52:34', 'Ativo'),
(1247, 40, 168, '2026-03-04 16:52:34', 'Ativo'),
(1248, 40, 170, '2026-03-04 16:52:34', 'Ativo'),
(1249, 40, 172, '2026-03-04 16:52:34', 'Ativo'),
(1250, 40, 181, '2026-03-04 16:52:34', 'Ativo'),
(1251, 40, 183, '2026-03-04 16:52:34', 'Ativo'),
(1252, 40, 185, '2026-03-04 16:52:34', 'Ativo'),
(1253, 40, 186, '2026-03-04 16:52:34', 'Ativo'),
(1254, 40, 187, '2026-03-04 16:52:34', 'Ativo'),
(1255, 40, 188, '2026-03-04 16:52:34', 'Ativo'),
(1256, 40, 191, '2026-03-04 16:52:34', 'Ativo'),
(1257, 40, 192, '2026-03-04 16:52:34', 'Ativo'),
(1258, 40, 193, '2026-03-04 16:52:34', 'Ativo'),
(1259, 40, 198, '2026-03-04 16:52:34', 'Ativo'),
(1260, 40, 202, '2026-03-04 16:52:34', 'Ativo'),
(1261, 40, 206, '2026-03-04 16:52:34', 'Ativo'),
(1262, 40, 208, '2026-03-04 16:52:34', 'Ativo'),
(1263, 40, 246, '2026-03-04 16:52:34', 'Ativo'),
(1264, 40, 250, '2026-03-04 16:52:34', 'Ativo'),
(1265, 40, 252, '2026-03-04 16:52:34', 'Ativo'),
(1266, 40, 265, '2026-03-04 16:52:34', 'Ativo'),
(1267, 40, 266, '2026-03-04 16:52:34', 'Ativo'),
(1268, 40, 267, '2026-03-04 16:52:34', 'Ativo'),
(1269, 40, 270, '2026-03-04 16:52:34', 'Ativo'),
(1270, 37, 41, '2026-03-05 14:37:10', 'Ativo'),
(1271, 36, 41, '2026-03-05 14:37:37', 'Ativo'),
(1272, 35, 41, '2026-03-05 14:37:56', 'Ativo'),
(1273, 24, 41, '2026-03-05 14:38:22', 'Ativo'),
(1274, 15, 41, '2026-03-05 14:38:47', 'Ativo'),
(1275, 40, 245, '2026-03-05 14:40:08', 'Ativo'),
(1276, 39, 245, '2026-03-05 14:40:20', 'Ativo'),
(1277, 38, 245, '2026-03-05 14:40:32', 'Ativo'),
(1278, 25, 245, '2026-03-05 14:40:49', 'Ativo'),
(1279, 17, 245, '2026-03-05 14:41:19', 'Ativo'),
(1280, 41, 272, '2026-03-05 15:07:07', 'Ativo'),
(1281, 41, 273, '2026-03-05 15:07:18', 'Ativo'),
(1282, 41, 274, '2026-03-05 15:07:29', 'Ativo'),
(1283, 41, 277, '2026-03-05 15:07:58', 'Ativo'),
(1284, 41, 285, '2026-03-05 15:08:35', 'Ativo'),
(1285, 41, 287, '2026-03-05 15:08:47', 'Ativo'),
(1286, 41, 290, '2026-03-05 15:08:59', 'Ativo'),
(1287, 41, 292, '2026-03-05 15:09:16', 'Ativo'),
(1288, 41, 295, '2026-03-05 15:09:25', 'Ativo'),
(1289, 41, 296, '2026-03-05 15:09:50', 'Ativo'),
(1290, 41, 297, '2026-03-05 15:10:12', 'Ativo'),
(1291, 41, 298, '2026-03-05 15:10:35', 'Ativo'),
(1292, 41, 279, '2026-03-05 15:10:54', 'Ativo'),
(1293, 41, 280, '2026-03-05 15:11:11', 'Ativo'),
(1294, 41, 301, '2026-03-05 15:11:29', 'Ativo'),
(1295, 41, 300, '2026-03-05 15:11:43', 'Ativo'),
(1296, 41, 302, '2026-03-05 15:11:59', 'Ativo'),
(1297, 41, 303, '2026-03-05 15:12:25', 'Ativo'),
(1298, 41, 304, '2026-03-05 15:12:47', 'Ativo'),
(1299, 42, 276, '2026-03-05 15:19:04', 'Ativo'),
(1300, 42, 284, '2026-03-05 15:21:28', 'Ativo'),
(1301, 42, 286, '2026-03-05 15:21:42', 'Ativo'),
(1302, 42, 291, '2026-03-05 15:22:01', 'Ativo'),
(1303, 42, 289, '2026-03-05 15:22:22', 'Ativo'),
(1304, 42, 293, '2026-03-05 15:22:35', 'Ativo'),
(1305, 42, 294, '2026-03-05 15:22:54', 'Ativo'),
(1306, 42, 299, '2026-03-05 15:23:12', 'Ativo');

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
(1, 'LUANDERSON ARLINDO DE OLIVEIRA', NULL, NULL, '2003-06-27 00:00:00.000', 'SILVANIA JOSEFA PEREIRA', NULL, '14047504440', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.535'),
(2, 'HELOÍSA BEATRIZ DA SILVA HORA', NULL, NULL, '2001-01-02 00:00:00.000', 'ELIANE MARIA DA SILVA HORA', NULL, '70931193443', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.540'),
(3, 'FERNANDA DA SILVA ANDRINI', NULL, NULL, '1993-04-23 00:00:00.000', 'JOANA ISAURA DA SILVA ANDRINI', NULL, '10585124477', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.542'),
(4, 'ANA BEATRIZ DA SILVA FELIX', NULL, NULL, '2004-07-05 00:00:00.000', 'JOSINEIDE MARIA DA SILVA', NULL, '16662416444', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.543'),
(5, 'ANA PAULA INACIA DA SILVA', NULL, NULL, '1982-05-02 00:00:00.000', 'INACIA MARIA DA SILVA', NULL, '06481848466', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.544'),
(6, 'MARIA EDUARDA RODRIGUES VASCONCELOS', NULL, NULL, '1999-09-02 00:00:00.000', 'CLAUDIA DANIELLA RODRIGUES DA SILVA', NULL, '10814202438', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.547'),
(7, 'LENIRA BARBOSA TORRES', NULL, NULL, '1951-06-06 00:00:00.000', 'MARIA BARBOSA DOS SANTOS', NULL, '38835851491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.548'),
(8, 'JOSEFA MOREIRA PEREIRA DA SILVA', NULL, NULL, '1963-11-20 00:00:00.000', 'IZAURA VICENTE DA SILVA', NULL, '04847124464', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.550'),
(9, 'MANOEL PEREIRA DA SILVA', NULL, NULL, '1960-07-10 00:00:00.000', 'JOSEFA PEREIRA DA SILVA', NULL, '04413386825', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.551'),
(10, 'MARIA JOSÉ DOS SANTOS', NULL, NULL, '1943-01-29 00:00:00.000', 'JOSEFA CARNEIRO DE VASCONCELOS', NULL, '23195614472', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.552'),
(11, 'MARIA DE LOURDES MEDEIROS', NULL, NULL, '1964-06-26 00:00:00.000', 'MARIA JOSÉ DOS SANTOS', NULL, '43749631468', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.553'),
(12, 'FIRMINA MONTEIRO DE MOURA', NULL, NULL, '1962-01-01 00:00:00.000', 'MARILUCIA MONTEIRO DE MOURA', NULL, '37759388420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.554'),
(13, 'MARIA SEVERINA DE LIMA', NULL, NULL, '1951-01-29 00:00:00.000', 'SEVERINA JOSEFA DA CONCEIÇÃO', NULL, '29024129400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.555'),
(14, 'SEVERINA DE FATIMA SOARES', NULL, NULL, '1956-08-06 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '22405631415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.556'),
(15, 'MARIA MARQUES PINHEIRO', NULL, NULL, '1964-04-25 00:00:00.000', 'FRANCISCA JOSEFA DA CONCEIÇÃO', NULL, '58038337468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.557'),
(16, 'MARIA DO CARMO DE LOURDES', NULL, NULL, '1953-02-08 00:00:00.000', 'MARIA DE LOURDES DA CONCEIÇÃO', NULL, '22404503472', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.557'),
(17, 'MARIA DE LOURDES DOS SANTOS', NULL, NULL, '1962-04-14 00:00:00.000', 'SEVERINA URÇULINA DOS SANTOS', NULL, '02093095475', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.558'),
(18, 'MARIA JOSÉ GOMES DE ARAUJO', NULL, NULL, '1961-03-09 00:00:00.000', 'ALZIRA CORREIA DE MELO', NULL, '06164146410', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.558'),
(19, 'JOSEFA SEVERINA DOS SANTOS', NULL, NULL, '1960-12-14 00:00:00.000', 'SEVERINA MARIA DOS SANTOS', NULL, '45041822468', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.558'),
(20, 'JOSEFA ALBERTINA DE SOUZA', NULL, NULL, '1950-02-13 00:00:00.000', 'ALBERTINA FRANCISCA DA SILVA', NULL, '54411319420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.559'),
(21, 'JOANA IRACEMA GOMES DA SILVA', NULL, NULL, '1945-06-24 00:00:00.000', 'IRACEMA MARIA DA SILVA', NULL, '43098509449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.560'),
(22, 'JOSEFA  ALVES DE ALMEIDA CABRAL', NULL, NULL, '1956-02-19 00:00:00.000', 'JOSEFA ALVES DE ALMEIDA', NULL, '28267303472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.560'),
(23, 'ENEDINA JOSÉ LOPES DE VASCONCELOS', NULL, NULL, '1960-03-13 00:00:00.000', 'SEVERINO JOSÉ LOPE', NULL, '97543080478', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.560'),
(24, 'MARIA JOSÉ RAMOS DA SILVA', NULL, NULL, '1955-01-04 00:00:00.000', 'LEONILA MARIA RAMOS', NULL, '40009688404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.561'),
(25, 'SEVERINA MARIA DE ARAÚJO LIMA', NULL, NULL, '1950-11-19 00:00:00.000', 'MARIA STELA DE ARAÚJO', NULL, '28511000410', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.561'),
(26, 'MARIA GLEICE SANTIAGO RIBEIRO', NULL, NULL, '1963-05-03 00:00:00.000', 'RUFINA SEBASTIANA RIBEIRO', NULL, '90994949472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.562'),
(27, 'MARIA IRENE DA SILVA', NULL, NULL, '1964-09-10 00:00:00.000', 'IRENE SEVERINA DA CONCEIÇÃO', NULL, '71591613434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.562'),
(28, 'MARIA JOSÉ DA CONCEIÇÃO SANTANA', NULL, NULL, '1966-01-08 00:00:00.000', 'MARIA LUZIA DA CONCEIÇÃO', NULL, '50706551400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.563'),
(29, 'MARIA MARQUES DOS SANTOS', NULL, NULL, '1954-12-25 00:00:00.000', 'SEVERINA MARQUES DOS SANTOS', NULL, '26263898895', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.564'),
(30, 'MARIA JOSEFA DOS SANTOS', NULL, NULL, '1958-11-13 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '62419471415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.565'),
(31, 'MARIA JOSÉ DA SILVA MOURA', NULL, NULL, '1959-05-05 00:00:00.000', 'GUILHERMINA INÁCIO DA SILVA', NULL, '39044629468', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.565'),
(32, 'JOSÉ FERNANDES BORBA SOBRINHO', NULL, NULL, '1962-04-26 00:00:00.000', 'MARIA ROSA DO VALE', NULL, '41541537491', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.566'),
(33, 'ODETE SEVERINA DE SANTANA', NULL, NULL, '1955-03-11 00:00:00.000', 'SEVERINA MARIA DE SANTANA', NULL, '71653716487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.566'),
(34, 'SEVERINO RAMOS DOS SANTOS', NULL, NULL, '1964-08-07 00:00:00.000', 'ANGELITA BEZERRA DA SILVA', NULL, '39897834400', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.566'),
(35, 'MARLUCE MARIA PEREIRA', NULL, NULL, '1960-01-01 00:00:00.000', 'COSMA MARIA BATISTA', NULL, '69665443453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.567'),
(36, 'MARIA JOVELINA DA CONCEIÇÃO', NULL, NULL, '1964-05-31 00:00:00.000', 'MARIA JOVELINA DA CONCEIÇÃO', NULL, '03956746465', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.567'),
(37, 'SEVERINA MARIA BATISTA DE SOUZA', NULL, NULL, '1957-02-17 00:00:00.000', 'COSMA MARIA BATISTA', NULL, '39754260478', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.568'),
(38, 'SEVERINA GESUINA DA SILVA', NULL, NULL, '1950-08-22 00:00:00.000', 'JOSEFA JESUINA DA CONCEIÇÃO', NULL, '02532400420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.568'),
(39, 'VALDIRA MARIA DA SILVA', NULL, NULL, '1962-01-30 00:00:00.000', 'JOSEFA MARIA DA SILVA', NULL, '32200595468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.569'),
(40, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1961-04-29 00:00:00.000', 'MARIA JOSE DA CONCEIÇÃO', NULL, '74337750487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.569'),
(41, 'SEVERINO FRANCISCO DA CRUZ', NULL, NULL, '1959-05-29 00:00:00.000', 'ALICE FRANCISCA DA CRUZ', NULL, '23552492453', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.569'),
(42, 'MARIA MARINA MONTEIRO', NULL, NULL, '1951-09-14 00:00:00.000', 'MARINA MADALENA DE JESUS', NULL, '40009580468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.570'),
(43, 'SEVERINA TEREZA DE SANTANA', NULL, NULL, '1957-10-18 00:00:00.000', 'SEVERINA TEREZA DE JESUS FILHA', NULL, '66804540425', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.570'),
(44, 'TEREZINHA EVANGELISTA FERREIRA DA SILVA', NULL, NULL, '1956-06-08 00:00:00.000', 'JOSEFA ALEXANDRINA DA CONCEIÇÃO', NULL, '07115574464', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.571'),
(45, 'MARIA ROSA DE BARROS', NULL, NULL, '1944-01-10 00:00:00.000', 'MARIA ROSA DO ESPÍRITO SANTO', NULL, '27086275468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.571'),
(46, 'MARIA DE FÁTIMA SANTOS', NULL, NULL, '1965-05-23 00:00:00.000', 'ROSA SEVERINA DA CONCEIÇÃO', NULL, '51370204434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.572'),
(47, 'BERNADETE IRENE DA HORA', NULL, NULL, '1963-12-10 00:00:00.000', 'IRENE FELISMINA DA HORA', NULL, '42872847472', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.572'),
(48, 'IZALTINA MARIA DE ARRUDA', NULL, NULL, '1955-10-20 00:00:00.000', 'MARIA JOSÉ DO NASCIMENTO', NULL, '30005086434', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.573'),
(49, 'ANDREIS VICTOR SANTANA DOS SANTOS', NULL, NULL, '1999-12-07 00:00:00.000', 'NORMA SEVERINA DE SANTANA SANTOS', NULL, '11638602476', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.574'),
(50, 'MARIA APARECIDA DE SANTANA HARM', NULL, NULL, '1942-09-10 00:00:00.000', 'ANTÔNIA BARBOSA DE SANTANA', NULL, '80957757468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.574'),
(51, 'JACIEDINA DA SILVA LIMA', NULL, NULL, '1988-07-13 00:00:00.000', 'HENEDINA SANTANA DA SILVA LIMA', NULL, '07196922450', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.575'),
(52, 'LUCIA MARIA DA SILVA', NULL, NULL, '1955-03-21 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '74264591449', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.576'),
(53, 'TATIANE MARIA DA SILVA', NULL, NULL, '1989-02-26 00:00:00.000', 'MARIA JOSÉ DE SOUZA', NULL, '01576152430', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.577'),
(54, 'ANTONIO SEVERINO DOS SANTOS', NULL, NULL, '1961-06-13 00:00:00.000', 'REGINA FRANCISCA DA CONCEIÇÃO', NULL, '25395130420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.577'),
(55, 'PETRONILA CANDIDA DE FRANÇA', NULL, NULL, '1951-12-25 00:00:00.000', 'VIRGINIA CANDIDA DE ALMEIDA', NULL, '43884245449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.578'),
(56, 'SEVERINA RODRIGUES DE ALMEIDA', NULL, NULL, '1959-12-28 00:00:00.000', 'SEVERINA RODRIGUES DE ALMEIDA', NULL, '02144942412', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.579'),
(57, 'SEVERINO MANOEL TAVAREZ', NULL, NULL, '1957-01-09 00:00:00.000', 'MARIA VIRGINIA DA CONCEIÇÃO', NULL, '35242515449', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.579'),
(58, 'ARTHUR YURE DOS SANTOS PEREIRA', NULL, NULL, '1995-10-19 00:00:00.000', 'LUCIANAA DOS SANTOS PEREIRA', NULL, '10651073405', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.580'),
(59, 'MARÍLIA EDUARDA DOS SANTOS', NULL, NULL, '1995-03-31 00:00:00.000', 'ALEXSANDRA ENEAS RIBEIRO', NULL, '11704862400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.580'),
(60, 'NATÁLIA ESMERALDA DA SILVA', NULL, NULL, '1988-12-22 00:00:00.000', 'ESMERALDA PAULINA DA SILVA', NULL, '10040744418', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.581'),
(61, 'MARIA YSTELLA AUREA DE LIMA', NULL, NULL, '1993-04-05 00:00:00.000', 'IAURA LUZIA DE BARROS LIMA', NULL, '09718666435', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.582'),
(62, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1955-06-29 00:00:00.000', 'JOSEFA MARIA DA SILVA', NULL, '40008746400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.582'),
(63, 'VITÓRIA SILVA DE OLIVEIRA', NULL, NULL, '2005-09-26 00:00:00.000', 'GIRLEIDE SEVERINA DA SILVA', NULL, '15767716447', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.585'),
(64, 'APARÍCIO LUIS DOS SANTOS', NULL, NULL, '1997-01-29 00:00:00.000', 'MARIA DE FÁTIMA DO ESPÍRITO SANTO', NULL, '11654804410', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.586'),
(65, 'MARIA JOSÉ DE LIMA ALVES', NULL, NULL, '1961-07-15 00:00:00.000', 'SEVERINA MARIA DE LIMA', NULL, '52733882449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.587'),
(66, 'SEBASTIÃO INACIO DA SILVA', NULL, NULL, '1957-10-19 00:00:00.000', 'ELVIRA MARIA DA CONCEIÇÃO', NULL, '17922747420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.587'),
(67, 'VERA LUCIA BARBOSA DE SOUSA MENEZES', NULL, NULL, '1964-08-09 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '03914805455', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.588'),
(68, 'PAULO JOSE DE SANTANA', NULL, NULL, '1982-07-08 00:00:00.000', 'MARIA SEVERINA DE SANTANA', NULL, '04084130427', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.588'),
(69, 'LUZIA MARIA BARBOSA SILVA', NULL, NULL, '1962-10-18 00:00:00.000', 'JOSEFA MARIA BARBOSA', NULL, '58555439434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.589'),
(70, 'JOSÉ LUIZ DE FRANÇA', NULL, NULL, '1956-11-20 00:00:00.000', 'MARIA MARCELINA DE MELO', NULL, '16553233420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.589'),
(71, 'TERESINHA MARINA MONTEIRO DA SILVA', NULL, NULL, '1963-05-13 00:00:00.000', 'MARINA MADALENA  DA CONCEIÇÃO', NULL, '39937232449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.590'),
(72, 'JOSEFA OLIMPIA DA SILVA', NULL, NULL, '1953-09-12 00:00:00.000', 'OLIMPIA MARIA DOS SANTOS', NULL, '02114490408', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.590'),
(73, 'MARIA SEVERINA DE LIMA', NULL, NULL, '1962-02-21 00:00:00.000', 'SEVERINA JOSEFA DA CONCEIÇÃO', NULL, '52573079449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.591'),
(74, 'ROSENILDA AMÉLIA DO NASCIMENTO', NULL, NULL, '1954-12-18 00:00:00.000', 'AMÉLIA COSMA DA SILVA', NULL, '42719933449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.591'),
(75, 'JOSEFA AMELIA SILVA DE SOUSA', NULL, NULL, '1962-10-18 00:00:00.000', 'AMÉLIA COSME DA SILVA', NULL, '71183124449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.592'),
(76, 'JUDITE SEVERINA DE LIMA PEREIRA', NULL, NULL, '1965-05-21 00:00:00.000', 'SEVERINA JOSEFA DA CONCIÇÃO', NULL, '54410924400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.592'),
(77, 'FÁTIMA FRANCISCA DE ALBUQUERQUE', NULL, NULL, '1960-12-01 00:00:00.000', 'REGINA FRANCISCA DE LIMA', NULL, '74264478472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.593'),
(78, 'JOSE FRANCCISCO DE ALBUQUERQUE', NULL, NULL, '1954-07-06 00:00:00.000', 'NOEMIA JULIA DA CONCEIÇÃO', NULL, '04679197803', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.593'),
(79, 'JOSEFA HONORINA DA SILVA', NULL, NULL, '1964-04-03 00:00:00.000', 'HONORINA JULIA DA SILVA', NULL, '40472272420', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.594'),
(80, 'CLEONICE MARIA DA SILVA', NULL, NULL, '1961-07-21 00:00:00.000', 'JULIA MARIA DA CONCEIÇÃO', NULL, '90993306420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.594'),
(81, 'SEVERINA MARIA SOARES BEZERRA', NULL, NULL, '1953-03-29 00:00:00.000', 'SEVERINA MARIA SOARES DA SILVA', NULL, '04418695486', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.596'),
(82, 'SEVERINA GOMES DE LIMA', NULL, NULL, '1953-09-01 00:00:00.000', 'SEVERINA FRANCISCA DA CONCEIÇÃO', NULL, '39389332400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.596'),
(83, 'SEVERINA FRANCISCA DE SOUZA', NULL, NULL, '1961-02-05 00:00:00.000', 'IRACI FRANCISCA DE SOUZA', NULL, '16688064871', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.597'),
(84, 'MARIA DA PAZ CANDIDA DA SILVA', NULL, NULL, '1957-11-09 00:00:00.000', 'JOSEFA CANDIDA DE MENDONÇA', NULL, '74247875434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.598'),
(85, 'MARIA ANTONIA DA SILVA', NULL, NULL, '1964-12-08 00:00:00.000', 'ANA ANTONIA DA CONCEIÇÃO', NULL, '83536019404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.598'),
(86, 'DORALICE GOMES DOS SANTOS', NULL, NULL, '1953-11-13 00:00:00.000', 'JOAQUINA GOMES DOS SANTOS', NULL, '58600582415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.599'),
(87, 'JOSEFA MARIA DA CONCEIÇÃO', NULL, NULL, '1957-03-06 00:00:00.000', 'MARIA JOSÉ DA CONCEIÇÃO', NULL, '83545620425', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.599'),
(88, 'REGINALDO DIAS DOS SANTOS', NULL, NULL, '1961-06-26 00:00:00.000', 'MARIA DO CARMO DOS SANTOS', NULL, '26849020463', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.600'),
(89, 'MARIA JOSÉ DO ESPÍRITO SANTO', NULL, NULL, '1963-09-13 00:00:00.000', 'RITA ROSA DA CONCEIÇÃO', NULL, '71591990491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.601'),
(90, 'MARIA DAS DORES DE SANTANA', NULL, NULL, '1954-01-23 00:00:00.000', 'MAXIMINIA MARIA DA CONCEIÇÃO', NULL, '68872410487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.601'),
(91, 'MARIA JOSÉ DE SANTANA', NULL, NULL, '1965-07-30 00:00:00.000', 'ANIZIA SEVERINA DA CONCEIÇÃO', NULL, '80981348491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.602'),
(92, 'MARIA DULCE DE FREITAS', NULL, NULL, '1955-12-06 00:00:00.000', 'JOSEFA DA CONCEIÇÃO DA SILVA', NULL, '21492018449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.603'),
(93, 'SEVERINA BARBOSA DO REGO', NULL, NULL, '1936-09-27 00:00:00.000', 'APOLINÁRIA BARBOSA DE SOUSA', NULL, '16539656491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.603'),
(94, 'SEVERINA MAXIMIANO BORGES', NULL, NULL, '1954-04-30 00:00:00.000', 'JOSEFA ANA DA CONCEIÇÃO', NULL, '45741930425', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.604'),
(95, 'MARGARIDA MARIA FERREIRA DE LIMA', NULL, NULL, '1951-09-07 00:00:00.000', 'MARIA JOSÉ DE LIMA', NULL, '35888202487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.604'),
(96, 'MARIA LUIZA MARTINS', NULL, NULL, '1944-09-13 00:00:00.000', 'INACIA FRNACISCA DA CONCEIÇÃO', NULL, '73480932487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.605'),
(97, 'MARIA DA CONCEIÇÃO DE SOUZA', NULL, NULL, '1962-02-04 00:00:00.000', 'OLINDINA MARIA DE SOUZA', NULL, '44683014491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.606'),
(98, 'SEVERINO MANOEL DA SILVA', NULL, NULL, '1947-01-04 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '47791250497', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.607'),
(99, 'MARIA BARBOSA NERY', NULL, NULL, '1955-07-22 00:00:00.000', 'PAULA NEUZA PEDROZA', NULL, '46090088404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.608'),
(100, 'SEBASTIANA FELIX DA LUZ', NULL, NULL, '1964-03-15 00:00:00.000', 'SEBASTIANA FELIX DA LUZ', NULL, '04884383494', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.609'),
(101, 'MARIA DE FATIMA DA SILVA', NULL, NULL, '1962-06-07 00:00:00.000', 'SEVERINA BELO DA SILVA', NULL, '46337407415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.609'),
(102, 'DEUZAMAR  SEVERINA DO NASCIMENTO', NULL, NULL, '1963-11-20 00:00:00.000', 'SEVERINA ELVIRA DA CONCEIÇÃO', NULL, '04935522437', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.610'),
(103, 'JOSÉ ANTONIO DOS SANTOS', NULL, NULL, '1944-12-27 00:00:00.000', 'LUZIA SEBASTIANA DA CONCEIÇÃO', NULL, '75677610410', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.610'),
(104, 'SONIA MARIA DA SILVA', NULL, NULL, '1961-06-01 00:00:00.000', 'MARIA FRANCISCA DA SILVA', NULL, '54642000453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.611'),
(105, 'JOSEFA FERREIRA BARBOSA', NULL, NULL, '1952-06-25 00:00:00.000', 'SEVERINA FERREIRA', NULL, '68876556400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.612'),
(106, 'DORALICE FERREIRA VIEIRA LIMA', NULL, NULL, '1964-05-05 00:00:00.000', 'SEVERINA VIEIRA DE LIRA', NULL, '45258112420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.612'),
(107, 'MARIA JOSÉ MARQUES', NULL, NULL, '1964-12-27 00:00:00.000', 'JOSEFA FRANCISCA XAVIER', NULL, '07501090416', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.613'),
(108, 'LUIZA BARBOSA BERNARDO', NULL, NULL, '1940-04-11 00:00:00.000', 'MARIA BARBOSA DA CONEIÇÃO', NULL, '39396746487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.614'),
(109, 'SEVERINA JOSEFA DA SILVA', NULL, NULL, '1947-12-16 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '74338374420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.614'),
(110, 'JOSEFA FERREIRA DA SILVA', NULL, NULL, '1961-05-11 00:00:00.000', 'MARIA JOSÉ BARBOSA', NULL, '71174761415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.615'),
(111, 'JOANA CELESTINA FAUSTINA', NULL, NULL, '1959-06-22 00:00:00.000', 'CELESTINA SEVERINA DA CONCEIÇÃO', NULL, '66804485491', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.616'),
(112, 'JULIA CELESTINA DA CONCEIÇÃO', NULL, NULL, '1955-04-21 00:00:00.000', 'CELESTINA SEVERINA DA CONCEIÇÃO', NULL, '58154604434', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.616'),
(113, 'LUIZA JOSEFA DS CONCEIÇAO', NULL, NULL, '1958-10-08 00:00:00.000', 'JOSEFA SEVRINA DA CONCEIÇÃO', NULL, '74339990434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.625'),
(114, 'SEVERINA MARIA FERREIRA DA SILVA', NULL, NULL, '1962-03-14 00:00:00.000', 'BEATRIZ JOSEFA DA SILVA', NULL, '94849013449', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.626'),
(115, 'MARIA JOSEFA DO NASCIMENTO', NULL, NULL, '1950-01-10 00:00:00.000', 'JOSEFA MARIA DA CONCEÇÃO', NULL, '62428950487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.627'),
(116, 'ROSA PAULINA DA SILVA', NULL, NULL, '1949-11-02 00:00:00.000', 'MARIA ENEDITA DOS SANTOS', NULL, '27815560415', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.628'),
(117, 'SEVERINA MARIA DA SILVA', NULL, NULL, '1947-03-03 00:00:00.000', 'MARIA JOSÉ DOS SANTOS', NULL, '62419382404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.629'),
(118, 'IZABEL MARIA DA SILVA', NULL, NULL, '1957-03-26 00:00:00.000', 'MARIA JOSÉ DO NASCIMENTO', NULL, '04931410499', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.630'),
(119, 'MARIA JOSÉ DE AQUINO E SILVA', NULL, NULL, '1939-08-28 00:00:00.000', 'SEVERINA MARIA DA FONSECA', NULL, '16553160449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.630'),
(120, 'IRENE AUXILIADORA DA SILVA', NULL, NULL, '1942-12-11 00:00:00.000', 'MARIA FRANCISCA DA CONCEIÇÃO', NULL, '72517719420', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.631'),
(121, 'ADILENE JULIETA DA SILVA SOUZA', NULL, NULL, '1963-12-27 00:00:00.000', 'JULIETA ANA DA SILVA', NULL, '40010562400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.631'),
(122, 'MARIA SEVERINA DA SILVA SANTOS', NULL, NULL, '1964-05-24 00:00:00.000', 'MARIA SEVERINA DA CONCEIÇÃO', NULL, '83534075404', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.632'),
(123, 'ANTONIA JOVELINA DA SILVA', NULL, NULL, '1962-05-16 00:00:00.000', 'MARIA JOVELINA DA CONCEIÇÃO', NULL, '76401596449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.632'),
(124, 'JOSEFA SEVERINA DA SILVA', NULL, NULL, '1962-05-14 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '90771982453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.633'),
(125, 'JOSE PEREIRA DE MELO', NULL, NULL, '1947-06-12 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '25740547415', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.634'),
(126, 'MARIA JOSEFA DA SILVA', NULL, NULL, '1950-04-10 00:00:00.000', 'JOSEFA SEVERINA DO ESPIRITO SANTO', NULL, '26795469468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.634'),
(127, 'MARIA LOURENÇO DA SILVA', NULL, NULL, '1964-02-26 00:00:00.000', 'SEVERINA LOURENÇO DA SILVA', NULL, '93246404453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.634'),
(128, 'MARINETE FRANCO DE SANTANA', NULL, NULL, '1957-04-24 00:00:00.000', 'ALICE PEREIRA ANICETO', NULL, '68872690404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.635'),
(129, 'JOSEFA MARIA DA SILVA', NULL, NULL, '1954-04-28 00:00:00.000', 'JOSEFA SEVERINA DA CONCEIÇÃO', NULL, '68873069487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.635'),
(130, 'MARIA DE LOURDES DOS SANTOS COELHO', NULL, NULL, '1960-02-16 00:00:00.000', 'ANGELITA BEZERRA DA SILVA', NULL, '39897842420', NULL, 'BRASIL', 'BRASIL', 2, 3, 1, 1, NULL, 1, '2026-02-26 12:56:08.636'),
(131, 'VICENTE JOÃO DE SANTANA', NULL, NULL, '1959-10-15 00:00:00.000', 'JOSEFA  ANA DA CONCEIÇÃO', NULL, '62324098415', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.636'),
(132, 'JOSEFA CARMELITA DA SILVA', NULL, NULL, '1964-06-29 00:00:00.000', 'CARMELITA ROSALINA DE LIRA', NULL, '58601201415', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.637'),
(133, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1951-07-20 00:00:00.000', 'MARIA INÁCIA DA SILVA', NULL, '50705822400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.637'),
(134, 'ANA JOSEFA DA SILVA', NULL, NULL, '1957-12-04 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '03966184486', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.638'),
(135, 'LUZINETE FRANCISCA DE ALBUQUERQUE', NULL, NULL, '1958-03-25 00:00:00.000', 'FRANCISCA ADELINA DA CONCEIÇÃO', NULL, '54853281487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.639'),
(136, 'MARIA OLINDINA DE LIMA', NULL, NULL, '1956-12-24 00:00:00.000', 'OLINDINA MARIA DO CARMO', NULL, '39387720420', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.639'),
(137, 'MARIA GOMES DA PAZ', NULL, NULL, '1955-06-28 00:00:00.000', 'SEVERINA CÉSAR DE LIMA', NULL, '55502776468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.640'),
(138, 'IZABEL MARIA DA CONCEIÇÃO', NULL, NULL, '1953-05-02 00:00:00.000', 'ANTONIA MARIA DA CONCEIÇÃO', NULL, '50706349415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.640'),
(139, 'NEUSA HELENA FERNANDES', NULL, NULL, '1964-02-07 00:00:00.000', 'HELENA DE SANTANA FERNANDES', NULL, '58600400406', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.641'),
(140, 'MARIA JOSÉ DE SOUZA', NULL, NULL, '1963-11-05 00:00:00.000', 'MARGARIDA JOSÉ CIPRIANA', NULL, '73162582415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.641'),
(141, 'MARIA DAMIANA DA SILVA', NULL, NULL, '1964-11-24 00:00:00.000', 'DAMIANA JOSEFINA DA SILVA', NULL, '39387712400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.642'),
(142, 'MARIA RIBEIRO DA SILVA', NULL, NULL, '1960-09-14 00:00:00.000', 'TEREZA SEVERINA DA CONCEIÇÃO', NULL, '75678675400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.642'),
(143, 'ANTONIA MARIA DA SILVA', NULL, NULL, '1954-10-06 00:00:00.000', 'MARIA URBANA DA CONCEIÇÃO', NULL, '83562290497', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.642'),
(144, 'ANA MARIA BARBOSA', NULL, NULL, '1964-11-05 00:00:00.000', 'GERTRUDES MARIA DA CONCEIÇÃO', NULL, '01349867411', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.643'),
(145, 'JOSE MANOEL LINS IRMÃO', NULL, NULL, '1950-05-05 00:00:00.000', 'MARIA PORCINA DA CONCEIÇÃO', NULL, '01126726800', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.644'),
(146, 'EDILEUZA MARIA DE SANTANA NASCIMENTO', NULL, NULL, '1960-10-17 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '52211010415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.644'),
(147, 'LINDALVA CAITANO GOMES', NULL, NULL, '1959-03-05 00:00:00.000', 'ANTONIA MARIA DA CONCEIÇÃO', NULL, '39390179491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.644'),
(148, 'MARIA JOSÉ VALENTIM DA SILVA', NULL, NULL, '1947-01-07 00:00:00.000', 'ANTONIA FRANCISCA DE JESUS', NULL, '07106833835', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.645'),
(149, 'MARIA TEREZA DA SILVA', NULL, NULL, '1957-03-10 00:00:00.000', 'TEREZA DE JESUS DA SILVA', NULL, '83547002400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.646'),
(150, 'EDNALDO SEVERINO RAMOS', NULL, NULL, '1958-06-25 00:00:00.000', 'DIONILA MARIA RAMOS', NULL, '00856180807', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.646'),
(151, 'MARIA JOSÉ ALEXANDRE', NULL, NULL, '1950-07-20 00:00:00.000', 'ANGELITA FRANCISCA DA SILVA', NULL, '45742537468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.647'),
(152, 'MARIA LÍDIA PEREIRA', NULL, NULL, '1963-03-30 00:00:00.000', 'LIDIA SEBASTIANA DE SANTANA', NULL, '83545760430', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.647'),
(153, 'ANTONIO DAMIÃO PEREIRA', NULL, NULL, '1956-10-10 00:00:00.000', 'MARIA JOSÉ DO CARMO', NULL, '57525226415', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.648'),
(154, 'JOSÉ MARTINIANO DE BARROS FILHO', NULL, NULL, '1960-01-28 00:00:00.000', 'MARGARIDA  MARIA DA  ANUNCIAÇÃO', NULL, '28961382420', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.648'),
(155, 'SEVERINA ALMEIDA BARBOSA', NULL, NULL, '1964-02-08 00:00:00.000', 'PAULA ALMEIDA PEDROSA', NULL, '43494811415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.649'),
(156, 'MARIA INEZ DE LIMA', NULL, NULL, '1947-10-01 00:00:00.000', 'INÊZ MARIA DE LIMA', NULL, '54642418415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.649'),
(157, 'TEREZINHA MARIA DOS SANTOS', NULL, NULL, '1947-10-23 00:00:00.000', 'MARIA CARMENCITA DA CONCEIÇÃO', NULL, '58039619491', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.650'),
(158, 'ANGELITA INEZ DE LIMA', NULL, NULL, '1966-02-07 00:00:00.000', 'INEZ MARIA DE LIMA', NULL, '81059302420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.650'),
(159, 'JOSEFA EDVETE DE SANTANA', NULL, NULL, '1960-08-01 00:00:00.000', 'ONECINA CÂNDIDA DA CONCEIÇÃO', NULL, '80983367434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.651'),
(160, 'CARMELITA MARIA GONÇALVES', NULL, NULL, '1950-05-04 00:00:00.000', 'MARIA ANTONIA DA CONCEIÇÃO', NULL, '75675617434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.651'),
(161, 'JOSEFA CORREIA DA SILVA', NULL, NULL, '1959-05-28 00:00:00.000', 'ONESCINA CÂNDIDA DA CONCEIÇÃO', NULL, '05168417426', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.651'),
(162, 'ISAURA TINTINO DA SILVA', NULL, NULL, '1955-10-01 00:00:00.000', 'MARIA DE LOURDES DA CONCEIÇÃO E SILVA', NULL, '11762168804', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.652'),
(163, 'MARIA DO SOCORRO SANTINA DA CONCEIÇÃO', NULL, NULL, '1963-09-10 00:00:00.000', 'MARIA SANTINA DA CONCEIÇÃO', NULL, '76399842468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.652'),
(164, 'MANOEL GERONIMO DA SILVA', NULL, NULL, '1959-05-15 00:00:00.000', 'TEREZINHA SEVERINA DA CONCEIÇÃO', NULL, '00755227808', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.653'),
(165, 'NIVALDO SEVERINO GONÇALVES', NULL, NULL, '1951-03-03 00:00:00.000', 'OLINDINA MARIA DO CARMO', NULL, '12819379400', NULL, 'BRASIL', 'BRASIL', 1, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.654'),
(166, 'CREUSA MARIA DA SILVA MELO', NULL, NULL, '1957-07-10 00:00:00.000', 'MARIA JOSE DA SILVA', NULL, '32836660406', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.655'),
(167, 'MARCELO FERREIRA DE MELO', NULL, NULL, '1960-12-02 00:00:00.000', 'JOSEFA FERREIRA MELO', NULL, '39389731453', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.655'),
(168, 'IZABEL LOPES DA SILVA', NULL, NULL, '1962-07-04 00:00:00.000', 'LUIZA LOPES DA SILVA', NULL, '02139284771', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.656'),
(169, 'ANA MARIA DA SILVA', NULL, NULL, '1963-10-03 00:00:00.000', 'MARIA ANA DA SILVA', NULL, '07693223444', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.656'),
(170, 'MARIA DO SOCORRO CORREIA DE MELO E SILVA', NULL, NULL, '1960-09-25 00:00:00.000', 'VALDECI  SEVERINA DO NASCIMENTO', NULL, '39389561434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.657'),
(171, 'MARIA CORREIA DE MELO SOUSA', NULL, NULL, '1956-12-30 00:00:00.000', 'VALDECÍ SEVERINA DO NASCIMENTO', NULL, '19857420478', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.660'),
(172, 'ANA MARIA DA CONCEIÇÃO', NULL, NULL, '1962-07-07 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '44765576434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.661'),
(173, 'HELENA PONCIANO DA CRUZ', NULL, NULL, '1955-06-12 00:00:00.000', 'JOANA MARIA DA CONCEIÇÃO', NULL, '39387518434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.661'),
(174, 'SEVERINA BERTULINA DOS SANTOS', NULL, NULL, '1955-05-25 00:00:00.000', 'BERTULINA ANA DA SILVA', NULL, '01418156809', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.662'),
(175, 'MARIA SEVERINA DOS SANTOS', NULL, NULL, '1963-03-11 00:00:00.000', 'JOSEFA SEVERINA DA CONCEIÇÃO', NULL, '04887882424', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.663'),
(176, 'MARIA DO CARMO MOREIRA DA SILVA', NULL, NULL, '1960-07-15 00:00:00.000', 'EULINA MOREIRA DE MENDONÇA', NULL, '83534121449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.663'),
(177, 'MARIA DAS DORES DA CRUZ SANTOS', NULL, NULL, '1958-10-03 00:00:00.000', 'MARIA JOSÉ DA CRUZ', NULL, '50706861434', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.664'),
(178, 'MARIA LÚCIA FERREIRA DA SILVA', NULL, NULL, '1964-12-05 00:00:00.000', 'JULIA FERREIRA DA SILVA', NULL, '90994280491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.664'),
(179, 'JOÃO JOSÉ DOS SANTOS', NULL, NULL, '1964-12-13 00:00:00.000', 'HELENA ANA DA CONCEIÇÃO', NULL, '66770939487', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.665'),
(180, 'IVANISE MARIA DA CONCEIÇÃO BORBA', NULL, NULL, '1951-07-12 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '52122409487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.666'),
(181, 'MARIA DE LOURDES DA CRUZ FARIAS', NULL, NULL, '1958-10-03 00:00:00.000', 'MARIA JOSÉ DA CRUZ', NULL, '74264265487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.667'),
(182, 'MARIA OLINDINA DA SILVA', NULL, NULL, '1961-05-15 00:00:00.000', 'OLINDINA JOSEFA DA CONCEIÇÃO', NULL, '42872057404', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.668'),
(183, 'MARINEUZA VIEIRA DE ALBUQUERQUE', NULL, NULL, '1965-03-17 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '83562206453', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.669'),
(184, 'MARIA JOSÉ DA CONCEIÇÃO', NULL, NULL, '1949-11-15 00:00:00.000', 'LAURA MARIA DA CONCEIÇÃO', NULL, '83312951453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.670'),
(185, 'MARIA CAETANA SILVA DO NASCIMENTO', NULL, NULL, '1955-04-22 00:00:00.000', 'MARIA CAETANA DA SILVA', NULL, '79507905472', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.670'),
(186, 'LINDALVA ANGELITA DA CONCEIÇÃO', NULL, NULL, '1957-12-30 00:00:00.000', 'ANGELITA PAULINA DA CONCEIÇÃO', NULL, '90997573449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.671'),
(187, 'MARIA ROSA DE ARAUJO DA SILVA', NULL, NULL, '1955-08-10 00:00:00.000', 'ROSA MARIA DE AQUINO', NULL, '78044677453', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.672'),
(188, 'IRACI ROSA DA SILVA', NULL, NULL, '1965-09-14 00:00:00.000', 'ROSA MARIANA DA SILVA', NULL, '48477010463', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.672'),
(189, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1954-05-28 00:00:00.000', 'MARIA JOSÉ DA CONCEIÇÃO', NULL, '83562451415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.673'),
(190, 'LUSIA MARIA DE BARROS', NULL, NULL, '1948-12-13 00:00:00.000', 'MARIA JOSÉ DE LIMA', NULL, '26795493415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.673'),
(191, 'ELIONAI DE FREITAS ABUD', NULL, NULL, '1958-06-25 00:00:00.000', 'IRACEMA COSTA DE FREITAS', NULL, '22480978400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.674'),
(192, 'ANA ROSA FERREIRA', NULL, NULL, '1957-04-16 00:00:00.000', 'JOSEFA ROSA DA SILVA', NULL, '79506879400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.674'),
(193, 'TEREZA MARIA DO NASCIMENTO', NULL, NULL, '1955-09-10 00:00:00.000', 'MARIA JOSEFA DA CONCEIÇÃO', NULL, '74337602453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.675'),
(194, 'COSMA SEVERINA BARBOSA DA SILVA', NULL, NULL, '1962-10-01 00:00:00.000', 'SEVERINA JOSEFA BARBOSA', NULL, '06766062452', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.675'),
(195, 'INÊZ MARIA DO NASCIMENTO', NULL, NULL, '1945-02-14 00:00:00.000', 'SEVERINA MARIA DA CONCEIÇÃO', NULL, '00893980412', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.677'),
(196, 'JOÃO MARIANO DA SILVA FILHO', NULL, NULL, '1958-12-28 00:00:00.000', 'JULIA MARIA DA SILVA', NULL, '58039325404', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.677'),
(197, 'JOSEFA MARIA DOS SANTOS', NULL, NULL, '1961-05-24 00:00:00.000', 'MARIA MIRANDA TEIXEIRA', NULL, '46064389400', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.678'),
(198, 'EZILVA EUGENIA GOMES', NULL, NULL, '1965-04-24 00:00:00.000', 'ZILDA EUGENIA GOMES', NULL, '52572366487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.679'),
(199, 'MARIA DO CARMO DE LIMA FARIAS', NULL, NULL, '1960-04-14 00:00:00.000', 'MARIA ANTONIA DE LIMA', NULL, '40339840463', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.679'),
(200, 'JOSÉ LUCIANO DA CRUZ', NULL, NULL, '1953-01-25 00:00:00.000', 'SEVERINA JOSEFA DA CRUZ', NULL, '58038809491', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.680'),
(201, 'JOSÉ JUSCELINO JOÃO DA SILVA', NULL, NULL, '1956-07-08 00:00:00.000', 'FRANQUILINA MARIA DA SILVA', NULL, '17964997491', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.681'),
(202, 'MARIA DA CONCEIÇÃO GONÇALO', NULL, NULL, '1959-08-19 00:00:00.000', 'DAMIANA MARIA GONÇALO', NULL, '05298635458', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.681'),
(203, 'LAURA MARIA DA CONCEIÇÃO', NULL, NULL, '1954-12-02 00:00:00.000', 'MARIA JOSÉ DA CONCEIÇÃO', NULL, '07407126402', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.682'),
(204, 'IVANILDA ALVES FERREIRA SILVA', NULL, NULL, '1964-10-12 00:00:00.000', 'ESMERALDINA ALVES FERREIRA', NULL, '74439286453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.682'),
(205, 'MARIA LÚCIA DA COSTA', NULL, NULL, '1963-10-16 00:00:00.000', 'JOSEFA FERREIRA DA COSTA', NULL, '44744455468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.683'),
(206, 'SEVERINA DA PAZ RIBEIRO', NULL, NULL, '1949-09-26 00:00:00.000', 'MARIA DA PAZ CAVALCANTE', NULL, '90990919404', NULL, 'BRASIL', 'BRASIL', 2, 3, 1, 1, NULL, 1, '2026-02-26 12:56:08.683'),
(207, 'MARIA DE FÁTIMA DE SANTANA', NULL, NULL, '1963-05-07 00:00:00.000', 'LETÍCIA MARIA DA CONCEIÇÃO', NULL, '96242442434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.684'),
(208, 'MARGARIDA ISABEL DA SILVA', NULL, NULL, '1951-10-09 00:00:00.000', 'SEVERINA MARIA DA SILVA', NULL, '79506801487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.684'),
(209, 'TERESA ISABEL RAMOS', NULL, NULL, '1957-04-05 00:00:00.000', 'SEVERINA MARIA DA SILVA', NULL, '08980966423', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.684'),
(210, 'JOSEFA RAMOS DE LIMA', NULL, NULL, '1961-06-02 00:00:00.000', 'JOSEFA MARIA DE SANTANA', NULL, '73237558400', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.685'),
(211, 'LUZINETE MARIA DE LUNA FERREIRA', NULL, NULL, '1959-11-09 00:00:00.000', 'MARIA ANTONIA DA CONCEIÇÃO', NULL, '11110755490', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.685'),
(212, 'LENICE MARIA DE BARROS', NULL, NULL, '1963-11-10 00:00:00.000', 'MARIA ALMEIDA DA SILVA', NULL, '73237299472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.686'),
(213, 'LUCIA MARIA DE ANDRADE', NULL, NULL, '1957-05-28 00:00:00.000', 'MARIA LUIZA DA CONCEIÇÃO', NULL, '37233483434', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.686'),
(214, 'JOÃO JOSÉ BEZERRA', NULL, NULL, '1954-05-25 00:00:00.000', 'JOSEFA ANTONIA BEZERRA', NULL, '33446288449', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.687'),
(215, 'TEREZA MARIA DA SILVA', NULL, NULL, '1954-02-01 00:00:00.000', 'MARIA LUIZA DA CONCEIÇÃO', NULL, '07832347406', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.687'),
(216, 'MARIA SEVERINA DE SOUZA', NULL, NULL, '1952-09-22 00:00:00.000', 'SEVERINA JÚLIA DE SOUZA', NULL, '07017803477', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.688'),
(217, 'DAMIANA MARIA DOS SANTOS BORBA', NULL, NULL, '1964-09-05 00:00:00.000', 'MARIA JOSÉ DA SILVA', NULL, '74262513491', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.688'),
(218, 'MARIA DAS DORES DE ARAUJO', NULL, NULL, '1964-10-03 00:00:00.000', 'MARIA MADALENA DA CONCEIÇÃO OLIVEIRA', NULL, '43258700400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.689'),
(219, 'MARIA CECÍLIA DE MELO E SILVA', NULL, NULL, '1953-10-20 00:00:00.000', 'CECÍLIA JOSEFA DA CONCEIÇÃO', NULL, '74263854420', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.689'),
(220, 'MARIA JOSÉ DE ALBURQUERQUE', NULL, NULL, '1960-10-08 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '03038417459', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.690'),
(221, 'MANOEL  FERNANDES BORBA', NULL, NULL, '1952-03-04 00:00:00.000', 'DONZÍLIA PETRONILA DE SOUSA', NULL, '18759580453', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.690'),
(222, 'JOANA MARIA DE ALBUQUERQUE', NULL, NULL, '1951-07-10 00:00:00.000', 'MARIA LUIZ DOS SANTOS', NULL, '74262505472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.691'),
(223, 'MARIA ARCELINA DA CONCEIÇÃO', NULL, NULL, '1952-08-24 00:00:00.000', 'ARCELINA MARIA DA CONCEIÇÃO', NULL, '83562281404', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.691'),
(224, 'MARIA OTACILIA DA CONCEIÇÃO SILVA', NULL, NULL, '1951-06-03 00:00:00.000', 'OTACILIA SEVERINA DA CONCEIÇÃO', NULL, '78103657468', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.692'),
(225, 'TEREZA CORREIA DE SOUZA', NULL, NULL, '1959-04-16 00:00:00.000', 'VALDECI SEVERINA DO NASCIMENTO', NULL, '36659592415', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.692'),
(226, 'GERALDA JOSEFA DA SILVA', NULL, NULL, '1959-11-09 00:00:00.000', 'JOSEFA SEVERINA DA SILVA', NULL, '79507751491', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.693'),
(227, 'VERA LUCIA DA SILVA SANTANA PESSOA', NULL, NULL, '1966-01-14 00:00:00.000', 'BEATRIZ DA SILVA SANTANA', NULL, '49320769400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.693'),
(228, 'GABRYELLA MAYARA VELOZO DA SILVA', NULL, NULL, '2017-07-10 00:00:00.000', 'MARIA APARECIDA VELOZO DA SILVA', NULL, '14672905489', NULL, 'BRASIL', 'BRASIL', 2, 5, 1, 1, NULL, 1, '2026-02-26 12:56:08.694'),
(229, 'MARIA VITÓRIA DE SOUZA LIMA', NULL, NULL, '2014-08-29 00:00:00.000', 'SEVERINA MARIA DE SOUZA', NULL, '17366086495', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.694'),
(230, 'JOÃO GUILHERME DA SILVA', NULL, NULL, '2012-11-04 00:00:00.000', 'VIVIANE MÔNICA DA CONCEIÇÃO SILVA', NULL, '17673638428', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.695'),
(231, 'ISAAC RAFAEL PEREIRA DE SANTANA', NULL, NULL, '2013-01-22 00:00:00.000', 'IVANEIDE JULIA DA CONCEIÇÃO PEREIRA', NULL, '16818108407', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.695'),
(232, 'JOSÉ DANILO NASCIMENTO DOS SANTOS', NULL, NULL, '2013-11-25 00:00:00.000', 'JAQUELINE MARIA DO NASCIMENTO', NULL, '16623783431', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.695'),
(233, 'ADRYAN DAVID DO NASCIMENTO SANTOS', NULL, NULL, '2013-02-20 00:00:00.000', 'ADRIANA SEVERINA DO NASCIMENTO', NULL, '15913842499', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.696'),
(234, 'JHONNATAN RYQUELMY ALVES DA SILVA', NULL, NULL, '2014-10-18 00:00:00.000', 'TATIANE MARIA SA SILVA', NULL, '15767755426', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.696'),
(235, 'JEFFERSON TOBIAS DA SILVA SANTOS', NULL, NULL, '2013-05-22 00:00:00.000', 'MARIA JOSÉ DA SILVA', NULL, '16692448492', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.697'),
(236, 'KAWAN DHIESUS PEREIRA DE OLIVEIRA', NULL, NULL, '2017-04-01 00:00:00.000', 'MÔNICA GERLÂNE DO NASCIMENTO PEREIRA', NULL, '14457309443', NULL, 'BRASIL', 'BRASIL', 1, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.697'),
(237, 'MARLON SANTOS DE MACÊDO SILVA', NULL, NULL, '2014-02-13 00:00:00.000', 'MICILENE SANTOS DE MACÊDO SILVA', NULL, '16835546476', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.698'),
(238, 'WESLLEY HENRIQUE DA SILVA LIBERATO', NULL, NULL, '2014-02-27 00:00:00.000', 'AURICLÉCIA LEIDJANE DA SILVA LIBERATO', NULL, '08112618160', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.699'),
(239, 'JHENNIFER YASMIM DA SILVA NASCIMENTO', NULL, NULL, '2010-03-18 00:00:00.000', 'SILENE CECÍCILA DA SILVA NASCIMENTO', NULL, '17348039405', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.699'),
(240, 'ALLANA  BEATRIZ DA SILVA LIBERATO', NULL, NULL, '2018-03-12 00:00:00.000', 'BENEDITA ANGELITA DE FRANÇA', NULL, '09166829194', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.700'),
(241, 'WANDERSON DA SILVA LUNA', NULL, NULL, '2013-09-13 00:00:00.000', 'JACILENE MARIA ANUNCIADA DA SILVA', NULL, '13987030445', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.700'),
(242, 'RAFAEL DA SILVA SILVESTRE', NULL, NULL, '2016-03-17 00:00:00.000', 'LINDACI SEVERINA DA SILVA', NULL, '13725293490', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.701'),
(243, 'ALICE PEREIRA BARBOSA DE LIMA', NULL, NULL, '2014-08-09 00:00:00.000', 'MÔNICA MARIA PEREIRA', NULL, '17138097450', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.701'),
(244, 'SAMUEL HEITOR PEREIRA BARBOSA LIMA', NULL, NULL, '2015-07-10 00:00:00.000', 'MÔNICA MARIA PEREIRA LIMA', NULL, '17137962440', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.701'),
(245, 'MARIA LÍDIA PEREIRA BARBOSA DE LIMA', NULL, NULL, '2019-04-22 00:00:00.000', 'MÔNICA MARIA PEREIRA LIMA', NULL, '16474234490', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.702'),
(246, 'JOÃO GUILHERME LIMA BORGES', NULL, NULL, '2013-02-24 00:00:00.000', 'AGENARIA MARIA DA CONCEIÇÃO LIMA', NULL, '14171324424', NULL, 'BRASIL', 'BRASIL', 1, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.702'),
(247, 'KEVYN IGOR FERREIRA DOS SANTOS', NULL, NULL, '2013-10-16 00:00:00.000', 'MARIA DE FÁTIMA DA CONCEIÇÃO FERREIRA', NULL, '08730313180', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.703'),
(248, 'YAGO FERREIRA DE LIMA', NULL, NULL, '2013-03-17 00:00:00.000', 'DANIELA MARIA DE LIMA', NULL, '18146264417', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.703'),
(249, 'LUCIANA SOFYA SILVA', NULL, NULL, '2016-12-16 00:00:00.000', 'JULIETE MARLENE DA SILVA', NULL, '15976819460', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.704'),
(250, 'PIETRO MARTINS DE SANTANA', NULL, NULL, '2017-09-22 00:00:00.000', 'GRACE KELLY SOARES DA SILVA', NULL, '14856448447', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.704'),
(251, 'LUIZ FELIPE DOS SANTOS SILVA', NULL, NULL, '2013-12-31 00:00:00.000', 'MARTA MARIA DOS SANTOS', NULL, '16802243440', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.705'),
(252, 'JOSÉ DAVI DA SILVA LIMA', NULL, NULL, '2014-04-01 00:00:00.000', 'MARIA JOSÉ DA SILVA LIMA', NULL, '16081973441', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.706');
INSERT INTO `pessoa` (`id`, `nome_completo`, `nome_social`, `apelido`, `data_nasc`, `nome_mae`, `nome_pai`, `cpf`, `rg`, `naturalidade`, `nacionalidade`, `genero_id`, `etnia_id`, `escolaridade_id`, `orgao_emissor_id`, `tipo_sanguineo`, `status`, `created_at`) VALUES
(253, 'JEFERSON CAIO DA SILVA SANTOS', NULL, NULL, '2013-02-28 00:00:00.000', 'IVONERE SEVERINA DA SILVA', NULL, '16762047416', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.706'),
(254, 'MARCELO HENRIQUE SANTIAGO OLIVEIRA', NULL, NULL, '2014-02-10 00:00:00.000', 'MARIA ROSA DA SILVA SANTIAGO', NULL, '00364143444', NULL, 'BRASIL', 'BRASIL', 1, 2, 1, 1, NULL, 1, '2026-02-26 12:56:08.707'),
(255, 'MARIANA GOMES DE SOUSA', NULL, NULL, '2015-12-10 00:00:00.000', 'MARIA STERFFANE GOMES DA SILVA', NULL, '17977432447', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.708'),
(256, 'ALLANA VITÓRIA GOMMES DA SILVA', NULL, NULL, '2019-06-11 00:00:00.000', 'MARIA STERFFANE GOMES DA SILVA', NULL, '16558303418', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.708'),
(257, 'MARINA GOMES DE SOUZA', NULL, NULL, '2015-12-10 00:00:00.000', 'MARIA STERFFANE GOMES DA SILVA', NULL, '17977447479', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.709'),
(258, 'ANGELA MARIA DA SILVA', NULL, NULL, '1958-12-03 00:00:00.000', 'JOSEFA SEVERINA MARIA DA SILVA', NULL, '75676745487', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 12:56:08.709'),
(259, 'WENDERSON RODRIGUES DA SILVA FARIAS', NULL, NULL, '1997-10-13 00:00:00.000', 'MARLUCE MARIA DA SILVA FARIAS', NULL, '12748211421', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-26 12:56:08.709'),
(260, 'MARIA DO SOCORRO DA SILVA COSTA', NULL, NULL, '1959-09-16 00:00:00.000', 'JOSEFA LOPES DE SANTANA', NULL, '51806967472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:02.998'),
(261, 'MARIA RITA PEREIRA  DA SILVA', NULL, NULL, '1960-07-16 00:00:00.000', 'MARIA DE MELO PEREIRA', NULL, '69455805472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.000'),
(262, 'CLEONICE BERTULINA DA SILVA ALBUQUERQUE', NULL, NULL, '1961-04-19 00:00:00.000', 'BERTULINA ANA DA SILVA', NULL, '36157252472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.001'),
(263, 'CLECIO FERREIRA DE BRITO', NULL, NULL, '1959-06-20 00:00:00.000', 'CECILIA BALBINO DE BRITO', NULL, '29075114400', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.002'),
(264, 'MARIA COSMA DA SILVA', NULL, NULL, '1963-11-12 00:00:00.000', 'COSMA MARIA SABINO', NULL, '64210634468', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.003'),
(265, 'JOSEFA FRANCISCO DO NASCIMENTO', NULL, NULL, '1963-11-06 00:00:00.000', 'MARINA DE ANDRARDE BARBOSA', NULL, '43494153434', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.004'),
(266, 'MARIA JOSÉ DA SILVA', NULL, NULL, '1954-06-13 00:00:00.000', 'MARIA JOSÉ DA CONCEIÇÃO', NULL, '01360403493', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 16:09:03.005'),
(267, 'JOSÉ BARBOSA DE SOUSA JUNIOR', NULL, NULL, '1961-09-10 00:00:00.000', 'PAULA NEUZA PEDROSA', NULL, '33582076415', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.006'),
(268, 'MARECI JOSEFA DA SILVA', NULL, NULL, '1959-05-18 00:00:00.000', 'JOSEFA ROSA DA CONCEIÇÃO', NULL, '27419973814', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.007'),
(269, 'TEREZINHA MARIA TEIXEIRA DOS SANTOS', NULL, NULL, '1957-09-18 00:00:00.000', 'MARIA MIRANDA TEIXEIRA', NULL, '04993547455', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.008'),
(270, 'JURACI SEVERINA DE SOUZA NASCIMENTO', NULL, NULL, '1965-01-25 00:00:00.000', 'SEVERINA JULIA DA CONCEIÇÃO', NULL, '48805564400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.009'),
(271, 'MARIA AUXILIADORA DA CONCEIÇÃO', NULL, NULL, '1962-05-24 00:00:00.000', 'ODÉLIA MARIA DA CONCEIÇÃO', NULL, '13465315871', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.010'),
(272, 'MARIA DO CARMO DE VASCONCELOS', NULL, NULL, '1951-12-10 00:00:00.000', 'MARIA CARNEIRO DE VASCONCELOS', NULL, '30579732487', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-02-26 16:09:03.011'),
(273, 'JOSEFA BESERRA CAVALCANTI', NULL, NULL, '1962-06-12 00:00:00.000', 'AUGUSTA BESERRA CAVALCANTI', NULL, '07355719882', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.012'),
(274, 'SEVERINA CECILIA DA SILVA', NULL, NULL, '1950-01-19 00:00:00.000', 'SEVERINA CECILIA DA SILVA', NULL, '39388093453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.012'),
(275, 'MARIA ROSA DA SILVA', NULL, NULL, '1953-11-13 00:00:00.000', 'MARIA ROSA DA CONCEÇÃO', NULL, '01931201439', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.013'),
(276, 'JOSEFA SEVERINA DA SILVA', NULL, NULL, '1945-12-05 00:00:00.000', 'SEVERINA ESTEVÃO DA SILVA', NULL, '62443097404', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.014'),
(277, 'HILDA BARBOSA DA SILVA', NULL, NULL, '1953-05-02 00:00:00.000', 'MARIA GOMES DO NASCIMENTO', NULL, '39388310497', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.015'),
(278, 'MARIA JOSE DA SILVA', NULL, NULL, '1961-03-19 00:00:00.000', 'MARIA LEITE DA SILVA', NULL, '48476862415', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-02-26 16:09:03.016'),
(279, 'LUZINETE JOSEFA DOS SANTOS', NULL, NULL, '1965-09-05 00:00:00.000', 'JOSEFA FRANÇA DA SILVA', NULL, '64211193449', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.017'),
(280, 'MARIA JOSÉ  LOPES DE VASCONCELOS', NULL, NULL, '1960-06-21 00:00:00.000', 'JOSEFA MARIA DA CONCEIÇÃO', NULL, '48476471491', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.018'),
(281, 'MARLENE MARIA PEREIRA', NULL, NULL, '1957-04-11 00:00:00.000', 'MARIA JOSEEFA DA CONCEIÇÃO', NULL, '25422944453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.019'),
(282, 'JOANA MARIA ALVES', NULL, NULL, '1955-06-23 00:00:00.000', 'JOANA MARIA DA CONCEIÇAO', NULL, '69828237415', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.020'),
(283, 'JOSEFA VIEIRA DE SANTANA', NULL, NULL, '1955-04-12 00:00:00.000', 'CECILIA RICARDO LOPES', NULL, '03051525480', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.032'),
(284, 'JOSEFA MARIA DA SILVA', NULL, NULL, '1960-01-02 00:00:00.000', 'FRANQUILINA MARIA DA SILVA', NULL, '36777382453', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.034'),
(285, 'MALU DE MELO', NULL, NULL, '1964-10-24 00:00:00.000', 'CATARINA SEVERINA DE MELO', NULL, '30675235472', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.036'),
(286, 'ELZA FERREIRA DE OLIVEIRA NUNES', NULL, NULL, '1958-12-30 00:00:00.000', 'ANA FERREIRA DE OLIVEIRA', NULL, '36402400491', NULL, 'BRASIL', 'BRASIL', 2, 3, 1, 1, NULL, 1, '2026-02-26 16:09:03.038'),
(287, 'MARIA ANGELA SANDE DIAS', NULL, NULL, '1958-02-04 00:00:00.000', 'AMARA LUZIA DE MORAIS', NULL, '02097964486', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-02-26 16:09:03.049'),
(288, 'DANIEL JOSÉ DA SILVA NETO', NULL, NULL, '1997-08-30 00:00:00.000', 'MARINES VASCONCELOS DA SILVA', NULL, '10818885475', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-02-27 11:29:45.970'),
(289, 'GEOVANE DA SILVA LIMA', NULL, NULL, '2001-07-11 00:00:00.000', 'SILVANA MARIA DA SILVA', NULL, '13331805432', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-01 06:50:12.429'),
(290, 'HERNANDES FERNANDES BORBA', NULL, NULL, '1998-03-27 00:00:00.000', 'DAMIANA MARIA DOS SANTOS BORBA', NULL, '12161301403', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-02 12:15:01.636'),
(291, 'ALEX JONATA DE SANTANA DA SILVA', NULL, NULL, '1997-05-09 00:00:00.000', 'ROZENILDA MARGARIDA DE SANTANA DA SILVA', NULL, '11441959424', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-02 12:15:01.638'),
(292, 'MARCUS GUILHERME ALBUQUERQUE GOMES', NULL, NULL, '2001-12-19 00:00:00.000', 'ANA ALBUQUERQUE DOS SANTOS GOMES', NULL, '14383618405', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-02 12:15:01.643'),
(293, 'JAILSON SOUSA FELIX', NULL, NULL, '1995-04-13 00:00:00.000', 'MARIA MATILDE DE SOUSA', NULL, '12114129462', NULL, 'BRASIL', 'BRASIL', 8, 1, 1, 1, NULL, 1, '2026-03-02 12:15:01.643'),
(294, 'LAURA ARIEL GOMES DE LIMA', NULL, NULL, '2002-01-19 00:00:00.000', 'MARIA ALBERTINA GOMES', NULL, '06253327410', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-03-02 12:15:01.646'),
(295, 'BEATRIZ SANDRA DA SILVA', NULL, NULL, '2000-05-12 00:00:00.000', 'SANDRA CORREIA DOS SANTOS', NULL, '13030837440', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-03-02 12:15:01.646'),
(296, 'IRLANE IVANILZA DOS SANTOS SILVA', NULL, NULL, '2002-02-23 00:00:00.000', 'IVANILZA MARIA DOS SANTOS', NULL, '15520883408', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-03-02 12:15:01.649'),
(297, 'VITÓRIA RÉGIA DE BARROS MONTEIRO', NULL, NULL, '1999-03-14 00:00:00.000', 'MARIA JOSÉ SELMA DE BARROS MONTEIRO', NULL, '11864369485', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-03-02 12:15:01.650'),
(298, 'JOAO VITOR TOME DA SILVA GOMES', NULL, NULL, '1998-10-13 00:00:00.000', 'ANDREA TOME DA SILVA', NULL, '13077093464', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-02 12:15:02.019'),
(299, 'DJAIR BATISTA DOS SANTOS', NULL, NULL, '1997-01-06 00:00:00.000', 'HOSANA MARIA DOS SANTOS', NULL, '11433636476', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-03 11:24:30.693'),
(300, 'LEANDRO INÁCIO DE SANTANA', NULL, NULL, '1992-06-29 00:00:00.000', 'SEVERINA TEREZA DE SANTANA', NULL, '10965054446', NULL, 'BRASIL', 'BRASIL', 8, 1, 1, 1, NULL, 1, '2026-03-04 16:32:14.341'),
(301, 'MARCO PAULO DA SILVA BARBOSA', NULL, NULL, '1993-01-09 00:00:00.000', 'SEVERINA MARIA DA SILVA', NULL, '11160386412', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-04 16:32:14.354'),
(302, 'JÊNIFER DAIANE TOMÉ FARIAS', NULL, NULL, '1998-01-09 00:00:00.000', 'MARIA JOSÉ DA SILVA', NULL, '12372044451', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-03-04 16:32:14.358'),
(303, 'MARCIO SANTOS DE MACÊDO SILVA', NULL, NULL, '2018-04-08 00:00:00.000', 'MICILENE SANTOS DE MACÊDO SILVA', NULL, '15468533405', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 10:00:02.949'),
(304, 'ELVIS ÂNGELO AGUIAR DA SILVA', NULL, NULL, '2015-09-19 00:00:00.000', 'ANDRECIA MARIA DE AGUIAR', NULL, '16903073400', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 10:00:02.970'),
(305, 'SOPHIA BEATRIZ BARBOSA DOS SANTOS', NULL, NULL, '2015-08-31 00:00:00.000', 'CLAUDIANE BARBOSA RUFINO', NULL, '16666759460', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-03-05 10:00:02.971'),
(306, 'JOAO SEVERINO DA SILVA', NULL, NULL, '2017-11-19 00:00:00.000', 'MARIA CLEIDE DA CRUZ SILVA', NULL, '14966996457', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-05 10:00:02.973'),
(307, 'YASMIM VANESSA DE SOUZA  ARAUJO', NULL, NULL, '2015-06-30 00:00:00.000', 'IVANEIDE JOSEFA DE ARAUJO', NULL, '00679206400', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 10:00:02.974'),
(308, 'LORENA VITÓRIA OLIVEIRA DOS SANTOS', NULL, NULL, '2018-09-02 00:00:00.000', 'SEVERINA REGINA DE OLIVEIRA', NULL, '15841257480', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 10:00:02.975'),
(309, 'SOFFIA MARIA DOS SANTOS FERREIRA', NULL, NULL, '2015-05-06 00:00:00.000', 'JACIARA MARIA DOS SANTOS DINIZ', NULL, '15808457467', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 10:00:02.976'),
(310, 'HUGO FERREIRA DINIZ', NULL, NULL, '2013-05-10 00:00:00.000', 'ROSINEIDE MARIA DINIZ', NULL, '18352302450', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 10:00:02.977'),
(311, 'ERICK RAFAEL MOREIRA DE SANTANA', NULL, NULL, '2018-03-14 00:00:00.000', 'ADRIANA MOREIRA DA SILVA', NULL, '15395550461', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 10:00:02.980'),
(312, 'LARISSA MIRELLA SILVA SANTOS', NULL, NULL, '2017-11-23 00:00:00.000', 'CLAUDIANE DA SILVA RUFINO', NULL, '14960285460', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-03-05 10:00:02.981'),
(313, 'ARLAN DEYVID SANTOS DA LUZ SILVA', NULL, NULL, '2014-08-29 00:00:00.000', 'DAIANE SANTOS DA LUZ', NULL, '00285483455', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 10:00:02.983'),
(314, 'JOÃO MIGUEL DO NASCIMENTO', NULL, NULL, '2016-05-18 00:00:00.000', 'PAULA NASCIMENTO DA LUZ', NULL, '13827082463', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.587'),
(315, 'WESLLEY FELIPE DA SILVA NASCIMENTO', NULL, NULL, '2019-09-16 00:00:00.000', 'FLÁVIA MARIA DA SILVA', NULL, '16742212403', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.590'),
(316, 'YURI EMANUEL VENÂNCIO DA SILVA XAVIER', NULL, NULL, '2020-07-29 00:00:00.000', 'ALEXANDRINA MARINHO VENANCIO', NULL, '17321398498', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.592'),
(317, 'HELLOYSA FERREIRA DA SILVA', NULL, NULL, '2016-09-07 00:00:00.000', 'NATALINE FERREIRA DINIZ', NULL, '13989438433', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.593'),
(318, 'LUCAS DE FREITAS SILVA', NULL, NULL, '2019-03-28 00:00:00.000', 'MARIA BETANIA DE FREITAS', NULL, '16368064498', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.594'),
(319, 'SANDRO GOMES DA SILVA', NULL, NULL, '2015-09-15 00:00:00.000', 'TATIANE FAUSTO DA SILVA', NULL, '17950992409', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.594'),
(320, 'HUGO GABRIEL DOS SANTOS MENEZES', NULL, NULL, '2016-12-21 00:00:00.000', 'MARIA CELESTE ANÁLIA DOS SANTOS', NULL, '14192881489', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.595'),
(321, 'HELLENA SOPHIA GOMES DE LIMA', NULL, NULL, '2019-09-24 00:00:00.000', 'LUANA BARBOSA DE LIMA', NULL, '16731690406', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.595'),
(322, 'THALLYS DHIEGO DA SILVA LIMA', NULL, NULL, '2015-07-12 00:00:00.000', 'LUANA BARBOSA DE LIMA', NULL, '00218406444', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.596'),
(323, 'EMYLLY MONYCK GOMES DE LIMA', NULL, NULL, '2018-04-15 00:00:00.000', 'LUANA BARBOSA DE LIMA', NULL, '15513484463', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.597'),
(324, 'JOSÉ ARTUR DA SILVA GOMES', NULL, NULL, '2016-12-12 00:00:00.000', 'ROSINEIDE MOEMA DA SILVA', NULL, '14204852459', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.598'),
(325, 'DÉBORA FLOR DE LIMA SILVA', NULL, NULL, '2018-09-16 00:00:00.000', 'MACELANE MARIA DA SILVA', NULL, '15875052406', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.599'),
(326, 'LAILA ESTER DA SILVA GOMES', NULL, NULL, '2019-12-29 00:00:00.000', 'ROSINEIDE MOEMA DA SILVA', NULL, '16942586455', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.599'),
(327, 'JHENNIFER SOPHIA DA SILVA SANTOS', NULL, NULL, '2018-02-24 00:00:00.000', 'MARIA SEVERINA DA SILVA FILHA', NULL, '15381097433', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.600'),
(328, 'LAYSA SOPHIA DA SILVA SANTOS', NULL, NULL, '2018-11-01 00:00:00.000', 'BRUNA MARIA DA SILVA FAUSTINO', NULL, '16108616474', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.601'),
(329, 'MARIA VITÓRIA CÂNDIDO DE SANTANA', NULL, NULL, '2017-06-28 00:00:00.000', 'ELIANE SEVERINA DE SANTANA SILVA', NULL, '14636629477', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.601'),
(330, 'DAVI HENRIQUE NASCIMENTO SILVA', NULL, NULL, '2016-10-13 00:00:00.000', 'JÉSSICA DAS GRAÇAS NASCIMENTO', NULL, '14072797421', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-05 11:53:55.602'),
(331, 'ALLANA SOBREIRA COUTINHO', NULL, NULL, '2019-07-01 00:00:00.000', 'HELAINI SOBREIRA DO NASCIMENTO', NULL, '16570481444', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.604'),
(332, 'REBECA VITÓRIA FERNANDES DE LIMA', NULL, NULL, '2016-03-26 00:00:00.000', 'EDILMA FERNANDES DA SILVA', NULL, '13726821473', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.605'),
(333, 'RAQUEL SOFIA FERNANDESDE LIMA', NULL, NULL, '2017-07-22 00:00:00.000', 'EDILMA FERNANDES DA SILVA', NULL, '14733106440', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.605'),
(334, 'MARIANA DA SILVA MENDES', NULL, NULL, '2016-07-22 00:00:00.000', 'LEIDI DAYANA DA SILVA BEZERRA', NULL, '13924904480', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 11:53:55.606'),
(335, 'LUCCAS GABRIEL DA SILVA OLIVEIRA', NULL, NULL, '2016-07-19 00:00:00.000', 'GABRIELA CARNEIRO DA SILVA', NULL, '13936546495', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-05 11:53:55.607'),
(336, 'STEFANY NATÁLIA BEZERRA BARBOSA', NULL, NULL, '2015-06-06 00:00:00.000', 'JOSEFA NATÁLIA BEZERRA', NULL, '13992556492', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-03-05 11:53:55.608'),
(337, 'LUCAS GABRIEL BARBOSA  EPIFANIO', NULL, NULL, '2018-07-30 00:00:00.000', 'MARIA JOSÉ BARBOSA', NULL, '15757322462', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-05 12:00:02.406'),
(338, 'ALLYCIA NICOLE CLEMENTE SILVA', NULL, NULL, '2018-06-06 00:00:00.000', 'GLEYCE CRISTINA CLEMENTE DO AMARAL', NULL, '15631791480', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 14:00:03.982'),
(339, 'KEILLYANNE SOPHIA TEODORO ALBUQUERQUE', NULL, NULL, '2018-04-09 00:00:00.000', 'SHEYLA  ALBUQUERQUE DA SILVA SOUSA', NULL, '15534041498', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 14:00:03.992'),
(340, 'LETÍCIA  MARIA  BARBOSA  EPIFANIO', NULL, NULL, '2016-10-20 00:00:00.000', 'MARIA JOSÉ  BARBOSA', NULL, '14043725477', NULL, 'BRASIL', 'BRASIL', 2, 1, 1, 1, NULL, 1, '2026-03-05 14:00:03.993'),
(341, 'ESTER VITÓRIA SANTOS DA LUZ', NULL, NULL, '2016-08-30 00:00:00.000', 'RAFAELA SANTOS DA LUZ', NULL, '14038401480', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 15:00:02.436'),
(342, 'JOSÉ MATHEUS DA LUZ SILVA  ARAUJO', NULL, NULL, '2014-12-13 00:00:00.000', 'RAFAELA SANTOS DA LUZ', NULL, '00685077470', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 15:00:02.441'),
(343, 'KAIKE GUILHERME DA LUZ SILVA ARAUJO', NULL, NULL, '2019-10-09 00:00:00.000', 'RAFAELA SANTOS DA LUZ', NULL, '17168811452', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 15:00:02.446'),
(344, 'WESLEY KAUÃ  DO NASCIMENTO', NULL, NULL, '2020-01-12 00:00:00.000', 'ELIONAI MARIA DA SILVA', NULL, '16957566498', NULL, 'BRASIL', 'BRASIL', 1, 1, 1, 1, NULL, 1, '2026-03-05 15:00:02.447'),
(345, 'KAMILLY VITÓRIA DO NASCIMENTO', NULL, NULL, '2018-05-08 00:00:00.000', 'PATRICIA MARIA DO NASCIMENTO', NULL, '15555926430', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-03-05 15:00:02.448'),
(346, 'KETILLY VITÓRIA DO NASCIMENTO SILVA', NULL, NULL, '2015-05-28 00:00:00.000', 'PATRÍCIA MARIA DO NASCIMENTO', NULL, '16719932411', NULL, 'BRASIL', 'BRASIL', 2, 2, 1, 1, NULL, 1, '2026-03-05 15:00:02.449'),
(347, 'MARCOS SEVERINO DO NASCIMENTO SOUSA', NULL, NULL, '2016-09-21 00:00:00.000', 'MARCIA MARIA DO NASCIMENTO', NULL, '14028117488', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 15:00:02.449'),
(348, 'MATHEUS  SEVERINO DO NASCIMENTO SOUSA', NULL, NULL, '2016-09-21 00:00:00.000', 'MARCIA MARIA DO NASCIMENTO', NULL, '14028142407', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 15:00:02.450'),
(349, 'MARIA SOPHIA RAMOS DA SILVA', NULL, NULL, '2018-08-20 00:00:00.000', 'MARIANA ONERCINA DA SILVA', NULL, '15889632418', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 15:00:02.451'),
(350, 'DAFYNY SOPHYA DA LUZ MENDONÇA', NULL, NULL, '2017-05-26 00:00:00.000', 'DAIANE SANTOS DA LUZ', NULL, '14572891486', NULL, 'BRASIL', 'BRASIL', 2, 4, 1, 1, NULL, 1, '2026-03-05 15:00:02.456'),
(351, 'DAVI LUCAS FERREIRA DE SANTANA', NULL, NULL, '2018-09-09 00:00:00.000', 'MARIA JOSÉ DE MELO FERREIRA', NULL, '15881109406', NULL, 'BRASIL', 'BRASIL', 1, 4, 1, 1, NULL, 1, '2026-03-05 16:00:02.783');

-- --------------------------------------------------------

--
-- Estrutura para tabela `plano_trabalho`
--

DROP TABLE IF EXISTS `plano_trabalho`;
CREATE TABLE `plano_trabalho` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `ano` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `caminho_planejamento` varchar(255) DEFAULT NULL,
  `caminho_relatorio` varchar(255) DEFAULT NULL,
  `feedback_coordenador` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `plano_trabalho`
--

INSERT INTO `plano_trabalho` (`id`, `usuario_id`, `ano`, `mes`, `caminho_planejamento`, `caminho_relatorio`, `feedback_coordenador`, `created_at`, `updated_at`) VALUES
(10, 19, 2026, 1, '/uploads/planos_trabalho/plano_b05dc9cf-1f24-4539-a64f-b934ae561163.pdf', '/uploads/planos_trabalho/plano_a963f8bd-0c2e-4cec-a694-226c587f35c9.pdf', 'precisa rever as metas', '2026-03-04 17:26:47', '2026-03-04 17:28:22'),
(8, 23, 2026, 3, '/uploads/planos_trabalho/plano_8e1cffb9-e867-4be8-a159-8e976ac7983b.pdf', NULL, NULL, '2026-03-04 16:59:33', '2026-03-04 16:59:33'),
(9, 19, 2026, 3, '/uploads/planos_trabalho/plano_23336656-e13a-44a7-a4a5-a32a68c8b5ec.pdf', '/uploads/planos_trabalho/plano_878caa28-adf3-48eb-aab7-35d473bc0069.pdf', 'tudo certo', '2026-03-04 17:26:19', '2026-03-04 17:28:11');

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
(8, 3, 'TURMA B1 - TEC', 'Manhã', '2026.1', '[\"Ter\"]', NULL, NULL, 1, '2026-02-26 14:40:48'),
(9, 1, 'VAMOSIMBORA? TEC - TURMA 1', 'Manhã', '2026.1', '[\"Qui\"]', NULL, NULL, 1, '2026-02-27 00:02:52'),
(10, 1, 'VAMOSIMBORA? TEC - TURMA 2', 'Manhã', '2026.1', '[\"Qui\"]', NULL, NULL, 1, '2026-02-27 00:38:56'),
(11, 3, 'TURMA B2 - TEC', 'Manhã', '2026.1', '[\"Ter\"]', NULL, NULL, 1, '2026-02-27 12:06:41'),
(12, 3, 'TURMA A1 - TEC', 'Manhã', '2026.1', '[\"Ter\"]', NULL, NULL, 1, '2026-02-27 12:18:53'),
(13, 3, 'TURMA A2 - TEC', 'Manhã', '2026.1', '[\"Ter\"]', NULL, NULL, 1, '2026-02-27 12:31:40'),
(14, 3, 'TURMA C1 - TEC', 'Tarde', '2026.1', '[\"Ter\"]', NULL, NULL, 1, '2026-02-27 12:41:55'),
(15, 3, 'TURMA C2 - TEC', 'Tarde', '2026.1', '[\"Ter\"]', NULL, NULL, 1, '2026-02-27 12:42:27'),
(16, 3, 'TURMA D1 - TEC', 'Tarde', '2026.1', '[\"Ter\"]', NULL, NULL, 1, '2026-02-27 12:43:13'),
(17, 3, 'TURMA D2 - TEC', 'Tarde', '2026.1', '[\"Ter\"]', NULL, NULL, 1, '2026-02-27 12:43:35'),
(18, 1, 'HIDROGINÁSTICA - VMS', 'Manhã', '2026.1', '[\"Seg\",\"Qua\",\"Sex\"]', NULL, NULL, 1, '2026-02-27 13:38:43'),
(19, 1, 'DANÇA', 'Manhã', '2026.1', '[\"Qui\"]', NULL, NULL, 1, '2026-02-27 14:09:02'),
(20, 1, 'HIDROPONIA', 'Manhã', '2026.1', '[\"Qua\"]', NULL, NULL, 1, '2026-02-27 14:34:22'),
(21, 3, 'HIDROGINÁSTICA - TURMA A', 'Manhã', '2026.1', '[\"Ter\",\"Qui\"]', NULL, NULL, 1, '2026-02-27 14:41:04'),
(22, 3, 'HIDROGINÁSTICA - TURMA B', 'Manhã', '2026.1', '[\"Ter\",\"Qui\"]', NULL, NULL, 1, '2026-02-27 14:41:46'),
(24, 3, 'HIDROGINÁSTICA - TURMA C', 'Tarde', '2026.1', '[\"Ter\",\"Qui\"]', NULL, NULL, 1, '2026-03-03 13:30:15'),
(25, 3, 'HIDROGINÁSTICA - TURMA D', 'Tarde', '2026.1', '[\"Ter\",\"Qui\"]', NULL, NULL, 1, '2026-03-03 13:30:59'),
(28, 3, 'turma teste', 'Tarde', '2026.1', '[\"Ter\",\"Qui\"]', NULL, NULL, 0, '2026-03-04 17:23:55'),
(29, 3, 'DANÇA - TURMA A', 'Manhã', '2026.1', '[\"Seg\"]', NULL, NULL, 1, '2026-03-04 19:28:52'),
(30, 3, ' HIDROPONIA - TURMA A', 'Manhã', '2026.1', '[\"Seg\"]', NULL, NULL, 1, '2026-03-04 19:30:22'),
(31, 3, ' CAMINHADA - TURMA A', 'Manhã', '2026.1', '[\"Sex\"]', NULL, NULL, 1, '2026-03-04 19:34:23'),
(32, 3, 'HIDROPONIA - TURMA B', 'Manhã', '2026.1', '[\"Seg\"]', NULL, NULL, 1, '2026-03-04 19:38:30'),
(33, 3, 'DANÇA - TURMA B', 'Manhã', '2026.1', '[\"Seg\"]', NULL, NULL, 1, '2026-03-04 19:40:00'),
(34, 3, 'CAMINHADA - TURMA B', 'Manhã', '2026.1', '[\"Sex\"]', NULL, NULL, 1, '2026-03-04 19:40:52'),
(35, 3, 'DANÇA - TURMA C', 'Tarde', '2026.1', '[\"Seg\"]', NULL, NULL, 1, '2026-03-04 19:43:40'),
(36, 3, 'HIDROPONIA - TURMA C', 'Tarde', '2026.1', '[\"Seg\"]', NULL, NULL, 1, '2026-03-04 19:44:39'),
(37, 3, 'CAMINHADA - TURMA C', 'Tarde', '2026.1', '[\"Sex\"]', NULL, NULL, 1, '2026-03-04 19:45:31'),
(38, 3, 'DANÇA - TURMA D', 'Tarde', '2026.1', '[\"Seg\"]', NULL, NULL, 1, '2026-03-04 19:47:47'),
(39, 3, 'HIDROPONIA - TURMA D', 'Tarde', '2026.1', '[\"Seg\"]', NULL, NULL, 1, '2026-03-04 19:50:58'),
(40, 3, 'CAMINHADA - TURMA D', 'Tarde', '2026.1', '[\"Seg\"]', NULL, NULL, 1, '2026-03-04 19:52:34'),
(41, 4, 'FERREIRA DE LIRA', 'Manhã', '2026.1', '[\"Ter\",\"Qui\"]', NULL, NULL, 1, '2026-03-05 18:00:59'),
(42, 4, 'FERREIRA DE LIRA', 'Tarde', '2026.1', '[\"Ter\",\"Qui\"]', NULL, NULL, 1, '2026-03-05 18:17:35');

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
(17, 4, 8, NULL, 0),
(18, 4, 6, NULL, 1),
(19, 5, 8, NULL, 1),
(20, 6, 8, NULL, 1),
(21, 7, 8, NULL, 0),
(22, 7, 15, NULL, 1),
(23, 9, 15, NULL, 1),
(24, 8, 15, NULL, 1),
(25, 10, 1, NULL, 1),
(26, 12, 15, NULL, 1),
(27, 14, 15, NULL, 1),
(28, 15, 1, NULL, 1),
(29, 16, 15, NULL, 1),
(30, 22, 19, NULL, 0),
(31, 11, 1, NULL, 1),
(32, 10, 18, NULL, 1),
(33, 13, 18, NULL, 1),
(34, 17, 18, NULL, 1),
(35, 18, 26, NULL, 1),
(36, 18, 25, NULL, 1),
(37, 20, 27, NULL, 1),
(38, 25, 22, NULL, 1),
(39, 25, 28, NULL, 1),
(40, 24, 22, NULL, 1),
(41, 24, 28, NULL, 1),
(42, 22, 22, NULL, 1),
(43, 22, 28, NULL, 1),
(44, 21, 22, NULL, 1),
(45, 21, 28, NULL, 1),
(46, 19, 23, NULL, 1),
(47, 25, 19, NULL, 0),
(48, 28, 19, NULL, 0),
(49, 29, 23, NULL, 1),
(50, 30, 27, NULL, 1),
(51, 31, 22, NULL, 1),
(52, 31, 28, NULL, 1),
(53, 32, 27, NULL, 1),
(54, 33, 23, NULL, 1),
(55, 34, 22, NULL, 1),
(56, 34, 28, NULL, 1),
(57, 35, 23, NULL, 1),
(58, 36, 27, NULL, 1),
(59, 37, 22, NULL, 1),
(60, 37, 28, NULL, 1),
(61, 38, 23, NULL, 1),
(62, 39, 27, NULL, 1),
(63, 40, 22, NULL, 1),
(64, 40, 28, NULL, 1),
(65, 41, 25, NULL, 1),
(66, 41, 26, NULL, 1),
(67, 42, 25, NULL, 1),
(68, 42, 26, NULL, 1);

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

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`id`, `id_colaborador`, `id_perfil_usuario`, `login`, `senha`, `status`) VALUES
(1, 1, 6, 'luanderson.oliveira', '$2b$10$d9Y73tcPQwEGxf.Ji2K0sOZbEe7X1o2ktd3mQ/te.DpomdiMPNA96', 1),
(2, 2, 3, 'heloisa.hora', '$2b$10$qVp4KkRwwdcQyEO7hi/9ouw8S9gIASGXJgrOTL3w.m67ZsZtKqk7y', 1),
(3, 3, 3, 'fernanda.andrini', '$2b$10$v8A2HfXQbcF.yQ.XZ3tIz.p4bkbJRJ.1kcCF1xLHOLoWTbmG1uW8C', 1),
(4, 4, 3, 'ana.beatriz', '$2b$10$jml6VfjUiXhoukIennX7Pej4JL8PkkIZGa850RWQrI1FqN5ZW8Fgm', 1),
(5, 5, 6, 'ana.silva', '$2b$10$aXHGPAv5GA6rTUAqxWNz3enClYIjlQQ3G7boHPTz9P3OOqe45oSZ2', 1),
(6, 6, 3, 'eduarda.vasconcelos', '$2b$10$ngdff0tMaJ1P6mBxiV5qvunT4a.QhnithPJR5Nuoby1yG4piYn912', 1),
(7, 7, 2, 'andreis.victor', '$2b$10$DLYvgDYu4rP0Y0VzynoCi.ATHBZDxMh9M6TT7IMev6W3McVDUhIBO', 1),
(8, 8, 2, 'jacy.lima', '$2b$10$cLoqzEM2J4LCrBPhB.v.uezjBzHppMSGOLdXDRzzqmXsj.aub3fBS', 1),
(9, 9, 2, 'tatiane.maria', '$2b$10$ntTw1uGO3hmCiD7mfXCZ6upgRNFvqDkzbZc73rZfJl.f8LImPr75G', 1),
(10, 10, 2, 'arthur.yure', '$2b$10$Re2CiYNBzxy.I3MCq4mH5.3hE17mDExm9lh03.iEpF2Mk8CL3A2Um', 1),
(11, 11, 3, 'marilia.eduarda', '$2b$10$oSmytNky7y3L5FyVzJJGAubJEFMC3F9.n1K3L5aWQ3xbzExvOekKG', 1),
(12, 12, 3, 'natalia.esmeralda', '$2b$10$Ydk/kjYyOnjidbiv7Hd/ouzEm.x05TbKpqhZWhUTrOZ2Mwp/gE022', 1),
(13, 13, 3, 'maria.ystella', '$2b$10$tYbtUU0byS.I/zOgYheUKe4Oox3YLOQH454vdpccERO3QT8n2OByS', 1),
(14, 14, 3, 'vitoria.oliveira', '$2b$10$L0XJZSglv806JL3QxYDVKOB6.FRlPWqFTa5J8zgquQ7LewmjTfkJm', 1),
(15, 15, 6, 'aparicio.luis', '$2b$10$2lDeMNJ.pPmhvNBIswWr4OAaxIOSCFSrYLGnnOf39.25a8E9mYH.W', 1),
(16, 16, 2, 'paulo.santana', '$2b$10$MxME9GO338z0/URt4v5QtOOu0oSGyZ3IZS1hAjPuBfHnN3XXnhThi', 1),
(17, 17, 2, 'wenderson.farias', '$2b$10$leTAvJmUGljJZRrpNH/0NewAZqDxZBC7dxrFZcv.1MWhfP.TBCbsO', 1),
(18, 18, 6, 'daniel.neto', '$2b$10$GDfN2Oon8g6iQKk491zBUOUypuYxr4IknaPlLBRiwuDwlkFThNTrW', 1),
(19, 19, 6, 'geovane.lima', '$2b$10$HQHOCubskJoEHEij137n3OjLMOXa1qPJ387mslLDW8IWKwMfnJn2y', 1),
(20, 20, 6, 'hernandes.fernandes', '$2b$10$MAduCrq9GsS4SyGHOQXQ3.OjfrdfN6RpZyyvn6uplE7o5IoJgjlSC', 1),
(21, 21, 6, 'alex.silva', '$2b$10$aiZqggnH9K/uOUKcdWrHouq6gA4mJ/OdctggnDV.yaSyJd6aPsPia', 1),
(22, 22, 6, 'marcus.guilherme', '$2b$10$gYbkmpNMCj6w0d4qNqLK0OokzwQy0tpRB7K6o3YmySEAWCvyb0bIi', 1),
(23, 23, 6, 'jailson.sousa', '$2b$10$IM.f3s9uDYb82xhn4OfqvuAIwy9BFiT2ABjsuNKEa/8mnY8KRiliW', 1),
(24, 24, 6, 'laura.ariel', '$2b$10$869yTL83KYyat8kWpgtgmOLWXd767FSEbecfLr8wqQQAGHYBx7Ql6', 1),
(25, 25, 6, 'beatriz.sandra', '$2b$10$KmQlpFdMZdnIla1B8WuuG.erMpd2IoJXOQKpO4UIAJ9f2z8KXIxcC', 1),
(26, 26, 6, 'irlane.ivanilza', '$2b$10$HVOS5OmF/zmGwZvkQ/YDDun5UhJZU9Brj5HPBsrwEf.1FjQreWseq', 1),
(27, 27, 6, 'vitoria.regia', '$2b$10$E8PiRsBnZNUDD8Xn6TXogOjR2rgyS/48B0gMaPrad1xZ5QPpECL2.', 1),
(28, 28, 6, 'joao.vitor', '$2b$10$h9X2.BORIBXotnhMnuiqgeMDbWm112SdcAtWTYpRnPqo8iwW/HQq6', 1),
(29, 29, 2, 'djair.batista', '$2b$10$X3eTkzfUHzpCqRhgkRAVN.ajr3BQIzZsoUNEAPberq6LwzPvT/O5W', 1),
(30, 30, 6, 'leandro.inacio', '$2b$10$VtUkvgjkuAp7T2DmjtzPMu4yBD4th0kJbQ6uTPCXH1VbniEtX5mVq', 1),
(31, 31, 6, 'marco.paulo', '$2b$10$qFWBkESfint36BGVZB.0vOOMWCuzs1IB6l41E2.fSUFJxrFcmYNZm', 1),
(32, 32, 6, 'jenifer.farias', '$2b$10$dprMhxee63AE9ylomer5PuU6wAmzaQB70etn.InQqiIhnq/PHpnMm', 1);

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
-- Índices de tabela `fotos_aula`
--
ALTER TABLE `fotos_aula`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aula_id` (`aula_id`);

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
-- Índices de tabela `plano_trabalho`
--
ALTER TABLE `plano_trabalho`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `proc_mes_ano` (`usuario_id`,`ano`,`mes`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `Beneficiario`
--
ALTER TABLE `Beneficiario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=320;

--
-- AUTO_INCREMENT de tabela `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de tabela `colaborador`
--
ALTER TABLE `colaborador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de tabela `contato`
--
ALTER TABLE `contato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=352;

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
-- AUTO_INCREMENT de tabela `fotos_aula`
--
ALTER TABLE `fotos_aula`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `frequencias`
--
ALTER TABLE `frequencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1307;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=352;

--
-- AUTO_INCREMENT de tabela `plano_trabalho`
--
ALTER TABLE `plano_trabalho`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de tabela `turma_professores`
--
ALTER TABLE `turma_professores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `fotos_aula`
--
ALTER TABLE `fotos_aula`
  ADD CONSTRAINT `fk_fotos_aula` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
