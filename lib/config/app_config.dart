class AppConfig {
  // Versión de la aplicación
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;

  // Configuración de la base de datos
  static const String databaseName = 'claud_assistant.db';
  static const int databaseVersion = 1;

  // Configuración de tiempo
  static const Duration sessionTimeout = Duration(hours: 24);
  static const Duration cacheExpiration = Duration(days: 7);

  // Formatos de fecha
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  // Configuración de API (para futuras implementaciones)
  static const String apiBaseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Límites y configuraciones
  static const int maxGoals = 10;
  static const int maxProjects = 20;
  static const int maxTransactionsPerPage = 50;

  // Configuración de animaciones
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Configuración de notificaciones
  static const Duration notificationInterval = Duration(hours: 24);
  static const String notificationChannelId = 'claud_assistant_channel';
  static const String notificationChannelName = 'Claud Assistant Notifications';

  // Mensajes predeterminados
  static const String defaultErrorMessage = 'Ha ocurrido un error. Por favor, inténtalo de nuevo.';
  static const String networkErrorMessage = 'Error de conexión. Verifica tu conexión a internet.';
  static const String sessionExpiredMessage = 'Tu sesión ha expirado. Por favor, inicia sesión nuevamente.';
}