import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/utils/failure_handler.dart';
import 'package:remedio_certeiro/data/repositories/i_user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final IUserRepository repository;
  String _username = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;

  LoginViewModel(this.repository);

  String get username => _username;
  String get password => _password;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setUsername(String value) {
    _username = value;
    _errorMessage = null;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.login(_username, _password);
      if (context.mounted) {
        Navigator.pushNamed(context, Routes.home);
      }
    } catch (e) {
      _errorMessage = FailureHandler.handleException(e, context: 'login');
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
