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
    int cpf = int.parse(cpfController.text);
    int age = int.parse(ageController.text);
    int phone = int.parse(phoneController.text);

    print("Dados de entrada: nome=$name, email=$email");

    try {
      _isLoading = true;
      notifyListeners();

      // Criar usuário com os valores estáticos
      final user = await _appWriteService.createUser(
        email: email,
        password: password,
        name: name,
      );

      // Criar o documento do usuário com os dados adicionais
      final userDocument = await _appWriteService.createUserDocument(
        cpf: cpf,
        age: age,
        phone: phone,
        userId: user['_id'], // Passar o ID do usuário criado
      );

      print("Usuário criado com sucesso: ${user['_id']}");
      print("Documento do usuário criado: ${userDocument['_id']}");

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

      print("Erro ao cadastrar: $e");
      Fluttertoast.showToast(
        msg: 'Erro ao cadastrar: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
      );
    }
  }
}
