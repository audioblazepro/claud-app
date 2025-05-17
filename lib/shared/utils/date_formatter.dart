import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} años';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} meses';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} días';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} horas';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutos';
    } else {
      return 'Ahora';
    }
  }

  static String formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return 'Vencido';
    } else if (difference.inDays == 0) {
      return 'Hoy';
    } else if (difference.inDays == 1) {
      return 'Mañana';
    } else {
      return 'En ${difference.inDays} días';
    }
  }
}