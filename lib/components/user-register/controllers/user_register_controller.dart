import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> registerUser(BuildContext context) async {
    final name = nameController.text;
    final password = passwordController.text;

    final cpf = int.tryParse(cpfController.text) ?? 0;
    final age = int.tryParse(ageController.text) ?? 0;
    final email = emailController.text;
    final phone = int.tryParse(phoneController.text) ?? 0;

    try {
      _isLoading = true;
      notifyListeners();

      final user = await _appWriteService.createUserGraphQL(
        email: email,
        password: password,
      );

      await _appWriteService.createUserProfileGraphQL(
        userId: user['id'],
        name: name,
        age: age,
        cpf: cpf,
        phone: phone,
      );

      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 50,
            ),
            content: const Text(
              'Cadastro realizado com sucesso!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Erro ao cadastrar: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
      );
    }
  }
}
