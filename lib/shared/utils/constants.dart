class AppConstants {
  // Strings generales
  static const String appName = 'Claud Assistant';
  static const String appVersion = '1.0.0';

  // Mensajes de error
  static const String errorGenerico = 'Ha ocurrido un error. Por favor, inténtalo de nuevo.';
  static const String errorConexion = 'Error de conexión. Verifica tu conexión a internet.';
  static const String errorAutenticacion = 'Error de autenticación. Por favor, inicia sesión nuevamente.';

  // Estados
  static const String estadoPendiente = 'pendiente';
  static const String estadoEnProgreso = 'en_progreso';
  static const String estadoCompletado = 'completado';
  static const String estadoCancelado = 'cancelado';

  // Prioridades
  static const String prioridadBaja = 'baja';
  static const String prioridadMedia = 'media';
  static const String prioridadAlta = 'alta';

  // Categorías de finanzas
  static const List<String> categoriasFinanzas = [
    'Alimentación',
    'Transporte',
    'Vivienda',
    'Servicios',
    'Entretenimiento',
    'Salud',
    'Educación',
    'Otros',
  ];

  // Duración de animaciones
  static const Duration animacionCorta = Duration(milliseconds: 300);
  static const Duration animacionMedia = Duration(milliseconds: 500);
  static const Duration animacionLarga = Duration(milliseconds: 800);

  // Tamaños
  static const double borderRadius = 15.0;
  static const double padding = 16.0;
  static const double margen = 16.0;
  static const double iconSize = 24.0;
}