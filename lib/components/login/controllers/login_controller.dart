import 'package:flutter/material.dart';
import 'package:remedio_certeiro/api-setup/app_write_service.dart';
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remedio_certeiro/utils/shared_preferences_service.dart';

class LoginController extends ChangeNotifier {
  final AppWriteService _appWriteService;

  LoginController(this._appWriteService);

  String _username = '';
  String _password = '';

  String get username => _username;
  String get password => _password;

  bool _isLoading = false;
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
      final session = await _appWriteService.account.createEmailPasswordSession(
        email: _username,
        password: _password,
      );
      await SharedPreferencesService.saveString('sessionId', session.$id);
      if (context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _isLoading = false;
          Navigator.pushNamed(context, ScreensRoutes.home);
          notifyListeners();
        });
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      Fluttertoast.showToast(
        msg: 'Erro ao fazer login',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
      );

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erro'),
            content: const Text('Credenciais inválidas: Por gentileza, cheque seu email ou senha'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
    }
  }
}
