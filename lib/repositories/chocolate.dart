import 'dart:convert';

import 'package:cadbury/models/data.dart';
import 'package:cadbury/utils/constants.dart';
import 'package:cadbury/utils/enums.dart';
import 'package:cadbury/utils/extensions.dart';
import 'package:http/http.dart' as http;

class ChocolateRepository {
  static const String _endpoint = '/chocolate.json';

  static Future<List<DataModel>> getDataBySpecificDate(
      {Month month = Month.jan}) async {
    final response = await http.get(Uri.parse(
        '$baseUrl$_endpoint?orderBy="Production_date"&equalTo="28-${month.name.capitalize()}"'));

    if (response.statusCode == 200) {
      Map dataList = jsonDecode(response.body) as Map;

      List<DataModel> result = dataList.values
          .map<DataModel>((data) => DataModel.fromJson(data))
          .toList();

      result.sort((b, a) => a.volume.compareTo(b.volume));

      return result.sublist(0, 5);
    } else {
      throw Exception('Failed to load data.');
    }
  }

  static Future<List<DataModel>> getDataByChocolateType(
      {Chocolate type = Chocolate.flake}) async {
    final response = await http.get(Uri.parse(
        '$baseUrl$_endpoint?orderBy="Chocolate Type"&equalTo="${type.name.capitalize()}"'));

    if (response.statusCode == 200) {
      Map dataList = jsonDecode(response.body) as Map;

      List<DataModel> result = dataList.values
          .map<DataModel>((data) => DataModel.fromJson(data))
          .toList();

      result.sort((a, b) => a.productionMonth.compareTo(b.productionMonth));

      return result;
    } else {
      throw Exception('Failed to load data.');
    }
  }
}
