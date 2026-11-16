# UACheck — Sistema Inteligente de Control de Asistencia Académica

**UACheck** es una aplicación móvil multiplataforma desarrollada en **Flutter** diseñada para optimizar y modernizar el registro y seguimiento de asistencia académica en la **Universidad de la Amazonia**[cite: 9, 11]. Ofrece una experiencia diferenciada y fluida para los roles de **Docente** y **Estudiante**, integrando códigos QR dinámicos, validación de ubicación y reportes estadísticos en tiempo real.

---

## Características Principales

### Módulo Docente
* **Panel de Inicio:** Resumen diario con métricas clave, próximas clases programadas y accesos rápidos a funciones críticas.
* **Gestión de Cursos:** Creación, visualización y administración de materias, grupos, horarios, aulas y listado de estudiantes (con soporte para importación por CSV).
* **Generación de QR y Sesión en Vivo:** Emisión de códigos QR dinámicos por sesión y monitoreo en tiempo real de los estudiantes que registran su asistencia (*Presente*, *Tarde*, *Ausente*).
* **Estadísticas y Reportes:** Visualización de porcentajes de asistencia por curso y exportación de reportes en formatos **Excel** y **CSV**.
* **Perfil y Ajustes:** Configuración de cuenta docente, modo oscuro, gestión de caché y soporte.

### Módulo Estudiante
* **Panel de Inicio:** Visualización del porcentaje general de asistencia semestral, estado de la clase actual o próxima y progreso individual por materia inscrita[cite: 4].
* **Escáner QR con Validación GPS:** Registro rápido de asistencia escaneando el código QR proyectado en el aula[cite: 8].
* **Carné Digital Institucional:** Identificación estudiantil digital con código QR personal dinámico como respaldo de registro[cite: 9].
* **Horario de Clases:** Consulta de asignaturas del día con aulas, docentes y horarios asignados[cite: 7].
* **Historial Cronológico:** Registro detallado de asistencias con filtros (*Todas*, *Este mes*, *Por materia*) y contadores acumulados[cite: 6].

---

## Stack Tecnológico

* **Framework:** Flutter (Dart)
* **Gestión de Estado:** Flutter Riverpod (`flutter_riverpod`)
* **Navegación:** GoRouter (`go_router`)
* **Backend & Autenticación:** Supabase (`supabase_flutter`)
* **Arquitectura:** Clean Architecture (Capas de `Config`, `Domain`, `Infrastructure` y `Presentation`)

---

## Estructura del Proyecto

```text
lib/
├── config/
│   ├── constants/        # Constantes globales de la aplicación
│   ├── helpers/          # Extensiones de contexto, excepciones y validadores[cite: 11]
│   ├── router/           # Configuración centralizada de rutas con GoRouter[cite: 11]
│   └── theme/            # Paleta de colores (AppColors) y temas (AppTheme)[cite: 11]
├── domain/
│   ├── datasources/      # Contratos de fuentes de datos[cite: 11]
│   ├── entities/         # Entidades puras del negocio (User, etc.)[cite: 11]
│   └── repositories/     # Contratos de repositorios[cite: 11]
├── infrastructure/
│   ├── datasources/      # Implementación con Supabase[cite: 11]
│   ├── mappers/          # Transformación entre modelos y entidades[cite: 11]
│   ├── models/           # Modelos de serialización (JSON)[cite: 11]
│   └── repositories/     # Implementación de repositorios[cite: 11]
├── presentation/
│   ├── providers/        # Providers de Riverpod (Auth, Roles, Repositorios)[cite: 11]
│   ├── screens/
│   │   ├── auth/         # Welcome, Login, Register, Forgot Password[cite: 11]
│   │   ├── home/         # Vistas principales para Docente y Estudiante[cite: 11]
│   │   ├── profile/      # Perfil y configuración docente[cite: 11]
│   │   ├── student/      # Clases, Escáner QR, Historial y Carné Digital[cite: 11]
│   │   └── teacher/      # Cursos, Detalle, Sesión en Vivo, QR y Estadísticas[cite: 11]
│   └── widgets/
│       ├── shared/       # Componentes reutilizables globales (AppBar, Nav, Buttons, etc.)[cite: 11]
│       ├── student/      # Widgets exclusivos del módulo estudiante[cite: 11]
│       └── teacher/      # Widgets exclusivos del módulo docente[cite: 11]
└── main.dart             # Punto de entrada de la aplicación[cite: 11]