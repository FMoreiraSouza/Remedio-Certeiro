import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:remedio_certeiro/api-setup/app_write_service.dart';
import 'package:remedio_certeiro/models/user_info_model.dart';
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:remedio_certeiro/utils/shared_preferences_service.dart';

class ProfileController extends ChangeNotifier {
  final AppWriteService _appWriteService;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String errorMessage = '';
  User? user;
  UserInfoModel? userInfoModel;

  ProfileController(this._appWriteService);

  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final userData = await _appWriteService.account.get();
      user = userData;

      final documents = await _appWriteService.database.listDocuments(
        databaseId: '67944210001fd099f8bc',
        collectionId: '6794439e000f4d482ae3',
        queries: [
          Query.equal('userId', user?.$id ?? ''),
        ],
      );

      if (documents.total > 0) {
        final document = documents.documents.first;
        userInfoModel = UserInfoModel.fromMap(document.data);
      } else {
        errorMessage = 'Documento não encontrado para o userId fornecido.';
      }
    } catch (e) {
      errorMessage = 'Erro ao recuperar dados do usuário: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _appWriteService.account.deleteSession(sessionId: 'current');
      await SharedPreferencesService.remove('sessionId');
      if (context.mounted) {
        Navigator.pushNamed(context, ScreensRoutes.login);
      }
    } catch (e) {
      errorMessage = 'Erro ao tentar realizar o logout: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
