# Flutter App - Notificaciones Push & Mapas

Esta aplicación Flutter fue desarrollada como parte de un proyecto educativo para integrar funcionalidades modernas como:

- ✅ Registro y gestión de tokens de dispositivos
- ✅ Envío y recepción de notificaciones push (Firebase Cloud Messaging)
- ✅ Visualización de mapas y objetos geográficos (puntos, rutas y polígonos)
- ✅ Consumo de una API RESTful desarrollada en Node.js + PostgreSQL

---

## Requisitos previos

- Antes de ejecutar este proyecto, asegúrate de tener instalados:
- Flutter SDK (v3.27.0 o superior)
- Dart SDK (v3.6.0 o superior)
- [Android Studio / Xcode] para emuladores o dispositivos físicos
- Una cuenta en Firebase Console

### Clonar el repositorio
```bash
git clone https://github.com/tu_usuario/app_notifications.git
cd app_notifications
flutter pub get
```

### Configuración de Firebase para notificaciones

- En Firebase Console, crea un nuevo proyecto (o usa uno existente).
- Agrega una app Android (y/o iOS) con los siguientes pasos:
- Para Android: coloca el archivo google-services.json en android/app/
- Para iOS: coloca el archivo GoogleService-Info.plist en ios/Runner/

### Activa Firebase Cloud Messaging en tu consola de Firebase.

Asegúrate de tener los siguientes plugins en pubspec.yaml:

```bash
firebase_core: ^2.x.x
firebase_messaging: ^14.x.x
flutter_local_notifications: ^17.x.x
dio: ^5.x.x
provider: ^6.x.x
```

### Ejecución de la app

```bash
flutter run
```

Al ejecutar, la app debe:
- Solicitar permisos de notificación
- Obtener el token del dispositivo
- Registrar el token mediante la API del backend
- Mostrar los objetos geográficos en un mapa

### Estructura del proyecto
```bash
app_notifications/
├── lib/
│   ├── data/                     ← data sources y modelos (dio)
│   ├── domain/                   ← entidades y casos de uso
│   ├── presentation/            ← pantallas, widgets y lógica visual
│   ├── providers/               ← controladores y estados (Provider)
│   ├── services/                ← utilidades como FCM, background, etc.
│   └── main.dart                ← punto de entrada
├── android/                     ← config para Android
├── ios/                         ← config para iOS
├── pubspec.yaml                 ← dependencias y assets
```
### Funcionalidades clave

- Mapa interactivo: visualización de puntos, rutas y polígonos desde la API
- Notificaciones push: integración con FCM (locales y remotas)
- Consumo de API: mediante DIO + arquitectura limpia + Provider

### Notas importantes

- El token de dispositivo es único por instalación y se registra automáticamente al iniciar la app.
- Las notificaciones son gestionadas en segundo plano mediante:
- FirebaseMessaging.onBackgroundMessage
- flutter_local_notifications para mostrar mensajes personalizados.

### API conectada

La aplicación se conecta al backend desarrollado en:

```bash
http://<tu_ip_local>:3000/api
```

## Configuración de Google Maps API Key

Para que el mapa funcione correctamente en Android y/o iOS, necesitas una clave de API de Google Maps. A continuación te explico cómo obtenerla y configurarla.

### Crear cuenta en Google Cloud Platform (GCP)
- Ingresa a: https://console.cloud.google.com
- Inicia sesión con tu cuenta de Google
- Haz clic en "Seleccionar proyecto" y luego en "Nuevo proyecto"
- Asigna un nombre a tu proyecto (por ejemplo: FlutterMapsApp) y crea el proyecto

### Habilitar la API de Google Maps

- Con tu proyecto seleccionado, ve a: https://console.cloud.google.com/apis/library/maps-backend.googleapis.com
- Haz clic en "Habilitar"
- Repite el proceso para:
- Maps SDK for Android
- Maps SDK for iOS
- Geocoding API (opcional para traducción de direcciones)

### Crear la clave de API

- Ve al menú: APIs y servicios → Credenciales
- Haz clic en “Crear credenciales” → “Clave de API”
- Copia la clave generada y colócala en tu proyecto Flutter

### Configurar la clave en Flutter

Para Android:
Edita el archivo android/app/src/main/AndroidManifest.xml y dentro de <application> agrega:

```bash
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="TU_API_KEY_AQUÍ"/>
```
Para iOS:
Abre ios/Runner/AppDelegate.swift o AppDelegate.m (según tu configuración) y asegúrate de que esté incluido:

```bash
GMSServices.provideAPIKey("TU_API_KEY_AQUÍ")
```
También puedes agregarlo a tu ios/Runner/Info.plist:

```bash
<key>GMSApiKey</key>
<string>TU_API_KEY_AQUÍ</string>
```

### (Opcional) Restringir el uso de tu API Key
Desde la consola de GCP, puedes:

- Limitar por plataforma (Android, iOS)
- Limitar por IP (si usas solo local)
- Limitar por tipo de API (solo Maps, etc.)

Esto ayuda a evitar que terceros abusen de tu clave.


### Autor
**Richard Armijos**  
Docente – Universidad Internacional del Ecuador  
Materia: *Programación Móvil en Flutter*  
Loja, Ecuador
