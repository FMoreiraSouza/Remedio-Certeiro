import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:remedio_certeiro/core/network/checker.dart';
import 'package:remedio_certeiro/core/utils/failure_handler.dart';
import 'package:remedio_certeiro/core/utils/shared_preferences_service.dart';
import 'package:remedio_certeiro/data/api/app_write_service.dart';
import 'package:remedio_certeiro/data/models/user_info_model.dart';
import 'package:remedio_certeiro/data/repositories/i_user_repository.dart';

class UserRepository implements IUserRepository {
  final AppWriteService appwriteService;

  UserRepository(this.appwriteService);

  @override
  Future<void> registerUser(
      String email, String password, String name, int age, String cpf, String phone) async {
    try {
      await Checker.checkNetworkConnectivity(context: 'register');
      final user = await appwriteService.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      await appwriteService.database.createDocument(
        databaseId: '67944210001fd099f8bc',
        collectionId: '6794439e000f4d482ae3',
        documentId: ID.unique(),
        data: {
          'userId': user.$id,
          'age': age,
          'cpf': cpf,
          'phone': phone,
          'name': name,
          'email': email,
        },
      );
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      await Checker.checkNetworkConnectivity(context: 'login');
      final session = await appwriteService.account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      await SharedPreferencesService.saveString('sessionId', session.$id);
      return await appwriteService.account.get();
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserInfoModel> fetchUserData(String userId) async {
    try {
      await Checker.checkNetworkConnectivity(context: 'fetch');
      final documents = await appwriteService.database.listDocuments(
        databaseId: '67944210001fd099f8bc',
        collectionId: '6794439e000f4d482ae3',
        queries: [Query.equal('userId', userId)],
      );

      if (documents.total > 0) {
        return UserInfoModel.fromMap(documents.documents.first.data);
      } else {
        throw Exception('Documento não encontrado');
      }
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await Checker.checkNetworkConnectivity(context: 'logout');
      await appwriteService.account.deleteSession(sessionId: 'current');
      await SharedPreferencesService.remove('sessionId');
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      await Checker.checkNetworkConnectivity(context: 'fetch');
      return await appwriteService.account.get();
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }
}
