import 'package:flutter/material.dart';
import 'package:remedio_certeiro/api-setup/app-write-service.dart';

class UserRegisterController extends ChangeNotifier {
  final AppWriteService _appWriteService;

  UserRegisterController(this._appWriteService);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<String?> registerUser() async {
    final name = nameController.text;
    final password = passwordController.text;
    final cpf = cpfController.text;
    final age = int.tryParse(ageController.text) ?? 0;
    final email = emailController.text;
    final phone = phoneController.text;

    try {
      final user = await _appWriteService.account.create(
        userId: 'unique()',
        email: email,
        password: password,
      );
      return user.$id;
    } catch (e) {
      return 'Erro ao cadastrar: $e';
    }
  }
}
