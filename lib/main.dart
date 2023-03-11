import 'package:cadbury/screens/home.dart';
import 'package:cadbury/utils/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Top 5 Cadbury Chocolate Bars Production',
        theme: AppTheme.primary,
        home: const HomeScreen(),
      );
}
