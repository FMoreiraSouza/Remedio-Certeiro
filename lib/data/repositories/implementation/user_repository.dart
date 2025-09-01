import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
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
  }

  @override
  Future<User> login(String email, String password) async {
    final session = await appwriteService.account.createEmailPasswordSession(
      email: email,
      password: password,
    );
    print('Session ID salvo: ${session.$id}'); // Log para depuração
    await SharedPreferencesService.saveString('sessionId', session.$id);
    return await appwriteService.account.get();
  }

  @override
  Future<UserInfoModel> fetchUserData(String userId) async {
    final documents = await appwriteService.database.listDocuments(
      databaseId: '67944210001fd099f8bc',
      collectionId: '6794439e000f4d482ae3',
      queries: [Query.equal('userId', userId)],
    );

    if (documents.total > 0) {
      return UserInfoModel.fromMap(documents.documents.first.data);
    } else {
      throw Exception('Documento não encontrado para o userId fornecido.');
    }
  }

  @override
  Future<void> logout() async {
    await appwriteService.account.deleteSession(sessionId: 'current');
    await SharedPreferencesService.remove('sessionId');
  }

  @override
  Future<User> getCurrentUser() async {
    return await appwriteService.account.get();
  }
}
