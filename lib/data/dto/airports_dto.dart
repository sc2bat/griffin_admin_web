class AirportsDto {
  AirportsDto({
      this.airportId, 
      this.airportCode, 
      this.airportName, 
      this.latitude, 
      this.longitude, 
      this.country, 
      this.createdAt, 
      this.isDeleted,});

  AirportsDto.fromJson(dynamic json) {
    airportId = json['airport_id'];
    airportCode = json['airport_code'];
    airportName = json['airport_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
    createdAt = json['created_at'];
    isDeleted = json['is_deleted'];
  }
  num? airportId;
  String? airportCode;
  String? airportName;
  num? latitude;
  num? longitude;
  String? country;
  String? createdAt;
  num? isDeleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['airport_id'] = airportId;
    map['airport_code'] = airportCode;
    map['airport_name'] = airportName;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['country'] = country;
    map['created_at'] = createdAt;
    map['is_deleted'] = isDeleted;
    return map;
  }

}