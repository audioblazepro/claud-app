class Validators {
  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo electrónico es requerido';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Ingresa un correo electrónico válido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    if (double.tryParse(value) == null) {
      return 'Ingresa un número válido';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'El monto es requerido';
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Ingresa un monto válido';
    }
    if (amount <= 0) {
      return 'El monto debe ser mayor a 0';
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'La fecha es requerida';
    }
    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return 'Ingresa una fecha válida';
    }
  }
}