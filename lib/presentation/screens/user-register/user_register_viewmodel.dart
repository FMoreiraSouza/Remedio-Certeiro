import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';
import 'package:remedio_certeiro/data/repositories/i_user_repository.dart';
import 'package:remedio_certeiro/core/utils/failure_handler.dart';

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
  String? _errorMessage;

  UserRegisterViewModel(this.repository);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void clearData() {
    nameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    ageController.clear();
    cpfController.clear();
    phoneController.clear();
    emailController.clear();
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> registerUser(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
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

      clearData();

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
      _errorMessage = FailureHandler.handleException(e, context: 'register');
    } finally {
      _isLoading = false;
      notifyListeners();

      if (_errorMessage != null && context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erro'),
            content: Text(_errorMessage!),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
    }
  }
}
