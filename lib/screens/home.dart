import 'package:cadbury/repositories/chocolate.dart';
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
      body: ListView(
        children: <Widget>[
          FutureBuilder(
            future: ChocolateRepository.getAllData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!
                    .map((e) =>
                        e.chocolateType +
                        e.productionDate +
                        e.volume.toString())
                    .toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}
