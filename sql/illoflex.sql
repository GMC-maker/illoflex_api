-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 17-04-2026 a las 05:06:19
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
(6, 0, 0, 0, 1, 1, 2),
(7, 0, 1, 0, 1, 2, 3),
(8, 0, 1, 0, 2, 2, 3),
(12, 0, 0, 0, 1, 2, 1),
(14, 0, 1, 2, 1, 3, 1),
(15, 0, 1, 0, 1, 3, 1),
(40, 1, 1, 0, 0, 0, 2),
(41, 2, 2, 0, 0, 0, 1),
(42, 2, 3, 0, 0, 0, 2),
(43, 1, 3, 1, 0, 0, 2),
(44, 1, 3, 1, 0, 0, 2),
(45, 0, 1, 0, 3, 0, 1),
(49, 0, 2, 0, 2, 0, 1),
(51, 0, 2, 0, 2, 0, 1),
(54, 0, 1, 1, 3, 1, 1),
(55, 0, 1, 1, 3, 1, 1);

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
(1, 'R', 'Realista', 'Interes por actividades practicas, tecnicas y concretas.'),
(2, 'I', 'Investigador', 'Interes por analizar, investigar, comprender y resolver problemas.'),
(3, 'A', 'Artistico', 'Interes por crear, disenar, expresar e innovar.'),
(4, 'S', 'Social', 'Interes por ayudar, ensenar, acompanar y cooperar con otras personas.'),
(5, 'E', 'Emprendedor', 'Interes por liderar, persuadir, coordinar y tomar decisiones.'),
(6, 'C', 'Convencional', 'Interes por el orden, la estructura, la organizacion y los procedimientos.');

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
(180, 5, 18, 72, '2026-04-17 04:50:44');

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
(5, 5, 6, '{\"brutas\": {\"A\": 8, \"C\": 12, \"E\": 5, \"I\": 1, \"R\": 1, \"S\": 9}, \"ranking\": [{\"codigo\": \"C\", \"nombre\": \"Convencional\", \"posicion\": 1, \"puntuacion_bruta\": 12, \"puntuacion_normalizada\": 0.9231}, {\"codigo\": \"S\", \"nombre\": \"Social\", \"posicion\": 2, \"puntuacion_bruta\": 9, \"puntuacion_normalizada\": 0.6429}, {\"codigo\": \"E\", \"nombre\": \"Emprendedor\", \"posicion\": 3, \"puntuacion_bruta\": 5, \"puntuacion_normalizada\": 0.625}, {\"codigo\": \"A\", \"nombre\": \"Artistico\", \"posicion\": 4, \"puntuacion_bruta\": 8, \"puntuacion_normalizada\": 0.6154}, {\"codigo\": \"I\", \"nombre\": \"Investigador\", \"posicion\": 5, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}, {\"codigo\": \"R\", \"nombre\": \"Realista\", \"posicion\": 6, \"puntuacion_bruta\": 1, \"puntuacion_normalizada\": 0.0833}], \"normalizadas\": {\"A\": 0.6154, \"C\": 0.9231, \"E\": 0.625, \"I\": 0.0833, \"R\": 0.0833, \"S\": 0.6429}, \"perfil_principal\": {\"codigo\": \"C\", \"nombre\": \"Convencional\"}, \"perfil_terciario\": {\"codigo\": \"E\", \"nombre\": \"Emprendedor\"}, \"perfil_secundario\": {\"codigo\": \"S\", \"nombre\": \"Social\"}}', '2026-04-17 04:50:44');

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
(5, '88038dff-0e6e-4bfc-92cb-90f8f8e2325b', NULL, 'FINALIZADO', '2026-04-17 04:49:56', '2026-04-17 04:50:44');

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
  MODIFY `id_enlace` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_respuesta` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT de la tabla `resultado`
--
ALTER TABLE `resultado`
  MODIFY `id_resultado` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `test`
--
ALTER TABLE `test`
  MODIFY `id_test` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
