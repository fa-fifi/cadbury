import 'dart:convert';

import 'package:cadbury/models/data.dart';
import 'package:cadbury/utils/constants.dart';
import 'package:cadbury/utils/enums.dart';
import 'package:http/http.dart' as http;

class ChocolateRepository {
  static const String _endpoint = '/chocolate.json';

  static Future<List<DataModel>> getDataBySpecificDate(
      {Month month = Month.jan}) async {
    final response = await http.get(Uri.parse(
        '$baseUrl$_endpoint?orderBy="Production_date"&equalTo="28-${month.toString()}"'));

    if (response.statusCode == 200) {
      Map dataList = jsonDecode(response.body) as Map;

      List<DataModel> unsortedData = dataList.values
          .map<DataModel>((data) => DataModel.fromJson(data))
          .toList();

      unsortedData.sort((b, a) => a.volume.compareTo(b.volume));

      return unsortedData.sublist(0, 5);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<DataModel>> getDataByChocolateType(
      {Chocolate type = Chocolate.flake}) async {
    final response = await http.get(Uri.parse(
        '$baseUrl$_endpoint?orderBy="Chocolate Type"&equalTo="${type.toString()}"'));

    if (response.statusCode == 200) {
      Map dataList = jsonDecode(response.body) as Map;

      List<DataModel> unsortedData = dataList.values
          .map<DataModel>((data) => DataModel.fromJson(data))
          .toList();

      return unsortedData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
