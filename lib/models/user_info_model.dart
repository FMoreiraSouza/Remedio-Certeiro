class UserInfoModel {
  final int age;
  final String cpf;
  final String phone;

  UserInfoModel({
    required this.age,
    required this.cpf,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'cpf': cpf,
      'phone': phone,
    };
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      age: map['age'],
      cpf: map['cpf'],
      phone: map['phone'],
    );
  }
}
