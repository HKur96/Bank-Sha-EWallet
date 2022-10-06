class UserEditFormModel {
  final String? username;
  final String? name;
  final String? email;
  final String? password;

  const UserEditFormModel({
    this.email,
    this.name,
    this.password,
    this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
