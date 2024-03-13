class PassportDTO {
  final int? passportId;
  final int? gender;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? birthday;
  final DateTime? createdAt;
  final int? isDeleted;
  final int? bookId;

  PassportDTO({
    this.passportId,
    this.gender,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.birthday,
    this.createdAt,
    this.isDeleted,
    this.bookId,
  });

  factory PassportDTO.fromJson(Map<String, dynamic> json) {
    return PassportDTO(
      passportId: json['passport_id'],
      gender: json['gender'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      birthday: json['birthday'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      isDeleted: json['is_deleted'],
      bookId: json['book_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passport_id': passportId,
      'gender': gender,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'created_at': createdAt?.toIso8601String(),
      'is_deleted': isDeleted,
      'book_id': bookId,
    };
  }
}
