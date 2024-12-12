class UserModel {
  final int id;
  final String name;
  final String mail;
  final String password;

  UserModel({required this.id, required this.name, required this.mail, required this.password});

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'password': password,
    };
  }

  // Factory constructor for JSON deserialization
  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] as int,
      name: data['name'] ?? '',
      mail: data['mail'] ?? '',
      password: data['password'] ?? '',
    );
  }
}
