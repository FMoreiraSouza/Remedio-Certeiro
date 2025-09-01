import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/data/models/user_info_model.dart';
import 'package:remedio_certeiro/data/repositories/i_user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final IUserRepository repository;
  UserInfo? _userInfo;
  bool _isLoading = false;
  String? _errorMessage;

  ProfileViewModel(this.repository);

  UserInfo? get userInfo => _userInfo;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _userInfo = await repository.fetchUserData('current');
    } catch (e) {
      _errorMessage = 'Erro ao recuperar dados do usuário: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await repository.logout();
      if (context.mounted) {
        Navigator.pushNamed(context, Routes.login);
      }
    } catch (e) {
      _errorMessage = 'Erro ao tentar realizar o logout: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
