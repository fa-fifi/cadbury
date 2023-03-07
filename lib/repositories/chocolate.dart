import 'package:http/http.dart' as http;

class ChocolateRepository {
  static Future<http.Response> getAllData() {
    return http.get(Uri.parse(
        'https://mobileassessment-36f02-default-rtdb.asia-southeast1.firebasedatabase.app/chocolate.json'));
  }
}
