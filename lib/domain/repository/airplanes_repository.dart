import 'package:admin_web_app/data/model/airplanes/airplanes_model.dart';

abstract interface class AirplanesRepository {
  Future <List<AirplanesModel>> getAirplanesList ();
}