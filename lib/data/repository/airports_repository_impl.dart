import 'dart:convert';
import 'package:admin_web_app/data/model/airports_model.dart';
import 'package:admin_web_app/domain/repository/airports_repository.dart';
import '../../env/env.dart';
import '../data_source/http.dart';

class AirportsRepositoryImpl implements AirportsRepository {
  @override
  Future<List<AirportsModel>> getAirportsList() async {
    final response = await fetchHttp('https://gist.githubusercontent.com/sc2bat/032757c85f460935540d4e57e1a811ce/raw/a473684a019c49d73931a862fed812bd6cb46f92/dump_airport.json');
    final List<dynamic> json = jsonDecode(response.body);
    return json.map((e) => AirportsModel.fromJson(e)).toList();
  }
}
