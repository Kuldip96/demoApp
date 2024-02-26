class GetProfile {
  String? id;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? profileImage;
  bool? isAdmin;
  bool? isDelete;
  int? v;

  GetProfile({
    this.id,
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.profileImage,
    this.isAdmin,
    this.isDelete,
    this.v,
  });

  factory GetProfile.fromJson(Map<String, dynamic> json) {
    return GetProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      profileImage: json['profileImage'],
      isAdmin: json['isAdmin'],
      isDelete: json['isDelete'],
      v: json['v'],
    );
  }
}
