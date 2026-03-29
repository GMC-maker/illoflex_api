-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 25-03-2026 a las 22:52:31
-- Versión del servidor: 8.0.43
-- Versión de PHP: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `illoflex`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciclo_formativo`
--

CREATE TABLE `ciclo_formativo` (
  `id_ciclo` int UNSIGNED NOT NULL,
  `id_familia` smallint UNSIGNED NOT NULL,
  `codigo_oficial` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nombre` varchar(160) COLLATE utf8mb4_general_ci NOT NULL,
  `nivel` enum('GS','GM','GB') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'GS',
  `descripcion` text COLLATE utf8mb4_general_ci,
  `duracion_horas` smallint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dimension_riasec`
--

CREATE TABLE `dimension_riasec` (
  `id_dimension` tinyint UNSIGNED NOT NULL,
  `codigo` char(1) COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `dimension_riasec`
--

INSERT INTO `dimension_riasec` (`id_dimension`, `codigo`, `nombre`, `descripcion`) VALUES
(1, 'R', 'Realista', 'Interés por actividades prácticas, técnicas y concretas.'),
(2, 'I', 'Investigador', 'Interés por analizar, investigar, comprender y resolver problemas.'),
(3, 'A', 'Artístico', 'Interés por crear, diseñar, expresar e innovar.'),
(4, 'S', 'Social', 'Interés por ayudar, enseñar, acompañar y cooperar con otras personas.'),
(5, 'E', 'Emprendedor', 'Interés por liderar, persuadir, coordinar y tomar decisiones.'),
(6, 'C', 'Convencional', 'Interés por el orden, la estructura, la organización y los procedimientos.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enlace_resultado`
--

