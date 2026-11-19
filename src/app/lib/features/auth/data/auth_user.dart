class AuthUser {
  final int id;
  final String name;
  final String email;
  const AuthUser({required this.id, required this.name, required this.email});
  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String,
    email: json['email'] as String,
  );
}
