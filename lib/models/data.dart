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
}
