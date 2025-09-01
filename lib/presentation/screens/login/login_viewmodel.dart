import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';
import 'package:remedio_certeiro/data/repositories/i_user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final IUserRepository repository;
  String _username = '';
  String _password = '';
  bool _isLoading = false;

  LoginViewModel(this.repository);

  String get username => _username;
  String get password => _password;
  bool get isLoading => _isLoading;

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.login(_username, _password);
      if (context.mounted) {
        Navigator.pushNamed(context, Routes.home);
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erro'),
            content: const Text(Texts.invalidCredentials),
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
