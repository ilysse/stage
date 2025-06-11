enum UserRole { admin, seller }

class User {
  final String username;
  final UserRole role;
  final String name;

  User({
    required this.username,
    required this.role,
    required this.name,
  });
} 