import 'package:cadbury/repositories/chocolate.dart';
import 'package:cadbury/utils/enums.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: ChocolateRepository.getDataBySpecificDate(month: Month.jun),
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
          FutureBuilder(
            future: ChocolateRepository.getDataByChocolateType(
                type: Chocolate.chomp),
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
}
