class UserInfoModel {
  final int age;
  final String cpf;
  final String phone;
  final String? name;
  final String? email;

  UserInfoModel({
    required this.age,
    required this.cpf,
    required this.phone,
    this.name,
    this.email,
  });

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      age: map['age'] as int,
      cpf: map['cpf'] as String,
      phone: map['phone'] as String,
      name: map['name'] as String?,
      email: map['email'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'cpf': cpf,
      'phone': phone,
      'name': name,
      'email': email,
    };
  }
}
