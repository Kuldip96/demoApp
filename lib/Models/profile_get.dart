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
}