CREATE TABLE `enlace_resultado` (
  `id_enlace` bigint UNSIGNED NOT NULL,
  `id_test` bigint UNSIGNED NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `token_hash` char(64) COLLATE utf8mb4_general_ci NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expira_en` datetime NOT NULL,
  `usado_en` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familia_fp`
--

CREATE TABLE `familia_fp` (
  `id_familia` smallint UNSIGNED NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opcion`
--

CREATE TABLE `opcion` (
  `id_opcion` int UNSIGNED NOT NULL,
  `id_pregunta` int UNSIGNED NOT NULL,
  `id_dimension` tinyint UNSIGNED NOT NULL,
  `texto` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `opcion`
--

INSERT INTO `opcion` (`id_opcion`, `id_pregunta`, `id_dimension`, `texto`, `activa`) VALUES
(1, 1, 3, 'Crear algo nuevo (dibujar, diseñar, imaginar ideas)', 1),
(2, 1, 4, 'Ayudar a otras personas en su día a día', 1),
(3, 1, 5, 'Organizar o coordinar actividades', 1),
(4, 1, 6, 'Trabajar con datos o información ordenada', 1),
(5, 2, 2, 'Analizar la situación y proponer soluciones', 1),
(6, 2, 4, 'Escuchar, apoyar y facilitar el trabajo del grupo', 1),
(7, 2, 5, 'Tomar decisiones para que las cosas avancen', 1),
(8, 2, 6, 'Organizar tareas, tiempos o recursos', 1),
(9, 3, 2, 'Haber entendido algo complejo', 1),
(10, 3, 3, 'Haber creado algo propio', 1),
(11, 3, 4, 'Haber ayudado a alguien', 1),
(12, 3, 6, 'Haber dejado todo claro y ordenado', 1),
(13, 4, 1, 'En un entorno práctico (taller, campo, laboratorio, espacio técnico)', 1),
(14, 4, 3, 'En un entorno creativo y flexible', 1),
(15, 4, 4, 'En un lugar con trato constante con personas', 1),
(16, 4, 6, 'En una oficina organizada y estructurada', 1),
(17, 5, 1, 'Resolviendo problemas prácticos', 1),
(18, 5, 3, 'Aportando ideas originales', 1),
(19, 5, 4, 'Ayudando y comprendiendo a otras personas', 1),
(20, 5, 6, 'Manteniendo el orden y la planificación', 1),
(21, 6, 1, 'Reparar, montar o trabajar con materiales', 1),
(22, 6, 2, 'Analizar información o buscar explicaciones', 1),
(23, 6, 4, 'Atender personas o resolver dudas', 1),
(24, 6, 6, 'Gestionar documentación o procesos', 1),
(25, 7, 2, 'Pensarlo y resolverlo por mi cuenta', 1),
(26, 7, 4, 'Compartirlo con otras personas y avanzar juntos', 1),
(27, 7, 3, 'Probar diferentes ideas hasta encontrar una propia', 1),
(28, 7, 6, 'Seguir un método claro paso a paso', 1),
(29, 8, 1, 'Donde se trabaja con herramientas o materiales', 1),
(30, 8, 3, 'Donde se crean ideas o contenidos', 1),
(31, 8, 4, 'Donde hay trato frecuente con personas', 1),
(32, 8, 6, 'Donde todo está organizado y estructurado', 1),
(33, 9, 1, 'Encargarte de las tareas prácticas', 1),
(34, 9, 3, 'Proponer ideas nuevas', 1),
(35, 9, 4, 'Cuidar el ambiente y la comunicación', 1),
(36, 9, 5, 'Tomar decisiones y coordinar', 1),
(37, 10, 1, 'Reparar o construir cosas', 1),
(38, 10, 2, 'Analizar datos o información', 1),
(39, 10, 5, 'Tomar decisiones basadas en resultados', 1),
(40, 10, 6, 'Organizar tareas o recursos', 1),
(41, 11, 1, 'Haberlo resuelto por mí mismo/a', 1),
(42, 11, 4, 'Saber que ayudé a alguien', 1),
(43, 11, 3, 'Haber creado algo propio', 1),
(44, 11, 6, 'Haber cumplido con lo esperado', 1),
(45, 12, 1, 'Buscar una solución práctica', 1),
(46, 12, 2, 'Analizar distintas opciones', 1),
(47, 12, 4, 'Pedir apoyo o colaborar', 1),
(48, 12, 6, 'Seguir un método paso a paso', 1),
(49, 13, 1, 'Probar soluciones hasta que funcione', 1),
(50, 13, 2, 'Pensar con calma qué ha fallado', 1),
(51, 13, 3, 'Buscar una alternativa creativa', 1),
(52, 13, 6, 'Reorganizar el proceso', 1),
(53, 14, 1, 'Ver un resultado concreto de tu trabajo', 1),
(54, 14, 2, 'Entender algo que antes no comprendías', 1),
(55, 14, 3, 'Crear algo propio', 1),
(56, 14, 4, 'Ayudar a mejorar la vida de alguien', 1),
(57, 15, 2, 'Prefiero analizar las cosas por mi cuenta antes de pedir ayuda.', 1),
(58, 15, 4, 'Me siento mejor cuando comparto y colaboro con otros.', 1),
(59, 15, 3, 'Me gusta expresarme de forma creativa', 1),
(60, 15, 6, 'Me siento cómodo/a siguiendo una estructura clara', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

CREATE TABLE `perfil` (
  `id_perfil` smallint UNSIGNED NOT NULL,
  `codigo` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil_familia_afinidad`
--

CREATE TABLE `perfil_familia_afinidad` (
  `id_perfil` smallint UNSIGNED NOT NULL,
  `id_familia` smallint UNSIGNED NOT NULL,
  `grado_afinidad` tinyint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta`
--

CREATE TABLE `pregunta` (
  `id_pregunta` int UNSIGNED NOT NULL,
  `enunciado` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `orden` smallint UNSIGNED DEFAULT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pregunta`
--

INSERT INTO `pregunta` (`id_pregunta`, `enunciado`, `orden`, `activa`) VALUES
(1, '¿Qué tipo de actividad te resulta más atractiva?', 1, 1),
(2, 'Cuando trabajas con otras personas, ¿qué sueles hacer mejor?', 2, 1),
(3, 'Al final del día, ¿qué te hace sentir que ha merecido la pena?', 3, 1),
(4, '¿En qué tipo de entorno te sentirías más cómodo/a trabajando?', 4, 1),
(5, '¿De qué manera sientes que aportas más valor a un equipo?', 5, 1),
(6, '¿Qué tipo de tareas te resultan más agradables?', 6, 1),
(7, 'Cuando tienes que hacer un trabajo importante, ¿qué te resulta más cómodo?', 7, 1),
(8, '¿En qué tipo de entorno te sentirías más a gusto?', 8, 1),
(9, 'Cuando formas parte de un grupo, ¿qué rol te atrae más?', 9, 1),
(10, '¿Qué tipo de trabajo te resulta más interesante?', 10, 1),
(11, '¿Qué te hace sentir más satisfecho/a cuando terminas una tarea?', 11, 1),
(12, 'Cuando surge un problema, tú sueles…', 12, 1),
(13, 'Si algo no sale como esperabas, tú tiendes a…', 13, 1),
(14, '¿Qué situación te haría sentir más satisfecho/a?', 14, 1),
(15, '¿Con cuál de estas frases te identificas más?', 15, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuesta`
--

CREATE TABLE `respuesta` (
  `id_respuesta` bigint UNSIGNED NOT NULL,
  `id_test` bigint UNSIGNED NOT NULL,
  `id_pregunta` int UNSIGNED NOT NULL,
  `id_opcion` int UNSIGNED NOT NULL,
  `fecha_respuesta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `respuesta`
--
DELIMITER $$
CREATE TRIGGER `trg_respuesta_max2` BEFORE INSERT ON `respuesta` FOR EACH ROW BEGIN
  DECLARE cnt INT;

  SELECT COUNT(*) INTO cnt
  FROM respuesta
  WHERE id_test = NEW.id_test
    AND id_pregunta = NEW.id_pregunta;

  IF cnt >= 2 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Regla de negocio: máximo 2 respuestas por (test, pregunta).';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultado`
--

CREATE TABLE `resultado` (
  `id_resultado` bigint UNSIGNED NOT NULL,
  `id_test` bigint UNSIGNED NOT NULL,
  `id_perfil` smallint UNSIGNED NOT NULL,
  `puntuaciones_json` json DEFAULT NULL,
  `fecha_resultado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `test`
--

CREATE TABLE `test` (
  `id_test` bigint UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `id_usuario` int UNSIGNED DEFAULT NULL,
  `estado` enum('EN_PROGRESO','FINALIZADO') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'EN_PROGRESO',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_finalizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int UNSIGNED NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rol` enum('ADMIN','NORMAL') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NORMAL',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ciclo_formativo`
--
ALTER TABLE `ciclo_formativo`
  ADD PRIMARY KEY (`id_ciclo`),
  ADD KEY `idx_ciclo_familia` (`id_familia`);

--
-- Indices de la tabla `dimension_riasec`
--
ALTER TABLE `dimension_riasec`
  ADD PRIMARY KEY (`id_dimension`),
  ADD UNIQUE KEY `uq_dimension_codigo` (`codigo`);

--
-- Indices de la tabla `enlace_resultado`
--
ALTER TABLE `enlace_resultado`
  ADD PRIMARY KEY (`id_enlace`),
  ADD UNIQUE KEY `uq_enlace_token` (`token_hash`),
  ADD KEY `idx_enlace_test` (`id_test`);

--
-- Indices de la tabla `familia_fp`
--
ALTER TABLE `familia_fp`
  ADD PRIMARY KEY (`id_familia`),
  ADD UNIQUE KEY `uq_familia_nombre` (`nombre`);

--
-- Indices de la tabla `opcion`
--
ALTER TABLE `opcion`
  ADD PRIMARY KEY (`id_opcion`),
  ADD UNIQUE KEY `uq_opcion_pregunta` (`id_opcion`,`id_pregunta`),
  ADD KEY `idx_opcion_pregunta` (`id_pregunta`),
  ADD KEY `idx_opcion_dimension` (`id_dimension`);

--
-- Indices de la tabla `perfil`
--
ALTER TABLE `perfil`
  ADD PRIMARY KEY (`id_perfil`),
  ADD UNIQUE KEY `uq_perfil_codigo` (`codigo`);

--
-- Indices de la tabla `perfil_familia_afinidad`
--
ALTER TABLE `perfil_familia_afinidad`
  ADD PRIMARY KEY (`id_perfil`,`id_familia`),
  ADD KEY `fk_pfa_familia` (`id_familia`);

--
-- Indices de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  ADD PRIMARY KEY (`id_pregunta`);

--
-- Indices de la tabla `respuesta`
--
ALTER TABLE `respuesta`
  ADD PRIMARY KEY (`id_respuesta`),
  ADD UNIQUE KEY `uq_resp_test_opcion` (`id_test`,`id_opcion`),
  ADD KEY `idx_resp_test` (`id_test`),
  ADD KEY `idx_resp_test_pregunta` (`id_test`,`id_pregunta`),
  ADD KEY `fk_resp_opcion_pregunta` (`id_opcion`,`id_pregunta`);

--
-- Indices de la tabla `resultado`
--
ALTER TABLE `resultado`
  ADD PRIMARY KEY (`id_resultado`),
  ADD UNIQUE KEY `uq_resultado_test` (`id_test`),
  ADD KEY `idx_resultado_perfil` (`id_perfil`);

--
-- Indices de la tabla `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id_test`),
  ADD UNIQUE KEY `uq_test_uuid` (`uuid`),
  ADD KEY `idx_test_usuario` (`id_usuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `uq_usuario_email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ciclo_formativo`
--
ALTER TABLE `ciclo_formativo`
  MODIFY `id_ciclo` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `dimension_riasec`
--
ALTER TABLE `dimension_riasec`
  MODIFY `id_dimension` tinyint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `enlace_resultado`
--
ALTER TABLE `enlace_resultado`
  MODIFY `id_enlace` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `familia_fp`
--
ALTER TABLE `familia_fp`
  MODIFY `id_familia` smallint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `opcion`
--
ALTER TABLE `opcion`
  MODIFY `id_opcion` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `perfil`
--
ALTER TABLE `perfil`
  MODIFY `id_perfil` smallint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  MODIFY `id_pregunta` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `respuesta`
--
ALTER TABLE `respuesta`
  MODIFY `id_respuesta` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resultado`
--
ALTER TABLE `resultado`
  MODIFY `id_resultado` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `test`
--
ALTER TABLE `test`
  MODIFY `id_test` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ciclo_formativo`
--
ALTER TABLE `ciclo_formativo`
  ADD CONSTRAINT `fk_ciclo_familia` FOREIGN KEY (`id_familia`) REFERENCES `familia_fp` (`id_familia`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `enlace_resultado`
--
ALTER TABLE `enlace_resultado`
  ADD CONSTRAINT `fk_enlace_test` FOREIGN KEY (`id_test`) REFERENCES `test` (`id_test`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `opcion`
--
ALTER TABLE `opcion`
  ADD CONSTRAINT `fk_opcion_dimension` FOREIGN KEY (`id_dimension`) REFERENCES `dimension_riasec` (`id_dimension`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_opcion_pregunta` FOREIGN KEY (`id_pregunta`) REFERENCES `pregunta` (`id_pregunta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `perfil_familia_afinidad`
--
ALTER TABLE `perfil_familia_afinidad`
  ADD CONSTRAINT `fk_pfa_familia` FOREIGN KEY (`id_familia`) REFERENCES `familia_fp` (`id_familia`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pfa_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `respuesta`
--
ALTER TABLE `respuesta`
  ADD CONSTRAINT `fk_resp_opcion_pregunta` FOREIGN KEY (`id_opcion`,`id_pregunta`) REFERENCES `opcion` (`id_opcion`, `id_pregunta`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_resp_test` FOREIGN KEY (`id_test`) REFERENCES `test` (`id_test`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `resultado`
--
ALTER TABLE `resultado`
  ADD CONSTRAINT `fk_resultado_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_resultado_test` FOREIGN KEY (`id_test`) REFERENCES `test` (`id_test`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `fk_test_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
