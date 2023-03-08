import 'package:cadbury/repositories/chocolate.dart';
import 'package:cadbury/utils/enums.dart';
import 'package:cadbury/widgets/dropdown.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Month selectedMonth = Month.jan;
  Chocolate selectedType = Chocolate.flake;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(
          children: [
            Dropdown(
                onChanged: (str) {
                  debugPrint(str);

                  if (str != null) {
                    setState(() {
                      selectedMonth = Month.values
                          .singleWhere((month) => month.name == str);
                    });
                  }
                },
                list: Month.values.map((e) => e.name).toList()),
            FutureBuilder(
              future: ChocolateRepository.getDataBySpecificDate(
                  month: selectedMonth),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ...snapshot.data!.map((e) => Text(e.chocolateType +
                          e.productionDate +
                          e.volume.toString())),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
            const Divider(),
            Dropdown(
                onChanged: (str) {
                  debugPrint(str);
                  if (str != null) {
                    setState(() {
                      selectedType = Chocolate.values
                          .singleWhere((chocolate) => chocolate.name == str);
                    });
                  }
                },
                list: Chocolate.values.map((e) => e.name).toList()),
            FutureBuilder(
              future: ChocolateRepository.getDataByChocolateType(
                  type: selectedType),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ...snapshot.data!.map((e) => Text(e.chocolateType +
                          e.productionDate +
                          e.volume.toString())),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      );
}
