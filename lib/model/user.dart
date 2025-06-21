class User {
  final String id;
  final DateTime createdAt;
  final String username;
  final String email;
  final String password;
  final String interest;

  User({
    required this.id,
    required this.createdAt,
    required this.username,
    required this.email,
    required this.password,
    required this.interest,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      username: json['username'],
      email: json['email'],
      password: json['password'],
      interest: json['interest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'username': username,
      'email': email,
      'password': password,
      'interest': interest,
    };
  }
}