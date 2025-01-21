class UserModel {
  final String name;
  final String password;
  final String confirmPassword;
  final int age;
  final String cpf;

  UserModel({
    required this.name,
    required this.password,
    required this.confirmPassword,
    required this.age,
    required this.cpf,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'confirmPassword': confirmPassword,
      'age': age,
      'cpf': cpf,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      password: map['password'],
      confirmPassword: map['confirmPassword'],
      age: map['age'],
      cpf: map['cpf'],
    );
  }

  bool isValid() {
    return password == confirmPassword;
  }
}
