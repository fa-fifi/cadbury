import 'package:cadbury/repositories/chocolate.dart';
import 'package:cadbury/utils/constants.dart';
import 'package:cadbury/utils/enums.dart';
import 'package:cadbury/utils/extensions.dart';
import 'package:cadbury/widgets/dropdown.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Month selectedMonth = Month.jan;
  Chocolate selectedType = Chocolate.flake;

  final FlGridData flGridData = FlGridData(
      getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.4),
          strokeWidth: 0.2,
          dashArray: [1, 0]),
      getDrawingVerticalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.4),
          strokeWidth: 0.2,
          dashArray: [1, 0]));

  final FlBorderData flBorderData = FlBorderData(
      border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.2));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text('Cadbury Chocolate Bars Production'),
            titleTextStyle: Theme.of(context).textTheme.titleMedium),
        body: SingleChildScrollView(
          child: Column(
            children: [
              top5MonthlyProduction(context),
              const Divider(),
              overallPerformanceAnalysis(context),
            ],
          ),
        ),
      );

  Widget top5MonthlyProduction(BuildContext context) => Column(
        children: [
          ListTile(
            title: Text('Top 5 Monthly Production',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: Dropdown(
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedMonth =
                        Month.values.singleWhere((month) => month.name == val));
                  }
                },
                list: Month.values.map((e) => e.name).toList()),
          ),
          FutureBuilder(
            future:
                ChocolateRepository.getDataBySpecificDate(month: selectedMonth),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AspectRatio(
                  aspectRatio: 3 / 2,
                  child: BarChart(BarChartData(
                      minY: 0,
                      maxY: 5000,
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (_, __) => const SizedBox())),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (_, __) => const SizedBox())),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (val, _) => Text(
                                      snapshot.data![val.toInt()].chocolateType
                                          .split(RegExp(r"(?=[A-Z])"))
                                          .join('\n'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ))),
                      ),
                      borderData: flBorderData,
                      gridData: flGridData,
                      barGroups: [
                        ...snapshot.data!.mapIndexed(
                          (i, e) => BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                  toY: e.volume.toDouble(),
                                  width: 10,
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(25)),
                                  color: Colors.primaries[i])
                            ],
                          ),
                        )
                      ])),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      );

  Widget overallPerformanceAnalysis(BuildContext context) => Column(
        children: [
          ListTile(
            title: Text('Overall Performance Analysis',
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: Dropdown(
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedType = Chocolate.values
                        .singleWhere((chocolate) => chocolate.name == val));
                  }
                },
                list: Chocolate.values.map((e) => e.name).toList()),
          ),
          FutureBuilder(
            future:
                ChocolateRepository.getDataByChocolateType(type: selectedType),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AspectRatio(
                  aspectRatio: 3 / 2,
                  child: LineChart(LineChartData(
                      minX: 0,
                      maxX: snapshot.data!.length.toDouble() - 1,
                      minY: 0,
                      maxY: 5000,
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (_, __) => const SizedBox())),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (_, __) => const SizedBox())),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (val, _) => Text(
                                      Month.values[val.toInt()].name
                                          .capitalize(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ))),
                      ),
                      borderData: flBorderData,
                      gridData: flGridData,
                      lineBarsData: [
                        LineChartBarData(
                            spots: [
                              ...snapshot.data!.map((e) => FlSpot(
                                  e.productionMonth.toDouble(),
                                  e.volume.toDouble())),
                            ],
                            gradient:
                                const LinearGradient(colors: gradientColors),
                            barWidth: 2,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                  colors: gradientColors
                                      .map((e) => e.withOpacity(0.3))
                                      .toList()),
                            )),
                      ])),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      );
}
