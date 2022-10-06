class SignUpFormModel {
  final String? name;
  final String? email;
  final String? password;
  final String? pin;
  final String? profilePicture;
  final String? ktp;

  const SignUpFormModel({
    this.name,
    this.email,
    this.ktp,
    this.password,
    this.pin,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'pin': pin,
      'profile_picture': profilePicture,
      'ktp': ktp,
    };
  }

  SignUpFormModel copyWith({String? pin, String? profilePicture, String? ktp}) {
    return SignUpFormModel(
        pin: pin ?? this.pin,
        profilePicture: profilePicture ?? this.profilePicture,
        ktp: ktp ?? this.ktp,
        name: name,
        email: email,
        password: password);
  }
}
