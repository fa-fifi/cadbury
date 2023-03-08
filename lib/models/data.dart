import 'package:cadbury/utils/enums.dart';
import 'package:cadbury/utils/extensions.dart';

class DataModel {
  final String chocolateType;
  final String productionDate;
  final int volume;

  const DataModel({
    required this.chocolateType,
    required this.productionDate,
    required this.volume,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        chocolateType: json['Chocolate Type'],
        productionDate: json['Production_date'],
        volume: json['Volume'],
      );

  int get productionMonth => Month.values
      .singleWhere(
          (month) => month.name.capitalize() == productionDate.split('-').last)
      .index;
}
