import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/data/api/app_write_service.dart';
import 'package:remedio_certeiro/data/models/user_info_model.dart';
import 'package:remedio_certeiro/data/repositories/i_user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final IUserRepository repository;
  final AppWriteService appwriteService = AppWriteService();
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
      _user = await appwriteService.getCurrentUser();
      _userInfoModel = await repository.fetchUserData(_user?.$id ?? "-1");
    } on AppwriteException catch (e) {
      _errorMessage = e.code == 404
          ? 'Documento não encontrado para o usuário logado.'
          : 'Erro ao recuperar dados do usuário: ${e.message}';
      Fluttertoast.showToast(
        msg: _errorMessage!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
      );
    } catch (e) {
      _errorMessage = 'Erro ao recuperar dados do usuário: $e';
      Fluttertoast.showToast(
        msg: _errorMessage!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
      );
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
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
      }
    } catch (e) {
      _errorMessage = 'Erro ao tentar realizar o logout';
      Fluttertoast.showToast(
        msg: _errorMessage!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
