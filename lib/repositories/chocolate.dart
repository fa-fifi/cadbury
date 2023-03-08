import 'dart:convert';

import 'package:cadbury/models/data.dart';
import 'package:http/http.dart' as http;

class ChocolateRepository {
  static Future<List<DataModel>> getAllData() async {
    final response = await http.get(Uri.parse(
        'https://mobileassessment-36f02-default-rtdb.asia-southeast1.firebasedatabase.app/chocolate.json'));

    if (response.statusCode == 200) {
      List dataList = jsonDecode(response.body) as List;

      return dataList
          .map<DataModel>((data) => DataModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
