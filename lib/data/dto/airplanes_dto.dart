class AirplanesDto {
  AirplanesDto({
      this.airplaneId, 
      this.firstClassSeat, 
      this.businessClassSeat, 
      this.economyClassSeat, 
      this.createdAt, 
      this.isDeleted,});

  AirplanesDto.fromJson(dynamic json) {
    airplaneId = json['airplane_id'];
    firstClassSeat = json['first_class_seat'];
    businessClassSeat = json['business_class_seat'];
    economyClassSeat = json['economy_class_seat'];
    createdAt = json['created_at'];
    isDeleted = json['is_deleted'];
  }
  num? airplaneId;
  num? firstClassSeat;
  num? businessClassSeat;
  num? economyClassSeat;
  String? createdAt;
  num? isDeleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['airplane_id'] = airplaneId;
    map['first_class_seat'] = firstClassSeat;
    map['business_class_seat'] = businessClassSeat;
    map['economy_class_seat'] = economyClassSeat;
    map['created_at'] = createdAt;
    map['is_deleted'] = isDeleted;
    return map;
  }

}