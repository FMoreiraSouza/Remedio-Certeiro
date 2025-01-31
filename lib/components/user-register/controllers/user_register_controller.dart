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
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String cpf = cpfController.text;
    int age = int.parse(ageController.text);
    String phone = phoneController.text;

    try {
      _isLoading = true;
      notifyListeners();

      final user = await _appWriteService.account.create(
        userId: 'unique()',
        email: email,
        password: password,
        name: name,
      );

      await _appWriteService.database.createDocument(
        databaseId: '67944210001fd099f8bc',
        collectionId: '6794439e000f4d482ae3',
        documentId: 'unique()',
        data: {
          'userId': user.$id,
          'age': age,
          'cpf': cpf,
          'phone': phone,
        },
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
    } catch (_) {
      _isLoading = false;
      notifyListeners();

      Fluttertoast.showToast(
        msg: 'Erro ao cadastrar',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
      );
    }
  }
}
