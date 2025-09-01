import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';
import 'package:remedio_certeiro/data/repositories/i_user_repository.dart';

class UserRegisterViewModel extends ChangeNotifier {
  final IUserRepository repository;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool _isLoading = false;

  UserRegisterViewModel(this.repository);

  bool get isLoading => _isLoading;

  Future<void> registerUser(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.registerUser(
        emailController.text,
        passwordController.text,
        nameController.text,
        int.parse(ageController.text),
        cpfController.text,
        phoneController.text,
      );
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Icon(Icons.check_circle_outline, color: Colors.green, size: 50),
            content: const Text(Texts.registerSuccess,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
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
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erro'),
            content: const Text(Texts.errorRegister),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
