import 'package:appwrite/models.dart';
import 'package:remedio_certeiro/data/models/user_info_model.dart';

abstract class IUserRepository {
  Future<void> registerUser(
      String email, String password, String name, int age, String cpf, String phone);
  Future<User> login(String email, String password);
  Future<UserInfo> fetchUserData(String userId);
  Future<void> logout();
}
