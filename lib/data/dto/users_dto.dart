class UserDTO {
  final int? userId;
  final String? userName;
  final String? email;
  final DateTime? createdAt;
  final int? isDeleted;

  UserDTO({
    required this.userId,
    required this.userName,
    required this.email,
    required this.createdAt,
    required this.isDeleted,
  });

  factory UserDTO.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError.notNull('json');
    }
    return UserDTO(
      userId: json['user_id'] as int?,
      userName: json['user_name'] as String?,
      email: json['email'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      isDeleted: json['is_deleted'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (userId != null) {
      json['user_id'] = userId;
    }
    if (userName != null) {
      json['user_name'] = userName;
    }
    if (email != null) {
      json['email'] = email;
    }
    if (createdAt != null) {
      json['created_at'] = createdAt!.toIso8601String();
    }
    if (isDeleted != null) {
      json['is_deleted'] = isDeleted;
    }

    return json;
  }
}
