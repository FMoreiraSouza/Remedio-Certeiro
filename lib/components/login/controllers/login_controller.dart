import 'package:flutter/material.dart';
import 'package:remedio_certeiro/screens-routes.dart';

class LoginController extends ChangeNotifier {
  String _username = '';
  String _password = '';
  bool _isLoading = false;

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

  void login(BuildContext context) {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      _isLoading = false;
      Navigator.pushReplacementNamed(context, ScreensRoutes.home);
      notifyListeners();
    });
  }

  void reset() {
    _username = '';
    _password = '';
    _isLoading = false;
    notifyListeners();
  }
}
