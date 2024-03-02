import 'package:admin_web_app/data/data_source/http.dart';
import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('url 매개변수 테스트', () async {
    Map<String, dynamic> jsonData = {
      'departure_loc': 3237,

    };
    final jsonResult =
    jsonData.map((key, value) => MapEntry(key, value.toString()));

    String url = 'http://${Env.griffinFlightUrl}/flights/';
    // logger.info(url);

    Uri uri = Uri.parse(url);
    // logger.info(uri);

    final urlWithQuery = uri.replace(queryParameters: jsonResult).toString();
    // logger.info(urlWithQuery);

    final response = await fetchHttp(urlWithQuery);

    if (response.statusCode == 200) {
      logger.info(response.body);
    } else {
      logger.info(response.statusCode);
    }
  });
}