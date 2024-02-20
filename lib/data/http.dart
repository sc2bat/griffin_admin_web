import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> fetchHttp(String url) async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response;
    }
    throw Exception('erorr fetchHttp ${response.statusCode}');
  } catch (e) {
    logger.info('http 통신 에러 => $e');
    throw Exception(e);
  }
}
