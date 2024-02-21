import 'package:admin_web_app/data/model/airports_model.dart';

abstract interface class AirportsRepository{
  Future <List<AirportsModel>> getAirportsList ();
}