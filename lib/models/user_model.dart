class UserModel {
  final String name;
  final String password;
  final int age;
  final String cpf;
  final String phone;
  final String email;

  UserModel({
    required this.name,
    required this.password,
    required this.age,
    required this.cpf,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'age': age,
      'cpf': cpf,
      'phone': phone,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      password: map['password'],
      age: map['age'],
      cpf: map['cpf'],
      phone: map['phone'],
      email: map['email'],
    );
  }

  // bool isValid() {
  //   return password == confirmPassword;
  // }
}
