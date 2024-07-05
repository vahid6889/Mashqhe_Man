class UserProfileParams {
  String? name;
  String? family;
  int? age;
  String? mobile;
  String? userName;
  int? role;

  UserProfileParams({
    this.name,
    this.family,
    this.age,
    required this.mobile,
    this.userName,
    this.role,
  });
}
