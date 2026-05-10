-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 03-05-2026 a las 22:36:03
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

--
-- Volcado de datos para la tabla `ciclo_formativo`
--

INSERT INTO `ciclo_formativo` (`id_ciclo`, `id_familia`, `codigo_oficial`, `nombre`, `nivel`, `descripcion`, `duracion_horas`) VALUES
(1, 1, NULL, 'Acceso y Conservación en Instalaciones Deportivas', 'GB', 'Operaciones básicas de apoyo en instalaciones deportivas.', 2000),
(2, 1, NULL, 'Guía en el Medio Natural y de Tiempo Libre', 'GM', 'Conducción de grupos y actividades en el medio natural y de ocio.', 2000),
(3, 1, NULL, 'Enseñanza y Animación Sociodeportiva', 'GS', 'Planificación, dinamización y evaluación de actividades físico-deportivas.', 2000),
(4, 1, NULL, 'Acondicionamiento Físico', 'GS', 'Programación y guía de actividades de fitness y entrenamiento físico.', 2000),
(5, 2, NULL, 'Servicios Administrativos', 'GB', 'Tareas básicas de apoyo administrativo y de oficina.', 2000),
(6, 2, NULL, 'Gestión Administrativa', 'GM', 'Tramitación administrativa, atención al cliente y apoyo de gestión.', 2000),
(7, 2, NULL, 'Administración y Finanzas', 'GS', 'Gestión administrativa, financiera, contable y comercial.', 2000),
(8, 2, NULL, 'Asistencia a la Dirección', 'GS', 'Asistencia documental, organizativa y comunicativa a dirección.', 2000),
(9, 3, NULL, 'Agrojardinería y Composiciones Florales', 'GB', 'Operaciones básicas de jardinería, viveros y composiciones florales.', 2000),
(10, 4, NULL, 'Preimpresión Digital', 'GM', 'Tratamiento de archivos y preparación de productos gráficos para impresión.', 2000),
(11, 6, NULL, 'Servicios Comerciales', 'GB', 'Operaciones básicas de apoyo a la actividad comercial y de almacén.', 2000),
(12, 6, NULL, 'Actividades Comerciales', 'GM', 'Venta, atención al cliente y dinamización comercial.', 2000),
(13, 6, NULL, 'Comercialización de Productos Alimentarios', 'GM', 'Venta especializada y gestión comercial en el sector alimentario.', 2000),
(14, 6, NULL, 'Marketing y Publicidad', 'GS', 'Acciones de marketing, comunicación y publicidad en distintos soportes.', 2000),
(15, 6, NULL, 'Comercio Internacional', 'GS', 'Gestión administrativa y comercial en operaciones internacionales.', 2000),
(16, 6, NULL, 'Gestión de Ventas y Espacios Comerciales', 'GS', 'Organización de ventas, equipos comerciales y espacios de venta.', 2000),
(17, 6, NULL, 'Transporte y Logística', 'GS', 'Planificación y gestión de operaciones logísticas y de transporte.', 2000),
(18, 8, NULL, 'Electricidad y Electrónica', 'GB', 'Operaciones básicas de montaje y mantenimiento en electricidad y electrónica.', 2000),
(19, 8, NULL, 'Instalaciones Eléctricas y Automáticas', 'GM', 'Montaje y mantenimiento de instalaciones eléctricas de baja tensión.', 2000),
(20, 8, NULL, 'Instalaciones de Telecomunicaciones', 'GM', 'Montaje y mantenimiento de infraestructuras de telecomunicaciones.', 2000),
(21, 8, NULL, 'Automatización y Robótica Industrial', 'GS', 'Diseño, montaje y mantenimiento de sistemas automáticos y robotizados.', 2000),
(22, 8, NULL, 'Sistemas Electrotécnicos y Automatizados', 'GS', 'Configuración y supervisión de instalaciones electrotécnicas.', 2000),
(23, 8, NULL, 'Sistemas de Telecomunicaciones e Informáticos', 'GS', 'Configuración y gestión de sistemas de telecomunicación e informática asociada.', 2000),
(24, 11, NULL, 'Cocina y Restauración', 'GB', 'Operaciones básicas de cocina, preparación y servicio.', 2000),
(25, 11, NULL, 'Cocina y Gastronomía', 'GM', 'Preelaboración, elaboración y presentación de alimentos.', 2000),
(26, 11, NULL, 'Servicios en Restauración', 'GM', 'Servicio de alimentos y bebidas y atención al cliente en restauración.', 2000),
(27, 11, NULL, 'Dirección de Cocina', 'GS', 'Planificación, organización y supervisión de la producción culinaria.', 2000),
(28, 11, NULL, 'Gestión de Alojamientos Turísticos', 'GS', 'Organización y control de establecimientos de alojamiento turístico.', 2000),
(29, 12, NULL, 'Peluquería y Estética', 'GB', 'Tareas básicas de peluquería, estética y atención al cliente.', 2000),
(30, 12, NULL, 'Estética y Belleza', 'GM', 'Aplicación de técnicas de estética, maquillaje y bienestar.', 2000),
(31, 12, NULL, 'Peluquería y Cosmética Capilar', 'GM', 'Corte, color, peinados y tratamientos capilares.', 2000),
(32, 12, NULL, 'Estética Integral y Bienestar', 'GS', 'Tratamientos estéticos avanzados, imagen y bienestar.', 2000),
(33, 12, NULL, 'Asesoría de Imagen Personal y Corporativa', 'GS', 'Diseño y gestión de la imagen personal, profesional y corporativa.', 2000),
(34, 13, NULL, 'Vídeo Disc-jockey y Sonido', 'GM', 'Captación, mezcla y reproducción de sonido e imagen en eventos.', 2000),
(35, 13, NULL, 'Animaciones 3D, Juegos y Entornos Interactivos', 'GS', 'Modelado, animación y desarrollo de contenidos digitales interactivos.', 2000),
(36, 13, NULL, 'Iluminación, Captación y Tratamiento de Imagen', 'GS', 'Captación, tratamiento e iluminación de imagen en proyectos audiovisuales.', 2000),
(37, 13, NULL, 'Producción de Audiovisuales y Espectáculos', 'GS', 'Planificación y gestión de proyectos audiovisuales y escénicos.', 2000),
(38, 13, NULL, 'Realización de Proyectos Audiovisuales y Espectáculos', 'GS', 'Coordinación técnica y artística de proyectos audiovisuales y espectáculos.', 2000),
(39, 13, NULL, 'Sonido para Audiovisuales y Espectáculos', 'GS', 'Captación, grabación, control y postproducción de sonido.', 2000),
(40, 16, NULL, 'Informática de Oficina', 'GB', 'Operaciones auxiliares con aplicaciones ofimáticas y equipos informáticos.', 2000),
(41, 16, NULL, 'Sistemas Microinformáticos y Redes', 'GM', 'Instalación y mantenimiento de equipos, sistemas y redes locales.', 2000),
(42, 16, NULL, 'Administración de Sistemas Informáticos en Red', 'GS', 'Administración avanzada de sistemas, servicios de red y seguridad.', 2000),
(43, 16, NULL, 'Desarrollo de Aplicaciones Multiplataforma', 'GS', 'Desarrollo de software para escritorio, móvil y otros entornos.', 2000),
(44, 16, NULL, 'Desarrollo de Aplicaciones Web', 'GS', 'Desarrollo de aplicaciones web en entorno cliente y servidor.', 2000),
(45, 21, NULL, 'Cuidados Auxiliares de Enfermería', 'GM', 'Cuidados básicos al paciente y apoyo al personal sanitario.', 1400),
(46, 21, NULL, 'Farmacia y Parafarmacia', 'GM', 'Dispensación y venta de productos farmacéuticos y parafarmacéuticos.', 2000),
(47, 21, NULL, 'Emergencias Sanitarias', 'GM', 'Traslado de pacientes y atención sanitaria inicial en emergencias.', 2000),
(48, 21, NULL, 'Documentación y Administración Sanitarias', 'GS', 'Gestión de documentación clínica y administrativa en el ámbito sanitario.', 2000),
(49, 21, NULL, 'Higiene Bucodental', 'GS', 'Prevención bucodental y apoyo en gabinete odontológico.', 2000),
(50, 21, NULL, 'Imagen para el Diagnóstico y Medicina Nuclear', 'GS', 'Obtención y tratamiento de imágenes diagnósticas y técnicas de medicina nuclear.', 2000),
(51, 21, NULL, 'Laboratorio Clínico y Biomédico', 'GS', 'Realización de análisis clínicos y biomédicos en laboratorio.', 2000),
(52, 23, NULL, 'Atención a Personas en Situación de Dependencia', 'GM', 'Apoyo asistencial, psicosocial y doméstico a personas dependientes.', 2000),
(53, 23, NULL, 'Animación Sociocultural y Turística', 'GS', 'Dinamización de proyectos socioculturales, de ocio y turísticos.', 2000),
(54, 23, NULL, 'Educación Infantil', 'GS', 'Diseño y desarrollo de intervenciones educativas con la infancia.', 2000),
(55, 23, NULL, 'Integración Social', 'GS', 'Intervención social con personas y colectivos en riesgo o necesidad de apoyo.', 2000),
(56, 23, NULL, 'Mediación Comunicativa', 'GS', 'Intervención comunicativa con personas sordas, sordociegas y con dificultades de comunicación.', 2000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciclo_riasec_afinidad`
--

CREATE TABLE `ciclo_riasec_afinidad` (
  `id_ciclo` int UNSIGNED NOT NULL,
  `puntaje_r` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `puntaje_i` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `puntaje_a` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `puntaje_s` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `puntaje_e` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `puntaje_c` tinyint UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciclo_riasec_afinidad`
--

INSERT INTO `ciclo_riasec_afinidad` (`id_ciclo`, `puntaje_r`, `puntaje_i`, `puntaje_a`, `puntaje_s`, `puntaje_e`, `puntaje_c`) VALUES
(1, 2, 0, 0, 2, 0, 1),
(2, 3, 1, 0, 2, 1, 0),
(3, 1, 0, 1, 3, 2, 0),
(4, 2, 1, 0, 3, 1, 0),
(5, 0, 0, 0, 1, 0, 3),
(6, 0, 0, 0, 2, 1, 3),
(7, 0, 1, 0, 1, 2, 3),
(8, 0, 1, 0, 2, 2, 3),
(9, 3, 1, 2, 0, 0, 1),
(10, 1, 0, 2, 0, 0, 2),
(11, 1, 0, 0, 1, 2, 2),
(12, 0, 0, 0, 2, 2, 1),
(13, 0, 0, 0, 2, 2, 1),
(14, 0, 1, 2, 1, 3, 1),
(15, 0, 1, 0, 1, 3, 2),
(16, 0, 0, 1, 2, 3, 2),
(17, 1, 1, 0, 0, 2, 3),
(18, 3, 1, 0, 0, 0, 2),
(19, 3, 2, 0, 0, 0, 1),
(20, 3, 2, 0, 0, 0, 1),
(21, 3, 3, 0, 0, 0, 2),
(22, 3, 2, 0, 0, 0, 2),
(23, 2, 3, 0, 0, 0, 2),
(24, 2, 0, 1, 1, 0, 1),
(25, 2, 0, 2, 1, 0, 0),
(26, 1, 0, 0, 3, 1, 1),
(27, 1, 0, 2, 0, 3, 2),
(28, 0, 0, 0, 2, 2, 3),
(29, 1, 0, 2, 2, 0, 0),
(30, 1, 1, 2, 2, 0, 0),
(31, 1, 0, 2, 2, 0, 0),
(32, 0, 1, 2, 2, 1, 0),
(33, 0, 0, 3, 2, 2, 1),
(34, 2, 0, 3, 0, 1, 0),
(35, 1, 2, 3, 0, 0, 0),
(36, 2, 1, 3, 0, 0, 0),
(37, 0, 0, 2, 1, 3, 2),
(38, 1, 0, 3, 1, 2, 0),
(39, 2, 1, 3, 0, 0, 0),
(40, 1, 1, 0, 0, 0, 2),
(41, 2, 2, 0, 0, 0, 1),
(42, 2, 3, 0, 0, 0, 2),
(43, 1, 3, 1, 0, 0, 2),
(44, 1, 3, 2, 0, 0, 2),
(45, 0, 1, 0, 3, 0, 1),
(46, 0, 1, 0, 2, 1, 2),
(47, 2, 1, 0, 3, 0, 1),
(48, 0, 2, 0, 1, 0, 3),
(49, 0, 2, 0, 2, 0, 1),
(50, 2, 3, 0, 1, 0, 1),
(51, 1, 3, 0, 0, 0, 2),
(52, 1, 0, 0, 3, 0, 1),
(53, 0, 0, 2, 3, 2, 0),
(54, 0, 1, 1, 3, 1, 1),
(55, 0, 1, 1, 3, 1, 1),
(56, 0, 1, 1, 3, 0, 1);

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
  `email` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `token` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `token_hash` char(64) COLLATE utf8mb4_general_ci NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expira_en` datetime NOT NULL,
  `usado_en` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `enlace_resultado`
--

INSERT INTO `enlace_resultado` (`id_enlace`, `id_test`, `email`, `token`, `token_hash`, `creado_en`, `expira_en`, `usado_en`) VALUES
(1, 6, NULL, NULL, '4deeddb57732aa42ad48434b1d6256ae3bd50a64777a84006322f4471a3c6f29', '2026-04-17 23:54:49', '2026-04-24 23:54:49', '2026-04-17 23:54:49'),
(2, 9, NULL, NULL, '2501d63dab0d64dc884ff3168bc8a147f9cf8e6737abf9ac8ddf037618db2dde', '2026-04-28 19:29:40', '2026-05-05 19:29:40', NULL),
(3, 10, 'prueba@email.com', '6b02b4c6b2c9eb41cdc205127b5850b0cb43def1c74f6008e1dc1f6b02c86e5a', 'a6f33892601018eca0b533e80c9756d1941e026ecbe6218d276849a200851a38', '2026-04-28 23:31:11', '2026-05-05 23:31:11', '2026-04-28 23:39:19'),
(4, 12, 'pruebaTest@email.com', '0ba682d44f0eba1c1db10810b1174ae4e9d5aa4c0fe8bc472916bfda04083b34', 'f4c94da5ba0ff23239cc94f1ba5a71081455042976e9f6e8d91bb74ba5d95ffb', '2026-04-29 00:37:37', '2026-05-06 00:37:37', '2026-04-29 00:37:50'),
(5, 13, 'prueba3@email.com', '23f32ea363e87fbedc448ec844e9f53745efb5d75a86013182f0f65ef367afec', 'f3107cbde15598963fb37fab3eb3791211bd60eb5408e7807cdad76fc10cb093', '2026-05-02 18:39:30', '2026-05-09 18:39:30', '2026-05-02 18:39:40'),
(6, 14, 'xgceldia796@ieshnosmachado.org', 'e5c46a36cd7bb0c56a65417c848573faf6f5d0f6e902b8f017fc90357f2f7047', '608bbe8341ed6969631793f79b9ee22b5b328f977d0f6dfffbc6ff2ae6719502', '2026-05-02 19:32:19', '2026-05-09 19:32:19', '2026-05-02 19:34:39'),
(7, 16, 'xgceldia796@ieshnosmachado.org', '8f56de499f28e852d2aba286f753dc4509acd90e7ddb165da61718aa36833e2a', '39056b9b766bc2b4987f3f2e96f63ec4b17beb751d0727936dd5a0f3d026da85', '2026-05-03 21:07:32', '2026-05-10 21:07:32', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familia_fp`
--

CREATE TABLE `familia_fp` (
  `id_familia` smallint UNSIGNED NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `familia_fp`
--

INSERT INTO `familia_fp` (`id_familia`, `nombre`, `descripcion`) VALUES
(1, 'Actividades Físicas y Deportivas', 'Familia profesional orientada a la actividad física, el deporte, la animación y el tiempo libre.'),
(2, 'Administración y Gestión', 'Familia profesional orientada a la gestión administrativa, la documentación, la atención empresarial y la organización de recursos.'),
(3, 'Agraria', 'Familia profesional orientada a la agricultura, ganadería, jardinería, explotaciones agrarias y medio natural.'),
(4, 'Artes Gráficas', 'Familia profesional orientada al diseño gráfico, impresión, edición y producción gráfica.'),
(5, 'Artes y Artesanías', 'Familia profesional orientada a oficios artísticos, técnicas artesanales y creación manual especializada.'),
(6, 'Comercio y Marketing', 'Familia profesional orientada a ventas, marketing, comercio internacional, logística comercial y atención al cliente.'),
(7, 'Edificación y Obra Civil', 'Familia profesional orientada a proyectos de construcción, obra civil, replanteos y organización de obras.'),
(8, 'Electricidad y Electrónica', 'Familia profesional orientada a instalaciones eléctricas, automatización, telecomunicaciones y sistemas electrónicos.'),
(9, 'Energía y Agua', 'Familia profesional orientada a energías renovables, eficiencia energética, redes y gestión del agua.'),
(10, 'Fabricación Mecánica', 'Familia profesional orientada a mecanizado, diseño industrial, soldadura y producción mecánica.'),
(11, 'Hostelería y Turismo', 'Familia profesional orientada a alojamiento, restauración, guía turística y servicios turísticos.'),
(12, 'Imagen Personal', 'Familia profesional orientada a estética, peluquería, caracterización y asesoría de imagen.'),
(13, 'Imagen y Sonido', 'Familia profesional orientada a audiovisual, vídeo, sonido, iluminación y producción de espectáculos.'),
(14, 'Industrias Alimentarias', 'Familia profesional orientada a elaboración, control, conservación y comercialización de productos alimentarios.'),
(15, 'Industrias Extractivas', 'Familia profesional orientada a excavaciones, sondeos, minería y actividades extractivas.'),
(16, 'Informática y Comunicaciones', 'Familia profesional orientada a desarrollo de software, sistemas, redes, ciberseguridad y soporte informático.'),
(17, 'Instalación y Mantenimiento', 'Familia profesional orientada al montaje, mantenimiento industrial, frío, climatización y mecatrónica.'),
(18, 'Madera, Mueble y Corcho', 'Familia profesional orientada a carpintería, mueble, diseño en madera y transformación del corcho.'),
(19, 'Marítimo-Pesquera', 'Familia profesional orientada a navegación, pesca, transporte marítimo y cultivos acuícolas.'),
(20, 'Química', 'Familia profesional orientada a laboratorio, análisis, planta química y control de procesos.'),
(21, 'Sanidad', 'Familia profesional orientada a cuidados de salud, diagnóstico, documentación sanitaria y apoyo clínico.'),
(22, 'Seguridad y Medio Ambiente', 'Familia profesional orientada a emergencias, protección civil, salud ambiental y gestión medioambiental.'),
(23, 'Servicios Socioculturales y a la Comunidad', 'Familia profesional orientada a educación infantil, integración social, atención a personas y mediación comunitaria.'),
(24, 'Textil, Confección y Piel', 'Familia profesional orientada a patronaje, confección, calzado, marroquinería y producción textil.'),
(25, 'Transporte y Mantenimiento de Vehículos', 'Familia profesional orientada a automoción, electromecánica, carrocería y mantenimiento de vehículos.'),
(26, 'Vidrio y Cerámica', 'Familia profesional orientada a fabricación, transformación y decoración de vidrio y cerámica.');

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
(3, 1, 5, 'Liderar y coordinar un equipo para lograr un objetivo', 1),
(4, 1, 6, 'Trabajar con datos o información organizada', 1),
(5, 2, 2, 'Analizar la situación y proponer soluciones', 1),
(6, 2, 4, 'Escuchar, apoyar y facilitar el trabajo del grupo', 1),
(7, 2, 5, 'Tomar decisiones para que las cosas avancen', 1),
(8, 2, 6, 'Organizar tareas, tiempos o recursos', 1),
(9, 3, 2, 'Haber entendido algo complejo', 1),
(10, 3, 3, 'Haber creado algo propio', 1),
(11, 3, 4, 'Haber ayudado a alguien', 1),
(12, 3, 6, 'Haber dejado todo claro y organizado', 1),
(13, 4, 1, 'En un entorno práctico (taller, campo, laboratorio)', 1),
(14, 4, 3, 'En un entorno creativo y flexible', 1),
(15, 4, 4, 'En un entorno con trato constante con personas', 1),
(16, 4, 6, 'En un entorno estructurado y organizado', 1),
(17, 5, 1, 'Resolviendo problemas prácticos', 1),
(18, 5, 3, 'Aportando ideas originales', 1),
(19, 5, 4, 'Ayudando y comprendiendo a otras personas', 1),
(20, 5, 6, 'Manteniendo el orden y la planificación', 1),
(21, 6, 1, 'Reparar, montar o trabajar con materiales', 1),
(22, 6, 2, 'Analizar información o investigar', 1),
(23, 6, 4, 'Atender personas o resolver dudas', 1),
(24, 6, 6, 'Gestionar documentación o procesos', 1),
(25, 7, 2, 'Resolverlo por tu cuenta con lógica', 1),
(26, 7, 4, 'Compartirlo con otros y avanzar juntos', 1),
(27, 7, 3, 'Probar ideas hasta encontrar una solución original', 1),
(28, 7, 6, 'Seguir un método claro paso a paso', 1),
(29, 8, 1, 'Trabajar con herramientas o tecnología', 1),
(30, 8, 2, 'Investigar cómo funcionan las cosas', 1),
(31, 8, 3, 'Crear algo artístico o expresivo', 1),
(32, 8, 5, 'Dirigir un equipo o proyecto', 1),
(33, 9, 1, 'Encargarte de tareas prácticas', 1),
(34, 9, 3, 'Proponer ideas nuevas', 1),
(35, 9, 4, 'Cuidar la comunicación del grupo', 1),
(36, 9, 5, 'Tomar decisiones y coordinar', 1),
(37, 10, 1, 'Construir o reparar cosas', 1),
(38, 10, 2, 'Analizar datos o información', 1),
(39, 10, 5, 'Tomar decisiones estratégicas', 1),
(40, 10, 6, 'Organizar tareas o recursos', 1),
(41, 11, 1, 'Haberlo resuelto por ti mismo/a', 1),
(42, 11, 4, 'Saber que ayudaste a alguien', 1),
(43, 11, 3, 'Haber creado algo original', 1),
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
(54, 14, 2, 'Entender algo complejo', 1),
(55, 14, 3, 'Crear algo propio', 1),
(56, 14, 4, 'Ayudar a alguien', 1),
(57, 15, 2, 'Prefiero analizar antes de actuar', 1),
(58, 15, 4, 'Me gusta colaborar con otros', 1),
(59, 15, 3, 'Me gusta expresarme de forma creativa', 1),
(60, 15, 6, 'Me siento cómodo/a siguiendo una estructura', 1),
(61, 16, 5, 'Liderar el proyecto y tomar decisiones', 1),
(62, 16, 2, 'Analizar el problema antes de actuar', 1),
(63, 16, 3, 'Diseñar algo creativo', 1),
(64, 16, 4, 'Ayudar a que el equipo funcione mejor', 1),
(65, 17, 6, 'Organizar tareas y procesos', 1),
(66, 17, 5, 'Coordinar personas y dirigir trabajo', 1),
(67, 17, 1, 'Resolver problemas técnicos o prácticos', 1),
(68, 17, 2, 'Investigar cómo mejorar algo', 1),
(69, 18, 5, 'Crear tu propio proyecto o negocio', 1),
(70, 18, 1, 'Trabajar con herramientas o sistemas técnicos', 1),
(71, 18, 3, 'Expresar ideas de forma creativa', 1),
(72, 18, 4, 'Ayudar directamente a otras personas', 1);

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

--
-- Volcado de datos para la tabla `perfil`
--

INSERT INTO `perfil` (`id_perfil`, `codigo`, `nombre`, `descripcion`) VALUES
(1, 'R', 'Realista', 'Te atraen las actividades prácticas, técnicas o manuales. Sueles disfrutar resolviendo problemas concretos, usando herramientas, montando, reparando, construyendo o trabajando con materiales, máquinas, tecnología, naturaleza o espacios físicos.'),
(2, 'I', 'Investigador', 'Te interesa comprender cómo funcionan las cosas. Sueles disfrutar analizando información, investigando, comparando datos, resolviendo problemas complejos o buscando explicaciones lógicas.'),
(3, 'A', 'Artistico', 'Te atraen las actividades creativas y expresivas. Sueles disfrutar imaginando ideas, diseñando, comunicando visualmente, creando contenidos, innovando o buscando formas originales de hacer las cosas.\r\n'),
(4, 'S', 'Social', 'Te interesa ayudar, acompañar, enseñar o cuidar a otras personas. Sueles disfrutar trabajando en equipo, escuchando, explicando, orientando o participando en actividades con impacto humano.\r\n'),
(5, 'E', 'Emprendedor', 'Te atraen los retos donde puedes liderar, convencer, organizar personas o impulsar proyectos. Sueles disfrutar tomando decisiones, proponiendo iniciativas, negociando o coordinando objetivos.'),
(6, 'C', 'Convencional', 'Te sientes cómodo/a con tareas organizadas, claras y estructuradas. Sueles disfrutar gestionando información, siguiendo procedimientos, planificando, revisando detalles o manteniendo el orden.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil_familia_afinidad`
--

CREATE TABLE `perfil_familia_afinidad` (
  `id_perfil` smallint UNSIGNED NOT NULL,
  `id_familia` smallint UNSIGNED NOT NULL,
  `grado_afinidad` tinyint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `perfil_familia_afinidad`
--

INSERT INTO `perfil_familia_afinidad` (`id_perfil`, `id_familia`, `grado_afinidad`) VALUES
(1, 1, 2),
(1, 3, 3),
(1, 4, 1),
(1, 5, 2),
(1, 7, 3),
(1, 8, 3),
(1, 9, 3),
(1, 10, 3),
(1, 11, 1),
(1, 13, 1),
(1, 14, 2),
(1, 15, 3),
(1, 16, 1),
(1, 17, 3),
(1, 18, 3),
(1, 19, 3),
(1, 20, 1),
(1, 22, 2),
(1, 24, 2),
(1, 25, 3),
(1, 26, 2),
(2, 3, 1),
(2, 7, 1),
(2, 8, 2),
(2, 9, 2),
(2, 10, 2),
(2, 14, 2),
(2, 15, 1),
(2, 16, 3),
(2, 17, 1),
(2, 19, 1),
(2, 20, 3),
(2, 21, 2),
(2, 22, 2),
(2, 25, 1),
(3, 4, 3),
(3, 5, 3),
(3, 6, 1),
(3, 11, 1),
(3, 12, 3),
(3, 13, 3),
(3, 16, 1),
(3, 18, 2),
(3, 23, 1),
(3, 24, 3),
(3, 26, 3),
(4, 1, 3),
(4, 6, 2),
(4, 11, 3),
(4, 12, 2),
(4, 21, 3),
(4, 22, 2),
(4, 23, 3),
(5, 1, 2),
(5, 2, 2),
(5, 6, 3),
(5, 11, 2),
(5, 12, 2),
(5, 13, 1),
(5, 23, 1),
(6, 2, 3),
(6, 3, 1),
(6, 4, 1),
(6, 6, 2),
(6, 7, 2),
(6, 8, 2),
(6, 9, 1),
(6, 10, 1),
(6, 14, 2),
(6, 15, 1),
(6, 16, 2),
(6, 17, 2),
(6, 18, 1),
(6, 19, 1),
(6, 20, 2),
(6, 21, 1),
(6, 22, 1),
(6, 24, 1),
(6, 25, 2),
(6, 26, 1);

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
(2, 'Cuando trabajas con otras personas, ¿qué haces mejor?', 2, 1),
(3, 'Al final del día, ¿qué te hace sentir que ha merecido la pena?', 3, 1),
(4, '¿En qué tipo de entorno te sentirías más cómodo/a trabajando?', 4, 1),
(5, '¿De qué manera sientes que aportas más valor a un equipo?', 5, 1),
(6, '¿Qué tipo de tareas te resultan más agradables?', 6, 1),
(7, 'Cuando tienes que hacer un trabajo importante, ¿qué prefieres?', 7, 1),
(8, '¿Qué tipo de actividad te gustaría aprender aunque fuera difícil?', 8, 1),
(9, 'Cuando formas parte de un grupo, ¿qué rol te atrae más?', 9, 1),
(10, '¿Qué tipo de trabajo te resulta más interesante?', 10, 1),
(11, '¿Qué te hace sentir más satisfecho/a cuando terminas una tarea?', 11, 1),
(12, 'Cuando surge un problema, tú sueles…', 12, 1),
(13, 'Si algo no sale como esperabas, tú tiendes a…', 13, 1),
(14, '¿Qué situación te haría sentir más satisfecho/a?', 14, 1),
(15, '¿Con cuál de estas frases te identificas más?', 15, 1),
(16, '¿Qué situación te resultaría más motivadora en un proyecto?', 16, 1),
(17, '¿Qué tipo de responsabilidad te atrae más?', 17, 1),
(18, '¿Qué te gustaría experimentar en tu futuro profesional?', 18, 1);

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
-- Volcado de datos para la tabla `respuesta`
--

INSERT INTO `respuesta` (`id_respuesta`, `id_test`, `id_pregunta`, `id_opcion`, `fecha_respuesta`) VALUES
(1, 1, 1, 3, '2026-04-10 07:28:09'),
(2, 1, 1, 4, '2026-04-10 07:28:09'),
(3, 1, 2, 7, '2026-04-10 07:28:11'),
(4, 1, 2, 8, '2026-04-10 07:28:11'),
(5, 1, 3, 11, '2026-04-10 07:28:12'),
(6, 1, 3, 12, '2026-04-10 07:28:12'),
(7, 1, 4, 15, '2026-04-10 07:28:14'),
(8, 1, 4, 16, '2026-04-10 07:28:14'),
(9, 1, 5, 19, '2026-04-10 07:28:16'),
(10, 1, 5, 20, '2026-04-10 07:28:16'),
(11, 1, 6, 23, '2026-04-10 07:28:18'),
(12, 1, 6, 24, '2026-04-10 07:28:18'),
(13, 1, 7, 27, '2026-04-10 07:28:20'),
(14, 1, 7, 28, '2026-04-10 07:28:20'),
(15, 1, 8, 31, '2026-04-10 07:28:22'),
(16, 1, 8, 32, '2026-04-10 07:28:22'),
(17, 1, 9, 35, '2026-04-10 07:28:26'),
(18, 1, 9, 36, '2026-04-10 07:28:26'),
(19, 1, 10, 39, '2026-04-10 07:28:28'),
(20, 1, 10, 40, '2026-04-10 07:28:28'),
(21, 1, 11, 43, '2026-04-10 07:28:31'),
(22, 1, 11, 44, '2026-04-10 07:28:31'),
(23, 1, 12, 47, '2026-04-10 07:28:33'),
(24, 1, 12, 48, '2026-04-10 07:28:33'),
(25, 1, 13, 51, '2026-04-10 07:28:35'),
(26, 1, 13, 52, '2026-04-10 07:28:35'),
(27, 1, 14, 55, '2026-04-10 07:28:37'),
(28, 1, 14, 56, '2026-04-10 07:28:37'),
(29, 1, 15, 59, '2026-04-10 07:28:42'),
(30, 1, 15, 60, '2026-04-10 07:28:42'),
(31, 1, 16, 63, '2026-04-10 07:28:45'),
(32, 1, 16, 64, '2026-04-10 07:28:45'),
(33, 1, 17, 67, '2026-04-10 07:28:47'),
(34, 1, 17, 68, '2026-04-10 07:28:47'),
(35, 1, 18, 71, '2026-04-10 07:28:49'),
(36, 1, 18, 72, '2026-04-10 07:28:49'),
(37, 2, 1, 3, '2026-04-17 04:13:55'),
(38, 2, 1, 4, '2026-04-17 04:13:55'),
(39, 2, 2, 7, '2026-04-17 04:13:58'),
(40, 2, 2, 8, '2026-04-17 04:13:58'),
(41, 2, 3, 11, '2026-04-17 04:14:01'),
(42, 2, 3, 12, '2026-04-17 04:14:01'),
(43, 2, 4, 15, '2026-04-17 04:14:03'),
(44, 2, 4, 16, '2026-04-17 04:14:03'),
(45, 2, 5, 19, '2026-04-17 04:14:06'),
(46, 2, 5, 20, '2026-04-17 04:14:06'),
(47, 2, 6, 23, '2026-04-17 04:14:09'),
(48, 2, 6, 24, '2026-04-17 04:14:09'),
(49, 2, 7, 27, '2026-04-17 04:14:12'),
(50, 2, 7, 28, '2026-04-17 04:14:12'),
(51, 2, 8, 31, '2026-04-17 04:14:15'),
(52, 2, 8, 32, '2026-04-17 04:14:15'),
(53, 2, 9, 35, '2026-04-17 04:14:17'),
(54, 2, 9, 36, '2026-04-17 04:14:17'),
(55, 2, 10, 39, '2026-04-17 04:14:20'),
(56, 2, 10, 40, '2026-04-17 04:14:20'),
(57, 2, 11, 43, '2026-04-17 04:14:23'),
(58, 2, 11, 44, '2026-04-17 04:14:23'),
(59, 2, 12, 47, '2026-04-17 04:14:26'),
(60, 2, 12, 48, '2026-04-17 04:14:26'),
(61, 2, 13, 51, '2026-04-17 04:14:29'),
(62, 2, 13, 52, '2026-04-17 04:14:29'),
(63, 2, 14, 55, '2026-04-17 04:14:32'),
(64, 2, 14, 56, '2026-04-17 04:14:32'),
(65, 2, 15, 59, '2026-04-17 04:14:35'),
(66, 2, 15, 60, '2026-04-17 04:14:35'),
(67, 2, 16, 63, '2026-04-17 04:14:37'),
(68, 2, 16, 64, '2026-04-17 04:14:37'),
(69, 2, 17, 67, '2026-04-17 04:14:42'),
(70, 2, 17, 68, '2026-04-17 04:14:42'),
(71, 2, 18, 71, '2026-04-17 04:14:44'),
(72, 2, 18, 72, '2026-04-17 04:14:45'),
(73, 3, 1, 1, '2026-04-17 04:38:17'),
(74, 3, 1, 2, '2026-04-17 04:38:18'),
(75, 3, 2, 5, '2026-04-17 04:38:18'),
(76, 3, 2, 6, '2026-04-17 04:38:18'),
(77, 3, 3, 9, '2026-04-17 04:38:18'),
(78, 3, 3, 10, '2026-04-17 04:38:18'),
(79, 3, 4, 13, '2026-04-17 04:38:18'),
(80, 3, 4, 14, '2026-04-17 04:38:18'),
(81, 3, 5, 17, '2026-04-17 04:38:18'),
(82, 3, 5, 18, '2026-04-17 04:38:18'),
(83, 3, 6, 21, '2026-04-17 04:38:18'),
(84, 3, 6, 22, '2026-04-17 04:38:18'),
(85, 3, 7, 25, '2026-04-17 04:38:18'),
(86, 3, 7, 26, '2026-04-17 04:38:18'),
(87, 3, 8, 29, '2026-04-17 04:38:18'),
(88, 3, 8, 30, '2026-04-17 04:38:18'),
(89, 3, 9, 33, '2026-04-17 04:38:18'),
(90, 3, 9, 34, '2026-04-17 04:38:18'),
(91, 3, 10, 37, '2026-04-17 04:38:18'),
(92, 3, 10, 38, '2026-04-17 04:38:18'),
(93, 3, 11, 41, '2026-04-17 04:38:18'),
(94, 3, 11, 42, '2026-04-17 04:38:18'),
(95, 3, 12, 45, '2026-04-17 04:38:18'),
(96, 3, 12, 46, '2026-04-17 04:38:18'),
(97, 3, 13, 49, '2026-04-17 04:38:18'),
(98, 3, 13, 50, '2026-04-17 04:38:18'),
(99, 3, 14, 53, '2026-04-17 04:38:18'),
(100, 3, 14, 54, '2026-04-17 04:38:18'),
(101, 3, 15, 57, '2026-04-17 04:38:18'),
(102, 3, 15, 58, '2026-04-17 04:38:18'),
(103, 3, 16, 61, '2026-04-17 04:38:18'),
(104, 3, 16, 62, '2026-04-17 04:38:18'),
(105, 3, 17, 65, '2026-04-17 04:38:19'),
(106, 3, 17, 66, '2026-04-17 04:38:19'),
(107, 3, 18, 69, '2026-04-17 04:38:19'),
(108, 3, 18, 70, '2026-04-17 04:38:19'),
(109, 4, 1, 1, '2026-04-17 04:39:23'),
(110, 4, 1, 2, '2026-04-17 04:39:23'),
(111, 4, 2, 5, '2026-04-17 04:39:23'),
(112, 4, 2, 6, '2026-04-17 04:39:23'),
(113, 4, 3, 9, '2026-04-17 04:39:23'),
(114, 4, 3, 10, '2026-04-17 04:39:23'),
(115, 4, 4, 13, '2026-04-17 04:39:23'),
(116, 4, 4, 14, '2026-04-17 04:39:23'),
(117, 4, 5, 17, '2026-04-17 04:39:23'),
(118, 4, 5, 18, '2026-04-17 04:39:23'),
(119, 4, 6, 21, '2026-04-17 04:39:23'),
(120, 4, 6, 22, '2026-04-17 04:39:23'),
(121, 4, 7, 25, '2026-04-17 04:39:23'),
(122, 4, 7, 26, '2026-04-17 04:39:23'),
(123, 4, 8, 29, '2026-04-17 04:39:24'),
(124, 4, 8, 30, '2026-04-17 04:39:24'),
(125, 4, 9, 33, '2026-04-17 04:39:24'),
(126, 4, 9, 34, '2026-04-17 04:39:24'),
(127, 4, 10, 37, '2026-04-17 04:39:24'),
(128, 4, 10, 38, '2026-04-17 04:39:24'),
(129, 4, 11, 41, '2026-04-17 04:39:24'),
(130, 4, 11, 42, '2026-04-17 04:39:24'),
(131, 4, 12, 45, '2026-04-17 04:39:24'),
(132, 4, 12, 46, '2026-04-17 04:39:24'),
(133, 4, 13, 49, '2026-04-17 04:39:24'),
(134, 4, 13, 50, '2026-04-17 04:39:24'),
(135, 4, 14, 53, '2026-04-17 04:39:24'),
(136, 4, 14, 54, '2026-04-17 04:39:24'),
(137, 4, 15, 57, '2026-04-17 04:39:24'),
(138, 4, 15, 58, '2026-04-17 04:39:24'),
(139, 4, 16, 61, '2026-04-17 04:39:24'),
(140, 4, 16, 62, '2026-04-17 04:39:24'),
(141, 4, 17, 65, '2026-04-17 04:39:24'),
(142, 4, 17, 66, '2026-04-17 04:39:24'),
(143, 4, 18, 69, '2026-04-17 04:39:24'),
(144, 4, 18, 70, '2026-04-17 04:39:24'),
(145, 5, 1, 3, '2026-04-17 04:50:01'),
(146, 5, 1, 4, '2026-04-17 04:50:01'),
(147, 5, 2, 7, '2026-04-17 04:50:03'),
(148, 5, 2, 8, '2026-04-17 04:50:03'),
(149, 5, 3, 11, '2026-04-17 04:50:06'),
(150, 5, 3, 12, '2026-04-17 04:50:06'),
(151, 5, 4, 15, '2026-04-17 04:50:08'),
(152, 5, 4, 16, '2026-04-17 04:50:08'),
(153, 5, 5, 19, '2026-04-17 04:50:11'),
(154, 5, 5, 20, '2026-04-17 04:50:11'),
(155, 5, 6, 23, '2026-04-17 04:50:14'),
(156, 5, 6, 24, '2026-04-17 04:50:14'),
(157, 5, 7, 27, '2026-04-17 04:50:17'),
(158, 5, 7, 28, '2026-04-17 04:50:17'),
(159, 5, 8, 31, '2026-04-17 04:50:19'),
(160, 5, 8, 32, '2026-04-17 04:50:19'),
(161, 5, 9, 35, '2026-04-17 04:50:22'),
(162, 5, 9, 36, '2026-04-17 04:50:22'),
(163, 5, 10, 39, '2026-04-17 04:50:24'),
(164, 5, 10, 40, '2026-04-17 04:50:24'),
(165, 5, 11, 43, '2026-04-17 04:50:27'),
(166, 5, 11, 44, '2026-04-17 04:50:27'),
(167, 5, 12, 47, '2026-04-17 04:50:29'),
(168, 5, 12, 48, '2026-04-17 04:50:29'),
(169, 5, 13, 51, '2026-04-17 04:50:32'),
(170, 5, 13, 52, '2026-04-17 04:50:32'),
(171, 5, 14, 55, '2026-04-17 04:50:34'),
(172, 5, 14, 56, '2026-04-17 04:50:34'),
(173, 5, 15, 59, '2026-04-17 04:50:37'),
(174, 5, 15, 60, '2026-04-17 04:50:37'),
(175, 5, 16, 63, '2026-04-17 04:50:39'),
(176, 5, 16, 64, '2026-04-17 04:50:39'),
(177, 5, 17, 67, '2026-04-17 04:50:42'),
(178, 5, 17, 68, '2026-04-17 04:50:42'),
(179, 5, 18, 71, '2026-04-17 04:50:44'),
(180, 5, 18, 72, '2026-04-17 04:50:44'),
(181, 6, 1, 3, '2026-04-17 07:23:20'),
(182, 6, 1, 4, '2026-04-17 07:23:20'),
(183, 6, 2, 7, '2026-04-17 07:23:22'),
(184, 6, 2, 8, '2026-04-17 07:23:22'),
(185, 6, 3, 11, '2026-04-17 07:23:24'),
(186, 6, 3, 12, '2026-04-17 07:23:24'),
(187, 6, 4, 15, '2026-04-17 07:23:26'),
(188, 6, 4, 16, '2026-04-17 07:23:26'),
(189, 6, 5, 19, '2026-04-17 07:23:28'),
(190, 6, 5, 20, '2026-04-17 07:23:28'),
(191, 6, 6, 23, '2026-04-17 07:23:29'),
(192, 6, 6, 24, '2026-04-17 07:23:29'),
(193, 6, 7, 27, '2026-04-17 07:23:32'),
(194, 6, 7, 28, '2026-04-17 07:23:32'),
(195, 6, 8, 31, '2026-04-17 07:23:33'),
(196, 6, 8, 32, '2026-04-17 07:23:33'),
(197, 6, 9, 35, '2026-04-17 07:23:35'),
(198, 6, 9, 36, '2026-04-17 07:23:35'),
(199, 6, 10, 39, '2026-04-17 07:23:38'),
(200, 6, 10, 40, '2026-04-17 07:23:38'),
(201, 6, 11, 43, '2026-04-17 07:23:40'),
(202, 6, 11, 44, '2026-04-17 07:23:40'),
(203, 6, 12, 47, '2026-04-17 07:23:42'),
(204, 6, 12, 48, '2026-04-17 07:23:42'),
(205, 6, 13, 51, '2026-04-17 07:23:46'),
(206, 6, 13, 52, '2026-04-17 07:23:46'),
(207, 6, 14, 55, '2026-04-17 07:23:48'),
(208, 6, 14, 56, '2026-04-17 07:23:48'),
(209, 6, 15, 59, '2026-04-17 07:23:50'),
(210, 6, 15, 60, '2026-04-17 07:23:50'),
(211, 6, 16, 63, '2026-04-17 07:23:53'),
(212, 6, 16, 64, '2026-04-17 07:23:53'),
(213, 6, 17, 67, '2026-04-17 07:23:55'),
(214, 6, 17, 68, '2026-04-17 07:23:55'),
(215, 6, 18, 71, '2026-04-17 07:23:56'),
(216, 6, 18, 72, '2026-04-17 07:23:56'),
(217, 7, 1, 3, '2026-04-28 18:41:46'),
(218, 7, 1, 4, '2026-04-28 18:41:48'),
(219, 7, 2, 7, '2026-04-28 18:41:53'),
(220, 7, 2, 8, '2026-04-28 18:41:56'),
(221, 7, 3, 11, '2026-04-28 18:42:00'),
(222, 7, 3, 12, '2026-04-28 18:42:01'),
(223, 7, 4, 15, '2026-04-28 18:42:05'),
(224, 8, 1, 3, '2026-04-28 18:43:41'),
(225, 8, 1, 4, '2026-04-28 18:43:42'),
(226, 8, 2, 7, '2026-04-28 18:43:49'),
(227, 8, 2, 8, '2026-04-28 18:43:51'),
(228, 8, 3, 11, '2026-04-28 18:43:55'),
(229, 8, 3, 12, '2026-04-28 18:43:57'),
(230, 8, 4, 15, '2026-04-28 18:44:01'),
(231, 8, 4, 16, '2026-04-28 18:44:01'),
(232, 8, 5, 19, '2026-04-28 18:44:10'),
(233, 8, 5, 20, '2026-04-28 18:44:11'),
(234, 8, 6, 23, '2026-04-28 18:44:18'),
(235, 8, 6, 24, '2026-04-28 18:44:18'),
(236, 8, 7, 27, '2026-04-28 18:44:35'),
(237, 8, 7, 28, '2026-04-28 18:44:38'),
(238, 8, 8, 31, '2026-04-28 18:44:44'),
(239, 8, 8, 32, '2026-04-28 18:44:47'),
(240, 8, 9, 35, '2026-04-28 18:44:53'),
(241, 8, 9, 36, '2026-04-28 18:44:56'),
(242, 8, 10, 39, '2026-04-28 18:45:04'),
(243, 8, 10, 40, '2026-04-28 18:45:04'),
(244, 8, 11, 43, '2026-04-28 18:45:09'),
(245, 8, 11, 44, '2026-04-28 18:45:11'),
(246, 8, 12, 47, '2026-04-28 18:45:16'),
(247, 8, 12, 48, '2026-04-28 18:45:17'),
(248, 8, 13, 51, '2026-04-28 18:45:26'),
(249, 8, 13, 52, '2026-04-28 18:45:28'),
(250, 8, 14, 55, '2026-04-28 18:45:37'),
(251, 8, 14, 56, '2026-04-28 18:45:41'),
(252, 9, 1, 3, '2026-04-28 19:28:45'),
(253, 9, 1, 4, '2026-04-28 19:28:45'),
(254, 9, 2, 7, '2026-04-28 19:28:47'),
(255, 9, 2, 8, '2026-04-28 19:28:47'),
(256, 9, 3, 11, '2026-04-28 19:28:49'),
(257, 9, 3, 12, '2026-04-28 19:28:49'),
(258, 9, 4, 15, '2026-04-28 19:28:51'),
(259, 9, 4, 16, '2026-04-28 19:28:51'),
(260, 9, 5, 19, '2026-04-28 19:28:53'),
(261, 9, 5, 20, '2026-04-28 19:28:53'),
(262, 9, 6, 23, '2026-04-28 19:28:55'),
(263, 9, 6, 24, '2026-04-28 19:28:55'),
(264, 9, 7, 27, '2026-04-28 19:28:57'),
(265, 9, 7, 28, '2026-04-28 19:28:57'),
(266, 9, 8, 31, '2026-04-28 19:28:59'),
(267, 9, 8, 32, '2026-04-28 19:28:59'),
(268, 9, 9, 35, '2026-04-28 19:29:01'),
(269, 9, 9, 36, '2026-04-28 19:29:01'),
(270, 9, 10, 39, '2026-04-28 19:29:03'),
(271, 9, 10, 40, '2026-04-28 19:29:03'),
(272, 9, 11, 43, '2026-04-28 19:29:05'),
(273, 9, 11, 44, '2026-04-28 19:29:05'),
(274, 9, 12, 47, '2026-04-28 19:29:08'),
(275, 9, 12, 48, '2026-04-28 19:29:08'),
(276, 9, 13, 51, '2026-04-28 19:29:10'),
(277, 9, 13, 52, '2026-04-28 19:29:10'),
(278, 9, 14, 55, '2026-04-28 19:29:11'),
(279, 9, 14, 56, '2026-04-28 19:29:11'),
(280, 9, 15, 59, '2026-04-28 19:29:14'),
(281, 9, 15, 60, '2026-04-28 19:29:14'),
(282, 9, 16, 63, '2026-04-28 19:29:16'),
(283, 9, 16, 64, '2026-04-28 19:29:16'),
(284, 9, 17, 67, '2026-04-28 19:29:18'),
(285, 9, 17, 68, '2026-04-28 19:29:18'),
(286, 9, 18, 71, '2026-04-28 19:29:20'),
(287, 9, 18, 72, '2026-04-28 19:29:20'),
(288, 10, 1, 1, '2026-04-28 23:27:41'),
(289, 10, 1, 2, '2026-04-28 23:27:41'),
(290, 10, 2, 5, '2026-04-28 23:27:43'),
(291, 10, 2, 6, '2026-04-28 23:27:43'),
(292, 10, 3, 9, '2026-04-28 23:27:45'),
(293, 10, 3, 10, '2026-04-28 23:27:45'),
(294, 10, 4, 13, '2026-04-28 23:27:47'),
(295, 10, 4, 14, '2026-04-28 23:27:47'),
(296, 10, 5, 17, '2026-04-28 23:27:49'),
(297, 10, 5, 18, '2026-04-28 23:27:49'),
(298, 10, 6, 21, '2026-04-28 23:27:51'),
(299, 10, 6, 22, '2026-04-28 23:27:51'),
(300, 10, 7, 25, '2026-04-28 23:27:53'),
(301, 10, 7, 26, '2026-04-28 23:27:53'),
(302, 10, 8, 29, '2026-04-28 23:27:55'),
(303, 10, 8, 30, '2026-04-28 23:27:55'),
(304, 10, 9, 33, '2026-04-28 23:27:57'),
(305, 10, 9, 34, '2026-04-28 23:27:57'),
(306, 10, 10, 37, '2026-04-28 23:27:59'),
(307, 10, 10, 38, '2026-04-28 23:27:59'),
(308, 10, 11, 41, '2026-04-28 23:28:01'),
(309, 10, 11, 42, '2026-04-28 23:28:01'),
(310, 10, 12, 45, '2026-04-28 23:28:03'),
(311, 10, 12, 46, '2026-04-28 23:28:03'),
(312, 10, 13, 49, '2026-04-28 23:28:05'),
(313, 10, 13, 50, '2026-04-28 23:28:05'),
(314, 10, 14, 53, '2026-04-28 23:28:07'),
(315, 10, 14, 54, '2026-04-28 23:28:07'),
(316, 10, 15, 57, '2026-04-28 23:28:09'),
(317, 10, 15, 58, '2026-04-28 23:28:09'),
(318, 10, 16, 61, '2026-04-28 23:28:11'),
(319, 10, 16, 62, '2026-04-28 23:28:11'),
(320, 10, 17, 65, '2026-04-28 23:28:13'),
(321, 10, 17, 66, '2026-04-28 23:28:13'),
(322, 10, 18, 69, '2026-04-28 23:28:16'),
(323, 10, 18, 70, '2026-04-28 23:28:16'),
(324, 11, 1, 1, '2026-04-29 00:04:40'),
(325, 11, 1, 2, '2026-04-29 00:04:40'),
(326, 11, 2, 6, '2026-04-29 00:04:51'),
(327, 11, 2, 7, '2026-04-29 00:04:51'),
(328, 11, 3, 11, '2026-04-29 00:04:53'),
(329, 11, 3, 12, '2026-04-29 00:04:53'),
(330, 12, 1, 1, '2026-04-29 00:36:43'),
(331, 12, 1, 2, '2026-04-29 00:36:43'),
(332, 12, 2, 6, '2026-04-29 00:36:45'),
(333, 12, 2, 7, '2026-04-29 00:36:45'),
(334, 12, 3, 10, '2026-04-29 00:36:47'),
(335, 12, 3, 11, '2026-04-29 00:36:47'),
(336, 12, 4, 15, '2026-04-29 00:36:48'),
(337, 12, 4, 16, '2026-04-29 00:36:48'),
(338, 12, 5, 18, '2026-04-29 00:36:51'),
(339, 12, 5, 20, '2026-04-29 00:36:51'),
(340, 12, 6, 21, '2026-04-29 00:36:53'),
(341, 12, 6, 23, '2026-04-29 00:36:53'),
(342, 12, 7, 26, '2026-04-29 00:36:55'),
(343, 12, 7, 28, '2026-04-29 00:36:55'),
(344, 12, 8, 29, '2026-04-29 00:36:57'),
(345, 12, 8, 30, '2026-04-29 00:36:57'),
(346, 12, 9, 35, '2026-04-29 00:36:59'),
(347, 12, 9, 36, '2026-04-29 00:36:59'),
(348, 12, 10, 37, '2026-04-29 00:37:01'),
(349, 12, 10, 38, '2026-04-29 00:37:01'),
(350, 12, 11, 44, '2026-04-29 00:37:04'),
(351, 12, 11, 43, '2026-04-29 00:37:04'),
(352, 12, 12, 46, '2026-04-29 00:37:06'),
(353, 12, 12, 47, '2026-04-29 00:37:06'),
(354, 12, 13, 49, '2026-04-29 00:37:09'),
(355, 12, 13, 52, '2026-04-29 00:37:09'),
(356, 12, 14, 56, '2026-04-29 00:37:11'),
(357, 12, 14, 54, '2026-04-29 00:37:11'),
(358, 12, 15, 57, '2026-04-29 00:37:13'),
(359, 12, 15, 59, '2026-04-29 00:37:13'),
(360, 12, 16, 62, '2026-04-29 00:37:15'),
(361, 12, 16, 63, '2026-04-29 00:37:15'),
(362, 12, 17, 67, '2026-04-29 00:37:18'),
(363, 12, 17, 68, '2026-04-29 00:37:18'),
(364, 12, 18, 69, '2026-04-29 00:37:20'),
(365, 12, 18, 70, '2026-04-29 00:37:20'),
(366, 13, 1, 3, '2026-05-02 18:38:21'),
(367, 13, 1, 4, '2026-05-02 18:38:21'),
(368, 13, 2, 7, '2026-05-02 18:38:23'),
(369, 13, 2, 8, '2026-05-02 18:38:23'),
(370, 13, 3, 11, '2026-05-02 18:38:25'),
(371, 13, 3, 12, '2026-05-02 18:38:25'),
(372, 13, 4, 15, '2026-05-02 18:38:27'),
(373, 13, 4, 16, '2026-05-02 18:38:27'),
(374, 13, 5, 19, '2026-05-02 18:38:28'),
(375, 13, 5, 20, '2026-05-02 18:38:28'),
(376, 13, 6, 23, '2026-05-02 18:38:30'),
(377, 13, 6, 24, '2026-05-02 18:38:30'),
(378, 13, 7, 27, '2026-05-02 18:38:32'),
(379, 13, 7, 28, '2026-05-02 18:38:32'),
(380, 13, 8, 31, '2026-05-02 18:38:34'),
(381, 13, 8, 32, '2026-05-02 18:38:34'),
(382, 13, 9, 35, '2026-05-02 18:38:36'),
(383, 13, 9, 36, '2026-05-02 18:38:36'),
(384, 13, 10, 39, '2026-05-02 18:38:52'),
(385, 13, 10, 40, '2026-05-02 18:38:53'),
(386, 13, 11, 43, '2026-05-02 18:38:55'),
(387, 13, 11, 44, '2026-05-02 18:38:55'),
(388, 13, 12, 47, '2026-05-02 18:38:57'),
(389, 13, 12, 48, '2026-05-02 18:38:57'),
(390, 13, 13, 51, '2026-05-02 18:38:59'),
(391, 13, 13, 52, '2026-05-02 18:38:59'),
(392, 13, 14, 55, '2026-05-02 18:39:01'),
(393, 13, 14, 56, '2026-05-02 18:39:01'),
(394, 13, 15, 59, '2026-05-02 18:39:04'),
(395, 13, 15, 60, '2026-05-02 18:39:04'),
(396, 13, 16, 63, '2026-05-02 18:39:06'),
(397, 13, 16, 64, '2026-05-02 18:39:06'),
(398, 13, 17, 67, '2026-05-02 18:39:08'),
(399, 13, 17, 68, '2026-05-02 18:39:08'),
(400, 13, 18, 71, '2026-05-02 18:39:11'),
(401, 13, 18, 72, '2026-05-02 18:39:11'),
(402, 14, 1, 3, '2026-05-02 19:30:13'),
(403, 14, 1, 4, '2026-05-02 19:30:13'),
(404, 14, 2, 6, '2026-05-02 19:30:15'),
(405, 14, 2, 7, '2026-05-02 19:30:15'),
(406, 14, 3, 9, '2026-05-02 19:30:17'),
(407, 14, 3, 10, '2026-05-02 19:30:17'),
(408, 14, 4, 13, '2026-05-02 19:30:19'),
(409, 14, 4, 14, '2026-05-02 19:30:19'),
(410, 14, 5, 18, '2026-05-02 19:30:20'),
(411, 14, 5, 19, '2026-05-02 19:30:20'),
(412, 14, 6, 23, '2026-05-02 19:30:22'),
(413, 14, 6, 24, '2026-05-02 19:30:22'),
(414, 14, 7, 25, '2026-05-02 19:30:24'),
(415, 14, 7, 28, '2026-05-02 19:30:24'),
(416, 14, 8, 30, '2026-05-02 19:30:26'),
(417, 14, 8, 31, '2026-05-02 19:30:26'),
(418, 14, 9, 33, '2026-05-02 19:30:28'),
(419, 14, 9, 34, '2026-05-02 19:30:28'),
(420, 14, 10, 39, '2026-05-02 19:30:29'),
(421, 14, 10, 40, '2026-05-02 19:30:29'),
(422, 14, 11, 41, '2026-05-02 19:30:31'),
(423, 14, 11, 42, '2026-05-02 19:30:31'),
(424, 14, 12, 47, '2026-05-02 19:30:33'),
(425, 14, 12, 48, '2026-05-02 19:30:33'),
(426, 14, 13, 49, '2026-05-02 19:30:35'),
(427, 14, 13, 52, '2026-05-02 19:30:35'),
(428, 14, 14, 54, '2026-05-02 19:30:37'),
(429, 14, 14, 55, '2026-05-02 19:30:37'),
(430, 14, 15, 58, '2026-05-02 19:30:39'),
(431, 14, 15, 59, '2026-05-02 19:30:39'),
(432, 14, 16, 61, '2026-05-02 19:30:41'),
(433, 14, 16, 62, '2026-05-02 19:30:41'),
(434, 14, 17, 66, '2026-05-02 19:30:43'),
(435, 14, 17, 67, '2026-05-02 19:30:43'),
(436, 14, 18, 70, '2026-05-02 19:30:44'),
(437, 14, 18, 71, '2026-05-02 19:30:45'),
(438, 16, 1, 3, '2026-05-03 20:38:37'),
(439, 16, 1, 4, '2026-05-03 20:38:37'),
(440, 16, 2, 7, '2026-05-03 20:38:38'),
(441, 16, 2, 8, '2026-05-03 20:38:38'),
(442, 16, 3, 11, '2026-05-03 20:38:40'),
(443, 16, 3, 12, '2026-05-03 20:38:40'),
(444, 16, 4, 15, '2026-05-03 20:38:42'),
(445, 16, 4, 16, '2026-05-03 20:38:42'),
(446, 16, 5, 19, '2026-05-03 20:38:43'),
(447, 16, 5, 20, '2026-05-03 20:38:43'),
(448, 16, 6, 23, '2026-05-03 20:38:45'),
(449, 16, 6, 24, '2026-05-03 20:38:45'),
(450, 16, 7, 27, '2026-05-03 20:38:47'),
(451, 16, 7, 28, '2026-05-03 20:38:47'),
(452, 16, 8, 31, '2026-05-03 20:38:49'),
(453, 16, 8, 32, '2026-05-03 20:38:49'),
(454, 16, 9, 35, '2026-05-03 20:38:51'),
(455, 16, 9, 36, '2026-05-03 20:38:51'),
(456, 16, 10, 39, '2026-05-03 20:38:53'),
(457, 16, 10, 40, '2026-05-03 20:38:53'),
(458, 16, 11, 43, '2026-05-03 20:38:55'),
(459, 16, 11, 44, '2026-05-03 20:38:55'),
(460, 16, 12, 47, '2026-05-03 20:38:56'),
(461, 16, 12, 48, '2026-05-03 20:38:56'),
(462, 16, 13, 51, '2026-05-03 20:38:58'),
(463, 16, 13, 52, '2026-05-03 20:38:58'),
(464, 16, 14, 55, '2026-05-03 20:39:00'),
(465, 16, 14, 56, '2026-05-03 20:39:00'),
(466, 16, 15, 59, '2026-05-03 20:39:01'),
(467, 16, 15, 60, '2026-05-03 20:39:01'),
(468, 16, 16, 63, '2026-05-03 20:39:03'),
(469, 16, 16, 64, '2026-05-03 20:39:03'),
(470, 16, 17, 67, '2026-05-03 20:39:04'),
(471, 16, 17, 68, '2026-05-03 20:39:04'),
(472, 16, 18, 71, '2026-05-03 20:39:05'),
(473, 16, 18, 72, '2026-05-03 20:39:05');

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

--
-- Volcado de datos para la tabla `resultado`
--

INSERT INTO `resultado` (`id_resultado`, `id_test`, `id_perfil`, `puntuaciones_json`, `fecha_resultado`) VALUES
(1, 1, 6, '{\"brutas\": {\"A\": 8, \"C\": 12, \"E\": 5, \"I\": 1, \"R\": 1, \"S\": 9}, \"ranking\": [{\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 1, \"puntuacion_bruta\": 12, \"puntuacion_normalizada\": 0.9231}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 2, \"puntuacion_bruta\": 9, \"puntuacion_normalizada\": 0.6429}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.625}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 4, \"puntuacion_bruta\": 8, \"puntuacion_normalizada\": 0.6154}, {\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 5, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}], \"normalizadas\": {\"A\": 0.6154, \"C\": 0.9231, \"E\": 0.625, \"I\": 0.0833, \"R\": 0.0833, \"S\": 0.6429}, \"perfil_principal\": {\"codigo\": \"C\", \"nombre\": \"Convencional\"}, \"perfil_secundario\": {\"codigo\": \"S\", \"nombre\": \"Social\"}}', '2026-04-10 07:28:49'),
(2, 2, 6, '{\"brutas\": {\"A\": 8, \"C\": 12, \"E\": 5, \"I\": 1, \"R\": 1, \"S\": 9}, \"ranking\": [{\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 1, \"puntuacion_bruta\": 12, \"puntuacion_normalizada\": 0.9231}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 2, \"puntuacion_bruta\": 9, \"puntuacion_normalizada\": 0.6429}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.625}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 4, \"puntuacion_bruta\": 8, \"puntuacion_normalizada\": 0.6154}, {\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 5, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}], \"normalizadas\": {\"A\": 0.6154, \"C\": 0.9231, \"E\": 0.625, \"I\": 0.0833, \"R\": 0.0833, \"S\": 0.6429}, \"perfil_principal\": {\"codigo\": \"C\", \"nombre\": \"Convencional\"}, \"perfil_terciario\": {\"codigo\": \"E\", \"nombre\": \"Emprendedor\"}, \"perfil_secundario\": {\"codigo\": \"S\", \"nombre\": \"Social\"}}', '2026-04-17 04:14:45'),
(3, 3, 2, '{\"brutas\": {\"A\": 5, \"C\": 1, \"E\": 3, \"I\": 11, \"R\": 11, \"S\": 5}, \"ranking\": [{\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 1, \"puntuacion_bruta\": 11, \"puntuacion_normalizada\": 0.9167}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 2, \"puntuacion_bruta\": 11, \"puntuacion_normalizada\": 0.9167}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.3846}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 4, \"puntuacion_bruta\": 3, \"puntuacion_normalizada\": 0.375}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 5, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.3571}, {\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0769}], \"normalizadas\": {\"A\": 0.3846, \"C\": 0.0769, \"E\": 0.375, \"I\": 0.9167, \"R\": 0.9167, \"S\": 0.3571}, \"perfil_principal\": {\"codigo\": \"I\", \"nombre\": \"Investigador\"}, \"perfil_terciario\": {\"codigo\": \"A\", \"nombre\": \"Artistico\"}, \"perfil_secundario\": {\"codigo\": \"R\", \"nombre\": \"Realista\"}}', '2026-04-17 04:38:19'),
(4, 4, 2, '{\"brutas\": {\"A\": 5, \"C\": 1, \"E\": 3, \"I\": 11, \"R\": 11, \"S\": 5}, \"ranking\": [{\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 1, \"puntuacion_bruta\": 11, \"puntuacion_normalizada\": 0.9167}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 2, \"puntuacion_bruta\": 11, \"puntuacion_normalizada\": 0.9167}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.3846}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 4, \"puntuacion_bruta\": 3, \"puntuacion_normalizada\": 0.375}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 5, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.3571}, {\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0769}], \"normalizadas\": {\"A\": 0.3846, \"C\": 0.0769, \"E\": 0.375, \"I\": 0.9167, \"R\": 0.9167, \"S\": 0.3571}, \"perfil_principal\": {\"codigo\": \"I\", \"nombre\": \"Investigador\"}, \"perfil_terciario\": {\"codigo\": \"A\", \"nombre\": \"Artistico\"}, \"perfil_secundario\": {\"codigo\": \"R\", \"nombre\": \"Realista\"}}', '2026-04-17 04:39:24'),
(5, 5, 6, '{\"brutas\": {\"A\": 8, \"C\": 12, \"E\": 5, \"I\": 1, \"R\": 1, \"S\": 9}, \"ranking\": [{\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 1, \"puntuacion_bruta\": 12, \"puntuacion_normalizada\": 0.9231}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 2, \"puntuacion_bruta\": 9, \"puntuacion_normalizada\": 0.6429}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.625}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 4, \"puntuacion_bruta\": 8, \"puntuacion_normalizada\": 0.6154}, {\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 5, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}], \"normalizadas\": {\"A\": 0.6154, \"C\": 0.9231, \"E\": 0.625, \"I\": 0.0833, \"R\": 0.0833, \"S\": 0.6429}, \"perfil_principal\": {\"codigo\": \"C\", \"nombre\": \"Convencional\"}, \"perfil_terciario\": {\"codigo\": \"E\", \"nombre\": \"Emprendedor\"}, \"perfil_secundario\": {\"codigo\": \"S\", \"nombre\": \"Social\"}}', '2026-04-17 04:50:44'),
(6, 6, 6, '{\"brutas\": {\"A\": 8, \"C\": 12, \"E\": 5, \"I\": 1, \"R\": 1, \"S\": 9}, \"ranking\": [{\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 1, \"puntuacion_bruta\": 12, \"puntuacion_normalizada\": 0.9231}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 2, \"puntuacion_bruta\": 9, \"puntuacion_normalizada\": 0.6429}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.625}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 4, \"puntuacion_bruta\": 8, \"puntuacion_normalizada\": 0.6154}, {\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 5, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}], \"normalizadas\": {\"A\": 0.6154, \"C\": 0.9231, \"E\": 0.625, \"I\": 0.0833, \"R\": 0.0833, \"S\": 0.6429}, \"perfil_principal\": {\"codigo\": \"C\", \"nombre\": \"Convencional\"}, \"perfil_terciario\": {\"codigo\": \"E\", \"nombre\": \"Emprendedor\"}, \"perfil_secundario\": {\"codigo\": \"S\", \"nombre\": \"Social\"}}', '2026-04-17 07:23:57'),
(7, 9, 6, '{\"brutas\": {\"A\": 8, \"C\": 12, \"E\": 5, \"I\": 1, \"R\": 1, \"S\": 9}, \"ranking\": [{\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 1, \"puntuacion_bruta\": 12, \"puntuacion_normalizada\": 0.9231}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 2, \"puntuacion_bruta\": 9, \"puntuacion_normalizada\": 0.6429}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.625}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 4, \"puntuacion_bruta\": 8, \"puntuacion_normalizada\": 0.6154}, {\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 5, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}], \"normalizadas\": {\"A\": 0.6154, \"C\": 0.9231, \"E\": 0.625, \"I\": 0.0833, \"R\": 0.0833, \"S\": 0.6429}, \"perfil_principal\": {\"codigo\": \"C\", \"nombre\": \"Convencional\"}, \"perfil_terciario\": {\"codigo\": \"E\", \"nombre\": \"Emprendedor\"}, \"perfil_secundario\": {\"codigo\": \"S\", \"nombre\": \"Social\"}}', '2026-04-28 19:29:20'),
(8, 10, 2, '{\"brutas\": {\"A\": 5, \"C\": 1, \"E\": 3, \"I\": 11, \"R\": 11, \"S\": 5}, \"ranking\": [{\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 1, \"puntuacion_bruta\": 11, \"puntuacion_normalizada\": 0.9167}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 2, \"puntuacion_bruta\": 11, \"puntuacion_normalizada\": 0.9167}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.3846}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 4, \"puntuacion_bruta\": 3, \"puntuacion_normalizada\": 0.375}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 5, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.3571}, {\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0769}], \"normalizadas\": {\"A\": 0.3846, \"C\": 0.0769, \"E\": 0.375, \"I\": 0.9167, \"R\": 0.9167, \"S\": 0.3571}, \"perfil_principal\": {\"codigo\": \"I\", \"nombre\": \"Investigador\"}, \"perfil_terciario\": {\"codigo\": \"A\", \"nombre\": \"Artistico\"}, \"perfil_secundario\": {\"codigo\": \"R\", \"nombre\": \"Realista\"}}', '2026-04-28 23:28:16'),
(9, 12, 4, '{\"brutas\": {\"A\": 6, \"C\": 5, \"E\": 3, \"I\": 7, \"R\": 6, \"S\": 9}, \"ranking\": [{\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 1, \"puntuacion_bruta\": 9, \"puntuacion_normalizada\": 0.6429}, {\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 2, \"puntuacion_bruta\": 7, \"puntuacion_normalizada\": 0.5833}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 3, \"puntuacion_bruta\": 6, \"puntuacion_normalizada\": 0.5}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 4, \"puntuacion_bruta\": 6, \"puntuacion_normalizada\": 0.4615}, {\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 5, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.3846}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 6, \"puntuacion_bruta\": 3, \"puntuacion_normalizada\": 0.375}], \"normalizadas\": {\"A\": 0.4615, \"C\": 0.3846, \"E\": 0.375, \"I\": 0.5833, \"R\": 0.5, \"S\": 0.6429}, \"perfil_principal\": {\"codigo\": \"S\", \"nombre\": \"Social\"}, \"perfil_terciario\": {\"codigo\": \"R\", \"nombre\": \"Realista\"}, \"perfil_secundario\": {\"codigo\": \"I\", \"nombre\": \"Investigador\"}}', '2026-04-29 00:37:21'),
(10, 13, 6, '{\"brutas\": {\"A\": 8, \"C\": 12, \"E\": 5, \"I\": 1, \"R\": 1, \"S\": 9}, \"ranking\": [{\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 1, \"puntuacion_bruta\": 12, \"puntuacion_normalizada\": 0.9231}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 2, \"puntuacion_bruta\": 9, \"puntuacion_normalizada\": 0.6429}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.625}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 4, \"puntuacion_bruta\": 8, \"puntuacion_normalizada\": 0.6154}, {\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 5, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}], \"normalizadas\": {\"A\": 0.6154, \"C\": 0.9231, \"E\": 0.625, \"I\": 0.0833, \"R\": 0.0833, \"S\": 0.6429}, \"perfil_principal\": {\"codigo\": \"C\", \"nombre\": \"Convencional\"}, \"perfil_terciario\": {\"codigo\": \"E\", \"nombre\": \"Emprendedor\"}, \"perfil_secundario\": {\"codigo\": \"S\", \"nombre\": \"Social\"}}', '2026-05-02 18:39:11'),
(11, 14, 5, '{\"brutas\": {\"A\": 8, \"C\": 6, \"E\": 5, \"I\": 5, \"R\": 6, \"S\": 6}, \"ranking\": [{\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 1, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.625}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 2, \"puntuacion_bruta\": 8, \"puntuacion_normalizada\": 0.6154}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 3, \"puntuacion_bruta\": 6, \"puntuacion_normalizada\": 0.5}, {\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 4, \"puntuacion_bruta\": 6, \"puntuacion_normalizada\": 0.4615}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 5, \"puntuacion_bruta\": 6, \"puntuacion_normalizada\": 0.4286}, {\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 6, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.4167}], \"normalizadas\": {\"A\": 0.6154, \"C\": 0.4615, \"E\": 0.625, \"I\": 0.4167, \"R\": 0.5, \"S\": 0.4286}, \"perfil_principal\": {\"codigo\": \"E\", \"nombre\": \"Emprendedor\"}, \"perfil_terciario\": {\"codigo\": \"R\", \"nombre\": \"Realista\"}, \"perfil_secundario\": {\"codigo\": \"A\", \"nombre\": \"Artistico\"}}', '2026-05-02 19:30:45'),
(12, 16, 6, '{\"brutas\": {\"A\": 8, \"C\": 12, \"E\": 5, \"I\": 1, \"R\": 1, \"S\": 9}, \"ranking\": [{\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 1, \"puntuacion_bruta\": 12, \"puntuacion_normalizada\": 0.9231}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 2, \"puntuacion_bruta\": 9, \"puntuacion_normalizada\": 0.6429}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.625}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 4, \"puntuacion_bruta\": 8, \"puntuacion_normalizada\": 0.6154}, {\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 5, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}], \"normalizadas\": {\"A\": 0.6154, \"C\": 0.9231, \"E\": 0.625, \"I\": 0.0833, \"R\": 0.0833, \"S\": 0.6429}, \"perfil_principal\": {\"codigo\": \"C\", \"nombre\": \"Convencional\"}, \"perfil_terciario\": {\"codigo\": \"E\", \"nombre\": \"Emprendedor\"}, \"perfil_secundario\": {\"codigo\": \"S\", \"nombre\": \"Social\"}}', '2026-05-03 20:39:06');

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

--
-- Volcado de datos para la tabla `test`
--

INSERT INTO `test` (`id_test`, `uuid`, `id_usuario`, `estado`, `fecha_creacion`, `fecha_finalizacion`) VALUES
(1, '583f230f-bb96-42de-979e-3396db9695b8', NULL, 'FINALIZADO', '2026-04-10 07:28:01', '2026-04-10 07:28:49'),
(2, '0c966650-d69a-4950-a254-cd8aaafb4037', NULL, 'FINALIZADO', '2026-04-17 04:13:48', '2026-04-17 04:14:45'),
(3, '511569d6-326e-4bf6-876f-b374c78139b4', NULL, 'FINALIZADO', '2026-04-17 04:38:17', '2026-04-17 04:38:19'),
(4, '3a22d60c-ed1e-47c9-9715-2d96c3ff6314', NULL, 'FINALIZADO', '2026-04-17 04:39:23', '2026-04-17 04:39:24'),
(5, '88038dff-0e6e-4bfc-92cb-90f8f8e2325b', NULL, 'FINALIZADO', '2026-04-17 04:49:56', '2026-04-17 04:50:44'),
(6, '1e89d723-bc62-4291-bad6-46ac77654e1b', NULL, 'FINALIZADO', '2026-04-17 07:23:15', '2026-04-17 07:23:57'),
(7, 'c8beb4d0-ff29-4683-a4c2-1bb3f9f82945', NULL, 'EN_PROGRESO', '2026-04-28 18:41:36', NULL),
(8, '49260b74-11fe-45ec-a342-e2cee4e97cd8', NULL, 'EN_PROGRESO', '2026-04-28 18:43:32', NULL),
(9, '70293779-2382-4de0-91d6-36f824748133', NULL, 'FINALIZADO', '2026-04-28 19:28:41', '2026-04-28 19:29:20'),
(10, 'e1766bae-59e6-4857-a07d-72e4d03cd31e', NULL, 'FINALIZADO', '2026-04-28 23:27:36', '2026-04-28 23:28:16'),
(11, '57f42bce-69e0-4135-a427-a85bb92ff597', NULL, 'EN_PROGRESO', '2026-04-29 00:01:29', NULL),
(12, '83119da4-8232-429f-a416-fc711303367e', NULL, 'FINALIZADO', '2026-04-29 00:36:39', '2026-04-29 00:37:21'),
(13, 'e178007b-9c27-4cc0-966a-b61e7a5ab96e', NULL, 'FINALIZADO', '2026-05-02 18:38:17', '2026-05-02 18:39:11'),
(14, 'd43b62e9-e13b-465a-9852-0ab45c5b4ed3', NULL, 'FINALIZADO', '2026-05-02 19:30:09', '2026-05-02 19:30:45'),
(15, '4ae7bfed-9b96-4c9a-b976-245b240f7309', NULL, 'EN_PROGRESO', '2026-05-02 20:37:26', NULL),
(16, '9ea413ee-e09d-47ac-86b4-bd9cd59497fd', NULL, 'FINALIZADO', '2026-05-03 20:38:33', '2026-05-03 20:39:06');

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
-- Indices de la tabla `ciclo_riasec_afinidad`
--
ALTER TABLE `ciclo_riasec_afinidad`
  ADD PRIMARY KEY (`id_ciclo`),
  ADD KEY `idx_cra_r` (`puntaje_r`),
  ADD KEY `idx_cra_i` (`puntaje_i`),
  ADD KEY `idx_cra_a` (`puntaje_a`),
  ADD KEY `idx_cra_s` (`puntaje_s`),
  ADD KEY `idx_cra_e` (`puntaje_e`),
  ADD KEY `idx_cra_c` (`puntaje_c`);

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
  MODIFY `id_ciclo` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT de la tabla `dimension_riasec`
--
ALTER TABLE `dimension_riasec`
  MODIFY `id_dimension` tinyint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `enlace_resultado`
--
ALTER TABLE `enlace_resultado`
  MODIFY `id_enlace` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `familia_fp`
--
ALTER TABLE `familia_fp`
  MODIFY `id_familia` smallint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `opcion`
--
ALTER TABLE `opcion`
  MODIFY `id_opcion` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT de la tabla `perfil`
--
ALTER TABLE `perfil`
  MODIFY `id_perfil` smallint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  MODIFY `id_pregunta` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `respuesta`
--
ALTER TABLE `respuesta`
  MODIFY `id_respuesta` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=474;

--
-- AUTO_INCREMENT de la tabla `resultado`
--
ALTER TABLE `resultado`
  MODIFY `id_resultado` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `test`
--
ALTER TABLE `test`
  MODIFY `id_test` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
-- Filtros para la tabla `ciclo_riasec_afinidad`
--
ALTER TABLE `ciclo_riasec_afinidad`
  ADD CONSTRAINT `fk_ciclo_riasec_afinidad_ciclo` FOREIGN KEY (`id_ciclo`) REFERENCES `ciclo_formativo` (`id_ciclo`) ON DELETE CASCADE ON UPDATE CASCADE;

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
