import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/utils/failure_handler.dart';
import 'package:remedio_certeiro/data/models/user_info_model.dart';
import 'package:remedio_certeiro/data/repositories/i_user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final IUserRepository repository;
  UserInfoModel? _userInfoModel;
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  ProfileViewModel(this.repository);

  User? get user => _user;
  UserInfoModel? get userInfoModel => _userInfoModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUserData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await repository.getCurrentUser();
      _userInfoModel = await repository.fetchUserData(_user?.$id ?? "-1");
    } catch (e) {
      _errorMessage = FailureHandler.handleException(e, context: 'fetch');
      _showToast(_errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.logout();
      if (Routes.navigatorKey.currentContext != null) {
        Navigator.of(Routes.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
          Routes.login,
          (route) => false,
        );
      } else if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
      }
    } catch (e) {
      _errorMessage = FailureHandler.handleException(e, context: 'logout');
      _showToast(_errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
    );
  }
}
