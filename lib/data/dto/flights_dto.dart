class FlightsDto {
  FlightsDto({
      this.flightId, 
      this.airplaneId, 
      this.flightDate, 
      this.departureTime, 
      this.arrivalTime, 
      this.departureLoc, 
      this.departureName, 
      this.arrivalLoc, 
      this.arrivalName,});

  FlightsDto.fromJson(dynamic json) {
    flightId = json['flight_id'];
    airplaneId = json['airplane_id'];
    flightDate = json['flight_date'];
    departureTime = json['departure_time'];
    arrivalTime = json['arrival_time'];
    departureLoc = json['departure_loc'];
    departureName = json['departure_name'];
    arrivalLoc = json['arrival_loc'];
    arrivalName = json['arrival_name'];
  }
  num? flightId;
  num? airplaneId;
  String? flightDate;
  String? departureTime;
  String? arrivalTime;
  num? departureLoc;
  String? departureName;
  num? arrivalLoc;
  String? arrivalName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['flight_id'] = flightId;
    map['airplane_id'] = airplaneId;
    map['flight_date'] = flightDate;
    map['departure_time'] = departureTime;
    map['arrival_time'] = arrivalTime;
    map['departure_loc'] = departureLoc;
    map['departure_name'] = departureName;
    map['arrival_loc'] = arrivalLoc;
    map['arrival_name'] = arrivalName;
    return map;
  }

}