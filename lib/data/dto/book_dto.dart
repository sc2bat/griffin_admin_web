class BookResultDTO {
  final int? bookId;
  final int? userId;
  final int? flightId;
  final String? flightDate;
  final String? classSeat;
  final int? status;
  final int? payStatus;
  final double? payAmount;
  final DateTime? createdAt;
  final String? userName;
  final String? departureTime;
  final String? departureCode;
  final String? departureName;
  final String? arrivalTime;
  final String? arrivalCode;
  final String? arrivalName;
  final String? firstName;
  final String? lastName;

  BookResultDTO({
    this.bookId,
    this.userId,
    this.flightId,
    this.flightDate,
    this.classSeat,
    this.status,
    this.payStatus,
    this.payAmount,
    this.createdAt,
    this.userName,
    this.departureTime,
    this.departureCode,
    this.departureName,
    this.arrivalTime,
    this.arrivalCode,
    this.arrivalName,
    this.firstName,
    this.lastName,
  });

  factory BookResultDTO.fromJson(Map<String, dynamic> json) {
    return BookResultDTO(
      bookId: json['book_id'],
      userId: json['user_id'],
      flightId: json['flight_id'],
      classSeat: json['class_seat'],
      status: json['status'],
      payStatus: json['pay_status'],
      payAmount: json['pay_amount']?.toDouble(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      userName: json['user_name'],
      flightDate: json['flight_date'],
      departureTime: json['departure_time'],
      departureCode: json['departure_code'],
      departureName: json['departure_name'],
      arrivalTime: json['arrival_time'],
      arrivalCode: json['arrival_code'],
      arrivalName: json['arrival_name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_id': bookId,
      'user_id': userId,
      'flight_id': flightId,
      'class_seat': classSeat,
      'status': status,
      'pay_status': payStatus,
      'pay_amount': payAmount,
      'created_at': createdAt?.toIso8601String(),
      'user_name': userName,
      'flight_date': flightDate,
      'departure_time': departureTime,
      'departure_code': departureCode,
      'departure_name': departureName,
      'arrival_time': arrivalTime,
      'arrival_code': arrivalCode,
      'arrival_name': arrivalName,
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}
