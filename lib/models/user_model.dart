class User {
  final String id;
  final String email;
  final String? name;
  final String? profilePicture;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    this.name,
    this.profilePicture,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      name: json['name']?.toString(),
      profilePicture: json['profilePicture']?.toString(),
      createdAt: json['createdAt'] is String
          ? DateTime.parse(json['createdAt'])
          : (json['createdAt'] as DateTime? ?? DateTime.now()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'email': email.toString(),
      'name': name?.toString(),
      'profilePicture': profilePicture?.toString(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
