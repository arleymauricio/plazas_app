enum UserRole {
  comerciante,
  comprador,
  transportador,
}

class UserModel {
  final String uid;
  final String email;
  final List<UserRole> roles;

  UserModel({
    required this.uid,
    required this.email,
    required this.roles,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'roles': roles.map((role) => role.name).toList(),
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        email: json['email'],
        roles: (json['roles'] as List)
            .map((role) => UserRole.values.byName(role))
            .toList(),
      );
}
