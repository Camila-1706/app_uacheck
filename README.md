# UACheck — Sistema Inteligente de Control de Asistencia Académica

**UACheck** es una aplicación móvil multiplataforma desarrollada en **Flutter** diseñada para optimizar y modernizar el registro y seguimiento de asistencia académica en la **Universidad de la Amazonia**. Ofrece una experiencia diferenciada y fluida para los roles de **Docente** y **Estudiante**, integrando códigos QR dinámicos, validación de ubicación y reportes estadísticos en tiempo real.

---

## Características Principales

### Módulo Docente
* **Panel de Inicio:** Resumen diario con métricas clave, próximas clases programadas y accesos rápidos a funciones críticas.
* **Gestión de Cursos:** Creación, visualización y administración de materias, grupos, horarios, aulas y listado de estudiantes (con soporte para importación por CSV).
* **Generación de QR y Sesión en Vivo:** Emisión de códigos QR dinámicos por sesión y monitoreo en tiempo real de los estudiantes que registran su asistencia (*Presente*, *Tarde*, *Ausente*).
* **Estadísticas y Reportes:** Visualización de porcentajes de asistencia por curso y exportación de reportes en formatos **Excel** y **CSV**.
* **Perfil y Ajustes:** Configuración de cuenta docente, modo oscuro, gestión de caché y soporte.

### Módulo Estudiante
* **Panel de Inicio:** Visualización del porcentaje general de asistencia semestral, estado de la clase actual o próxima y progreso individual por materia inscrita.
* **Escáner QR con Validación GPS:** Registro rápido de asistencia escaneando el código QR proyectado en el aula.
* **Carné Digital Institucional:** Identificación estudiantil digital con código QR personal dinámico como respaldo de registro.
* **Horario de Clases:** Consulta de asignaturas del día con aulas, docentes y horarios asignados.
* **Historial Cronológico:** Registro detallado de asistencias con filtros (*Todas*, *Este mes*, *Por materia*) y contadores acumulados.

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
│   ├── helpers/          # Extensiones de contexto, excepciones y validadores
│   ├── router/           # Configuración centralizada de rutas con GoRouter
│   └── theme/            # Paleta de colores (AppColors) y temas (AppTheme)
├── domain/
│   ├── datasources/      # Contratos de fuentes de datos
│   ├── entities/         # Entidades puras del negocio (User, etc.)
│   └── repositories/     # Contratos de repositorios
├── infrastructure/
│   ├── datasources/      # Implementación con Supabase
│   ├── mappers/          # Transformación entre modelos y entidades
│   ├── models/           # Modelos de serialización (JSON)
│   └── repositories/     # Implementación de repositorios
├── presentation/
│   ├── providers/        # Providers de Riverpod (Auth, Roles, Repositorios)
│   ├── screens/
│   │   ├── auth/         # Welcome, Login, Register, Forgot Password
│   │   ├── home/         # Vistas principales para Docente y Estudiante
│   │   ├── profile/      # Perfil y configuración docente
│   │   ├── student/      # Clases, Escáner QR, Historial y Carné Digital
│   │   └── teacher/      # Cursos, Detalle, Sesión en Vivo, QR y Estadísticas
│   └── widgets/
│       ├── shared/       # Componentes reutilizables globales (AppBar, Nav, Buttons, etc.)
│       ├── student/      # Widgets exclusivos del módulo estudiante
│       └── teacher/      # Widgets exclusivos del módulo docente
└── main.dart             # Punto de entrada de la aplicación


Requisitos Previos
Flutter SDK (versión 3.x o superior)

Dart SDK compatible

Un editor de código como Visual Studio Code o Android Studio

Un emulador Android/iOS, navegador web o dispositivo físico conectado

Cuenta y proyecto activo en Supabase

Instalación y Ejecución Local
Clonar el repositorio:

Bash
git clone [https://github.com/Camila-1706/app_uacheck.git](https://github.com/Camila-1706/app_uacheck.git)
cd app_uacheck
Instalar dependencias:

Bash
flutter pub get
Configurar variables de entorno (Supabase):
Crea un archivo .env en la raíz del proyecto con las credenciales de tu proyecto en Supabase:

Fragmento de código
SUPABASE_URL=tu_supabase_url
SUPABASE_ANON_KEY=tu_supabase_anon_key
Verificar dispositivos disponibles y ejecutar la aplicación:

Bash
flutter devices
flutter run


Autora
Laura Camila Álvarez Rojas