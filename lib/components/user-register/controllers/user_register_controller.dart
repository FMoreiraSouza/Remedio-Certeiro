import 'package:flutter/material.dart';
import 'package:remedio_certeiro/api-setup/app_write_service.dart';

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

    final cpf = int.tryParse(cpfController.text) ?? 0;
    final age = int.tryParse(ageController.text) ?? 0;
    final email = emailController.text;
    final phone = int.tryParse(phoneController.text) ?? 0;

    try {
      final user = await _appWriteService.account.create(
        userId: 'unique()',
        email: email,
        password: password,
      );

      await _appWriteService.database.createDocument(
        databaseId: '67944210001fd099f8bc',
        collectionId: '6794439e000f4d482ae3',
        documentId: 'unique()',
        data: {
          'userId': user.$id,
          'name': name,
          'age': age,
          'cpf': cpf,
          'phone': phone,
        },
      );

      return user.$id;
    } catch (e) {
      return 'Erro ao cadastrar: $e';
    }
  }
}
