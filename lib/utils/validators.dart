class Validators {
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu nome';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma senha';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirme a senha';
    }
    if (value != password) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  String? validateCpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu CPF';
    }
    if (value.length != 11) {
      return 'CPF deve ter 11 dígitos';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua idade';
    }
    return null;
  }

  // Validação de email com expressão regular
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu email';
    }
    // Regex para validar formato de email
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }

  // Validação de telefone com expressão regular
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu telefone';
    }
    // Regex para validar telefone (considerando formato brasileiro)
    final phoneRegex = RegExp(r'^\(?\d{2}\)?\s?\d{4,5}-?\d{4}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Por favor, insira um telefone válido';
    }
    return null;
  }
}
